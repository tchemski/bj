class Player
  START_MONEY = 100
  BJ_NAME = 'Чёрный Джек'

  def self.black_jack
    Player.new(BJ_NAME)
  end

  attr_reader :name, :cards
  attr_accessor :wallet

  def initialize(name)
    @name = name
    discard_cards
    self.wallet = START_MONEY
  end

  def discard_cards
    @cards = CardArray.new
  end

  def points
    cards.calculate_points
  end

  def take_card(deck)
    cards.add(deck.random_card)
  end
end
