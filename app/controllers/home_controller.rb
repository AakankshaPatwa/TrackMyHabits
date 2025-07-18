class HomeController < ApplicationController
  def index
    # This action shows a simple welcome page for visitors.
    # If you prefer, you can redirect authenticated users here too:
    redirect_to authenticated_root_path if user_signed_in?
  end
end
