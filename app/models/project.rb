class Project < ApplicationRecord
  belongs_to :builder
  has_many :lots
end
