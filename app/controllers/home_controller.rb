class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def about
  end

  def contact
  end

  def pricing
  end
end