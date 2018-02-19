class AddStatusToVendor < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :status, :integer, :default => Vendor::Status[:active]
  end
end
