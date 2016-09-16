class GroupsController < ApplicationController
  before_action :authenticate_user! 

  def new
    @user = User.find(params[:id])
    render plain: "Crear nuevo grupo"
  end

  def index
    # render plain: user_signed_in?
    # session[:bugs] = "Hay mi madre el Bixo"
    # render plain: user_session

    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])

    render plain: current_user.id == params[:id]

    @users = @group.users
    # render plain: "Aqui va el grupo"
  end

  def exit
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
    render plain: "Exit del grupo"
  end

  def invite_user
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
    render plain: "Invite user"
  end    

  def delete_user
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
    render plain: "Delete user"
  end    

end
