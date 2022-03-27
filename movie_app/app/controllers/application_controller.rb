class ApplicationController < ActionController::API
  include ActionController::Cookies
  include JsonWebToken

  before_action :authenticate_request

  # AuthenticationErrorへ継承
  class AuthenticationError < StandardError; end

  # 認証例外処理
  rescue_from AuthenticationError, with: :render_unauthorized_error

  # 現在ログイン中のuserかどうかを判定するメソッド
  # current_userが存在しない場合、user_authenticatorでuser情報を取得し、@current_userに代入します
  # user情報が取得できない場合はfalseを返します
  def authenticate_request
    @current_user ||= user_authenticator(cookies[:token])
    raise AuthenticationError if @current_user.nil?
  end

  private

    def render_unauthorized_error
      render json: { message: 'unauthorized' }, status: 401
    end
end
