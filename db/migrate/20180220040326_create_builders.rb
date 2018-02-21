class CreateBuilders < ActiveRecord::Migration[5.1]
  def change
    create_table :builders do |t|
      t.string :name
      t.integer :status, default: Builder::Status[:active]

      t.timestamps
    end
  end
end
