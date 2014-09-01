class Partner < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def set_name
    self.slug = self.name.parameterize.downcase
    self.save!
  end

  
  has_attached_file :logo, :default_url => "/assets/eu.png"
  validates :name, :presence => true
  # validates :description, :presence => true
  validates :link, :presence => true
  # validates :tier, :presence => true
  validates :year, :presence => true
end
