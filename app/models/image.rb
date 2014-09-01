class Image < ActiveRecord::Base
	has_attached_file :logo,
    :storage => :dropbox,
    :default_url => "/assets/eu.png",
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")

    has_attached_file :favicon,
    :storage => :dropbox,
    :default_url => "/assets/eu.png",
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
end
