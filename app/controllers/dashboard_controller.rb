class DashboardController < ApplicationController
	before_action :authenticate_admin!
  def index
  	@post = Post.new
  	@country = Country.new
  	@city = City.new
  	@person = Person.new
  end
end
