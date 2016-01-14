require 'oauth'

class TrelloService

  TRELLO_URL        = "https://trello.com"
  API_URL           = TRELLO_URL + "/1"

  attr_accessor :client, :access_token

  def initialize(rails_session)
    @session        = rails_session
    @request_token  = @session[:trello_request_token]
    @access_token   = @session[:trello_access_token]
    @client         = nil
  end

  def load_trello_client
    @client = Trello::Client.new(
      consumer_key:       Figaro.env.trello_developer_key,
      consumer_secret:    Figaro.env.trello_developer_secret,
      oauth_token:        @access_token.token,
      oauth_token_secret: @access_token.secret
    )
  end

  def authorize
    @request_token = set_trello_request_token

    authorize_query = {
      name:       "Github-Trello",
      expiration: "never",
      scope:      "read,write,account"
    }.to_query
    @request_token.authorize_url + "&" + authorize_query
  end

  def login(oauth_verifier)
    @access_token ||= set_trello_access_token(oauth_verifier)
    load_trello_client
  end

  private

  def set_trello_access_token(oauth_verifier)
    @request_token ||= set_trello_request_token

    @session[:trello_access_token] = @request_token.get_access_token(
      oauth_verifier: oauth_verifier
    )
  end

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
