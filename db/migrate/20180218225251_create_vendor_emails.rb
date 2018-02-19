class CreateVendorEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :vendor_emails do |t|
      t.string :description
      t.string :email
      t.string :name
      t.integer :status, :default => VendorEmail::Status[:active]
      t.references :vendor, index: true, foreign_key: true

      t.timestamps
    end
  end
end
