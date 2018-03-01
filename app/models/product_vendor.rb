class ProductVendor < ApplicationRecord
	belongs_to :product
	belongs_to :vendor
	Status = {:active => 1, :inactive => 0}
end
