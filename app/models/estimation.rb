class Estimation < ActiveRecord::Base
  attr_accessible :board_id,
                  :card_id,
                  :developer_id,
                  :developer_time,
                  :manager_id,
                  :manager_time

end
