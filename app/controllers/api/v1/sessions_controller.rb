class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: create_params[:email])
    if user && user.authenticate(create_params[:password])
      self.current_user = user
      render json: user, status: 201
    else
      render json: { error: "Not Found" }, status: 404
    end
  end

  private

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
