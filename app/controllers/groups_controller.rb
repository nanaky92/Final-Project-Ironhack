class GroupsController < ApplicationController
  before_action :authenticate_user! 

  def new

    @user = current_user
    @group = Group.new
    
  end

  def create

    @admin = Admin.create({user_id: current_user.id})
    @group = Group.create({name: params[:group][:name], admin_id: @admin.id})

    if @admin.id && @group.id
      flash[:notice] = "Group created successfully"
      @group.users.push(current_user)
      # GroupMailer.welcome(current_user).deliver_later
      GroupMailer.welcome(current_user).deliver_later
      redirect_to group_url(@group.id)
      return
    elsif @admin_id
      flash[:alert] = "Group couldn't be created"
    elsif @group_id
      flash[:alert] = "Admin couldn't be created"
    else
      flash[:alert] = "Neither admin nor group could be created"
    end

    redirect_to show_user_url

  end

  def show

    @user = current_user
    @group = Group.find(params[:id])
    @users = @group.users
    @isUserAdmin = @group.isUserAdmin?(@user)
    @events = @group.events

  end


  def delete_user
    @group = Group.find(params[:group_id])
    @user = User.find(params[:user_id])

    # if(isUserAdmin?(params[:group_id]))
    if(@group.isUserAdmin?(@user))
      if(@group.admin.user == @user)
        flash[:alert] = "User to delete is the admin of the group and cannot be deleted"
      else
        @group.users.delete(@user)
        flash[:notice] = "User successfully deleted from group"
      end
    else
      flash[:alert] = "Current user is not the admin of the group and cannot delete other users"
    end

    redirect_to group_url(@group)
  end    

  def exit_group  

    @group = Group.find(params[:group_id])

    if(@group.admin.user == current_user)
      flash[:alert] = "You are the admin of the group and cannot be deleted from group"
    else
      votations = Votation.where(user_id: current_user.id)
      votations.each do |votation|
        if votation.appointment.event.group == @group
          votation.destroy
        end
      end
      @group.users.delete(current_user)
      flash[:notice] = "You were successfully deleted from group"
    end

    redirect_to "/"

  end    


  def destroy
    @group = Group.find(params[:id])
    @user = current_user
    @admin = @group.admin

    if(@group)
      if(@group.isUserAdmin?(@user))
        @group.destroy
        flash[:notice] = "Group successfully destroyed"
      else
        flash[:alert] = "You are not the admin of the group, and you cannot destroy the group"      
      end
    end

    redirect_to "/"
  end
  
  private

    def group_params
      params.require(:group).permit(:name)
    end

end
