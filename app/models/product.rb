class Product < ApplicationRecord
	belongs_to :unit
	Status = {:active => 1, :inactive => 0}
	Categories = {:stucco => 1, :phone => 2}
end
