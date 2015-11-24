class Movie < ActiveRecord::Base
  scope :auto_imported, -> { where(auto_imported: true) }
  scope :by_title, -> (title) { title.present? ? where("title ILIKE ?", "%#{title}%") : all }
  scope :rating_from, -> (rating) { rating.present? ? where("rating > ?", rating.to_f) : all }
  scope :rating_to, -> (rating) { rating.present? ? where("rating < ?", rating.to_f) : all }
  scope :by_actor, -> (actor) { actor.present? ? where("? = ANY (cast_members)", actor) : all }
  scope :by_director, -> (director) { director.present? ? where("? = ANY (director)", director) : all }
end
