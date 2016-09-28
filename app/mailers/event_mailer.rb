class EventMailer < ApplicationMailer
  def reminder_votation(user, group, event)
    @user = user
    @group = group
    @event = event
    @admin_name = @group.admin.user.name

    @url = group_event_vote_url(@group.id, @event.id)
    mail(to: @user.email, subject: "Reminder: Votation for " + @event.name )
  end
end
