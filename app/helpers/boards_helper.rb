module BoardsHelper

  private

  def board_tracked_time(board_id)
    HarvestLog.joins( :harvest_trello )
      .where( harvest_trellos: { trello_board_id: board_id } )
      .total_hours
  end

  def get_max_time(dev_estimate, manager_estimate)
    [dev_estimate, manager_estimate].max
  end

  def board_remaining_time(dev_estimate, manager_estimate, tracked_time)
    return if tracked_time.zero?

    max_estimate = [dev_estimate, manager_estimate].max
    time = (max_estimate - tracked_time).round(2)
    klass = (time < 0 ? 'text-danger' : 'text-success')
    content_tag :span, sprintf("%0.2f", time), class: klass
  end

  def board_performance(dev_estimate, manager_estimate, tracked_time)
    return if tracked_time.zero?

    max_estimate = [dev_estimate, manager_estimate].max
    result = (max_estimate / tracked_time.round(2)) * 100
    klass = (result < 100? 'text-danger' : 'text-success')
    content_tag :span, sprintf("%.2f%", result), class: klass
  end

end
