class HarvestLog < ActiveRecord::Base

  belongs_to :harvest_trello

  validates :harvest_entry_id,  presence: true
  validates :harvest_task_id,   presence: true
  validates :harvest_task_name, presence: true
  validates :trello_card_id,    presence: true
  validates :trello_card_name,  presence: true
  validates :time_spent,        presence: true
  validates :day,               presence: true
  validates :developer_email,   presence: true

  scope :by_trello_board, ->(board_id) {
    joins(:harvest_trello).
    where(harvest_trellos: { trello_board_id: board_id })
  }

  scope :by_trello_card, ->(card_id) {
    where(trello_card_id: card_id)
  }

  scope :search, ->(target, target_id) {
    send("by_trello_#{target}", target_id)
  }

  # sum of tracked times in hours
  scope :total_hours, -> { sum(:time_spent) }

  # total tracked time of every card on a board
  scope :cards_on_board, ->(board_id) {
    select("trello_card_id, sum(time_spent) AS tracked_time").
    by_trello_board(board_id).
    group(:trello_card_id)
  }

  # this method deletes from database all logs for recon_day that aren't on Harvest
  def self.reconcile_daily_logs(recon_day, harvest_entries)
    harvest_entry_ids = harvest_entries.collect(&:id)
    self
      .where(day: recon_day)
      .where.not(harvest_entry_id: harvest_entry_ids)
      .delete_all
  end

end
