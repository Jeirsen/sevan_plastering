class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  Roles = {normal: 0, admin: 1}

  has_many :orders

  def role_name
  	return "Admin" if self.role == Roles[:admin]
  	return "Normal" if self.role == Roles[:normal]
  	return "NA"
  end

  def self.get_roles
    {
      "Admin" => Roles[:admin],
      "Normal" => Roles[:normal]
    }
  end

  def is_admin
    self.role == Roles[:admin]
  end

  def full_name
    full_name = "#{self.first_name} #{self.last_name}"
    if !full_name.present?
      return "(Pending)"
    else
      return full_name
    end
    
  end
end
