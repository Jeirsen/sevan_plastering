class UpdateTotalPrecisionOrderDetail < ActiveRecord::Migration[5.1]
  def change
  	change_column :order_details, :total, :decimal, precision: 10, scale:2
  end
end
