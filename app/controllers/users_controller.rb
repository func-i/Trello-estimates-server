class UsersController < ApplicationController

  #TODO: This can be improved later
  def show
    @user_email = current_user.find("member", params[:id]).email
    # @estimation_time_tracked_dif = Tasks::Calculator.avg_estimation_timetracked_by_developer
  end

end
