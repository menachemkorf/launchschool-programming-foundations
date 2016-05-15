VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  's' => 'scissors',
                  'l' => 'lizard',
                  'sp' => 'spock' }

WINNING_COMBOS = {  'rock'      => %w(scissors lizard),
                    'paper'     => %w(rock spock),
                    'scissors'  => %w(paper lizard),
                    'lizard'    => %w(paper spock),
                    'spock'     => %w(rock scissors) }
POINTS_TO_WIN = 5

def prompt(msg, format = '')
  if format == :prompt
    puts "#{msg} >>"
  elsif format == :result
    puts "=> #{msg}"
  elsif format == :error
    puts "! #{msg}"
  else
    puts msg
  end
end

def won?(player1, player2)
  WINNING_COMBOS[player1].include?(player2)
end

loop do
  points = { player: 0, computer: 0 }

  loop do
    player_choice = ''
    loop do
      prompt "Choose one:"
      VALID_CHOICES.each do |k, v|
        prompt "#{k}. #{v}"
      end
      prompt("", :prompt)
      player_choice = gets.chomp.downcase
      if VALID_CHOICES.flatten.include?(player_choice)
        VALID_CHOICES.each do |k, v|
          player_choice = v if player_choice == k
        end
        break
      else
        prompt("Invalid choice", :error)
      end
    end

    computer_choice = VALID_CHOICES.values.sample

    prompt("You chose '#{player_choice}', computer chose '#{computer_choice}'.", :result)

    if won?(player_choice, computer_choice)
      points[:player] += 1
      prompt("You win!", :result)
    elsif won?(computer_choice, player_choice)
      points[:computer] += 1
      prompt("Computer wins!", :result)
    else
      prompt("It's a tie!", :result)
    end
    prompt("You have #{points[:player]} points, computer has #{points[:computer]} points.", :result)

    if points[:player] == POINTS_TO_WIN
      prompt "You won the game!"
      break
    elsif points[:computer] == POINTS_TO_WIN
      prompt "Game over!"
      break
    end
  end

  prompt("Do you want to play again? (y/n)", :prompt)
  answer = ''
  loop do
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'n'
      break
    else
      prompt("Invalid option.", :error)
      prompt("Please enter a valid option (y/n)", :prompt)
    end
  end
  break if answer == 'n'
end
prompt("Thank you for playing. Good bye!")
