require 'trello'
require 'json'
require 'pp'

class ApplicationController < ActionController::Base

  before_action :load_trello_service
  before_action :check_trello_client

  private

  def load_trello_service
    @trello ||= TrelloService.new(session)
  end

  def check_trello_client
    redirect_to @trello.login if @trello.client.blank?
  end

end
