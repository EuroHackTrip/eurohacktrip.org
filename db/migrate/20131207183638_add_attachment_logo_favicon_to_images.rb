class AddAttachmentLogoFaviconToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :logo
      t.attachment :favicon
    end
  end

  def self.down
    drop_attached_file :images, :logo
    drop_attached_file :images, :favicon
  end
end
