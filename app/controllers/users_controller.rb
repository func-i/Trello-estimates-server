class UsersController < ApplicationController
  #TODO: This can be improved later
  def show
    user_email = current_user.find("member", params[:id]).email
    @estimation_time_tracked_dif = Calculator.avg_estimation_timetracked_by_developer
    #@developer_tracked_time = HarvestLog.total_time_tracked_by_developer(user_email).select("day, avg(total_time) as total_tracked_time").group("day").map do |elem|
    #  {
    #      :date => elem.day.strftime("%Y-%m-%d"),
    #      :total_tracked_time => elem.total_tracked_time
    #  }
    #end.to_json

    #@estimation_tracked_time =
    #@developer_tracked_time = HarvestLog.total_time_tracked_by_developer(user_email).order("total_time DESC, day DESC").map do |elem|
    #  {
    #      :card_id => elem.card_id,
    #      :date => elem.day.strftime("%Y-%m-%d"),
    #      :tracked_time => elem.total_time
    #  }
    #end.to_json

    #@manager_estimations = Estimation.total_time_tracked_by_developer(user_email).order("total_time DESC, day DESC").map do |elem|
    #  {
    #      :card_id => elem.card_id,
    #      :date => elem.day.strftime("%Y-%m-%d"),
    #      :estimation => elem.estimations
    #  }
    #end.to_json
  end
end
