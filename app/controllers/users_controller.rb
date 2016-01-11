class UsersController < ApplicationController

  def show
    @user_email = trello_client.find("member", params[:id]).email
    # @estimation_time_tracked_dif = Tasks::Calculator.avg_estimation_timetracked_by_developer
  end

end
