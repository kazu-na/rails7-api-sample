class Genre < ApplicationRecord
  has_many :movie_genre_managements, dependent: :destroy
  has_many :movies, through: :movie_genre_managements

  validates :genre_name, presence: true
end
