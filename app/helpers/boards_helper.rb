module BoardsHelper
  include HarvestTrelloHelper

  #TODO Remove SQL calls from helpers
  #TODO broken method since time_tracked has changed
  # def time_track_less_estimation(board, lists, only_staged_and_live = false)
  #   cards = list_cards(lists, only_staged_and_live)
  #   if cards.length > 0
  #     board_id = board.id
  #     time_tracked = list_time_tracked(board, cards)
  #     total_time_tracked = time_tracked.inject(0) { |sum, n| sum + n.total_time }

  #     developers_estimation = Estimation.developers_estimation(board_id).where("estimations.card_id IN (?)", cards)
  #     managers_estimation = Estimation.managers_estimation(board_id).where("estimations.card_id IN (?)", cards)

  #     result = "#{"%.2f" % (total_time_tracked - developers_estimation.sum(&:user_time))} / "
  #     result+= "#{"%.2f" % (total_time_tracked - managers_estimation.sum(&:user_time))}"
  #   else
  #     result = "0.00 / 0.00"
  #   end
  # end

  private

    def linked_card_name(card)
      link_to "Card #{card.short_id} - #{truncate card.name, length: 40}", card.url
    end

    def get_developer_estimate(board, card = nil)
      avg = 0
      card_id, board_id = get_card_id(card), board.id if card
      estimate = Estimation.developers_estimation(board_id, card_id)
      if estimate.count > 0
        estimate.sum(&:user_time) / estimate.count.to_f
      else
        0
      end
    end

    def get_manager_estimate(board, card)
      avg = 0
      card_id, board_id = get_card_id(card), board.id
      estimate = Estimation.managers_estimation(board_id, card_id)
      if estimate.count > 0
        estimate.sum(&:user_time) / estimate.count.to_f
      else
        0
      end
    end

    # TODO fix this method
    # def developer_time_ratio(board, card)
    #   total_time = total_harvest_time(board, card)
    #   result = get_developer_estimate(board, card) - total_time
    #   result > 0 ? sprintf("%.2f", result) : "0.00"
    # end

    # TODO fix this method
    # def manager_time_ratio(board, card)
    #   total_time = total_harvest_time(board, card)
    #   result = get_manager_estimate(board, card) - total_time
    #   result > 0 ? sprintf("%.2f", result) : "0.00"
    # end

    # TODO fix this method
    # def developer_and_manager_ratios(board, card)
    #   developer_time_ratio(board, card) + " / " + manager_time_ratio(board, card)
    # end

    # TODO fix this method
    # def list_time_tracked(board, cards_id)
    #   HarvestLog.total_time_tracked(board.id).where("harvest_logs.card_id IN (?)", cards_id)
    # end

    # TODO fix this method
    # def total_harvest_time(board, card)
    #   card_id, board_id = get_card_id(card), board.id
    #   HarvestLog.total_time_tracked(board_id, card_id).sum(&:total_time)
    # end

    def list_cards(lists, only_staged_and_live)
      cards = Array.new
      lists.each do |list|
        cards << list.cards.map(&:id) if only_staged_and_live == list.finished?
      end
      cards
    end

end
