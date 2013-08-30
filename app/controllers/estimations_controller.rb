class EstimationsController < ApplicationController
  def index
    member = current_user.find(:member, params[:member_name])
    @estimations = Estimation.where(card_id: params[:cardId], user_id: member.id)
  end

  def create
    estimation_params = params[:estimation]

    user_username = estimation_params.delete :user_username
    is_manager = estimation_params[:is_manager].to_bool
    user = current_user.find(:member, user_username)

    if is_manager
      estimation = Estimation.manager.where(:card_id => estimation_params[:card_id]).first
    else
      estimation = Estimation.not_manager.where(:card_id => estimation_params[:card_id], :user_id => user.id).first
    end

    if estimation
      estimation.user_time = estimation_params[:user_time]
    else
      estimation = Estimation.new params[:estimation]
    end

    estimation.user_id = user.id unless is_manager
    estimation.is_manager = Admin.is_manager(user.email) if is_manager

    if trello_card = current_user.find(:cards, estimation.card_id)
      estimation.board_id = trello_card.board_id
    end

    if estimation.save
      render :json => estimation
    else
      render :json => estimation.errors.full_messages, :status => 500
    end
  end
end
