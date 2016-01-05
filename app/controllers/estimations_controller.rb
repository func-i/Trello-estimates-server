class EstimationsController < ApplicationController

  def index
    member = current_user.find(:member, params[:member_name])

    if Admin.is_manager(member.email)
      @estimations = Estimation.where(card_id: params[:cardId])
    else
      @estimations = Estimation.where(card_id: params[:cardId], user_id: member.id)
    end
  end

  def create
    est_params    = estimation_params
    user_username = est_params.delete :user_username
    is_manager    = est_params[:is_manager].to_bool
    user          = current_user.find(:member, user_username)

    if is_manager
      estimation = Estimation.manager_card(est_params[:card_id]).first
    else
      estimation = Estimation.developer_card(user.id, est_params[:card_id]).first
    end

    if estimation
      estimation.user_time = est_params[:user_time]
    else
      estimation = Estimation.new est_params
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

  private

  def estimation_params
    params.require(:estimation).permit(
      :card_id, 
      :user_username, 
      :user_time, 
      :is_manager
    )
  end
end
