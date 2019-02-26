class Player
  START_MONEY = 100

  attr_reader :name, :cards
  attr_accessor :wallet

  def initialize(name, money = START_MONEY)
    @name = name
    discard
    self.wallet = money
  end

  def discard
    @cards = CardArray.new
  end

  def points
    cards.points
  end

  def take_from(deck)
    cards << deck.random_card
  end
end
