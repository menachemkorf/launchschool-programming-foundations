SUITS = ['Hearts', 'Diamonds', 'Spades', 'Clubs'].freeze

VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
          'J', 'Q', 'K', 'A'].freeze

BUST = 21
DEALER_STAY = 17

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  VALUES.product(SUITS).shuffle
end

def initialize_hands(deck)
  player_cards = []
  dealer_cards = []

  2.times { deal(deck, player_cards) }
  2.times { deal(deck, dealer_cards) }

  [player_cards, dealer_cards]
end

def display_greeting
  system('clear') || system('cls')
  prompt "Welcome to Twenty-One!"
end

def format_cards(cards)
  formatted_cards = []

  cards.each do |card|
    value = card[0]
    suit = card[1]
    formatted_cards.push("'#{value} of #{suit}'")
  end
  formatted_cards.join(', ')
end

def display_hand(name, cards, full = true)
  if full
    visible_cards = cards
    total = " for a total of #{total(cards)}"
  else
    visible_cards = [cards[0]]
    total = " and ?"
  end
  msg = "#{name} has #{cards.length} cards: "
  msg += format_cards(visible_cards)
  msg += total
  puts msg
end

def display_hands(player_cards, dealer_cards, player_turn = false)
  full = !player_turn
  display_greeting if player_turn
  display_hand('Player', player_cards)
  display_hand('Dealer', dealer_cards, full)
end

def total(cards)
  values = cards.map { |card| card[0] }
  sum = 0

  # calculate sum
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
  end

  # modify value of 'A' if total more than 21
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > BUST
  end

  sum
end

def deal(deck, player, num=1)
  num.times do
    player.push(deck.pop)
  end
end

def choose(question, valid_answers)
  loop do
    prompt(question)
    choice = gets.chomp.downcase
    return choice if valid_answers.include?(choice)
    prompt("Invalid option.")
  end
end

def hit_or_stay
  player_choice = ''
  loop do
    prompt("(h)it or (s)tay?")
    player_choice = gets.chomp.downcase
    break if %w(h s).include?(player_choice)
    prompt("Invalid option.")
  end
  player_choice
end

def busted?(sum)
  sum > BUST
end

def detect_result(player_total, dealer_total)
  if player_total > dealer_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(result)
  case result
  when :player_busted
    prompt "You busted, dealer won."
  when :dealer_busted
    prompt "Dealer busted, you win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer won."
  when :tie
    prompt "It's a tie."
  end
end

def play_again?
  choice = choose("Do you want to play again? (y/n)", ['y', 'n'])
  choice == 'y'
end

loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  deal(deck, player_cards, 2)
  deal(deck, dealer_cards, 2)

  # player turn
  player_turn = true
  display_hands(player_cards, dealer_cards, player_turn)

  player_choice = nil
  player_total = nil
  loop do
    player_choice = choose("(h)it or (s)tay?", ['h', 's'])
    if player_choice == 'h'
      deal(deck, player_cards)
      display_hands(player_cards, dealer_cards, player_turn)
    end
    player_total = total(player_cards)
    break if player_choice == 's' || busted?(player_total)
  end

  if busted?(player_total)
    display_result(:player_busted)
    play_again? ? next : break
  else
    prompt "You stayed at #{player_total}"
  end

  # dealer turn
  player_turn = false
  dealer_total = nil
  loop do
    dealer_total = total(dealer_cards)
    break if dealer_total >= DEALER_STAY
    prompt "Dealer hits"
    deal(deck, dealer_cards)
  end
  display_hands(player_cards, dealer_cards, player_turn)

  if busted?(dealer_total)
    display_result(:dealer_busted)
    play_again? ? next : break
  else
    prompt "Dealer stayed at #{dealer_total}"
  end

  result = detect_result(player_total, dealer_total)
  display_result(result)

  break unless play_again?
end
prompt "Thank you for playing Twenty-One! Good bye!"
