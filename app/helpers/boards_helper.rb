module BoardsHelper

  private

  def board_estimated_time(board_id, estimator)
    estimated_time = Estimation.for_board(board_id)
      .send("by_#{estimator}")
      .total_hours
    estimated_time unless estimated_time.zero?
  end

  def board_tracked_time(board_id)
    tracked_time = HarvestLog.by_trello_board(board_id).total_hours
    tracked_time unless tracked_time.zero?
  end

  def board_remaining_time(dev_estimate, manager_estimate, tracked_time)
    return unless tracked_time && (dev_estimate || manager_estimate)

    max_estimate = get_max(dev_estimate, manager_estimate)
    time = (max_estimate - tracked_time).round(2)
    klass = (time < 0 ? 'text-danger' : 'text-success')

    content_tag :span, sprintf("%0.2f", time), class: klass
  end

  def board_performance(dev_estimate, manager_estimate, tracked_time)
    return unless tracked_time && (dev_estimate || manager_estimate)

    max_estimate = get_max(dev_estimate, manager_estimate)
    result = ((max_estimate / tracked_time) * 100).round(2)
    klass = (result < 100? 'text-danger' : 'text-success')

    content_tag :span, sprintf("%.2f%", result), class: klass
  end

  # return the bigger of x and y; either could be nil
  def get_max(x, y)
    [dev_estimate.to_f, manager_estimate.to_f].max
  end

end
