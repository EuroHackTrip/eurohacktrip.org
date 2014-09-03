class AddAttachmentPicToStops < ActiveRecord::Migration
  def self.up
    change_table :stops do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :stops, :pic
  end
end
