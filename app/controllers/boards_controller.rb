class BoardsController < ApplicationController
  include HarvestTrelloHelper

  def show
    @board = current_user.find(:board, params[:id])
    @lists = @board.lists
  end

end
