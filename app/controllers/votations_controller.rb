class VotationsController < ApplicationController
  before_action :authenticate_user! 

  def update
    @user = current_user
    @group = Group.find(params[:group_id])
    @appointments = Event.find(params[:event_id]).appointments
    @data = params[:data]

    @appointments.each do |appointment|
      votation = appointment.votations.find_by(user_id: @user.id)
      votation.update(result: @data["votation"+votation.id.to_s], access: true)
    end
      
  end
end
