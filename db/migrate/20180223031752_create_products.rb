class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :unit, index: true, foreign_key: true
      t.integer :status, :default => Product::Status[:active]
      t.timestamps
    end
  end
end
