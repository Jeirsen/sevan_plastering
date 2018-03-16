class Model < ApplicationRecord	
	validates :name, presence: true

	belongs_to :builder
	Status = {:active => 1, :inactive => 0}
end
