class SessionsController < ApplicationController

  before_action :signed_in?, only: [:create, :new]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
              session_params[:user_name],
              session_params[:password])

    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:user_name, :password)
  end
end
