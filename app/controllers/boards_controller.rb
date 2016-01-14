class BoardsController < ApplicationController

  def show
    @board = @trello.client.find(:board, params[:id])
    @lists = @board.lists
  end

end
