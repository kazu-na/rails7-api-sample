class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_many :favorites, dependent: :destroy
  has_many :movies, through: :favorites

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 8 },
                       format: { with: VALID_PASSWORD_REGEX },
                       allow_nil: true

  # ユーザー認証(パスワード)
  # メールアドレスとパスワードで認証します
  #
  # @param [String] email
  # @param [String] password
  # @return [User]
  def self.authenticate_user_with_password!(email, password)
    user = find_by(email: email)&.authenticate(password)
    raise AuthenticationError if user.nil?

    user
  end
end
