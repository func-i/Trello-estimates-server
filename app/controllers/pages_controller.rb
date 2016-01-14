class PagesController < ApplicationController

  skip_before_action :check_trello_client, only: :login

  def dashboard
    board_unfiltered = @trello.client.find(:members, "me").boards
    @boards = board_unfiltered.reject{ |b| b.closed? }
  end

  def login
    @trello.set_trello_client(params["oauth_verifier"])
    redirect_to root_path
  end

end
