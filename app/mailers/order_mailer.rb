def order_confirmation(order)
    @order = order
    mail(to: @order.customer.email, subject: "Your Order from Despised Beats")
  end
  