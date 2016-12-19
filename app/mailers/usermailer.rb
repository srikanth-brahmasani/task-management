class Usermailer < ActionMailer::Base
  default from: "srikanth.brahmasani@gmail.com"
  require 'pony'

  def reminder_notification(user_email, subject)
    Rails.logger.debug 'test_email'
    Pony.mail(:to => 'srikanth.brahmasani@gmail.com', :from => 'srikanth@freshdesk.com', :subject => 'Test Email', :body => subject)

  end


end
