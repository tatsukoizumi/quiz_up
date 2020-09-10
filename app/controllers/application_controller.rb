class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user
  helper_method :reset_count
  
  @@quiz_num = 0
  @@score = 0
  @@miss = 0

  private
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:notice] = 'ログインしてください'
        redirect_to login_url
      end
    end
    
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
    def reset_count
      @@quiz_num = 0
      @@score = 0
      @@miss = 0
    end
    
end