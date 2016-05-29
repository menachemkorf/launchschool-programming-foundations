require 'pry'

SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
          'J', 'Q', 'K', 'A'].freeze
FULL_VALUES = { 'J' => 'Jack',
                'Q' => 'Queen',
                'K' => 'King',
                'A' => 'Ace' }.freeze
FULL_SUITS = { 'H' => 'Hearts',
               'D' => 'Diamonds',
               'S' => 'Spades',
               'C' => 'Clubs' }.freeze
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

def format_cards(cards)
  formatted_cards = []

  cards.each do |card|
    value = card[0]
    suit = card[1]

    full_value = if value.to_i == 0
                   FULL_VALUES[value]
                 else
                   value
                 end
    full_suit = FULL_SUITS[suit]
    formatted_cards.push("'#{full_value} of #{full_suit}'")
  end
  formatted_cards.join(', ')
end

def display_partial_hands(player_cards, dealer_cards)
  system 'clear'
  prompt "Welcome to Twenty-One!"
  prompt "Player has #{player_cards.length} "\
        "cards: #{format_cards(player_cards)}, "\
        "for a total of #{total(player_cards)}"
  prompt "Dealer has #{dealer_cards.length} "\
        "cards: #{format_cards([dealer_cards[0]])} and ?"
end

def display_full_hands(player_cards, dealer_cards)
  prompt "Player has #{player_cards.length} "\
        "cards: #{format_cards(player_cards)}, "\
        "for a total of #{total(player_cards)}"
  prompt "Dealer has #{dealer_cards.length} "\
        "cards: #{format_cards(dealer_cards)}, "\
        "for a total of #{total(dealer_cards)}"
end

def total(cards)
  values = cards.map { |card| card[0] }
  sum = 0

  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
  end

  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > BUST
  end

  sum
end

def deal(deck, player)
  player.push(deck.pop)
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

def busted?(ttl)
  ttl > BUST
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
  answer = ''
  loop do
    prompt("Do you want to play again? (y/n)")
    answer = gets.chomp.downcase
    break if %w(y n).include?(answer)
    prompt("Invalid option.")
  end
  answer == 'y'
end

loop do
  deck = initialize_deck
  player_cards, dealer_cards = initialize_hands(deck)
  display_partial_hands(player_cards, dealer_cards)

  # player turn
  player_choice = nil
  player_total = nil
  loop do
    player_choice = hit_or_stay
    if player_choice == 'h'
      deal(deck, player_cards)
      display_partial_hands(player_cards, dealer_cards)
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
  dealer_total = nil
  loop do
    dealer_total = total(dealer_cards)
    break if dealer_total >= DEALER_STAY
    prompt "Dealer hits"
    deal(deck, dealer_cards)
  end
  display_full_hands(player_cards, dealer_cards)

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
