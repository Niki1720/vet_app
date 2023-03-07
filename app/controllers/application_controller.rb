class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = jwt_decode(token)
    @current_user = User.find(decoded[:user_id])
  end

  def record_not_found(e)
    render json: { error: e.to_s }, status: :not_found
  end
end
