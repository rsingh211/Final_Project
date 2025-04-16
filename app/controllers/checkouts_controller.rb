class CheckoutsController < ApplicationController
  def checkout
    session[:cart] ||= {}
    @cart = session[:cart]
    beat_ids = @cart.keys.map(&:to_i)
    @beats = Beat.where(id: beat_ids)
    @provinces = Province.all.order(:name)

    @subtotal = @beats.sum { |beat| beat.price * @cart[beat.id.to_s] }

    @province_id = params[:province_id]
    @selected_province = Province.find_by(id: @province_id) || Province.find_by(name: "MB")

    @gst = (@subtotal * @selected_province.gst).round(2) if @selected_province.gst
    @pst = (@subtotal * @selected_province.pst).round(2) if @selected_province.pst
    @hst = (@subtotal * @selected_province.hst).round(2) if @selected_province.hst
    @qst = (@subtotal * @selected_province.qst).round(2) if @selected_province.qst

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
    tax_amount = subtotal * [province.gst, province.pst, province.hst, province.qst].compact.sum
    total = subtotal + tax_amount

    customer = Customer.create!(name: name, email: email, province_id: province.id)

    order = Order.create!(
      customer: customer,
      total: total.round(2),
      tax: tax_amount.round(2)
    )

    session[:cart] = {}

    redirect_to root_path, notice: "Order placed successfully!"
  end
end
