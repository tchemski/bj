require_relative 'card.rb'

# наборы карт, генерация колоды
class CardArray < Array
  BLACK_JACK = 21

  def self.deck_generate
    deck = CardArray.new
    Card::SUITS.each_key do |suit_name|
      (2..10).each { |i| deck << Card.new(i, suit_name, i) }

      (Card::JACK..Card::KING).each { |i| deck << Card.new(i, suit_name, 10) }

      deck << Card.new(Card::ACE, suit_name, 11)
    end
    deck
  end

  def points
    result = []
    sum = 0
    aces = 0
    each do |card|
      sum += card.points
      aces += 1 if card.name == Card::ACE
    end
    loop do
      result << sum
      break if aces.zero?

      sum -= 10
      aces -= 1
    end
    # удаляем до последнего либо до подходящего
    result.delete_at(0) while result.size > 1 && result[0] >= BLACK_JACK
    result[0]
  end

  def random_card
    delete_at(rand(size))
  end

  def to_s
    map(&:to_s).join(' ')
  end
end
