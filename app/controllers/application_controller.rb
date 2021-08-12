class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

end
