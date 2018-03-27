class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
    	t.references :order, index:true, foreign_key: true
   		t.references :product, index: true, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 5, scale: 2
      t.decimal :total, precision: 5, scale:2

      t.timestamps
    end
  end
end
