require 'trello'
require 'oauth'
require 'json'
require 'pp'

class ApplicationController < ActionController::Base
  include TrelloHelper

  before_action :set_auth_config
  before_action :user_authenticated

  private

  def set_auth_config
    @consumer = OAuth::Consumer.new(
      Figaro.env.trello_developer_key,
      Figaro.env.trello_developer_secret,
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

end
