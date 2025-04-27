class ErrorsController < ApplicationController
  # Skip authentication for error pages
  skip_before_action :authenticate_user!
  # Skip checking for missing callback actions
  skip_before_action :verify_authenticity_token
  
  layout 'error'

  def not_found
    if current_user
      respond_to do |format|
        format.html { render status: 404 }
        format.all { render nothing: true, status: 404 }
      end
    else
      redirect_to new_user_session_path, alert: "Please sign in to continue."
    end
  end

  def unprocessable_entity
    render status: 422
  end

  

  def internal_server_error
    render status: 500
  end
end