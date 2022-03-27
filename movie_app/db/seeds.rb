require "csv"

# ジャンル
CSV.foreach('db/seeds/genres.csv', headers: true) do |row|
  Genre.find_or_create_by!(
    id: row['id'],
    genre_name: row['genre_name']
  )
end

# 映画
CSV.foreach('db/seeds/movies.csv', headers: true) do |row|
  Movie.find_or_create_by!(
    id: row['id'],
    title: row['title'],
    description: row['description'],
    prod_country: row['prod_country'],
    director: row['director'],
    release_date: row['release_date'],
    running_time: row['running_time']
  )
end

# ユーザー
CSV.foreach('db/seeds/users.csv', headers: true) do |row|
  User.find_or_create_by!(id: row['id']) do |user|
    user.id = row['id']
    user.name = row['name']
    user.email = row['email']
    user.password = row['password']
  end
end

# 映画ジャンル管理
CSV.foreach('db/seeds/movie_genre_managements.csv', headers: true) do |row|
  MovieGenreManagement.find_or_create_by!(
    id: row['id'],
    movie_id: row['movie_id'],
    genre_id: row['genre_id']
  )
end

# お気に入り
CSV.foreach('db/seeds/favorites.csv', headers: true) do |row|
  Favorite.find_or_create_by!(
    id: row['id'],
    user_id: row['user_id'],
    movie_id: row['movie_id']
  )
end