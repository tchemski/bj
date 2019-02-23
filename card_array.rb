require_relative 'card.rb'

#наборы карт, генерация колоды
class CardArray
  class << self
    def deck_generate
      deck = CardArray.new
      Card::SUITS.each_key do |suit_name|
        (2..10).each {|i| deck.add(Card.new(i, suit_name, i))}

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
    result = []
    sum = 0
    aces = 0
    card_array.each do |card|
      sum += card.points
      aces += 1 if card.name == Card::ACE
    end
    loop do
      result << sum
      break if aces.zero?
      sum -= 10
      aces -= 1
    end
    result
  end

  def random_card
    card_array.delete_at(rand(card_array.size))
  end
end
