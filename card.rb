class Card
  SUITS = { hearts: '♥',
            diamonds: '♦',
            clubs: '♣',
            spades: '♠' }.freeze

  JACK, QUEEN, KING, ACE = (11..14).to_a

  FACES = { JACK => 'J',
            QUEEN => 'Q',
            KING => 'K',
            ACE => 'A' }.merge!(Hash[*(2..10).map { |e| [e, e.to_s] }.flatten])

  (2..10).each { |i| FACES[i] = i.to_s.freeze }

  attr_reader :name, :suit, :points

  def initialize(name, suit, points)
    @name = name.to_i
    @suit = suit.to_sym
    @points = points.to_i
  end

  def to_s
    "#{FACES[name]}#{SUITS[suit]}"
  end
end
