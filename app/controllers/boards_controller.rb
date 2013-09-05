class BoardsController < ApplicationController
  include HarvestTrelloHelper

  def show
    @board = current_user.find(:board, params[:id])
    @lists = @board.lists
    check_board_against_join_database(@board)
  end

end
