# separate from TrelloHelper, which includes Trello modules
module TrelloParser

  # parse out the shortLink of a board or card from its url
  # the shortLink is used as board_id, card_id
  def parse_short_link(url)
    url.split('/')[4]
  end

end
