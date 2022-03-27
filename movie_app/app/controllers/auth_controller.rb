class AuthController < ApplicationController
  skip_before_action :authenticate_request

  # 認証API
  # POST /auth
  #
  # @return
  #   [Integer] status HTTPステータスコード
  #   [String] message メッセージ
  def create
    # ユーザの取得
    user = User.authenticate_user_with_password!(params[:email], params[:password])
    raise AuthenticationError if user.nil?

    # JWTをCookieにセット
    token = jwt_encode(user.id)
    cookies[:token] = token

    render json: { status: 200, message: 'authenticate' }
  end
end
