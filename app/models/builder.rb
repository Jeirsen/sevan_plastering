class Builder < ApplicationRecord
  validates :name, presence: true

  Status = {:active => 1, :inactive => 0}

  has_many :projects

  def disable
    self.status = Status[:inactive]
    self.save
  end
end
