class Card
  SUITS = { hearts: '♥',
            diamonds: '♦',
            clubs: '♣',
            spades: '♠' }.freeze

  JACK, QUEEN, KING, ACE = (11..14)

  attr_reader name, face, suit, points

  def initialize(name, face, suit, points)
    @name = name.to_i
    @face = face.to_s.freeze
    @suit = suit.to_sym
    @points = points.to_i
  end

  def to_s
    "#{@face}#{SUITS[@suit]}"
  end
end
