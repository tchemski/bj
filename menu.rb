class Menu
  LINE = '=' * 15

  attr_reader :player, :dealer

  def self.name_gets
    print 'Введите ваше имя: '
    gets.chomp
  end

  def initialize(param)
    @player = param[:player]
    @dealer = param[:dealer]
  end

  def hello_puts
    puts "Добро пожаловать в игру Блэк-Джек, #{player.name}!"
    puts
    puts 'Enter - сделать ставку, взять ещё карту'
    puts 'пробел - вскрыть карты'
    puts 'любой другой символ - пропустить ход'
    puts
  end

  def wallets_puts
    players_info(
      head: 'счёт',
      player: "#{player.wallet}$",
      dealer: "#{dealer.wallet}$"
    )
    puts LINE
  end

  def cards_puts
    players_info(
      head: 'карты',
      player: "#{player.cards} - #{player.cards.points}",
      dealer: "#{dealer.cards} - #{dealer.cards.points}"
    )
  end

  def closed_cards_puts
    players_info(
      head: 'карты',
      player: "#{player.cards} - #{player.cards.points}",
      dealer: '[X]' * dealer.cards.size
    )
  end

  def bank(money)
    puts "банк: #{money}$"
  end

  def yet_or_show_gets
    print 'ещё карту или вскрываемся? '
    gets.chomp
  end

  def bet?
    print "Делаем ставку, #{player.name}? "
    gets.chomp.empty?
  end

  def no_money_puts(player)
    puts "#{player.name} не имеет денег на ставку."
  end

  def game_over_puts
    puts "Игра окончена, приходите к нам ещё, #{player.name}"
  end

  def win(winner, bank)
    puts "#{winner.name} получает банк #{bank}$"
  end

  def draw(bank)
    puts "ничья, банк #{bank}$ поделен между: #{player.name} и #{dealer.name}"
  end

  private

  def players_info(param)
    puts "#{param[:head]}:"
    puts "  #{player.name}: #{param[:player]}"
    puts "  #{dealer.name}: #{param[:dealer]}"
  end
end
