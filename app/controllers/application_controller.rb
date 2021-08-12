class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  #.find raises an exception. This rescues us from that exception
  #with the method defined below
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  #we can follow the same logic for a 422 error
  # (validation error)

end
