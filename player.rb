require_relative 'hand.rb'

class Player
  START_MONEY = 100

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

  def take_from(deck)
    hand << deck.random_card
  end
end
