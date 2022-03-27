class MoviesController < ApplicationController
  skip_before_action :authenticate_request

  # 映画一覧取得API
  # GET /movies
  #
  # @params
  #   [String] search 映画タイトル検索ワード example: アベンジャーズ
  #   [String] genre ジャンル example: アクション
  #   [String] sort ソート対象 example: popular
  #   [String] direction ソート順 asc, desc
  # @return
  #   [Integer] status HTTPステータスコード
  #   [Object] data
  #     [Integer] id 映画ID
  #     [String] title タイトル名
  #     [String] release_date 公開日
  #     [Integer] favorite_count お気に入り数
  def index
    movies = Movie.get_movie_lists(params).flatten

    render json: { status: 200, data: movies }
  end

  # 映画詳細取得API
  # GET /movies/:movie_id
  #
  # @return
  #   [Integer] status HTTPステータスコード
  #   [Object] data
  #     [Integer] id 映画ID
  #     [String] title タイトル名
  #     [String] description 概要
  #     [String] prod_country 製作国
  #     [String] description 概要
  #     [String] director 監督
  #     [String] release_date 公開日
  #     [String] running_time 上映時間
  #     [Array] genres ジャンル
  #     [Integer] favorite_count お気に入り数
  def show
    movie = Movie.get_movie_detail(params[:movie_id])
    # ジャンル取得
    genres = movie.genres.pluck(:genre_name)
    # お気に入り数
    favorite_count = movie.favorites.size

    render json: {
      status: 200,
      data: {
        id: movie.id,
        title: movie.title,
        description: movie.description,
        prod_country: movie.prod_country,
        director: movie.director,
        release_date: movie.release_date,
        running_time: movie.running_time.strftime("%H:%M"),
        genres: genres,
        favorite_count: favorite_count
      }
    }
  end
end
