class Estimation < ActiveRecord::Base
  extend UsersHelper

  attr_accessible :board_id,
    :card_id,
    :user_id,
    :user_time,
    :is_manager

  validates :card_id,   :presence => true
  validates :board_id,  :presence => true
  validates :user_id,   :presence => true, :unless => Proc.new { |estimation| estimation.is_manager? }
  validates :user_time, :presence => true

  scope :manager, lambda { where(is_manager: true) }
  scope :not_manager, lambda { where(is_manager: false) }

  scope :developers_estimation, lambda { |board_id, card_id = nil|
    if card_id
      where("board_id = ? AND card_id LIKE ? AND is_manager = false", board_id, card_id)
    else
      where("board_id = ? AND is_manager = false", board_id)
    end
  }

  scope :managers_estimation, lambda { |board_id, card_id = nil|
    if card_id
      where("board_id = ? AND card_id LIKE ? AND is_manager = true", board_id, card_id)
    else
      where("board_id = ? AND is_manager = true", board_id)
    end
  }

  scope :batch_estimates, lambda { |board_id, card_id|
    where("board_id = ? AND card_id = ?", board_id, card_id)
  }

end
