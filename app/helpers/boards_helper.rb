module BoardsHelper
  def hours_left(board)
    finished_card = Array.new
    #
    #board.cards.each do |card|
    #  associated_list = card.list.name
    #  finished_card << card.id if associated_list == "Staged" || associated_list == "Live"
    #end
    #
    #total_time_tracked = HarvestLog.total_time_tracked(board.id).where("harvest_logs.card_id NOT IN (?)", finished_card)
    #if total_time_tracked.count > 0
    #  total_time_tracked.sum(&:total_time) / total_time_tracked.count.to_f
    #else
    #  0
    #end
     0
  end
end
