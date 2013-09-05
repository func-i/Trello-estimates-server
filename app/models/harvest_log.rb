class HarvestLog < ActiveRecord::Base

  attr_accessible :day,
    :time_spent,
    :harvest_project_name,
    :harvest_project_id,
    :harvest_task_name,
    :harvest_task_id,
    :trello_board_name,
    :trello_board_id,
    :trello_card_name,
    :trello_card_id,
    :developer_email

  attr_accessor :harvest_project, :harvest_note

  # validates :board_id, :presence => true
  # validates :card_id, :presence => true
  # validates :developer_email, :presence => true
  # validates :total_time, :presence => true

  scope :total_time_tracked, lambda { |board_id, card_id = nil|
    if card_id
      where("board_id = ? AND card_id = ?", board_id, card_id)
    else
      where("board_id = ?", board_id)
    end
  }

  scope :total_time_tracked_by_developer, lambda { |developer_email|
    where("developer_email = ?", developer_email)
  }

  def self.create_or_update_harvest_log(args)

    harvest_log = where(
      day:                args[:day],
      time_spent:         args[:time_spent],
      harvest_project_id: args[:harvest_project_id],
      harvest_task_id:    args[:harvest_task_id],
      trello_card_id:     args[:trello_card_id] )

    harvest_trello = HarvestTrello.where(trello_card_short_id: args[:trello_card_id]).first

    HarvestLog.create!(
      harvest_project_name: args[:harvest_project_name],
      harvest_project_id:   args[:harvest_project_id],
      harvest_task_name:    args[:harvest_task_name],
      harvest_task_id:      args[:harvest_task_id],

      trello_board_name:    harvest_trello.trello_board_name,
      trello_board_id:      harvest_trello.trello_board_id,
      trello_card_name:     harvest_trello.trello_card_name,
      trello_card_id:      harvest_trello.trello_card_short_id,

      trello_card_id:       args[:trello_card_id],
      time_spent:           args[:time_spent],
      developer_email:      args[:dev_email],
      day:                  args[:day]
    )
  end

  private

    CARD_REGEX = /[C|c]ard ([0-9]+)/

    def self.assigned_card(text)
      CARD_REGEX.match(text)[1]
    end

    def self.fetch_trello_board_from_join_table(trello_card_id)
    end

    def self.fetch_trello_board_from_api(trello_card_id)
      Trello.configure do |config|
        config.developer_public_key = Figaro.env.trello_member_key
        config.member_token = Figaro.env.trello_token
      end
      Trello::Card.find(trello_card_id).board_id
    end
end

# def self.create_or_update_log(card_id, harvest_project_id, project_name, total_time, developer_email, day)
#   card_id = assigned_card(harvest_note)
#   harvest_log = where(:card_id => card_id, :developer_email => developer_email, :day => day).first

#   harvest_trello = HarvestTrello.find_or_create_by_harvest_project_and_project_name harvest_project_id, project_name
#   if harvest_trello.trello_board_id.nil?
#     board_id = fetch_board_id_from_trello_api(card_id)
#     harvest_trello.update_attribute :trello_board_id, board_id
#   end

#   if harvest_log
#     harvest_log.update_attribute("total_time", total_time) if harvest_log.total_time != total_time
#   else
#     HarvestLog.create!(
#       card_id: card_id,
#       day: day,
#       developer_email: developer_email,
#       total_time:  total_time,
#       board_id: harvest_trello.board_id
#     )
#   end
# end

