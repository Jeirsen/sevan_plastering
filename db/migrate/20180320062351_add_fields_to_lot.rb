class AddFieldsToLot < ActiveRecord::Migration[5.1]
  def change
    add_column :lots, :status, :integer, :default => Lot::Status[:active]
    add_reference :lots, :model, foreign_key: true
    add_column :lots, :number, :string
    add_column :lots, :address1, :string
    add_column :lots, :address2, :string
    add_column :lots, :city, :string
    add_column :lots, :state, :string
    add_column :lots, :zip, :string
  end
end
