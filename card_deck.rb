require_relative 'card.rb'

# генерация колоды
class CardDeck

  def initialize
    Card::SUITS.each_key do |suit_name|
      (2..10).each { |i| deck << Card.new(i, suit_name, i) }

      (Card::JACK..Card::KING).each { |i| deck << Card.new(i, suit_name, 10) }

      deck << Card.new(Card::ACE, suit_name, 11)
    end
  end

  def random_card
    deck.delete_at(rand(deck.size))
  end

  private

  def deck
    @deck ||= []
  end
end
