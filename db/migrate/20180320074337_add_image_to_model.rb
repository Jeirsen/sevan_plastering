class AddImageToModel < ActiveRecord::Migration[5.1]
  def change
    def self.up
      add_attachment :models, :image
    end

    def self.down
      remove_attachment :models, :image
    end
  end
end
