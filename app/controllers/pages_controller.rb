require 'trello'
require 'oauth'
require 'json'
require 'pp'

include Trello
include Trello::Authorization

class PagesController < ApplicationController
  before_filter :set_auth_config
  before_filter :set_oauth_settings
  before_filter :user_authenticated
  skip_before_filter :set_oauth_settings, :only => :login

  def dashboard

    #@client_bob = Trello::Client.new(
    #    :consumer_key => "f8947184de87275b7d2d7d8a7cad978f",
    #    :consumer_secret => "506c0d9127cf52eaa22f240533c4cc5894a5e227ecd08d888c13cb4a6fb9aad4"
    #)
    #debugger
    #
    #bob = @client_bob.find(:members,"bobtester")
    #        puts bob
  end

  def login
    debugger
# Then I can get access token/secret with verifier

    rt = OAuth::RequestToken.new(@consumer, @request_token.token, @request_token.secret)

    at = rt.get_access_token(:oauth_verifier => params["oauth_verifier"])
  end


  private

  def set_auth_config
    #TODO TALK TO KVIRANI TO SEE BETTER PLACE TO ATTACH THIS METHOD
    @consumer = OAuth::Consumer.new "f8947184de87275b7d2d7d8a7cad978f", "506c0d9127cf52eaa22f240533c4cc5894a5e227ecd08d888c13cb4a6fb9aad4", {
        :site => "https://trello.com",
        :scheme => :header,
        :http_method => :post,
        :request_token_url => "https://trello.com/1/OAuthGetRequestToken",
        :access_token_url => "https://trello.com/1/OAuthGetAccessToken",
        :authorize_url => "https://trello.com/1/OAuthAuthorizeToken"
    }

    @request_token = @consumer.get_request_token(:oauth_callback => "http://localhost:3000/login")
  end

  def set_oauth_settings

    redirect_to @request_token.authorize_url+"&name=Github-Trello"
  end

  def user_authenticated
    #redirect_to "/login" unless current_user

  end
end
