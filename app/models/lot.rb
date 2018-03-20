class Lot < ApplicationRecord
  belongs_to :project
  belongs_to :model

  Status = {:active => 1, :inactive => 0}
end
