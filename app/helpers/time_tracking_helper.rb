module TimeTrackingHelper

  def check_board_against_join_database(board)
    project_name, trello_board_id = board.name, board.id
    lists = board.lists
    lists.each do |list|
      if list.cards
        list.cards.each do |card|
          HarvestTrello.find_or_create(get_card_id(card), project_name, trello_board_id)
        end
      else
        puts "<----- #{board} does not have any lists ---->"
      end
    end
  end

  def get_card_id(card)
    card.url.split('/')[4]
  end

end
