class Project < ApplicationRecord
  belongs_to :builder
  has_many :lots
  has_many :orders

  Status = {:active => 1, :inactive => 0}
  
end
