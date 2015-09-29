class ApplicationController < ActionController::Base

  require 'amazon'
  include SessionsHelper
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  after_filter :cors_set_access_control_headers
  before_action :start_benchmark
  after_action :end_benchmark

  def cors_preflight_check
    logger.info ">>> responding to CORS request"
    render :text => '', :content_type => 'text/plain'
  end

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    if Rails.env.production?
      headers['Access-Control-Allow-Origin'] = '*'
    else
      headers['Access-Control-Allow-Origin'] = '*'
    end
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'X-AUTH-TOKEN, X-API-VERSION, X-Requested-With, Content-Type, Accept, Origin, X-Titanium-Id, charset, Authorization'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

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

  def start_benchmark
    @start = Time.now
  end

  def end_benchmark
    @end = Time.now
    diff = @end - @start
    Rails.logger.warn("Url: #{request.url}")
    Rails.logger.warn("Time: #{diff}")
  end

  protected
  def generate_pdf
    UploadPdfJob.perform_later @report.id
  end

  private
  def error_message(e)
    { message: e.message }
  end

end
