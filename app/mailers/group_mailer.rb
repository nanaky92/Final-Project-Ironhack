class GroupMailer < ApplicationMailer
  def welcome(user)
    @user = user
    @url = 'http://myapp.com/'
    mail(to: @user.email, subject: 'Welcome to Taskly')
  end
end
