class UsersController < ApplicationController

  def create
    user = User.new(params[:user])
    if user.save
      session[:user] = user
      redirect_to root_path
    else
      redirect_to "/login"
    end

  end
end
