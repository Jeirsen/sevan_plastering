class AddPriorizationToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :prioritize, :boolean, default: false
  end
end
