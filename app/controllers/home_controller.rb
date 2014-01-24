class HomeController < ApplicationController
  def index
  	@message = Message.new
  end
end
