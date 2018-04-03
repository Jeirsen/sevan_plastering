class Lot < ApplicationRecord
  belongs_to :project
  belongs_to :model
  has_many :orders

  Status = {:active => 1, :inactive => 0}

  def full_address
  	"#{self.address1} #{self.address2} #{self.city} #{self.state} #{self.zip}"
  end
end
