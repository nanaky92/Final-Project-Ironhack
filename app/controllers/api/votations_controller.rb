class Api::VotationsController < ApplicationController


  def update
    @user = User.find(session[:id])

    @group = Group.find(params["group"])
    @event = Event.find(params["event"])
    @appointments = @event.appointments

    if isDeadline?(@event.deadline)
      @appointments.each do |appointment|
        votation = appointment.votations.find_by(user_id: @user.id)
        votation.update(result: params["votation"+votation.id.to_s], access: true)
      end
      render json: {
        message: "Votations updated.",
        }, status: 200 
    else
      render json: {
        message: "Deadline has passed.",
        }, status: 400 
    end

  end
end
