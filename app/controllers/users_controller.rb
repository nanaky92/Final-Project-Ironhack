class UsersController < ApplicationController
  before_action :authenticate_user! 
  def index
    @user = User.find(params[:id])
    @groups = @user.groups
  end
end
