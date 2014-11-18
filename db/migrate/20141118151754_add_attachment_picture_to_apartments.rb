class AddAttachmentPictureToApartments < ActiveRecord::Migration
  def self.up
    change_table :apartments do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :apartments, :picture
  end
end
