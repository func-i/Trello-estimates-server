module TimeTrackingHelper

  def save_lists_to_db(board)
    project_name, trello_board_id = board.name, board.id
    lists = board.lists
    lists.each do |list|
      if list.cards
        list.cards.each do |card|
          harvest_project = get_card_id(card)
          HarvestTrello.find_or_create_by_harvest_project(harvest_project)
        end
      else
        puts "<----- #{board} does not have any lists ---->"
      end
    end
  end

  private

    def get_card_id(card)
      card.url.split('/')[4]
    end

end
# create_table "harvest_trellos", :force => true do |t|
#   t.string   "harvest_project"
#   t.string   "trello_board_id"
#   t.datetime "created_at",      :null => false
#   t.datetime "updated_at",      :null => false
#   t.string   "project_name"
# end

#<HarvestTrello id: 1,
  #harvest_project: "abcd",
  #trello_board_id: "asdf",
  #created_at: "2013-09-04 21:31:29",
  #updated_at: "2013-09-04 21:31:29",
  #project_name: "test">

#<HarvestLog id: 7,
  #board_id: nil,
  #card_id: "H0ibK9k5",
  #total_time: 0.9,
  #developer_email: "jon@func-i.com",
  #day: "2013-09-04",
  #created_at: "2013-09-04 16:19:46",
  #updated_at: "2013-09-04 16:19:46">

