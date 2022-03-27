class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, comment: 'ユーザー' do |t|
      t.string :name, limit: 50, null: false, comment: '氏名'
      t.string :email, null: false, comment: 'メールアドレス'
      t.string :password_digest, comment: 'パスワード'

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
