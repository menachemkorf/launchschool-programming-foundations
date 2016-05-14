VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  's' => 'scissors' }
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

choose_prompt = <<-MSG
Choose one:
  r. rock
  p. paper
  s. scissors
MSG

loop do
  points = { player: 0, computer: 0 }

  loop do
    player_choice = ''
    loop do
      prompt choose_prompt
      player_choice = gets.chomp.downcase
      if VALID_CHOICES.flatten.include?(player_choice)
        VALID_CHOICES.each do |k, v|
          player_choice = v if player_choice == k
        end
        break
      else
        display_error "Invalid choice"
      end
    end

    computer_coice = VALID_CHOICES.values.sample

    display_result("You chose #{player_choice}")
    display_result("Computer chose #{computer_coice}")

    if won?(player_choice, computer_coice)
      points[:player] += 1
      display_result "You win"
    elsif won?(computer_coice, player_choice)
      points[:computer] += 1
      display_result "Computer wins"
    else
      display_result "It's a tie!"
    end
    display_result("You have #{points[:player]} points")
    display_result("Computer has #{points[:computer]} points")

    if points[:player] == 5
      puts "You won the game!"
      break
    elsif points[:computer] == 5
      puts "Game over!"
      break
    end
  end

  prompt "Do you want to play again? (y/n)"
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
