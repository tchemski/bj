require_relative 'hand.rb'

class Player
  START_MONEY = 100
  EXCESS_MESSAGE = 'перебор!'.freeze
  BLACK_JACK_MESSAGE = 'Блэк Джэк!'.freeze

  attr_reader :name, :hand
  attr_accessor :wallet

  def initialize(name, money = START_MONEY)
    @name = name
    discard
    self.wallet = money
  end

  def discard
    @hand = Hand.new
  end

  def points
    hand.points
  end

  def points_to_s
    if points > Hand::BLACK_JACK
      EXCESS_MESSAGE
    elsif points == Hand::BLACK_JACK
      BLACK_JACK_MESSAGE
    else
      points.to_s
    end
  end

  def take_from(deck)
    hand << deck.random_card
  end
end
