class BoardsController < ApplicationController

  def show
    @board = current_user.find(:board, params[:id])
    @lists = @board.lists
  end

end
