class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    return api_error(status: 422, errors: user.errors) unless user.valid?

    user.save!
    render json: user
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
