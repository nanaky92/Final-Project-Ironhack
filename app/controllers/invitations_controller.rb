class InvitationsController < ApplicationController
  before_action :authenticate_user! 

  #invite user to group
  def new
    if(is_user_admin?(params[:group_id]))
      @user = current_user
      @group = Group.find(params[:group_id])
      @invitation = Invitation.new
    else
      flash[:alert] = 
        "Access forbidden: Only the admin of a group can invite people to the group"
      redirect_to show_group_url(params[:group_id])
    end
    # render plain: "Invite user"
  end    

  def create
    if(is_user_admin?(params[:group_id]))
      # @user = current_user
      @invited_user = User.find(params[:invited_id])
      @group = Group.find(params[:group_id])

      create_invitation_as_admin @invited_user, @group 
    else
      flash[:alert] = 
        "Access forbidden: Only the admin of a group can invite people to the group"
    end
    redirect_to new_invitation_url(params[:group_id])
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @user = User.find(@invitation.user_id)
    @group = Group.find(@invitation.group_id)

    if existance?(@invitation) and existance?(@user) and existance?(@group)
      if(current_user != @user)
        flash[:alert] = 
          "Access forbidden: Only the recipient of a group can invite people to the group"
        redirect_to show_user_url
      else
        begin
          if @group.users.include?(@user)
            flash[:alert] = "User already exists"
          else
            @group.users.push(@user)
            @invitation.delete
            flash[:notice] = "You now belong to " + @group.name
          end
        rescue
          flash[:alert] = "User already exists"
        end
      end
    end
    redirect_to show_user_url        
  end

  private

  def invitation_params
    params.require(:invitation).permit(:user)
  end

  def is_user_admin?(group_id)
    current_user == Group.find(group_id).admin.user
  end

  def existance?(obj)
    if(!obj)
      flash[:alert] = "This " + obj.class + " does not exist"
    end
    obj
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
