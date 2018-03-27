class AddOrderTotalToOrders < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :order_total, :decimal, precision: 5, scale: 2
  end
end
