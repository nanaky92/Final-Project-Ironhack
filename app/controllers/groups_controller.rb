class GroupsController < ApplicationController
  before_action :authenticate_user! 

  def new
    @user = current_user
    @group = Group.new
    # render plain: "Crear nuevo grupo"
  end

  def create
    @group = Group.create(group_params)
    redirect_to action: "index"
  end

  def index
    @user = current_user
    render json: @user.groups
  end

  def show
    @user = current_user
    @group = Group.find(params[:group_id])
    @users = @group.users
    render plain: "Aqui va el grupo"
  end

  def exit
    @user = current_user
    @group = Group.find(params[:group_id])
    render plain: "Exit del grupo"
  end

  def invite_user
    @user = current_user
    @group = Group.find(params[:group_id])
    render plain: "Invite user"
  end    

  def delete_user
    @user = current_user
    @group = Group.find(params[:group_id])
    render plain: "Delete user"
  end    

  private

    def group_params
      params.require(:group).permit(:name)
    end

end
