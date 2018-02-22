class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :unit
      t.integer :status, :default => Product::Status[:active]

      t.timestamps
    end
  end
end
