class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :director, :rating, :year, :cast_members, :auto_imported,
              :imdb_id, :plot, :poster_url, :votes
end
