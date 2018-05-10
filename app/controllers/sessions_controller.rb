class SessionsController < ApplicationController
  before_action :authenticate_user, :only => [:home, :profile, :setting]
  before_action :save_login_state, :only => [:login, :login_attempt]

  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out"
    redirect_to :action => "login"
  end

  def login_attempt
    authorized_user = User.authenticate(params[:email], params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome! You logged in as #{authorized_user.username}"
      redirect_to root_path
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end
end
