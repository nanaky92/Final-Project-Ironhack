class VotationsController < ApplicationController

  before_action :authenticate_user! 

  def index
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @user = current_user
    @appointments = @event.appointments

    @appointments_result = {}
    @appointments.each do |appointment|
      accessed_app = appointment.votations.where(access: true)
      number_voters = accessed_app ? accessed_app.length : 0
      @appointments_result[appointment.id] = 
        {average: appointment.votations.average(:result), number: number_voters}
    end

    @isAdmin = @group.isUserAdmin?(current_user)
  end
end
