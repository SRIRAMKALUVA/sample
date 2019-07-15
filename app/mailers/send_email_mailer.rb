class SendEmailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_email_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(:to=> user.email, :subject=> "Welcome to rails learnig")
  end
  def very_email(user)
    @user = user
    mail(:to=> user.email, :subject=> "Click on below link to become admin")
  end
end
