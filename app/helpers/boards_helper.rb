module BoardsHelper

  private

    def parse_card_id(url)
      url.split('/')[4]
    end

    def linked_card_name(card)
      link_to "Card #{card.short_id} - #{truncate card.name, length: 65}", card.url, target: "_blank"
    end

    def fetch_card_estimates(board, card)
      result = Hash.new(0)
      board_id, card_id = board.id, parse_card_id(card.url)
      Estimation.batch_estimates(board_id, card_id).each do |card|
        if card.is_manager
          result[:manager] = card.user_time
        else
          result[:dev] = card.user_time
        end
      end
      result
    end

    def time_estimation(card, manager = false)
      if manager
        card[:manager]
      else
        card[:dev]
      end
    end

    def card_tracked_time(card)
      card_id = parse_card_id(card.url)
      HarvestLog.where(trello_card_id: card_id).sum(&:time_spent)
    end

    def remaining_time(dev_estimate, manager_estimate, harvest_time)
      ([dev_estimate, manager_estimate].max - harvest_time).round(2)
    end

    def card_performance(dev_estimate, manager_estimate, harvest_time)
      result = unless harvest_time.zero?
        (([dev_estimate, manager_estimate].max / harvest_time) * 100).round(2)
      else
        0
      end
      sprintf("%0.2f%", result)
    end

end
