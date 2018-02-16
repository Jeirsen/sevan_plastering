class Vendor < ApplicationRecord
	validates :name, presence: true
    validates :state, presence: true
    validates :zipcode, presence: true
    validates :address1, presence: true
    validates :phone, presence: true
    validates :city, presence: true
end
