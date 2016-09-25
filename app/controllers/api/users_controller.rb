class Api::UsersController < ApplicationController
  def show
    user = User.where("name LIKE ?", "%#{params[:key]}%")
    render json: user
  end
end
