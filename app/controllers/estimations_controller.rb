class EstimationsController < ApplicationController
  def index
    @estimations = Estimation.where(:card_id => params[:cardId])
    @estimations
  end

  def create
    card_id = params[:estimation][:card_id]
    user_username = params[:estimation].delete :user_username
    is_manager = params[:estimation][:is_manager].to_bool

    user = current_user.find(:member, user_username)
    card = current_user.find(:cards, ""+card_id)

    if is_manager
      estimation_db = Estimation.where(:board_id => card.board_id, :card_id => card.id, :is_manager => is_manager).first
    else
      estimation_db = Estimation.where(:board_id => card.board_id, :card_id => card.id, :user_id => user.id, :is_manager => is_manager).first
    end

    estimation = if estimation_db
                   estimation_db.user_time = params[:estimation][:user_time]
                   estimation_db
                 else
                   Estimation.new(params[:estimation])
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
