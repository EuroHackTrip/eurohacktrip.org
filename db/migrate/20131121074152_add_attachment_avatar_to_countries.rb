class AddAttachmentAvatarToCountries < ActiveRecord::Migration
  def self.up
    change_table :countries do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :countries, :avatar
  end
end
