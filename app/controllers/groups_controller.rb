class GroupsController < ApplicationController
  before_action :authenticate_user! 

  def new
    @user = current_user
    @group = Group.new
    # render plain: "Crear nuevo grupo"
  end

  def create
    @group = Group.create({name: params[:group][:name], admin_id: current_user.id})
    @group.users.push(current_user)
    redirect_to "/groups/#{@group.id}"
  end

  def show
    @user = current_user
    @group = Group.find(params[:group_id])
    @users = @group.users
    @isUserAdmin = isUserAdmin?(params[:group_id])
  end

  def invite_user
    @user = current_user
    @group = Group.find(params[:group_id])
    render plain: "Invite user"
  end    

  def delete_user
    @isUserAdmin = isUserAdmin?(params[:group_id])
    
    @group = Group.find(params[:group_id])

    if(@isUserAdmin)
      if(@group.admin == current_user)
        flash[:alert] = "User to delete is the admin of the group and cannot be deleted"
        # render plain: "Admins cannot leave the group"
        # sleep(4.0)
      else
        @group.users.delete(current_user)
        flash[:notice] = "User successfully deleted from group"
      end
    else
      flash[:alert] = "Current user is not the admin of the group and cannot delete other users"
      # render plain: "Access forbidden"
      # sleep(4.0)
    end

    # redirect_to action: "users#show"
    redirect_to "/"
  end    

  private

    def group_params
      params.require(:group).permit(:name)
    end

    def isUserAdmin?(group_id)
      current_user == Group.find(group_id).admin
    end

end
