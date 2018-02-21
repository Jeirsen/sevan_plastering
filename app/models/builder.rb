class Builder < ApplicationRecord
  validates :name, presence: true

  Status = {:active => 1, :inactive => 0}

  def disable
    self.status = Status[:inactive]
    self.save
  end
end
