class CreateProductVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :product_vendors do |t|
      t.references :product, index: true, foreign_key: true
      t.references :vendor, index: true, foreign_key: true
      t.decimal :price, precision: 5, scale: 2
      t.integer :status, :default => ProductVendor::Status[:active]
      t.timestamps
    end
  end
end
