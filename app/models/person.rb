class Person < ActiveRecord::Base
  belongs_to :country
  has_attached_file :avatar,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
end
