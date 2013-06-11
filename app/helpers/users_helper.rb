
module UsersHelper
  include Trello
  include Trello::Authorization

  def current_user
    session[:user]
  end

  def set_current_user(access_token)
    session[:user] = Trello::Client.new(
        :consumer_key => Figaro.env.trello_developer_key,
        :consumer_secret => Figaro.env.trello_developer_secret_key,
        :oauth_token => access_token.token,
        :oauth_token_secret => access_token.secret
    )
  end
end
