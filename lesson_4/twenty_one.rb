require 'pry'

SUITS = { "H" => "Heart",
          "S" => "Spade",
          "D" => "Dimond",
          "C" => "Club" }

def prompt(msg)
  puts "=> #{msg}"
end

def display_hands(player, dealer)
  puts "You have #{player.length} cards:   #{player}"
  puts "Dealer has #{dealer.length} cards: #{dealer[0]}"
end

def total(cards)
  values = cards.map { |card| card[0] }
  sum = 0

  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == "A"}.count.times do
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

  return player_cards, dealer_cards
end

def deal(deck, player)
  player.push(deck.delete(deck.sample))
end

def busted?(cards)
  total(cards) > 21 ? true : false
end

def play_again?
  answer = ''
  loop do
    prompt("Do you want to play again? (y/n)")
    answer = gets.chomp.downcase
    break if %(y n).include?(answer)
    prompt("Invalid option.")
  end
  true if answer == 'y'
end

loop do
  deck = initialize_deck
  player_cards, dealer_cards = initialize_hands(deck)
  display_hands(player_cards, dealer_cards)

  loop do
    prompt("hit or stay?")
    answer = gets.chomp.downcase
    break if answer == 'stay' # || busted?(player_cards)
    deal(deck, player_cards)

    display_hands(player_cards, dealer_cards)
    break if busted?(player_cards)
  end


  break unless play_again?
end
