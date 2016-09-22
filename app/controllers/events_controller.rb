class EventsController < ApplicationController
  before_action :authenticate_user! 

  def new
    if(is_user_admin?(params[:group_id]))
      @user = current_user
      @group = Group.find(params[:group_id])
      @event = Event.new(group_id: @group.id)
    else
      flash[:alert] = "Access forbidden: Only the admin of a group can create an event in the group"
      redirect_to show_group_url(params[:group_id])
    end
    # render plain: "Invite user"
  end 

  def create
    if(is_user_admin?(params[:event][:group_id]))
      @event = Event.create(event_params)
      redirect_to appointments_url(params[:group_id], @event.id)
    else
      flash[:alert] = "Access forbidden: Only the admin of a group can invite people to the group"
      redirect_to show_group_url(params[:group_id])
    end
  end

  def show
    @user = current_user
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @appointments = @event.appointments
  end


  private

  def is_user_admin?(group_id)
    current_user == Group.find(group_id).admin.user
  end

  def event_params
    hash = params.require(:event).permit(:name, :description, :group_id)

    ev_params = params[:event]

    hash[:deadline] = Time.new(ev_params["deadline(1i)"], ev_params["deadline(2i)"], 
      ev_params["deadline(3i)"], ev_params["deadline(4i)"], ev_params["deadline(5i)"])

    hash
  end

end
