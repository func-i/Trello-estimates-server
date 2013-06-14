module BoardsHelper
  #TODO THOSE METHODS CAN BE REFACTORED
  def hours_left(board)
    unfinished_cards = list_cards(board)
    time_tracked = list_time_tracked(board, unfinished_cards)

    total_time_tracked = time_tracked.inject(0) { |sum, n| sum + n.total_time }
    result = "#{"%.2f" % (Estimation.developers_estimation(board.id).sum(&:user_time) - total_time_tracked)} / "
    result+= "#{"%.2f" % (Estimation.managers_estimation(board.id).sum(&:user_time) - total_time_tracked)}"
  end

  def performance(board)
    finished_cards = list_cards(board, true)
    time_tracked = list_time_tracked(board, finished_cards)
    total_time_tracked = time_tracked.inject(0) { |sum, n| sum + n.total_time }

    result = "#{"%.2f" % (Estimation.developers_estimation(board.id).sum(&:user_time) - total_time_tracked) } / "
    result+= "#{"%.2f" % (Estimation.managers_estimation(board.id).sum(&:user_time) - total_time_tracked) }"
  end

  private

  def list_time_tracked(board, card_ids)
    HarvestLog.total_time_tracked(board.id).where("harvest_logs.card_id IN (?)", card_ids)
  end

  def list_cards(board, only_staged_and_live = false)
    cards = Array.new
    board.lists.each do |list|
      list_name = list.name
      if only_staged_and_live
        cards+= list.cards.map(&:short_id) if list_name == "Staged" || list_name == "Live"
      else
        cards+= list.cards.map(&:short_id) if list_name != "Staged" && list_name != "Live"
      end
    end
    cards
  end
end
