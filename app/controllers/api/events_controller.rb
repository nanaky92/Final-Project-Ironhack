class Api::EventsController < ApplicationController
  def send_reminders
    @user = User.find(session[:id])
    @group = Group.find(params["group"])
    @event = Event.find(params["event"])

    if @group.isUserAdmin?(@user)
      @appointments = @event.appointments
      @group.users.each do |user|
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

end
