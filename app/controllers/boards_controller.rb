class BoardsController < ApplicationController
  include TimeTrackingHelper

  def show
    @board = current_user.find(:board, params[:id])
    @lists = @board.lists
    save_lists_to_db(@board)
  end

end
