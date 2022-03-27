require "jwt"
module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.credentials.secret_key_base

  # ユーザー認証
  #
  # @param [String] token
  # @return [User]
  def user_authenticator(token)
    begin
      p 'token'
      p token
      payload,_ = jwt_decode(token)
      p 'aaa'
      User.find(payload['sub'])
    rescue StandardError
      nil
    end
  end

  # 暗号化
  # HS256で暗号化したトークンを返却します
  #
  # @param [Integer] user_id
  # @return [String]
  def jwt_encode(user_id)
    # ペイロードの作成
    payload = {
      iss: "movie_app", # JWTの発行者
      sub: user_id, # JWTの主体
      exp: (DateTime.current + 14.days).to_i # JWTの有効期限
    }

    JWT.encode(payload, SECRET_KEY)
  end

  private

    # 復号化
    # トークンを復号化し、payloadを取得します
    #
    # @param [String] token
    # @return [Object]
    def jwt_decode(token)
      # JWTからペイロードが取得できない場合は認証エラーにする
      begin
        decoded_token = JWT.decode(token, SECRET_KEY)
      rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
        raise AuthenticationError
      end
    end
end