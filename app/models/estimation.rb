class Estimation < ActiveRecord::Base

  validates :card_id,   presence: true
  validates :board_id,  presence: true
  validates :user_id,   presence: true, 
    unless: Proc.new { |estimation| estimation.is_manager? }
  validates :user_time, presence: true

  scope :by_manager, -> { where(is_manager: true) }
  scope :by_developers, -> { where(is_manager: false) }

  # estimations by the manager for a board
  scope :manager_board, ->(board_id) {
    by_manager.where(board_id: board_id)
  }

  # estimations by all developers for a board
  scope :developers_board, ->(board_id) {
    by_developers.where(board_id: board_id)
  }

  # estimations by the manager for a card
  scope :manager_card, ->(card_id) {
    by_manager.where(card_id: card_id)
  }

  # estimations by all developers for a card
  scope :developers_card, ->(card_id) {
    by_developers.where(card_id: card_id)
  }

  # estimations by a particular developer for a card
  scope :developer_card, ->(dev_id, card_id) {
    by_developers.where(user_id: dev_id, card_id: card_id)
  }

end
