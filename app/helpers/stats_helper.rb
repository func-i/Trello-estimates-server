module StatsHelper

  private

  def get_estimated_time(target, target_id, estimator)
    time = Estimation.search(target, target_id, estimator).total_hours
    time unless time.zero?
  end

  def get_tracked_time(target, target_id)
    time = HarvestLog.search(target, target_id).total_hours
    time unless time.zero?
  end

  def calc_remaining_time(dev_estimate, manager_estimate, tracked_time)
    return unless tracked_time && (dev_estimate || manager_estimate)

    max_estimate = calc_max(dev_estimate, manager_estimate)
    time = (max_estimate - tracked_time).round(2)
    klass = (time < 0 ? 'text-danger' : 'text-success')

    content_tag :span, time, class: klass
  end

  def calc_performance(dev_estimate, manager_estimate, tracked_time)
    return unless tracked_time && (dev_estimate || manager_estimate)

    max_estimate = calc_max(dev_estimate, manager_estimate)
    result = ((max_estimate / tracked_time) * 100).round
    klass = (result < 100 ? 'text-danger' : 'text-success')

    content_tag :span, "#{result}%", class: klass
  end

  # return the bigger of x and y; either could be nil
  def calc_max(x, y)
    [x.to_f, y.to_f].max
  end

end
