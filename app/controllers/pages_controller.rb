require 'trello'
require 'oauth'
require 'json'
require 'pp'

include Trello
include Trello::Authorization

class PagesController < ApplicationController
  before_filter :set_auth_config
  before_filter :user_authenticated
  skip_before_filter :user_authenticated, :only => :login

  def dashboard
    @organization = current_user.find(:organization, "functionalimperative")
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

  def set_auth_config
    #TODO TALK TO KVIRANI TO SEE BETTER PLACE TO ATTACH THIS METHOD
    #MAYBE MOVE THIS TO A HELPER - BEING DUPLICAtED ON USERS CONTROLLER
    @consumer = OAuth::Consumer.new Figaro.env.trello_developer_key, Figaro.env.trello_developer_secret_key, {
        :site => "https://trello.com",
        :scheme => :header,
        :http_method => :post,
        :request_token_url => "https://trello.com/1/OAuthGetRequestToken",
        :access_token_url => "https://trello.com/1/OAuthGetAccessToken",
        :authorize_url => "https://trello.com/1/OAuthAuthorizeToken"
    }

    @request_token = @consumer.get_request_token(:oauth_callback => "http://localhost:3000/login")
  end

  def user_authenticated
      redirect_to @request_token.authorize_url+"&name=Github-Trello&expiration=never&scope=read,write,account" unless current_user
  end

end
