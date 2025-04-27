class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActionController::UnknownFormat, with: :not_found

  allow_browser versions: :modern

   
  # Handle authentication failure
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || tasks_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  # Override Devise's authentication failure
  def user_not_authorized
    flash[:alert] = "You need to sign in or sign up before continuing."
    redirect_to new_user_session_path
  end
  
  private
  
  def set_current_user
    Current.user = current_user if user_signed_in?
  end

  # Add custom error handling
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'errors/not_found', status: :not_found
  end

  rescue_from ActionController::RoutingError do |exception|
    render 'errors/not_found', status: :not_found
  end

  def not_found
    render 'errors/not_found', status: :not_found
  end
end
