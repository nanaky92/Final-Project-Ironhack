class EventMailer < ApplicationMailer
  def reminder_votation(user, group, event)
    @user = user
    @group = group
    @event = @event

    @url = 'https://coodle-hackshow.herokuapp.com/groups/' + @group.id + '/invitations/new'
    mail(to: @user.email, subject: @group.name + " created")
  end
end
