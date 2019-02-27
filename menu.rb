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
      player: "#{player.hand} - #{player.points}",
      dealer: "#{dealer.hand} - #{dealer.points}"
    )
  end

  def closed_cards_puts
    players_info(
      head: 'карты',
      player: "#{player.hand} - #{player.points}",
      dealer: '[X]' * dealer.hand.size
    )
  end

  def bank(money)
    puts "банк: #{money}$"
  end

  def ask_yet
    puts '1) ещё карту'
    puts '2) вскрываемся'
    puts '3) пропустить ход'
    print ': '
    gets.chomp
  end

  def ask_bet
    puts "Делаем ставку, #{player.name}?"
    puts "1) Да"
    puts "2) Нет"
    print ': '
    gets.chomp
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

  def error_message
    puts "Неправильный ввод, такого пункта нет!!!"
  end

  private

  def players_info(param)
    puts "#{param[:head]}:"
    puts "  #{player.name}: #{param[:player]}"
    puts "  #{dealer.name}: #{param[:dealer]}"
  end
end
