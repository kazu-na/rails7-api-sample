class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres, comment: 'ジャンル' do |t|
      t.string :genre_name, null: false, comment: 'ジャンル名'

      t.timestamps
    end
  end
end
