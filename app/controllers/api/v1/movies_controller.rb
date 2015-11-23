class Api::V1::MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Movie.all
  end
end
