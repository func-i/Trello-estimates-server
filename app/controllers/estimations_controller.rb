class EstimationsController < ApplicationController
  def index
    card = current_user.find(:cards, ""+params[:cardId])
    @estimations = Estimation.where(:card_id => card.id)
    @estimations
  end

  def create
    card_temp = params[:estimation][:card_id]
    user_username = params[:estimation].delete :user_username
    is_manager = params[:estimation][:is_manager].to_bool

    user = current_user.find(:member, user_username)
    card = current_user.find(:cards, ""+card_temp)
    board_id = card.board.id
    card_id = card.id
    if is_manager
      estimation_db = Estimation.where(:board_id => card.board_id, :card_id => card.id, :is_manager => is_manager).first
    else
      estimation_db = Estimation.where(:board_id => card.board_id, :card_id => card.id, :user_id => user.id, :is_manager => is_manager).first
    end

    estimation = if estimation_db
                   estimation_db.user_time = params[:estimation][:user_time]
                   estimation_db
                 else
                   est_aux = Estimation.new(params[:estimation])
                   est_aux.board_id = board_id
                   est_aux.card_id = card_id
                   est_aux
                 end

    estimation.user_id = user.id if !is_manager
    estimation.is_manager = Admin.is_manager(user.email) if is_manager

    if estimation.save
      render :json => estimation
    else
      render :json => estimation.errors.full_messages,
             :status => 500
    end
  end
end
