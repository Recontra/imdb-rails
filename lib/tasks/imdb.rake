namespace :imdb do
  desc "Import top 250 movies from imdb"
  task import_top_250: :environment do
    Movie.auto_imported.destroy_all

    Imdb::Top250.new.movies.each_with_index do |movie, i|
     next if i%2 == 1
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
    end
  end

end
