module BoardsHelper
  #TODO Remove SQL calls from helpers
  def time_track_less_estimation(board, lists, only_staged_and_live = false)
    cards = list_cards(lists, only_staged_and_live)
    if cards.length > 0
      board_id = board.id
      time_tracked = list_time_tracked(board, cards)
      total_time_tracked = time_tracked.inject(0) { |sum, n| sum + n.total_time }

      developers_estimation = Estimation.developers_estimation(board_id).where("estimations.card_id IN (?)", cards)
      managers_estimation = Estimation.managers_estimation(board_id).where("estimations.card_id IN (?)", cards)

      result = "#{"%.2f" % (total_time_tracked - developers_estimation.sum(&:user_time))} / "
      result+= "#{"%.2f" % (total_time_tracked - managers_estimation.sum(&:user_time))}"
    else
      result = "0.00 / 0.00"
    end
  end

  private

  def list_time_tracked(board, cards_id)
    HarvestLog.total_time_tracked(board.id).where("harvest_logs.card_id IN (?)", cards_id)
  end

  def list_cards(lists, only_staged_and_live)
    cards = Array.new
    lists.each do |list|
      cards+= list.cards.map(&:id) if only_staged_and_live == list.finished?
    end
    cards
  end
end
