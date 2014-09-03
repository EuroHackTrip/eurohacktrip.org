class Stop < ActiveRecord::Base
  belongs_to :city

  has_attached_file :pic, :default_url => "/assets/eu.png"

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

end
