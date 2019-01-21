class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email user
    @user = user
    mail(to: @user.email, subject: 'Order Success')
  end
end
