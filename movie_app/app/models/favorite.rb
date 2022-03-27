class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, { presence: true, uniqueness: { scope: :user_id } }
end