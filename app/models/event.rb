class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :event_name, use: [:slugged, :history]

  def set_name
    self.slug = self.event_name.parameterize.downcase
    self.save!
  end

  
  belongs_to :city

  has_many :participation
  has_many :startups, through: :participation

  has_attached_file :venue_pic, :default_url => "/assets/eu.png"

  # validates :year, :presence => true
  # validates :date, :presence => true
  # validates :theme, :presence => true
  # validates :icon, :presence => true
  # validates :description, :presence => true
  # validates :venue_pic, :presence => true
  
  # validates :event_link, :presence => true
  # validates :event_name, :presence => true
  # validates :event_venue, :presence => true
  # validates :event_id, :presence => true

  # validates :city_id, :presence => true

end
