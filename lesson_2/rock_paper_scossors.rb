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

  if  (player_choice == 'rock'      && computer_coice == 'scissors') ||
      (player_choice == 'scissors'  && computer_coice == 'paper') ||
      (player_choice == 'paper'     && computer_coice == 'rock')
    display_result "You won!"
  elsif (computer_coice == 'rock'      && player_choice == 'scissors') ||
        (computer_coice == 'scissors'  && player_choice == 'paper') ||
        (computer_coice == 'paper'     && player_choice == 'rock')
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
