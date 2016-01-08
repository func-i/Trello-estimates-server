module TrelloHelper
  include Trello
  include Trello::Authorization

  def trello_client
    session[:trello_client]
  end

  def set_trello_client(access_token)
    session[:trello_client] = Trello::Client.new(
      consumer_key:       Figaro.env.trello_developer_key,
      consumer_secret:    Figaro.env.trello_developer_secret_key,
      oauth_token:        access_token.token,
      oauth_token_secret: access_token.secret
    )
  end

  # parse out the shortLink of a board or card from its url
  # the shortLink is used as board_id, card_id
  def parse_short_link(url)
    url.split('/')[4]
  end

  # merge two arrays into one nested hash
  # { card_id: { estimate: 3.0, tracked: 2.5 }, card_id: .... }
  def merge_cards_stats(estimates, trackings)
    cards = {}
    estimates.to_a.each do |est|
      cards[est.card_id] = { estimate: est.estimated_time }
    end

    trackings.to_a.each do |tr|
      card_id = tr.trello_card_id
      
      if cards[card_id]
        cards[card_id][:tracked] = tr.tracked_time
      else
        cards[card_id] = { tracked: tr.tracked_time }
      end
    end

    cards
  end

end
