class Estimation < ActiveRecord::Base

  validates :card_id,   presence: true
  validates :board_id,  presence: true
  validates :user_id,   presence: true, 
    unless: Proc.new { |estimation| estimation.is_manager? }
  validates :user_time, presence: true

  scope :by_manager,    -> { where(is_manager: true) }
  scope :by_developers, -> { where(is_manager: false) }
  scope :by_developer,  ->(dev_id) { where(user_id: dev_id) }

  scope :for_board, ->(board_id) { where(board_id: board_id) }
  scope :for_card,  ->(card_id) { where(card_id: card_id) }

  # for target, by estimator
  scope :search, ->(target, target_id, estimator, estimator_id = nil) {
    result = send("for_#{target}", target_id)
    
    if estimator == :developer
      result.send("by_#{estimator}", estimator_id)
    else
      result.send("by_#{estimator}")
    end
  }

  # sum of estimated times in hours
  scope :total_hours, -> { sum(:user_time) }

end
