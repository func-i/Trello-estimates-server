module HarvestTrelloHelper

  def check_board_against_join_database(board)
    board_name, board_id = board.name, board.id
    lists = board.lists
    lists.each do |list|
      if list.cards
        list.cards.each do |card|
          short_id = get_card_id(card)
          HarvestTrello.find_or_create(card.id, short_id, card.name, board_name, board_id)
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
