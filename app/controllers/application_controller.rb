require 'trello'
require 'json'
require 'pp'

class ApplicationController < ActionController::Base

  before_action :load_trello_service
  before_action :load_trello_client

  private

  def load_trello_service
    @trello = TrelloService.new(session)
  end

  def load_trello_client
    if @trello.access_token.present?
      @trello.load_trello_client
    else
      redirect_to @trello.authorize
    end
  end

end
