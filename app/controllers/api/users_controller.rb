class Api::UsersController < ApplicationController
  def show
    user = User.where("name LIKE ?", "%#{params[:key]}%")
    # user = User.find_by(name: params[:key])
    render json: user
  end
end
