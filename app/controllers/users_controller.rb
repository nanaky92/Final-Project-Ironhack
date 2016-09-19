class UsersController < ApplicationController
  before_action :authenticate_user! 

  def show
    @user = current_user
    @groups = @user.groups
    @invitations = @user.invitations
    # GroupMailer.welcome(current_user).deliver_now
  end

end
