class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  Roles = {normal: 0, admin: 1}


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
end
