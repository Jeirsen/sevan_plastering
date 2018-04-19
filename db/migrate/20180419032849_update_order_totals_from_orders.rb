class UpdateOrderTotalsFromOrders < ActiveRecord::Migration[5.1]
  def change
  	change_column :orders, :order_total, :decimal
  end
end
