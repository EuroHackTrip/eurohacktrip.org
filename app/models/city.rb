class City < ActiveRecord::Base
  belongs_to :country

  has_many :events
  
  has_attached_file :photo, :default_url => "/assets/eu.png"

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

end
