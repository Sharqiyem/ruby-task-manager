
class HomeController < ApplicationController
  before_action :authenticate_user!  # Blocks access unless logged in

  def dashboard
    # Optional: Add instance variables for the view
    @message = "Welcome, #{current_user.email}" 
  end
end