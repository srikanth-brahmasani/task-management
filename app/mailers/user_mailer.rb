class UserMailer < ActionMailer::Base
  default from: "srikanth.brahmasani@gmail.com"

  def reminder_notification(user_email, subject)
    mail(to: user_email, subject: subject)
  end

end
