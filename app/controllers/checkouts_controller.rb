class CheckoutsController < ApplicationController
  def checkout
    session[:cart] ||= {}
    @cart = session[:cart]
    beat_ids = @cart.keys.map(&:to_i)
    @beats = Beat.where(id: beat_ids)
    @provinces = Province.order(:name)

    @subtotal = @beats.sum { |beat| beat.price * @cart[beat.id.to_s] }

    @province_id = params[:province_id]
    @selected_province = Province.find_by(id: @province_id) || Province.find_by(name: "MB")

    if @selected_province
      @gst = (@subtotal * @selected_province.gst).round(2) if @selected_province.gst.to_f > 0
      @pst = (@subtotal * @selected_province.pst).round(2) if @selected_province.pst.to_f > 0
      @hst = (@subtotal * @selected_province.hst).round(2) if @selected_province.hst.to_f > 0
      @qst = (@subtotal * @selected_province.qst).round(2) if @selected_province.qst.to_f > 0
    end

    @total_tax = [@gst, @pst, @hst, @qst].compact.sum.round(2)
    @total = (@subtotal + @total_tax).round(2)
  end

  def create
    name = params[:name]
    email = params[:email]
    province_id = params[:province_id]
    cart = session[:cart] || {}

    beats = Beat.where(id: cart.keys.map(&:to_i))
    subtotal = beats.sum { |beat| beat.price * cart[beat.id.to_s] }

    province = Province.find_by(id: province_id)
    unless province
      redirect_to checkout_path, alert: "Invalid province selected." and return
    end

    tax_amount = subtotal * [province.gst, province.pst, province.hst, province.qst].compact.sum
    total = subtotal + tax_amount

    customer = Customer.create!(name: name, email: email, province: province)

    order = Order.create!(
      customer: customer,
      total: total.round(2),
      tax: tax_amount.round(2)
    )

    session[:cart] = {}
    OrderMailer.order_confirmation(order).deliver_now
    redirect_to root_path, notice: "Order placed successfully!"
    

  end
end
