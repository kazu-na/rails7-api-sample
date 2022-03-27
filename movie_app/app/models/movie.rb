class Movie < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :movie_genre_managements, dependent: :destroy
  has_many :genres, through: :movie_genre_managements

  validates :title, presence: true

  # 映画一覧取得
  #
  # @param [Hash] params クエリパラメータ
  # @return [Array]
  def self.get_movie_lists(params)
    movies = eager_load(:genres, :favorites).distinct

    # 映画タイトル検索ワードがある場合は、タイトル名にワードを含む映画を返却する
    movies = movies.where("title LIKE ?", "%#{params[:search]}%") if params[:search].present?

    # ジャンル指定がある場合は、対象ジャンルの映画を返却する
    movies = movies.where("genres.genre_name LIKE ?", "#{params[:genre]}") if params[:genre].present?

    # ソート対象があり、人気順(popular)が指定された場合は、お気に入り数の多い順で返却する
    movies = movies.sort { |a,b| b.favorites.size <=> a.favorites.size } if params[:sort].present? && params[:sort] == 'popular'

    # ソート対象があり、人気順(popular)以外が指定された場合は、ソート対象とソート順で返却する
    if params[:sort].present? && params[:sort] != 'popular'
      sort_column = self.column_names.include?(params[:sort]) ? params[:sort] : 'id'
      sort_direction = %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'

      movies = movies.order("#{sort_column} #{sort_direction}")
    end

    # 返却値整形
    movies = movies.map { |movie| [
      id: movie.id,
      title: movie.title,
      release_date: movie.release_date,
      favorite_count: movie.favorites.size
    ]}

    movies
  end

  # 映画詳細取得
  #
  # @param [Integer] movie_id 映画ID
  # @return [Movie]
  def self.get_movie_detail(movie_id)
    eager_load(:genres, :favorites).find(movie_id)
  end

  # お気に入り映画一覧取得
  #
  # @param [Integer] user_id ユーザーID
  # @return [Array]
  def self.get_favorite_movie_lists(user_id)
    movies = eager_load(:users).where(users: user_id).order("favorites.created_at desc")

    # 返却値整形
    movies = movies.map { |movie| [
      id: movie.id,
      title: movie.title,
      release_date: movie.release_date,
      favorite_count: movie.favorites.size
    ]}

    movies
  end
end
