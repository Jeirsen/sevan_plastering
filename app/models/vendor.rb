class Vendor < ApplicationRecord
	validates :name, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :address1, presence: true
  validates :phone, presence: true
  validates :city, presence: true

  has_many :vendor_emails
  has_many :product_vendors
  has_many :orders

  Status = {:active => 1, :inactive => 0}

end
