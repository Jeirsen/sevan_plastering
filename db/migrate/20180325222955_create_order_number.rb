class CreateOrderNumber < ActiveRecord::Migration[5.1]
  def change
    create_table :order_numbers do |t|
      t.integer :order_number
    end
  end
end
