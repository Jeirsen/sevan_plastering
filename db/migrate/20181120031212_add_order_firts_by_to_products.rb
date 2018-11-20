class AddOrderFirtsByToProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :products, :order_first_by, :integer, default: nil
  end
end
