class EstimationsController < ApplicationController
  def index
    estimation = Estimation.where(:card_id => params[:cardId], :board_id => params[:boardId], :user_email => params[:email]).first
    render :json => estimation
  end
end
