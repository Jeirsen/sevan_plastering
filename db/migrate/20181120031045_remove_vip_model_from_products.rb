class RemoveVipModelFromProducts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :products, :vip_model
  end
end
