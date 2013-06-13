class Estimation < ActiveRecord::Base
  attr_accessible :board_id,
                  :card_id,
                  :user_id,
                  :user_time,
                  :is_manager

  validates :board_id,
            :presence => true

  validates :card_id,
            :presence => true

  validates :user_id,
            :presence => true

  validates :user_time,
            :presence => true

  scope :developers_estimation, lambda { |board_id, card_id = nil|
    if card_id
      where("board_id = ? AND card_id = ? AND is_manager IS NULL", board_id, card_id)
    else
      where("board_id = ? AND is_manager IS NULL", board_id)
    end
  }

  scope :managers_estimation, lambda { |board_id, card_id = nil|
    if card_id
      where("board_id = ? AND card_id = ? AND is_manager IS NOT NULL", board_id, card_id)
    else
      where("board_id = ? AND is_manager IS NOT NULL", board_id)
    end
  }

  scope :estimations_by_developer, lambda { |user_id| where("user_id =? AND is_manager IS NULL", user_id) }

  scope :total_estimation_by_developer, lambda { self.estimations_by_developer }

end
