class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    authenticate_or_request_with_http_basic do |username,password|
      command = AuthenticateUser.call(username, password)
      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end