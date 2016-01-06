class HarvestLog < ActiveRecord::Base

  belongs_to :harvest_trello

  validates :harvest_task_name, presence: true
  validates :harvest_task_id,   presence: true
  validates :trello_card_id,    presence: true
  validates :time_spent,        presence: true
  validates :day,               presence: true
  validates :developer_email,   presence: true
  validates :trello_card_name,  presence: true

  scope :by_trello_card, ->(card_id) {
    where(trello_card_id: card_id)
  }

  # sum of tracked times in hours
  scope :total_hours, -> { sum(:time_spent) }

end
