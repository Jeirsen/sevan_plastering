class AddAttachmentPhotoToModels < ActiveRecord::Migration[5.1]
  def self.up
    change_table :models do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :models, :photo
  end
end
