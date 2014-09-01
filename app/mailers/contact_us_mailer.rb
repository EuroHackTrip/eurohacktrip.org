class ContactUsMailer < ActionMailer::Base
  # default :from => "#{@message.email}"
  default :to => "info@eurohacktrip.org"

  def new_message(message)
    @message = message
    # render json: @message
    # URI.extract(@message[:subject])
    # unless @message.subject =~ %r{\Ahttp?://www.google.com\z}i    
    unless !URI.extract(@message[:subject]).blank? || !@message[:message].blank?
    	mail(:subject => "[EuroHackTrip] #{@message.subject}", from: "#{@message.email}")
    end
    # mail(to: "info@eurohacktrip.org", subject: "Testing here")
  end
end
