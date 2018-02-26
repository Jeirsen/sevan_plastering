class Unit < ApplicationRecord
  	has_many :products

  	def self.get_all
  		Unit.all
  	end

end
