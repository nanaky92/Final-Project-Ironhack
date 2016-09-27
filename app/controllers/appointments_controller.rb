class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin, except: [:show, :index]

  def index
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @user = current_user
    @appointments = @event.appointments

    @isAdmin = @group.isUserAdmin?(current_user)

    @event_results = @event.get_results
    @winner_appointment = @event.get_winner

    @users_who_wont_come = @winner_appointment.get_users_who_wont_come 
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
      render :new
      return
    end

    @group = Group.find params[:group_id]
    @group.users.each do |user|
      votation = Votation.create(user_id: user.id, appointment_id: @appointment.id, result: 50)
    end

    redirect_to group_event_url(@group.id, @event.id)
  end

  def show
    @user = current_user

    @group = Group.find params[:group_id]
    @users_group = @group.users

    @event = Event.find params[:event_id]
    @appointment = Appointment.find(params[:id])

    @number_voters = @appointment.get_number_of_voters
    number_users = @users_group.length
    @number_non_voters = number_users - @number_voters

    unless (@appointment.event == @event and @event.group == @group and @users_group.include?(@user))
      render plain: "Error"
    end

    @votations = @appointment.votations
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
        "Access forbidden: Only the admin of a group can access this"
        redirect_to group_event_url(params[:group_id], params[:event_id])
      end
    end
end
