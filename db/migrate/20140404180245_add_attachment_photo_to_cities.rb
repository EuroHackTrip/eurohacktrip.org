class AddAttachmentPhotoToCities < ActiveRecord::Migration
  def self.up
    change_table :cities do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :cities, :photo
  end
end
