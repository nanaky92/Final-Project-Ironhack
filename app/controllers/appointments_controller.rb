class AppointmentsController < ApplicationController
  before_action :authenticate_user! 

  def index
    @group = Group.find params[:group_id]
    @event = Event.find params[:event_id]
    @appointments = @event.appointments
# isUserAdmin
    # render plain: "Estamos trabajando en ello"
  end

  def new
    @group = Group.find params[:group_id]
    @event = Event.find params[:event_id]
    @appointment = Appointment.new
    # render plain: "Estamos trabajando en ello"
  end

  def create
    @event = Event.find params[:event_id]
    @appointment = Appointment.create(appointment_params)
    # raise @appointment
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
end
