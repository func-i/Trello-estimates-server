if @estimations.count > 0
  json.total_tracked_time HarvestLog.time_tracked_by_card(@estimations.first.card_id).sum(&:time_spent)
else
  json.total_tracked_time 0
end

json.estimations @estimations do |estimation|
  json.partial! estimation
end
