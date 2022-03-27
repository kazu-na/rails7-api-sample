class CreateMovieGenreManagements < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_genre_managements, comment: '映画ジャンル管理' do |t|
      t.references :movie, foreign_key: true, null: false, comment: '映画ID'
      t.references :genre, foreign_key: true, null: false, comment: 'ジャンルID'

      t.timestamps
    end
  end
end
