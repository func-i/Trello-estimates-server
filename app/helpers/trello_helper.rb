module TrelloHelper
  include Trello
  include Trello::Authorization

  def trello_client
    session[:trello_client]
  end

  def set_trello_client(access_token)
    session[:trello_client] = Trello::Client.new(
      consumer_key:       Figaro.env.trello_developer_key,
      consumer_secret:    Figaro.env.trello_developer_secret_key,
      oauth_token:        access_token.token,
      oauth_token_secret: access_token.secret
    )
  end
end
