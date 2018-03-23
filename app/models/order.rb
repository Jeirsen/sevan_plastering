class Order < ApplicationRecord
	belongs_to :project
	belongs_to :lot
	belongs_to :vendor

	Status = {:saved => 0, :sent => 1, :view => 3, :closed => 4, :received => 5}
	TimeNeededBy = {:firts_am => 0, :second_am => 1, :anytime => 2, :asap => 3, :pick_up => 4, :morning => 5, :noon => 6, :afternoon => 7, :saturday => 8}
end
