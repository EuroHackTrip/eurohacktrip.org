class Post < ActiveRecord::Base
	#is_impressionable

	has_many :comments, dependent: :destroy
	
	validates :title, presence: true
	validates :content, presence: true

	acts_as_taggable
end
