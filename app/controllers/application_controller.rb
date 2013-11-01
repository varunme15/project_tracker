class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def check_login
    if !session[:user_id]
      flash[:status]= FALSE
      flash[:alert] = 'You need to be logged in first'

      redirect_to login_path
    else
      @user = User.find(session[:user_id])
      @user_full_name = "#{@user.first_name} #{@user.last_name}"
    end
  end
end
