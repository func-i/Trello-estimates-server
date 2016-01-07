class EstimationsController < ApplicationController

  def index
    if board_id = params[:boardId]
      render_cards_on_board(board_id)
      return
    end

    member        = current_user.find(:member, params[:member_name])
    @estimations  = Estimation.for_card(params[:cardId])
    
    unless Admin.is_manager(member.email)
      @estimations = @estimations.by_developers
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

  def render_cards_on_board(board_id)
    estimates = Estimation.cards_on_board(board_id)
    trackings = HarvestLog.cards_on_board(board_id)
    render json: { estimates: estimates, trackings: trackings }
  end

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
    estimates =
      if is_manager
        Estimation.search(:card, card_id, :manager)
      else
        Estimation.search(:card, card_id, :developer, user.id)
      end
    @estimation = estimates.first
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
    # current_user.find(:cards, ...) strips out board shortLink
    card_url  = "/cards/" + params[:cardId]
    options   = { board: "true", board_fields: "shortLink" }
    response  = current_user.get(card_url, options)

    if response.present?
      card_hash = JSON.parse(response)
      @estimation.board_id = card_hash["board"]["shortLink"]
    end
  end

end
