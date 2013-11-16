require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "The title of the post should be entered" do
  	post = Post.new
     assert !post.save
     assert !post.errors[:title].empty?
   end

   test "The body of a post should be entered" do
  	post = Post.new
     assert !post.save
     assert !post.errors[:content].empty?
   end
end
