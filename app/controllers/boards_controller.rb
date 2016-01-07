class BoardsController < ApplicationController

  def show
    @board = trello_client.find(:board, params[:id])
    @lists = @board.lists
  end

end
