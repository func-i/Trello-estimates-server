class Estimation < ActiveRecord::Base
  attr_accessible :board_id,
                  :card_id,
                  :developer_time,
                  :manager_time,
                  :user_email,
                  :manager_email

end
