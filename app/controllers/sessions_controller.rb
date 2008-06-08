class SessionsController < ApplicationController
  allow_access :all
  
  def create
    if @authenticated = User.authenticate(params[:username], params[:password])
      session[:authenticated] = @authenticated.id
      redirect_to pastes_url
    else
      @user = User.new(:username => params[:username])
      @user.errors.add_to_base "The username/password combination you entered is invalid."
      render :action => :new
    end
  end
end
