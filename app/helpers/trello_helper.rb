module TrelloHelper
  include Trello
  include Trello::Authorization

  def trello_client
    puts "in trello_client"

    session[:trello_client]
  end

  def trello_login
    puts "in trello_login"

    request_token = get_trello_request_token
    redirect_to request_token.authorize_url + "&name=Github-Trello&expiration=never&scope=read,write,account"
  end

  def get_trello_request_token
    puts "get_trello_request_token"

    return session[:trello_request_token] if session[:trello_request_token].present?

    oauth_consumer = get_trello_oauth_consumer
    session[:trello_request_token] = oauth_consumer.get_request_token(
      oauth_callback: Figaro.env.domain + "/login"
    )
  end

  def get_trello_oauth_consumer
    puts "get_trello_oauth_consumer"

    OAuth::Consumer.new(
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
  end

  def set_trello_client(access_token)
    puts "set_trello_client"

    session[:trello_client] = Trello::Client.new(
      consumer_key:       Figaro.env.trello_developer_key,
      consumer_secret:    Figaro.env.trello_developer_secret,
      oauth_token:        access_token.token,
      oauth_token_secret: access_token.secret
    )
  end

end
