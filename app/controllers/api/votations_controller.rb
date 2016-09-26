class Api::VotationsController < ApplicationController

  def update
    @user = User.find(session[:id])

    @group = Group.find(params["group"])
    @event = Event.find(params["event"])
    @appointments = @event.appointments

    if !@event.deadlinePassed?
      @appointments.each do |appointment|
        votation = appointment.votations.find_by(user_id: @user.id)
        votation.update(result: params["votation"+votation.id.to_s], access: true)
      end
      render json: {
        message: "Votations updated",
        }, status: 200 
    else
      render json: {
        message: "Deadline has passed",
        }, status: 400 
    end

  end

  def finish
    @user = User.find(session[:id])

    @group = Group.find(params["group"])
    @event = Event.find(params["event"])

    if @group.admin.user == @user
      if @event.deadlinePassed?
        render json: {
          message: "Deadline has passed",
          }, status: 403 
      else
        @event.update(deadline: Time.now)
        render json: {
          message: "Deadline changed",
          }, status: 200       
      end
    else
      render json: {
        message: "Only the admin can finish this votation",
        }, status: 401 
    end
  end

end
