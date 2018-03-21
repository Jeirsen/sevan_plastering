class Model < ApplicationRecord	
	validates :name, presence: true

	belongs_to :builder
	has_many :templates
	Status = {:active => 1, :inactive => 0}

	has_attached_file :image, styles: {
			thumb: '100x100>',
			square: '300x200#',
			medium: '450x300>',
			large: '700x400>'
	}, default_url: 'https://s3-sa-east-1.amazonaws.com/pet-id-tag/customers/default-avatar.jpg'

	def model_image
		if self.image
			medium = self.image.url(:medium)
		else
			medium = 'https://s3-sa-east-1.amazonaws.com/pet-id-tag/pets/default_pet.jpg'
		end
		return medium
	end
end
