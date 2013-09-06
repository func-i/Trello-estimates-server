module EstimationsHelper

  private

    def get_max_time(dev_estimate, manager_estimate)
      [dev_estimate, manager_estimate].max
    end

    def get_remaining_hours(dev_estimate, manager_estimate, tracked_time)
      (get_max_time(dev_estimate, manager_estimate) - tracked_time).round(2)
    end

    def calculate_board_performance(dev_estimate, manager_estimate, tracked_time)
      result = (get_max_time(dev_estimate, manager_estimate) / tracked_time.round(2)) * 100
      if result.nan?
        "-"
      else
        sprintf("%.2f%", result)
      end
    end

end
