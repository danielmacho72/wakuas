class ApplicationController < ActionController::Base
  protect_from_forgery if: :json_request #return null session when API call
  protect_from_forgery with: :exception, unless: :json_request

  before_action :authenticate_request, if: :json_request
  before_action :authenticate_user!, unless: :json_request

  attr_reader :current_user

  private

  def json_request
    request.format.json?
  end

  def authenticate_request
  	@current_user = AuthorizeApiRequest.call(request.headers).result
  	render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
