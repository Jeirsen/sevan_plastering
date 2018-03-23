class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :order_number
      t.datetime :delivery_date
      t.references :project, index: true, foreign_key: true
      t.integer :time_needed_by
      t.references :lot, index: true, foreign_key: true
      t.integer :status, default: Order::Status[:saved]
      t.references :vendor, index: true, foreign_key: true
      t.string :notes
      t.timestamps
    end
  end
end
