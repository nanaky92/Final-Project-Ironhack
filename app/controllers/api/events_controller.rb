class Api::EventsController < ApplicationController
  def send_reminders
    @user = User.find(session[:id])
    @group = Group.find(params["group"])
    @event = Event.find(params["event"])

    if @group.isUserAdmin?(@user)

      filter_users.each do |user|
        EventMailer.reminder_votation(user, @group, @event).deliver_later
      end
      render json: {
        message: "Reminders sent",
        }, status: 200 
    else
      render json: {
        message: "You don't have permission for this",
        }, status: 400 
    end
  end

  def filter_users
    @votations = @event.votations.find_by(access: true)

    @users = []
    @votations.each do |votation|
      @users.push(votation.user)
    end
    return @users
  end

end
