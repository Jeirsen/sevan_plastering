class CreateModels < ActiveRecord::Migration[5.1]
  def change
    create_table :models do |t|
    	t.references :builder, index: true, foreign_key: true
      t.string :name
      t.string :url_model_image
      t.integer :status, :default => Model::Status[:active]
      t.timestamps
    end
  end
end
