class Movie < ActiveRecord::Base
  scope :auto_imported, -> { where(auto_imported: true) }
end
