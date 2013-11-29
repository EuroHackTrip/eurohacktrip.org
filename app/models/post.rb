class Post < ActiveRecord::Base
	is_impressionable

	#self.per_page = PostSetting.last.posts_per_page

	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]

	has_many :comments, dependent: :destroy
	
	validates :title, presence: true
	validates :content, presence: true

	acts_as_taggable
end
