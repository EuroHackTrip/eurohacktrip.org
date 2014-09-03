class DashboardController < ApplicationController
	before_action :authenticate_user!
  def index
  	@post = Post.new
  	@country = Country.new
  	@city = City.new
    @startup = Startup.new
    @stop = Stop.new
  	@post_setting = PostSetting.last
  	@post_setting_new = PostSetting.new
    @image = Image.last
    @image_new = Image.new
  end
end