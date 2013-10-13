
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  layout :layout

  
  
  def current_user
    session[:current_user_id]
  end

  def current_user=(user)
    session[:current_user_id] = user
  end

  private
    def layout
      # only turn it off for login pages:
      is_a?(SessionsController) || is_a?(GenerateController)  ? "welcome" : "application"
      # or turn layout off for every devise controller:
    end

    def require_login
      if !is_a?(SessionsController)

        unless current_user
          redirect_to root_path
        end
      end
    end
end
