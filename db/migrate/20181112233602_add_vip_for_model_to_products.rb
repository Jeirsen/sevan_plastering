class AddVipForModelToProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :products, :vip_model, :boolean, default: false
  end
end
