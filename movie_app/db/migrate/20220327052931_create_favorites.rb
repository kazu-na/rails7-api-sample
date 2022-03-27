class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites, comment: 'お気に入り' do |t|
      t.references :user, foreign_key: true, null: false, comment: 'ユーザーID'
      t.references :movie, foreign_key: true, null: false, comment: '映画ID'

      t.timestamps
    end
  end
end
