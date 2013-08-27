require 'trello'
require 'oauth'
require 'json'
require 'pp'

include Trello
include Trello::Authorization
class ApplicationController < ActionController::Base
  include UsersHelper
  before_filter :set_auth_config
  before_filter :user_authenticated
  before_filter :load_all_users

  #TODO: ACTIVATE IT LATER!!!
  #protect_from_forgery

  private
  def load_all_users
    @users = current_user.find(:organization, "functionalimperative").members
  end

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

    @request_token = @consumer.get_request_token(:oauth_callback =>  Figaro.env.domain+"/login")    
  end

  def user_authenticated
    redirect_to @request_token.authorize_url+"&name=Github-Trello&expiration=never&scope=read,write,account" unless current_user
  end

end
