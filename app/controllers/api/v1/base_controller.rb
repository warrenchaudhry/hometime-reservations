class Api::V1::BaseController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate
 
  # include Response
  # include ExceptionHandler
 
  API_TOKEN = "sample-token"

  before_action :authenticate

  def test
    render json: { message: 'It works!' }, status: 200
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, API_TOKEN)
    end
  end
end