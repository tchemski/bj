require_relative 'card_array.rb'
require_relative 'menu.rb'
require_relative 'player.rb'

class Game
  DEALER_NAME = 'Диллер'.freeze
  BET = 10
  STOP_WORD = /^ $/.freeze
  YET_WORD = /^$/.freeze
  MAX_CARDS_SIZE = 3

  attr_reader :player, :dealer, :menu

  attr_accessor :bank,
                :deck,
                :stop_word

  def initialize
    @player = Player.new(Menu.name_gets)
    @dealer = Player.new(DEALER_NAME)
    @menu = Menu.new(player: player, dealer: dealer)
    menu.hello_puts
  end

  def turn
    return false unless make_bank?

    self.deck = CardArray.deck_generate
    players.each { |p| 2.times { p.take_from(deck) } }
    player_turn
    dealer_turn
    player_turn
    distribute_bank
    self.stop_word = ''
  end

  def make_bank?
    menu.wallets_puts

    # есть ли деньги?
    players.each do |p|
      next unless p.wallet < BET

      menu.no_money_puts(p)
      menu.game_over_puts
      return false
    end

    # делаем ставку?
    unless menu.bet?
      menu.game_over_puts
      return false
    end

    players.each { |p| p.wallet -= BET }
    self.bank = BET + BET
    menu.bank(bank)

    true
  end

  def dealer_turn
    dealer.take_from(deck) if dealer.points < 17
  end

  def player_turn
    return if stop_word =~ STOP_WORD\
              || player.cards.size == MAX_CARDS_SIZE\
              || player.cards.points == CardArray::BLACK_JACK

    menu.closed_cards_puts
    self.stop_word = menu.yet_or_show_gets

    player.take_from(deck) if stop_word =~ YET_WORD
  end

  def distribute_bank
    menu.cards_puts

    if (player.points == dealer.points)\
       || players.all? { |p| p.points > CardArray::BLACK_JACK }
      players.each { |p| p.wallet += bank / 2 }
      menu.draw(bank)
    elsif player.points > CardArray::BLACK_JACK
      win dealer
    elsif dealer.points > CardArray::BLACK_JACK
      win player
    elsif player.points > dealer.points
      win player
    else
      win dealer
    end

    self.bank = 0
    players.each(&:discard)
  end

  def win(winner)
    winner.wallet += bank
    menu.win(winner, bank)
  end

  def players
    [player, dealer]
  end
end
