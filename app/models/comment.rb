class Comment < ActiveRecord::Base
  belongs_to :post
  validates :commenter, presence: true
  validates :email, presence: true
  validates :website, presence: true
  validates :content, presence: true
end
