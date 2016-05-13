VALID_CHICES = %w(rock paper scissors)

def prompt(msg)
  puts "#{msg} >>"
end

def display_result(msg)
  puts "=> #{msg}"
end

def display_error(msg)
  puts "! #{msg}"
end

def won?(player1, player2)
  (player1 == 'rock' && player2 == 'scissors') ||
    (player1 == 'paper' && player2 == 'rock') ||
    (player1 == 'scissors' && player2 == 'paper')
end

loop do
  player_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHICES.join(', ')}")
    player_choice = gets.chomp
    break if VALID_CHICES.include?(player_choice)
    display_error "Invalid choice"
  end

  computer_coice = VALID_CHICES.sample

  display_result("You chose #{player_choice}")
  display_result("Computer chose #{computer_coice}")

  if won?(player_choice, computer_coice)
    display_result "You won!"
  elsif won?(computer_coice, player_choice)
    display_result "Computer won!"
  else
    display_result "It's a tie!"
  end

  prompt "Do you want to plat again? (y/n)"
  answer = ''
  loop do
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'n'
      break
    else
      display_error "Invalid option."
      prompt "Please enter a valid option (y/n)"
    end
  end
  break if answer == 'n'
end
