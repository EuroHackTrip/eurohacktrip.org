class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  after_create :set_name
  def set_name
    self.name = "#{self.first_name} #{self.last_name}"
    self.slug = "#{self.name.parameterize.downcase}"
    self.save!
  end

  has_attached_file :photo,
    :default_url => "/assets/eu.png"

  has_many :involvement
  has_many :startups, through: :involvement

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # devise :omniauthable, :omniauth_providers => [:facebook]

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end

  # validate :file_dimensions, :unless => "errors.any?" #errorneous
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :email, presence: true
  # validates :password, presence: true
  # validates :country, presence: true
  # validates :city, presence: true
  # validates :about, presence: true
  # validates :photo, presence: true
  # validates :video, presence: true
  # validates :interest, presence: true
  # validates :funding_campaign, presence: true #not necessary!
end


  # rails g devise user first_name:string last_name:string email:string password:string country:string city:string about:text photo:string video:string interest:text funding_campaign:string is_admin:boolean approved:boolean

# changes:

# activity
# video_link
# funding_profile
# -tag_line  +city