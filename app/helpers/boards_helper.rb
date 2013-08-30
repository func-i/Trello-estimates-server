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

  def get_developer_estimate(board, card)
    avg = 0
    card_id, board_id = get_card_id(card), board.id
    estimate = Estimation.developers_estimation(@board.id, card_id)
    if estimate.count > 0
      avg = estimate.sum(&:user_time) / estimate.count.to_f
    end
    sprintf("%.2f", avg)
  end

  private

  def get_card_id(card)
    card.url.split('/')[4]
  end

  # <% developers_estimation = Estimation.developers_estimation(@board.id, get_card_id(card)) %>


  # <% average_developer_estimation = 0 %>
  # <% if developers_estimation.count > 0 %>
  #   <% average_developer_estimation = developers_estimation.sum(&:user_time)/ developers_estimation.count.to_f %>
  # <% end %>
  # <%= "%.2f" % average_developer_estimation %>

  def linked_card_name(card)
    link_to "Card #{card.short_id}", card.url
  end

  def truncate_card_title(card)
    truncate card.name, length: 25, seperator: " "
  end

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
