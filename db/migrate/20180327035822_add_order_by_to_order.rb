class AddOrderByToOrder < ActiveRecord::Migration[5.1]
  def change
  	add_reference :orders, :user, index: true
  end
end
