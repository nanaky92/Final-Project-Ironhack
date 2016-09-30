class InvitationsController < ApplicationController
  before_action :authenticate_user! 

  #invite user to group
  def new
    @user = current_user
    @group = Group.find(params[:group_id])

    if(@group.isUserAdmin?(@user))
      @invitation = Invitation.new
    else
      flash[:alert] = 
        "Access forbidden: Only the admin of a group can invite people to the group"
      redirect_to group_url(params[:group_id])
    end
  end    

  def create
    @user = current_user
    @group = Group.find(params[:group_id])

    if(@group.isUserAdmin?(@user))
      @invited_user = User.find(params[:id])
      create_invitation_as_admin @invited_user, @group
      flash[:notice] = "Invitation sent"
    else
      flash[:alert] = 
        "Access forbidden: Only the admin of a group can invite people to the group"
    end
    redirect_to new_group_invitation_url(params[:group_id])
  end

  #destroy invitation without joining group
  def delete
    @invitation = Invitation.find(params[:id])
    @user = User.find(@invitation.user_id)
    @group = Group.find(@invitation.group_id)

    if destroy_has_sanitized_input?
      @invitation.delete
      flash[:notice] = "Invitation destroyed"
    end

    if @isUserAdmin
      redirect_to group_url
    else
      redirect_to groups_url
    end
  end

  #destroy invitation, join group, create votations
  def destroy
    @invitation = Invitation.find(params[:id])
    @user = User.find(@invitation.user_id)
    @group = Group.find(@invitation.group_id)

    if destroy_has_sanitized_input?
      @group.users.push(@user)
      @invitation.delete
      flash[:notice] = "You now belong to " + @group.name
      @group.events.each do |event|
        event.appointments.each do |appointment|
          Votation.create(user_id: @user.id, appointment_id: appointment.id, result: 50, access: false)
        end
      end
    end
    redirect_to groups_url
  end

  private

    def invitation_params
      params.require(:invitation).permit(:user)
    end

    def existance?(obj)
      if(!obj)
        flash[:alert] = "This " + obj.class + " does not exist"
      end
      obj
    end

    def destroy_has_sanitized_input?
      sanitized = true

      @isUserAdmin = @group.isUserAdmin?(current_user)
      
      if(@group.id != params[:group_id].to_i)
        flash[:alert] = "Invitation doesn't belong to group"
        sanitized = false
      elsif(!existance?(@invitation) || !existance?(@user) || !existance?(@group))
        flash[:alert] = "Wrongly formed invitation. Invitation deleted"
        @invitation.delete
        sanitized = false      
      elsif(current_user != @user && !@isUserAdmin)
        flash[:alert] =
          "Access forbidden: Only the recipient of a group or the admin of a group can use an invitation"
        sanitized = false
      elsif(@group.users.include?(@user) && !@isUserAdmin)
        flash[:alert] = "User already exists"
        @invitation.delete
        sanitized = false        
      end
      return sanitized
    end

    def create_invitation_as_admin invited_user, group
      if(invited_user && group)
        if(group.users.include? invited_user)
          flash[:alert] = "User already belongs to group"
        else
          begin 
            Invitation.create(user_id: invited_user.id, group_id: group.id)
            flash[:notice] = "Invitation successfully sent"
          rescue 
            flash[:alert] = "Invitation already exists"
            #Do you want to renew?
          end
        end
      else
        flash[:alert] = "No user or no group with described parameters"
      end

  end
end
