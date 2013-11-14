require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "a commenter should enter a name" do
  	comment = Comment.new
     assert !comment.save
     assert !comment.errors[:commenter].empty?
   end

   test "a commenter should enter an email" do
  	comment = Comment.new
     assert !comment.save
     assert !comment.errors[:email].empty?
   end

   test "a commenter should enter a website" do
  	comment = Comment.new
     assert !comment.save
     assert !comment.errors[:website].empty?
   end

   test "a commenter should enter a comment" do
  	comment = Comment.new
     assert !comment.save
     assert !comment.errors[:content].empty?
   end
end
