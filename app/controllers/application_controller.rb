require 'trello'
require 'oauth'
require 'json'
require 'pp'

class ApplicationController < ActionController::Base
  include TrelloHelper

  before_action :check_trello_client

  private

  def check_trello_client
    trello_login if trello_client.blank?
  end

end
