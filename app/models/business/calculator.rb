class Calculator
  def self.avg_estimation_timetracked_by_developer

    query = "select ((sum(e.user_time)-sum(ht.total_time))/(count(e.id)+ count(ht.id))) as difference,
            ht.day from estimations e, harvest_logs ht where
            e.board_id = ht.board_id AND e.card_id = ht.card_id
            group by e.created_at,ht.day"


    # this isn't working
    # ActiveRecord::Base.connection.execute(query)
  end
end
