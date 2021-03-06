class EventsController < ApplicationController
  before_action :authenticate_user! 


  def show
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
    @user = current_user
    @appointments = @event.appointments

    @isAdmin = @group.isUserAdmin?(current_user)

    @event_results = @event.get_results
    winner_id = @event.get_winner_id

    if winner_id == -1
      flash[:alert] = "Empty event. Please add a meetup before seeing the results"
      redirect_to group_event_vote_url(@group.id, @event.id)
    else
      @winner_appointment = Appointment.find(winner_id)
      @users_who_wont_come = @winner_appointment.get_users_who_wont_come 
    end

  end

  def new
    @group = Group.find(params[:group_id])

    if(@group.isUserAdmin?(current_user))
      @user = current_user
      @event = Event.new(group_id: @group.id)
    else
      flash[:alert] = "Access forbidden: Only the admin of a group can create an event in the group"
      redirect_to group_url(params[:group_id])
    end
  end 

  def create
    @group = Group.find(params[:event][:group_id])
    
    if(@group.isUserAdmin?(current_user))
      @event = Event.create(event_params)
      if (@event.id)
        flash[:notice] = "Event created"
        redirect_to group_event_vote_url(params[:group_id], @event.id)
      else
        flash[:alert] = "Error creating event"
        render :new
        # redirect_to new_group_event_url(@group.id)
      end
    else
      flash[:alert] = "Access forbidden: Only the admin of a group can create events"
      redirect_to group_url(params[:group_id])
    end
  end

  def edit
    authenticate_admin
  end

  def update
    authenticate_admin
    if @event.update(event_params) 
      flash[:notice] = "Event updated"
      redirect_to group_event_vote_url(params[:group_id], @event.id)
    else
      # redirect_to edit_group_event_url(@group.id, @event.id)
      render :edit
    end
         
  end

  def vote
    @user = current_user
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @appointments = @event.appointments

    @appointments_votation_map = {}
    @appointments.each do |appointment|
      @appointments_votation_map[appointment.id] = appointment.votations.find_by(user_id: @user.id)
    end

    @isUserAdmin = @group.isUserAdmin?(current_user)
  end

  def destroy
    authenticate_admin
    @user = current_user

    @appointments = @event.appointments

    if @event.destroy
      flash[:notice] = "Event destroyed"
    else
      flash[:alert] = "Event couldn't be destroyed"
    end

    redirect_to group_url(params[:group_id])    
  end

  private

    def event_params
      hash = params.require(:event).permit(:name, :description, :group_id)

      ev_params = params[:event]

      hash[:deadline] = Time.new(ev_params["deadline(1i)"], ev_params["deadline(2i)"], 
        ev_params["deadline(3i)"], ev_params["deadline(4i)"], ev_params["deadline(5i)"])

      hash
    end

    def authenticate_admin
      @group = Group.find params[:group_id]
      @event = Event.find params[:id]
      unless @group.isUserAdmin?(current_user)
        flash[:alert] = 
        "Access forbidden: Only the admin of a group can access this"
        redirect_to group_event_vote_url(params[:group_id], params[:id])
      end
    end

end
