module SessionsHelper
  def user_signed_in?
    current_user.is_a?(User)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def store_user_location!
    session[:forwarding_url] = request.original_url if request.get?
  end
end
