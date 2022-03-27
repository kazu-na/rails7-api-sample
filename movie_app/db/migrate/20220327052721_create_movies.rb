class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies, comment: '映画' do |t|
      t.string :title, null: false, comment: 'タイトル名'
      t.text :description, comment: '概要'
      t.string :prod_country, comment: '製作国'
      t.string :director, comment: '監督'
      t.date :release_date, comment: '公開日'
      t.time :running_time, comment: '上映時間'

      t.timestamps
    end
  end
end
