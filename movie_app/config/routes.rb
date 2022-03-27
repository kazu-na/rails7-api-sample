Rails.application.routes.draw do
  # 認証API
  post "/auth", to: "auth#create"

  # 映画一覧取得API
  get '/movies', to: 'movies#index'
  # 映画詳細取得API
  get '/movies/:movie_id', to: 'movies#show'

  # お気に入り映画一覧取得API
  get '/favorites', to: 'users#favorite_list'
  # お気に入り映画追加API
  post '/favorites/:movie_id', to: 'users#add_favorite'
end
