class Movie < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :movie_genre_managements, dependent: :destroy
  has_many :genres, through: :movie_genre_managements

  validates :title, presence: true
end
