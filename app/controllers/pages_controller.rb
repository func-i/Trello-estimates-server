class PagesController < ApplicationController
  skip_before_action :check_trello_client, only: :login

  def dashboard
    board_unfiltered = trello_client.find(:members, "me").boards
    @boards = board_unfiltered.reject{ |b| b.closed? }
  end

  def login
    # @rt = OAuth::RequestToken.new(@consumer, @request_token.token, @request_token.secret)
    request_token = get_trello_request_token
    access_token = request_token.get_access_token(oauth_verifier: params["oauth_verifier"])
    set_trello_client(access_token)
    redirect_to root_path
  end

end
