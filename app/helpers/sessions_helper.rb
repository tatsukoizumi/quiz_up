module SessionsHelper
  
  def logged_in?
    !current_user.nil?
  end
  
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end