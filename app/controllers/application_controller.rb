require 'trello'
require 'oauth'
require 'json'
require 'pp'

class ApplicationController < ActionController::Base
  include TrelloHelper
  
  # before_action :set_auth_config
  # before_action :user_authenticated
  # before_action :load_all_users

  before_filter :set_auth_config
  before_filter :user_authenticated
  before_filter :load_all_users

  #TODO: ACTIVATE IT LATER!!!
  #protect_from_forgery
  
  private

  def set_auth_config
    #TODO TALK TO KVIRANI TO SEE BETTER PLACE TO ATTACH THIS METHOD
    #MAYBE MOVE THIS TO A HELPER - BEING DUPLICAtED ON USERS CONTROLLER
    @consumer = OAuth::Consumer.new(
      Figaro.env.trello_developer_key,
      Figaro.env.trello_developer_secret_key,
      {
        site:         "https://trello.com",
        scheme:       :header,
        http_method:  :post,
        request_token_url:  "https://trello.com/1/OAuthGetRequestToken",
        access_token_url:   "https://trello.com/1/OAuthGetAccessToken",
        authorize_url:      "https://trello.com/1/OAuthAuthorizeToken"
      }
    )

    @request_token = @consumer.get_request_token(
      oauth_callback: Figaro.env.domain + "/login"
    )
  end

  def user_authenticated
    redirect_to @request_token.authorize_url + "&name=Github-Trello&expiration=never&scope=read,write,account" unless trello_client
  end

  def load_all_users
    # organization endpoints refer to Trello teams
    # @users = trello_client.find(:organization, "functionalimperative").members
    team = trello_client.find(:organization, Figaro.env.trello_team)
    @users = team.members
  end
end
