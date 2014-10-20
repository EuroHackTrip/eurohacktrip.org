class HomeController < ApplicationController
  def index
    @message = Message.new
    @page_type = 'Home'
    @title = Time.now.year.to_s
    render "home/"+Time.now.year.to_s
  end

  def about
    @title = 'About'
    render "home/about"
  end

  def attendees
    @title = 'Attendees'
    render "home/attendees"
  end

  def campaign
    @title = 'Campaign'
    render "home/campaign"
  end

  def year
    @message = Message.new
    @id = params[:id]
    # render json: @id
    # render json: range(2014, 2017)
    if @id == "2014"
      @title = @id
      render "home/"+@id
    else
      redirect_to action: "index"
    end
  end

  def partnership
    @title = 'Partnership'
    render "home/partnership"
  end

  def partner
    redirect_to "#"
    # redirect_to "http://indiegogo.com/eurohacktrip"
  end

end
