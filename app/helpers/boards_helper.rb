module BoardsHelper

  private

    def parse_card_id(url)
      url.split('/')[4]
    end

    def linked_card_name(card)
      link_to "Card #{card.short_id} - #{truncate card.name, length: 65}", card.url, target: "_blank"
    end

    def card_estimated_time(card_id, by_manager = false)
      estimated_time = 
        if by_manager
          Estimation.manager_card(card_id).total_hours
        else
          Estimation.developers_card(card_id).total_hours
        end
      estimated_time unless estimated_time.zero?
    end

    def card_tracked_time(card_id)
      tracked_time = HarvestLog.time_tracked_by_card(card_id).total_hours
      tracked_time unless tracked_time.zero?
    end

    def remaining_time(dev_estimate, manager_estimate, harvest_time)
      return unless (dev_estimate || manager_estimate) && harvest_time
      time = ([dev_estimate.to_f, manager_estimate.to_f].max - harvest_time).round(2)
      klass = (time < 0 ? 'text-danger' : 'text-success')

      content_tag :span, time, class: klass
    end

    def card_performance(dev_estimate, manager_estimate, harvest_time)
      return unless harvest_time && (dev_estimate || manager_estimate)
      result = (harvest_time.zero? ? 0 : (([dev_estimate.to_f, manager_estimate.to_f].max / harvest_time) * 100).round(2))

      klass = (result < 100 ? 'text-danger' : 'text-success')
      content_tag :span, sprintf("%0.2f%", result), class: klass
    end

end
