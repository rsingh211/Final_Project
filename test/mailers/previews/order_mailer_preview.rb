# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
    def order_confirmation
      order = Order.includes(:customer).where.not(customer_id: nil).last || Order.first
      OrderMailer.order_confirmation(order)
    end
  end
  