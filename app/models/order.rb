class Order < ApplicationRecord
	belongs_to :project
	belongs_to :lot
	belongs_to :vendor
	belongs_to :user
	has_many :order_details

	Status = {:saved => 0, :sent => 1, :view => 3, :closed => 4, :received => 5}
	OrderStatus = {saved: 0, sent: 1, view: 3, closed: 4, received: 5}
	TimeNeededBy = {:firts_am => 0, :second_am => 1, :anytime => 2, :asap => 3, :pick_up => 4, :morning => 5, :noon => 6, :afternoon => 7, :saturday => 8}
	TimeNeeded = {firts_am: 0, second_am: 1, anytime: 2, asap: 3, pick_up: 4, morning: 5, noon: 6, afternoon: 7, saturday: 8}

	def self.get_time_needed_by
		{
			"-None-" => nil,
			"First AM" => TimeNeeded[:firts_am],
			"Second AM" => TimeNeeded[:second_am],
			"Anytime" => TimeNeeded[:anytime],
			"ASAP" => TimeNeeded[:asap],
			"Pick Up" => TimeNeeded[:pick_up],
			"Morning" => TimeNeeded[:morning],
			"Noon" => TimeNeeded[:noon],
			"Afternoon" => TimeNeeded[:afternoon],
			"Saturday" => TimeNeeded[:saturday]
		}
	end

	def self.order_status(status)
		case status
		when Order::OrderStatus[:saved]
			return "Saved"
		when Order::OrderStatus[:sent]
			return "Sent"
		when Order::OrderStatus[:view]
			return "View"
		when Order::OrderStatus[:closed]
			return "Closed"
		when Order::OrderStatus[:received]
			return "Received"
		end
		
	end

	def self.TimeNeededBy(time_type)
		case time_type
		when Order::TimeNeededBy[:firts_am]
			return "First AM"
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
