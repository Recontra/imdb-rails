class Api::V1::MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    movies = Movie.by_title(params[:title])
                  .rating_from(params[:rating_from])
                  .rating_to(params[:rating_to])
                  .by_actor(params[:actor])
                  .by_director(params[:director])

    movies = paginate(movies)
    render json: movies, meta: meta_attributes(movies)
  end

  def create
    movies = Imdb::Search.new(create_params[:title]).movies

    if movies.first.nil?
      render json: { error: "Movie not found" }, status: 404
    else
      movie = movies.first

      m = Movie.create(
        title: movie.title(true),
        director: movie.director,
        rating: movie.rating,
        year: movie.year,
        plot: movie.plot,
        poster_url: movie.poster,
        votes: movie.votes,
        imdb_id: movie.id,
        cast_members: movie.cast_members,
        auto_imported: true
      )

      render json: m, status: 201
    end
  end

  private

  def create_params
    params.require(:movie).permit(:title, :year)
  end
end
