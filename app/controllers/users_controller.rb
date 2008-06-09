class UsersController < ApplicationController
  allow_access :all
  
  def new
    @user = User.new
  end
end