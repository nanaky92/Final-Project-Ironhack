class Api::VotationsController < ApplicationController
  def update
    @user = User.find(session[:id])

    @group = Group.find(params["group"])
    @appointments = Event.find(params["event"]).appointments

    @appointments.each do |appointment|
      votation = appointment.votations.find_by(user_id: @user.id)
      votation.update(result: params["votation"+votation.id.to_s], access: true)
    end

    # render json: @appointments
  end
end
