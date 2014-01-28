class ContactUsMailer < ActionMailer::Base
  default :from => "thedevsorg@gmail.com"
  default :to => "info@thedevs.org"

  def new_message(message)
    @message = message
    mail(:subject => "[EuroHackTrip] #{@message.subject}")
    # mail(to: "muadh24@gmail.com", subject: "Hey")
  end
end
