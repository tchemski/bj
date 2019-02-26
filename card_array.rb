require_relative 'card.rb'

#наборы карт, генерация колоды
class CardArray < Array

  BLACK_JACK = 21

  attr_reader :card_array

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
    # удаляем до последнего либо до подходящего
    result.delete_at(0) while result.size > 1 && result[0] >= BLACK_JACK
    result[0]
  end

  def random_card
    card_array.delete_at(rand(card_array.size))
  end

  def to_s
    self.map{|c| c.to_s}.join(' ')
  end
end
