require 'oauth'

class TrelloService

  TRELLO_URL        = "https://trello.com"
  API_URL           = TRELLO_URL + "/1"

  attr_accessor :client

  def initialize(rails_session)
    # cookie size almost 4KB => save tokens instead
    @session        = rails_session
    @client         = @session[:trello_client]
    @request_token  = @session[:trello_request_token]
  end

  def login
    @request_token ||= set_trello_request_token
    @request_token.authorize_url + "&name=Github-Trello&expiration=never&scope=read,write,account"
  end

  def set_trello_client(oauth_verifier)
    @request_token ||= set_trello_request_token
    access_token = @request_token.get_access_token(oauth_verifier: oauth_verifier)

    @session[:trello_client] = Trello::Client.new(
      consumer_key:       Figaro.env.trello_developer_key,
      consumer_secret:    Figaro.env.trello_developer_secret,
      oauth_token:        access_token.token,
      oauth_token_secret: access_token.secret
    )
  end

  private

  def set_trello_request_token
    oauth_consumer = get_trello_oauth_consumer
    @session[:trello_request_token] = oauth_consumer.get_request_token(
      oauth_callback: Figaro.env.domain + "/login"
    )
  end

  def get_trello_oauth_consumer
    OAuth::Consumer.new(
      Figaro.env.trello_developer_key,
      Figaro.env.trello_developer_secret,
      {
        site:         TRELLO_URL,
        scheme:       :header,
        http_method:  :post,
        request_token_url:  API_URL + "/OAuthGetRequestToken",
        access_token_url:   API_URL + "/OAuthGetAccessToken",
        authorize_url:      API_URL + "/OAuthAuthorizeToken"
      }
    )
  end

end
