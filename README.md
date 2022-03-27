# README

## セットアップ
### Docker
- コンテナ作成
```
$ docker compose up -d --build
```
- データ投入
```
$ cd movie_app
$ docker compose exec api bash
$ rails db:migrate
$ rails db:seed
```

## API
### 認証API
ユーザーの認証に使用します
リクエストボディ: email, password

```
POST /auth
example Body
{
    "email":"taro@example.com",
    "password":"taro1234"
}
```


### 映画一覧取得API
映画一覧を取得します
- searchで映画タイトル名の検索を行います
- genreでジャンル名の検索を行います
- sortがpopularの場合は、お気に入り数の多い順で取得します
- sortがそのほかの指定の場合はそのパラメータでソートします
- directionはascまたはdescが入ります
```
GET /movies
example url
/movies?search=アベンジャーズ&genre=アクション&sort=release_date&direction=desc
```
### 映画詳細取得API
指定されたmovie_idの映画詳細を取得します
```
GET /movies/:movie_id
```

### お気に入り映画一覧取得API
ユーザーがお気に入りに登録した映画一覧を取得します(認証必須)
```
GET /favorites
```
### お気に入り映画追加API
ユーザーが選択した対象映画をお気に入りに登録します(認証必須)
```
POST /favorites/:movie_id
```
