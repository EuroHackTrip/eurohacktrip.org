class DashboardController < ApplicationController
	before_action :authenticate_admin!
  def index
  	@post = Post.new
  end

end
