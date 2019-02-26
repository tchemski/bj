class Menu
  LINE = '='*15

  attr_reader :player, :dealer

  def self.name_gets
    print "Введите ваше имя: "
    gets.chomp
  end

  def initialize(param)
    @player = param[:player]
    @dealer = param[:dealer]
  end

  def hello_puts
    puts "Добро пожаловать в игру Блэк-Джек, #{player.name}!"
    puts
    puts "Enter - сделать ставку, взять ещё карту"
    puts "пробел - вскрыть карты"
    puts "любой другой символ - пропустить ход"
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
      player: "#{player.cards} - #{layer.cards.points}",
      dealer: "#{dealer.cards} - #{dealer.cards.points}"
    )
  end

  def closed_cards_puts
    players_info(
      head: 'карты',
      player: "#{player.cards} - #{layer.cards.points}",
      dealer: '[X]'*dealer.cards.size
    )
  end

  def bank(money)
    puts "банк: #{money}$"
  end

  def yet_or_show_gets
    puts "ещё карту или вскрываемся?"
    gets.chomp
  end

  def bet?
    puts "Делаем ставку?"
    gets.chomp.empty?
  end

  def no_money_puts(player)
    puts "#{player.name} не имеет денег на ставку."
  end

  def game_over_puts
    puts "Игра окончена, приходите к нам ещё, #{player.name}"
  end

  private

  def players_info(param)
    puts "#{param[:head]}:"
    puts "  #{player.name}: #{param[:player]}"
    puts "  #{dealer.name}: #{param[:dealer]}"
  end
end
__END__
Добро пожаловать в игру Блэк-Джек, Дмитрий!

Enter - сделать ставку, взять ещё карту
любой символ - отказаться

счёт:
  Дмитрий: 100$
  Диллер: 100$
==============
делаем ставку?
банк:20$
карты:
  Дмитрий: 5 3 - 8
  Диллер: Х Х
ещё карту?
карты:
  Дмитрий: 5 3 2 - 10
  Диллер: 10 T - 21

