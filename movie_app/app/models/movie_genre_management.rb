class MovieGenreManagement < ApplicationRecord
  belongs_to :movie
  belongs_to :genre

  validates :movie_id, { presence: true, uniqueness: { scope: :genre_id } }
  validates :genre_id, presence: true
end