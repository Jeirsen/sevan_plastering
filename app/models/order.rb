class Order < ApplicationRecord
	belongs_to :project
	belongs_to :lot
	belongs_to :vendor

	Status = {:saved => 0, :sent => 1, :view => 3, :closed => 4, :received => 5}
	TimeNeededBy = {:firts_am => 0, :second_am => 1, :anytime => 2, :asap => 3, :pick_up => 4, :morning => 5, :noon => 6, :afternoon => 7, :saturday => 8}

	def self.TimeNeededBy(time_type)
		case time_type
		when Order::TimeNeededBy[:firts_am]
			return "Firts AM"
		when Order::TimeNeededBy[:second_am]
			return "Second AM"
		when Order::TimeNeededBy[:anytime]
			return "Anytime"
		when Order::TimeNeededBy[:asap]
			return "ASAP"
		when Order::TimeNeededBy[:pick_up]
			return "Pick Up"
		when Order::TimeNeededBy[:morning]
			return "Morning"
		when Order::TimeNeededBy[:noon]
			return "Noon"
		when Order::TimeNeededBy[:afternoon]
			return "Afternoon"
		when Order::TimeNeededBy[:saturday]
			return "Saturday"
		end
	end

end
