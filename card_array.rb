require_relative 'card.rb'

#наборы карт, генерация колоды
class CardArray
  class << self
    def deck_generate
      deck = CardArray.new
      p deck
      Card::SUITS.each_key do |suit_name|
        p suit_name
        (2..10).each {|i| deck.add(Card.new(i, suit_name, i))}
        p deck
        (Card::JACK..Card::KING).each { |i| deck.add(Card.new(i, suit_name, 10)) }

        deck.add(Card.new(Card::ACE, suit_name, 11))
      end
      deck
    end
  end

  attr_reader :card_array

  def initialize
    @card_array = []
  end

  def add(card)
    card_array << card
  end

  def calculate_points
    # TODO
  end

  def random_card
    # TODO
  end
end
