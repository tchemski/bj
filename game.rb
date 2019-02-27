require_relative 'card_deck.rb'
require_relative 'menu.rb'
require_relative 'player.rb'

class Game
  DEALER_NAME = 'Диллер'.freeze
  BET = 10

  word_regexp = {
    1 => /^1$/.freeze,
    2 => /^2$/.freeze,
    3 => /^3$/.freeze
  }

  MENU_WORDS = {
    bet_yes: word_regexp[1],
    bet_no: word_regexp[2],

    yet: word_regexp[1],
    open: word_regexp[2],
    skip: word_regexp[3]
  }.freeze

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

    self.deck = CardDeck.new
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
    loop do
      ask = menu.ask_bet
      if ask =~ MENU_WORDS[:bet_yes]
        break
      elsif ask =~ MENU_WORDS[:bet_no]
        menu.game_over_puts
        return false
      else
        menu.error_message
      end
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
    return if stop_word =~ MENU_WORDS[:open]\
              || player.hand.size == MAX_CARDS_SIZE\
              || player.points == Hand::BLACK_JACK

    menu.closed_cards_puts

    loop do
      ask = menu.ask_yet
      if MENU_WORDS.values_at(:yet, :open, :skip).none? { |re| ask =~ re }
        menu.error_message
        next
      end
      self.stop_word = ask
      break
    end

    player.take_from(deck) if stop_word =~ MENU_WORDS[:yet]
  end

  def distribute_bank
    menu.cards_puts

    if (player.points == dealer.points)\
       || players.all? { |p| p.points > Hand::BLACK_JACK }
      players.each { |p| p.wallet += bank / 2 }
      menu.draw(bank)
    elsif player.points > Hand::BLACK_JACK
      win dealer
    elsif dealer.points > Hand::BLACK_JACK
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
