json.extract! estimation

if estimation.developer_id
  json.developer_name current_user.find(:members, estimation.developer_id).username
  json.developer_time estimation.developer_time
else
  json.developer_time ""
  json.developer_name ""
end

if estimation.manager_id
  json.manager_name current_user.find(:members, estimation.manager_id).username
  json.manager_time estimation.manager_time
else
  json.manager_time ""
  json.manager_name ""
end