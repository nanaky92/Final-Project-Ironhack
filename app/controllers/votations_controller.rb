class VotationsController < ApplicationController

  before_action :authenticate_user! 

  def index
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @user = current_user
    @appointments = @event.appointments

    max = 0
    index = 0
    @appointments_result = {}
    @appointments.each do |appointment|
      @appointments_result[appointment.id] = {average: appointment.get_average, number: appointment.get_number_of_voters}
    end

    @isAdmin = @group.isUserAdmin?(current_user)

    @winner_appointment = Appointment.get_winner(@appointments_result)

    @users_who_wont_come = @winner_appointment.get_users_who_wont_come 
  end

end
