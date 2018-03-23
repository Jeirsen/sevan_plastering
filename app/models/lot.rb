class Lot < ApplicationRecord
  belongs_to :project
  belongs_to :model
  has_many :orders

  Status = {:active => 1, :inactive => 0}
end
