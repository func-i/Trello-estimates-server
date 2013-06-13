if @estimations.count > 0
  json.total_tracked_time HarvestLog.total_time_tracked(@estimations.first.board_id, @estimations.first.card_id).sum(&:total_time)
else
  json.total_tracked_time 0
end

json.estimations do
  json.array! @estimations do |estimation|
    json.partial! estimation
  end
end