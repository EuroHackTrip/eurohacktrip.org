class MessagesController < ApplicationController

  def new
    @message = Message.new
  end
  
  def create
  	@message = Message.new(params[:message])
    
    if @message.valid?
      ContactUsMailer.new_message(@message).deliver
      redirect_to(:back, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      # render "/#contact"
      redirect_to(:back, :error => "Message not sent.")
    end
  end
end
