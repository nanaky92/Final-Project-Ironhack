class GroupsController < ApplicationController
  before_action :authenticate_user! 


  #form to create new user
  def new
    @user = current_user
    @group = Group.new
  end

  #creates new user and redirects to show
  def create
    @group = Group.create({name: params[:group][:name], admin_id: current_user.id})
    @group.users.push(current_user)
    redirect_to show_group_url(@group.id)
  end

  #shows the group
  def show
    @user = current_user
    @group = Group.find(params[:group_id])
    @users = @group.users
    @isUserAdmin = isUserAdmin?(params[:group_id])
  end

  #delete user from group
  def delete_user
    @isUserAdmin = isUserAdmin?(params[:group_id])
    
    @group = Group.find(params[:group_id])

    if(@isUserAdmin)
      if(@group.admin == current_user)
        flash[:alert] = "User to delete is the admin of the group and cannot be deleted"
      else
        @group.users.delete(current_user)
        flash[:notice] = "User successfully deleted from group"
      end
    else
      flash[:alert] = "Current user is not the admin of the group and cannot delete other users"
    end

    redirect_to "/"
  end    

  def exit_group    
    @group = Group.find(params[:group_id])

    if(@group.admin == current_user)
      flash[:alert] = "You are the admin of the group and cannot be deleted from group"
    else
      @group.users.delete(current_user)
      flash[:notice] = "You were successfully deleted from group"
    end

    redirect_to "/"
  end    


  # finish
  def destroy
    if(@isUserAdmin)
      Group.find(params[:group_id]).destroy
    end
  end
  
  private

  def group_params
    params.require(:group).permit(:name)
  end

  def isUserAdmin?(group_id)
    current_user == Group.find(group_id).admin
  end

end
