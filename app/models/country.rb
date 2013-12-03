require Rails.root.to_s + "/lib/eventbrite/eventbrite.rb"

class Country < ActiveRecord::Base
	is_impressionable
	extend FriendlyId
	friendly_id :name, use: [:slugged, :history]
	has_attached_file :avatar,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
	has_many :cities, dependent: :destroy
	has_many :people, dependent: :destroy
	has_many :events, dependent: :destroy
end
