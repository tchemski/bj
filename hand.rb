require_relative 'card.rb'

class Hand
  BLACK_JACK = 21

  attr_reader :points

  def initialize
    @deck = []
    @points = 0
  end

  def <<(card)
    deck << card
    @points = points_calculate
  end

  def size
    deck.size
  end

  def to_s
    deck.map(&:to_s).join(' ')
  end

  private

  def points_calculate
    result = []
    sum = 0
    aces = 0
    deck.each do |card|
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
    result.delete_at(0) while result.size > 1 && result[0] > BLACK_JACK
    result[0]
  end

  attr_reader :deck
end

__END__




