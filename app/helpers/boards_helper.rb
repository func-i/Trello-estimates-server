module BoardsHelper

  private

    def parse_card_id(url)
      url.split('/')[4]
    end

    # def list_cards(lists, only_staged_and_live)
    #   cards = Array.new
    #   lists.each do |list|
    #     cards << list.cards.map(&:id) if only_staged_and_live == list.finished?
    #   end
    #   cards
    # end

    def linked_card_name(card)
      link_to "Card #{card.short_id} - #{truncate card.name, length: 40}", card.url
    end

    # will only display the most recently submitted estimations
    # the workflow in this case would be:
    # developer and manager both submit 1 time estimation for each card
    # can go back and update estimation but only the most recent is displayed
    def fetch_time_estimates(board, card, manager = false)
      card_id, board_id = parse_card_id(card.url), board.id
      if manager
        Estimation.managers_estimation(board_id, card_id).sum(&:user_time)
      else
        Estimation.developers_estimation(board_id, card_id).sum(&:user_time)
      end
    end

    def total_card_tracked_time(card)
      card_id = parse_card_id(card.url)
      HarvestLog.where(trello_card_id: card_id).sum(&:time_spent)
    end

    def get_max_time(dev_estimate, manager_estimate)
      [dev_estimate, manager_estimate].max
    end

    def calculate_time_remaining(dev_estimate, manager_estimate, tracked_time)
      (get_max_time(dev_estimate, manager_estimate) - tracked_time).round(2)
    end

    def calculate_card_performance(dev_estimate, manager_estimate, tracked_time)
      result = unless tracked_time.zero?
        ((get_max_time(dev_estimate, manager_estimate) / tracked_time) * 100).round(2)
      else
        0
      end
      sprintf("%0.2f%", result)
    end

end
