class CreateVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :phone
      t.string :address1
      t.string :address2
      t.string :state
      t.string :zipcode
      t.string :city
      t.string :fax

      t.timestamps
    end
  end
end
