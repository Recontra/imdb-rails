class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :director, :rating, :year
end
