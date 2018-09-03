class Product < ApplicationRecord
	belongs_to :unit
	Status = {:active => 1, :inactive => 0}
	Categories = {:stucco => 1, :foam => 2}

	def self.categories
	[
        	{id: Categories[:stucco], name: "Stucco"},
        	{id: Categories[:foam], name: "Foam"}
	]
	end
end
