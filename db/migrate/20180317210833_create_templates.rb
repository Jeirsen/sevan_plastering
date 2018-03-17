class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
	  t.references :model, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
