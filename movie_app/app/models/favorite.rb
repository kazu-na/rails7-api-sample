class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, { presence: true, uniqueness: { scope: :user_id } }

  # お気に入り映画追加
  #
  # @param [Integer] user_id ユーザーID
  # @param [Integer] movie_id 映画ID
  def self.add_favorite(user_id, movie_id)
    create!({ user_id: user_id, movie_id: movie_id })
  end
end
