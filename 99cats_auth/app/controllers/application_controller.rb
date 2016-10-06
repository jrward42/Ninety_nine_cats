class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :login_user!

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
    return nil unless @current_user
    @current_user
  end

  def login_user!(user)
    session[:session_token] = user.session_token
  end

  def signed_in?
    if current_user
      redirect_to cats_url
    end
  end


end
