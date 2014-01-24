class ContactUsMailer < ActionMailer::Base
  default :from => "misc.library@gmail.com"
  default :to => "muadh24@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "[YourWebsite.tld] #{message.subject}")
    # mail(to: "muadh24@gmail.com", subject: "Hey")
  end
end
