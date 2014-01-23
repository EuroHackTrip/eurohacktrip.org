class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_attached_file :photo,
    :storage => :dropbox,
    :default_url => "/images/:style/missing.png",
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	  admin = Admin.where(:provider => auth.provider, :uid => auth.uid).first
	  unless admin
	    admin = Admin.create(name:auth.extra.raw_info.name,
	                         provider:auth.provider,
	                         uid:auth.uid,
	                         email:auth.info.email,
	                         password:Devise.friendly_token[0,20]
	                         )
	  end
	  admin
  end

  validate :file_dimensions, :unless => "errors.any?"
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :country, presence: true
  validates :activity, presence: true
  validates :interest, presence: true
  validates :video_link, presence: true
  validates :funding_profile, presence: true
end
