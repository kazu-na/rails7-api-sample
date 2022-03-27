class UsersController < ApplicationController
  # お気に入り映画一覧取得API
  # GET /favorites
  #
  # @return
  #   [Integer] status HTTPステータスコード
  #   [Object] data
  #     [Integer] id 映画ID
  #     [String] title タイトル名
  #     [String] release_date 公開日
  #     [Integer] favorite_count お気に入り数
  def favorite_list
    favorite_movies = Movie.get_favorite_movie_lists(@current_user.id).flatten

    render json: { status: 200, data: favorite_movies }
  end

  # お気に入り映画追加API
  # POST /favorites/:movie_id
  #
  # @return
  #   [Integer] status HTTPステータスコード
  #   [String] message メッセージ
  def add_favorite
    Favorite.add_favorite(@current_user.id, params[:movie_id])

    render json: { status: 200, message: 'add favorite' }
  end
end
