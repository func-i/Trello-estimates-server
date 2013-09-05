module HarvestTrelloHelper

  def check_board_against_join_database(board)
    puts board.to_yaml
    trello_board_id, trello_board_name = board.id, board.name
    lists = board.lists
    lists.each do |list|
      if list.cards
        list.cards.each do |card|
          short_id = get_card_id(card.url)
          HarvestTrello.find_or_create(card.id, short_id, card.name, trello_board_id, trello_board_name)
        end
      else
        puts "<----- #{board} does not have any lists ---->"
      end
    end
  end

  def get_card_id(url)
    url.split('/')[4]
  end

end

# create_table "harvest_trellos", :force => true do |t|
#   t.string   "trello_board_name"
#   t.string   "trello_board_id"
#   t.string   "trello_card_name"
#   t.string   "trello_card_short_id"
#   t.string   "trello_card_long_id"
#   t.datetime "created_at",           :null => false
#   t.datetime "updated_at",           :null => false
# end

# --- !ruby/object:Trello::Card
# attributes:
#   :id: 52267b7ce43702e33d000b17
#   :short_id: 3
#   :name: test card done!
#   :description: ''
#   :due:
#   :closed: false
#   :url: https://trello.com/c/SfNvSd8B/3-test-card-done
#   :board_id: 522675c950e7c1b44b001177
#   :member_ids: []
#   :list_id: 522675c950e7c1b44b00117a
#   :pos: 65535
#   :last_activity_date: 2013-09-04 00:14:52.920000000 Z
#
#
#<HarvestLog id: 58,
  #harvest_project_name: "Internal",
  #harvest_project_id: "4064723",
  #harvest_task_name: "Vacation",
  #harvest_task_id: "2332997",
  #trello_board_name: nil,
  #trello_board_id: nil,
  #trello_card_name: nil,
  #trello_card_id: "H0ibK9k5",
  #time_spent: 5.0,
  #developer_email:
  #"jon@func-i.com",
  #day: "2013-09-05",
  #created_at: "2013-09-05 23:14:34",
  #updated_at: "2013-09-05 23:14:34">
