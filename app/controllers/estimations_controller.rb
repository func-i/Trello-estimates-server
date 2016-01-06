class EstimationsController < ApplicationController

  def index
    member  = current_user.find(:member, params[:member_name])
    card_id = params[:cardId]

    @estimations = 
      if Admin.is_manager(member.email)
        Estimation.for_card(card_id)
      else
        Estimation.developers_card(card_id)
      end
  end

  def create
    est_params  = estimation_params
    is_manager  = est_params[:is_manager].to_bool
    user_name   = est_params.delete :user_username
    user        = current_user.find(:member, user_name)

    # render error if a non-manager wants to create a manager estimation
    if is_manager && !Admin.is_manager(user.email)
      render json: "user is not a manager!", status: 500
      return
    end

    find_estimation(user, is_manager, est_params[:card_id])
    edit_or_build_estimation(user, is_manager, est_params)
    link_estimation_to_board

    if @estimation.save
      render json: @estimation
    else
      render json: @estimation.errors.full_messages, status: 500
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

  # true if a non-manager wants to create a manager estimation
  def error_not_manager(is_manager, user)
    is_manager && Admin.is_manager(user.email)
  end

  def find_estimation(user, is_manager, card_id)
    @estimation = 
      if is_manager
        Estimation.manager_card(card_id).first
      else
        Estimation.developer_card(user.id, card_id).first
      end
  end

  def edit_or_build_estimation(user, is_manager, est_params)
    if @estimation
      @estimation.user_time = est_params[:user_time]
    else
      @estimation = Estimation.new est_params
    end

    if is_manager
      @estimation.is_manager = true
    else
      @estimation.user_id = user.id
    end
  end

  def link_estimation_to_board
    if trello_card = current_user.find(:cards, @estimation.card_id)
      @estimation.board_id = trello_card.board_id
    end
  end

end
