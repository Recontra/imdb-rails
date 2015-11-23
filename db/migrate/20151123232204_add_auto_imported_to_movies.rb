class AddAutoImportedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :auto_imported, :boolean
  end
end
