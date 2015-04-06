class ApplicationController < ActionController::Base

  include SessionsHelper
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
  rescue_from ActionController::ParameterMissing, with: :error_parameter_missing
  rescue_from CanCan::AccessDenied, with: :error_unauthorized

  def error_not_found
    render nothing: true, status: :not_found
  end

  def error_unauthorized
    render nothing: true, status: :unauthorized
  end

  def error_parameter_missing(e)
    render json: error_message(e), status: :bad_request
  end

  private
  def error_message(e)
    { message: e.message }
  end

end
