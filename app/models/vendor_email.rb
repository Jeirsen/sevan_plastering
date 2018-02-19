class VendorEmail < ApplicationRecord
	belongs_to :vendor
	Status = {:active => 1, :inactive => 0}
end
