class Api::V1::MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    movies = Movie.by_title(params[:title])
                  .rating_from(params[:rating_from])
                  .rating_to(params[:rating_to])
                  .by_actor(params[:actor])
                  .by_director(params[:director])
                  .order(sort_column + " " + sort_direction)

    movies = paginate(movies)
    render json: movies, meta: meta_attributes(movies)
  end

  def create
    movies = Imdb::Search.new(create_params[:title]).movies
    movie = movies.first

     existing = (Movie.where(imdb_id: movie.id).count > 0) unless movie.nil?

    if movie.nil?
      render json: { error: "Movie not found" }, status: 404
    elsif existing
      render json: { error: "Movie already exists" }, status: 404
    else
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
        auto_imported: false
      )

      render json: m, status: 201
    end
  end

  def update
    current_movie = Movie.find(params[:id])

    movies = Imdb::Search.new(create_params[:title]).movies

    if movies.first.nil?
      render json: { error: "Movie not found" }, status: 404
    else
      movie = movies.first

      current_movie.update_attributes({
        title: movie.title(true),
        director: movie.director,
        rating: movie.rating,
        year: movie.year,
        plot: movie.plot,
        poster_url: movie.poster,
        votes: movie.votes,
        imdb_id: movie.id,
        cast_members: movie.cast_members,
        auto_imported: false
      })

      render json: current_movie, status: 201
    end
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def destroy
    movie = Movie.find(params[:id])
    if movie.destroy
      render json: {}, status: 200
    else
      render json: { error: "Movie can't be deleted" }, status: 404
    end
  end

  private

  def create_params
    params.require(:movie).permit(:title, :year)
  end

  def sort_column
    ['title','rating', 'year'].include?(params[:sort]) ? params[:sort] : "rating"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
