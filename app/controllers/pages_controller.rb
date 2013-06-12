class PagesController < ApplicationController
  skip_before_filter :user_authenticated, :only => :login
  skip_before_filter :load_all_users, :only => :login

  def dashboard
    @projects = current_user.find(:members, "me").boards
  end

  def login
    set_client_token
  end

  private
  def set_client_token
    @rt = OAuth::RequestToken.new(@consumer, @request_token.token, @request_token.secret)
    @at = @rt.get_access_token(:oauth_verifier => params["oauth_verifier"])

    set_current_user(@at)
    redirect_to root_path
  end

  #def create_user
  #  email = session[:user].find(:members, "me").email
  #  user = User.new(:email => email, :public_token => @at.token, :secret_token => @at.secret)
  #  if user.save
  #    redirect_to root_path
  #  else
  #    session[:user] = nil
  #    user_authenticated
  #  end
  #end



end
