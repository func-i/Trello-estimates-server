module CardsHelper

  private

  def parse_card_id(url)
    url.split('/')[4]
  end

  def linked_card_name(card)
    link_to "Card #{card.short_id} - #{truncate card.name, length: 65}", card.url, target: "_blank"
  end

  def card_estimated_time(card_id, estimator)
    estimates = Estimation.for_card(card_id).send("by_#{estimator}")
    estimated_time = estimates.total_hours
    estimated_time unless estimated_time.zero?
  end

  def card_tracked_time(card_id)
    tracked_time = HarvestLog.by_trello_card(card_id).total_hours
    tracked_time unless tracked_time.zero?
  end

  def card_remaining_time(dev_estimate, manager_estimate, harvest_time)
    return unless harvest_time && (dev_estimate || manager_estimate)

    max_estimate = get_max(dev_estimate, manager_estimate)
    time = (max_estimate - harvest_time).round(2)
    klass = (time < 0 ? 'text-danger' : 'text-success')

    content_tag :span, time, class: klass
  end

  def card_performance(dev_estimate, manager_estimate, harvest_time)
    return unless harvest_time && (dev_estimate || manager_estimate)

    max_estimate = get_max(dev_estimate, manager_estimate)
    result = ((max_estimate / harvest_time) * 100).round(2)
    klass = (result < 100 ? 'text-danger' : 'text-success')

    content_tag :span, sprintf("%0.2f%", result), class: klass
  end

  # return the bigger of x and y; either could be nil
  def get_max(x, y)
    [x.to_f, y.to_f].max
  end

end
