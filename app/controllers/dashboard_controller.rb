class DashboardController < ApplicationController
	before_action :authenticate_admin!
  def index
  	@post = Post.new
  	@country = Country.new
  	@city = City.new
  	@person = Person.new
  	@event = Event.new
  	@post_setting = PostSetting.last
  	@post_setting_new = PostSetting.new
  end
end