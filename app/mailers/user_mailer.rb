class UserMailer < ActionMailer::Base
  default from: "juflo@bnb.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Hi"

    mail(to: @user.email, subject: "Welcome in the new airbnb")
  end
end
