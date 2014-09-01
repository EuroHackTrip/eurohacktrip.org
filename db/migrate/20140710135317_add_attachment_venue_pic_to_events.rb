class AddAttachmentVenuePicToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :venue_pic
    end
  end

  def self.down
    drop_attached_file :events, :venue_pic
  end
end
