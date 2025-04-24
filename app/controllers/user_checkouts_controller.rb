class UserCheckoutsController < ApplicationController
  before_action :authenticate_user!

  def checkout
    session[:cart] ||= {}
    @cart = session[:cart]
    beat_ids = @cart.keys.map(&:to_i)
    @beats = Beat.where(id: beat_ids)

    @subtotal = @beats.sum { |beat| beat.price * @cart[beat.id.to_s] }

    @province = current_user.province.name || "MB" # fallback
    tax_rates = get_tax_rates(@province)

    @gst = (@subtotal * tax_rates[:gst]).round(2) if tax_rates[:gst]
    @pst = (@subtotal * tax_rates[:pst]).round(2) if tax_rates[:pst]
    @hst = (@subtotal * tax_rates[:hst]).round(2) if tax_rates[:hst]
    @qst = (@subtotal * tax_rates[:qst]).round(2) if tax_rates[:qst]

    @total_tax = [@gst, @pst, @hst, @qst].compact.sum.round(2)
    @total = (@subtotal + @total_tax).round(2)
  end

  def create
    cart = session[:cart] || {}
    beats = Beat.where(id: cart.keys.map(&:to_i))
    subtotal = beats.sum { |beat| beat.price * cart[beat.id.to_s] }

    province = current_user.province.name || "MB"
    tax_rates = get_tax_rates(province)
    tax_amount = subtotal * tax_rates.values.compact.sum
    total = subtotal + tax_amount

    order = Order.create!(
      user: current_user,
      total: total.round(2),
      tax: tax_amount.round(2),
      paid: false
    )

    cart.each do |beat_id, quantity|
      OrderItem.create!(
        order: order,
        beat_id: beat_id,
        quantity: quantity
      )
    end

    # Create Stripe Checkout session
    stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'payment',
      line_items: [{
        price_data: {
          currency: 'cad',
          product_data: {
            name: "Order ##{order.id}"
          },
          unit_amount: (total * 100).to_i
        },
        quantity: 1
      }],
      success_url: "http://127.0.0.1:3000/checkout/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "http://127.0.0.1:3000/checkout/cancel"
    )
    


    order.update(payment_session_id: stripe_session.id)

    redirect_to stripe_session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]
    stripe_session = Stripe::Checkout::Session.retrieve(session_id)

    order = Order.find_by(payment_session_id: stripe_session.id)
    if order
      order.update(
        paid: true,
        status: 'paid',
        stripe_payment_id: stripe_session.payment_intent
      )
      flash[:notice] = "Payment successful. Thank you!"
    else
      flash[:alert] = "Could not verify payment session."
    end

    session[:cart] = {}
    redirect_to root_path
  end

  def cancel
    flash[:alert] = "Payment was canceled."
    redirect_to cart_path
  end

  private

  def get_tax_rates(province)
    {
      "MB" => { pst: 0.07, gst: 0.05 },
      "ON" => { hst: 0.13 },
      "BC" => { pst: 0.07, gst: 0.05 },
      "QC" => { gst: 0.05, qst: 0.09975 },
      "AB" => { gst: 0.05 },
      "NS" => { hst: 0.15 }
    }[province.upcase] || { gst: 0.05 }
  end
end
