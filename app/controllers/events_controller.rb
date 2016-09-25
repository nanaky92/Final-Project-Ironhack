class EventsController < ApplicationController
  before_action :authenticate_user! 

  def new
    @group = Group.find(params[:group_id])

    if(@group.isUserAdmin?(current_user))
      @user = current_user
      @event = Event.new(group_id: @group.id)
    else
      flash[:alert] = "Access forbidden: Only the admin of a group can create an event in the group"
      redirect_to group_url(params[:group_id])
    end
    # render plain: "Invite user"
  end 

  def create
    @group = Group.find(params[:event][:group_id])
    
    if(@group.isUserAdmin?(current_user))
      @event = Event.create(event_params)
      redirect_to group_event_appointments_url(params[:group_id], @event.id)
    else
      flash[:alert] = "Access forbidden: Only the admin of a group can create events"
      redirect_to group_url(params[:group_id])
    end
  end

  def show
    @user = current_user
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
    @appointments = @event.appointments

    @appointments_votation_map = {}
    @appointments.each do |appointment|
      @appointments_votation_map[appointment.id] = appointment.votations.find_by(user_id: @user.id)
    end
    session[:id] = @user.id
  end


  private

    def event_params
      hash = params.require(:event).permit(:name, :description, :group_id)

      ev_params = params[:event]

      hash[:deadline] = Time.new(ev_params["deadline(1i)"], ev_params["deadline(2i)"], 
        ev_params["deadline(3i)"], ev_params["deadline(4i)"], ev_params["deadline(5i)"])

      hash
    end

end
