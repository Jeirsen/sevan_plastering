class Model < ApplicationRecord
	belongs_to :builder
	Status = {:active => 1, :inactive => 0}
end
