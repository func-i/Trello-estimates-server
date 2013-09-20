module EstimationsHelper

  private

    def get_total_tracked_time(board)
      HarvestLog.joins( :harvest_trello )
        .where( harvest_trellos: { trello_board_id: board.id } )
        .sum( &:time_spent )
    end

    def get_max_time(dev_estimate, manager_estimate)
      [dev_estimate, manager_estimate].max
    end

    def get_remaining_hours(dev_estimate, manager_estimate, tracked_time)
      return if tracked_time.zero?
      time = (get_max_time(dev_estimate, manager_estimate) - tracked_time).round(2)
      klass = (time < 0 ? 'text-danger' : 'text-success')
      content_tag :span, sprintf("%0.2f", time), class: klass
    end

    def total_board_performance(dev_estimate, manager_estimate, tracked_time)
      return if tracked_time.zero?
      result = (get_max_time(dev_estimate, manager_estimate) / tracked_time.round(2)) * 100
      klass = (result < 100? 'text-danger' : 'text-success')
      content_tag :span, sprintf("%.2f%", result), class: klass
    end

end
