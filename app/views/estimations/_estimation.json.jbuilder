json.extract! estimation, :is_manager, :user_time

if estimation.is_manager?
  json.user_name ""
else
  json.user_name trello_client.find(:members, estimation.user_id).username
end
