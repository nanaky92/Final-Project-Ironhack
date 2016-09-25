class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin 

  def index
    @appointments = @event.appointments
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.create(appointment_params)
    if @appointment.id
      flash[:notice] = "Meetup created"
    else
      flash[:alarm] = "Meetup couldn't be created"
    end

    @group = Group.find params[:group_id]
    @group.users.each do |user|
      votation = Votation.create(user_id: user.id, appointment_id: @appointment.id, result: 50)
    end

    redirect_to group_event_appointments_url(@group.id, @event.id)
  end

  private

    def appointment_params
      hash = params.require(:appointment).permit(:action, :place, :event_id)

      app_params = params[:appointment]

      hash[:time] = Time.new(app_params["time(1i)"], app_params["time(2i)"], 
        app_params["time(3i)"], app_params["time(4i)"], app_params["time(5i)"])
      hash
    end

    def authenticate_admin
      @group = Group.find params[:group_id]
      @event = Event.find params[:event_id]
      unless @group.isUserAdmin?(current_user)
        flash[:alert] = 
        "Access forbidden: Only the admin of a group can add meetups"
        redirect_to group_event_url(params[:group_id], params[:event_id])
      end
    end
end
