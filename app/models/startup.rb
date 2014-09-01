class Startup < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
  def set_name
    self.slug = self.name.parameterize.downcase
    self.save!
  end
  
  has_many :participation
  has_many :events, through: :participation

  has_many :involvement
  has_many :users, through: :involvement

  has_attached_file :logo, :default_url => "/assets/eu.png"

end