class GroupMailer < ApplicationMailer
  def welcome(user)
    @user = user
    @url = 'https://coodle-hackshow.herokuapp.com/groups/'
    mail(to: @user.email, subject: 'Welcome to Taskly')
  end

  def welcome_new_group(user, group)
    @user = user
    @group = group
    @url = 'https://coodle-hackshow.herokuapp.com/groups/' + @group.id + '/invitations/new'
    mail(to: @user.email, subject: @group.name + " created")
  end

end
