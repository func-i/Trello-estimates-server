module HarvestTrelloHelper

  # def check_board_against_join_database(board)
  #   board_name, board_id = board.name, board.id
  #   lists = board.lists
  #   lists.each do |list|
  #     if list.cards
  #       list.cards.each do |card|
  #         long_id = card.id
  #         short_id = Tasks::ParseCardUrl.get_id(card.url)
  #         HarvestTrello.find_or_create(long_id, short_id, card.name, board_name, board_id)
  #       end
  #     else
  #       puts "<----- #{board} does not have any lists ---->"
  #     end
  #   end
  # end

end
