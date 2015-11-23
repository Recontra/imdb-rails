class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director, array: true
      t.float :rating
      t.integer :year
      t.string :plot
      t.string :poster_url
      t.integer :votes
      t.string :imdb_id
      t.string :cast_members, array: true

      t.timestamps null: false
    end
  end
end
