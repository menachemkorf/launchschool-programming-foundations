require 'pry'

SUITS = { "H" => "Hearts",
          "S" => "Spades",
          "D" => "Diamonds",
          "C" => "Clubs" }.freeze
VALUES = { "J" => "Jack",
           "Q" => "Queen",
           "K" => "King",
           "A" => "Ace" }.freeze

def prompt(msg)
  puts "=> #{msg}"
end

def format_value(card)
  if card.to_i == 0
    VALUES[card]
  else
    card
  end
end

def display_cards(cards)
  msg = []
  cards.each do |card|
    msg.push("'#{format_value(card[0])} of #{SUITS[card[1]]}'")
  end
  msg.join(', ')
end

def display_hands(player, dealer)
  system "clear"
  prompt "You have #{player.length} cards: #{display_cards(player)}"
  prompt "Dealer has #{dealer.length} cards: #{display_cards([dealer.first])}"
  puts ''
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
    sum -= 10 if sum > 21
  end

  sum
end

def initialize_deck
  deck = []
  suits = SUITS.keys
  values = []
  numbers = (2..10)

  numbers.each { |num| values.push(num.to_s) }
  values.push("J", "Q", "K", "A")

  values.each do |num|
    deck.push([num, suits[0]])
    deck.push([num, suits[1]])
    deck.push([num, suits[2]])
    deck.push([num, suits[3]])
  end
  deck
end

def initialize_hands(deck)
  player_cards = []
  dealer_cards = []

  2.times { deal(deck, player_cards) }
  2.times { deal(deck, dealer_cards) }

  [player_cards, dealer_cards]
end

def deal(deck, player)
  player.push(deck.delete(deck.sample))
end

def busted?(cards)
  total(cards) > 21
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
  display_hands(player_cards, dealer_cards)

  loop do
    player_choice = ''
    loop do
      prompt("hit or stay?")
      player_choice = gets.chomp.downcase
      break if %w(hit stay).include?(player_choice)
      prompt("Invalid option.")
    end

    break if player_choice == 'stay'
    deal(deck, player_cards)

    display_hands(player_cards, dealer_cards)
    break if busted?(player_cards)
  end

  break unless play_again?
end
