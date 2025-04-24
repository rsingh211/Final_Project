class AddTaxRatesToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :gst, :decimal
    add_column :orders, :pst, :decimal
    add_column :orders, :hst, :decimal
    add_column :orders, :qst, :decimal
  end
end
