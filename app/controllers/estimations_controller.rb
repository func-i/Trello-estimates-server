class EstimationsController < ApplicationController
  def index
    @estimations = Estimation.where(:card_id => params[:cardId], :board_id => params[:boardId])
    @estimations
  end

  def create
    type = params[:estimation].delete :type
    user_username = params[:estimation].delete :user_username
    user_time = params[:estimation].delete :user_time
    board_id = params[:estimation][:board_id]
    card_id = params[:estimation][:card_id]

    user = current_user.find(:member, user_username)
    if type == "developer"
      estimation_db = Estimation.where(:board_id => board_id, :card_id => card_id, :developer_id => user.id).first
      estimation = if estimation_db
                     estimation_db
                   else
                     Estimation.new(params[:estimation])
                   end
      estimation.developer_id = user.id
      estimation.developer_time = user_time

    else
      estimation_db = Estimation.where(:board_id => board_id, :card_id => card_id, :manager_id => user.id).first
      estimation = if estimation_db
                     estimation_db
                   else
                     Estimation.new(params[:estimation])
                   end
      estimation.manager_id = user.id
      estimation.manager_time = user_time
    end

    if estimation.save
      render :json => estimation
    else
      render :json => estimation.errors.full_messages,
             :status => 500
    end
  end
end
