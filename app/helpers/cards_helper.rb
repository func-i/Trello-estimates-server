module CardsHelper

  private

  def parse_card_id(url)
    url.split('/')[4]
  end

  def linked_card_name(card)
    link_to "Card #{card.short_id} - #{truncate card.name, length: 65}", card.url, target: "_blank"
  end

end
