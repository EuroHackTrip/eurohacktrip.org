class Post < ActiveRecord::Base
	is_impressionable

	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]

	has_many :comments, dependent: :destroy
	
	validates :title, presence: true
	validates :content, presence: true

	# acts_as_taggable
	acts_as_taggable rescue nil
end
