class SeedOrderNumber < ActiveRecord::Migration[5.1]
  def change
  	OrderNumbers.create(order_number: 1)
  end
end
