json.extract! estimation, :is_manager,:user_time

json.user_name current_user.find(:members, estimation.user_id).username