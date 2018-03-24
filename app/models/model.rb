class Model < ApplicationRecord

	belongs_to :builder
	has_many :templates
	Status = {:active => 1, :inactive => 0}



  has_attached_file :photo, styles: {
			thumb: '100x100>',
			square: '300x200#',
			medium: '450x300>',
			large: '700x400>'
	}, default_url: 'https://s3-sa-east-1.amazonaws.com/pet-id-tag/customers/default-avatar.jpg'

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

	def model_image
		if self.photo
			medium = self.photo.url(:medium)
		else
			medium = 'https://s3-sa-east-1.amazonaws.com/pet-id-tag/pets/default_pet.jpg'
		end
		return medium
	end
end
