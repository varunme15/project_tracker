class SessionsController < ApplicationController
  before_filter :check_login, :only => [:registereduser]
  def new
  end
  def registereduser
  end

  def create
   user = User.validate_login(params[:session][:email],
params[:session][:password]
)

   if user 
    session[:user_id]= user.id
	  redirect_to registereduser_path;

   else
	      flash[:status] = FALSE;
        flash[:alert] = 'Invalid username or password'
        redirect_to login_path
   end
  end
   

  def destroy
	      session[:user_id] = nil
        flash[:status]= FALSE
        flash[:alert] = 'You have successfully logged out'
        redirect_to login_path 
  end
end
