class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(e)
    render json: { error: e.to_s }, status: :not_found
  end
end
