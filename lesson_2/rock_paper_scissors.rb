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
VALID_ANSWEWRS = %w(y n)

def display_msg(msg, format = '')
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

def options_msg
  display_msg "Choose one:"
  VALID_CHOICES.each do |k, v|
    display_msg "#{k}. #{v}"
  end
  display_msg("", :prompt)
end

def validate_choice(player_choice)
  if VALID_CHOICES.flatten.include?(player_choice)
    VALID_CHOICES.each do |k, v|
      player_choice = v if player_choice == k
    end
    player_choice
  else
    display_msg("Invalid choice", :error)
  end
end

def eval_player_choice
  player_choice = ''
  loop do
    options_msg
    player_choice = gets.chomp.downcase
    player_choice = validate_choice(player_choice)
    break if player_choice
  end
  player_choice
end

def won_round?(player1, player2)
  WINNING_COMBOS[player1].include?(player2)
end

def calculate(player_choice, computer_choice, points)
  if won_round?(player_choice, computer_choice)
    points[:player] += 1
    display_msg("You win!", :result)
  elsif won_round?(computer_choice, player_choice)
    points[:computer] += 1
    display_msg("Computer wins!", :result)
  else
    display_msg("It's a tie!", :result)
  end
  display_msg("You have #{points[:player]} points, computer has #{points[:computer]} points.", :result)
end

def play_again?
  display_msg("Do you want to play again? (y/n)", :prompt)
  answer = ''
  loop do
    answer = gets.chomp.downcase
    break if VALID_ANSWEWRS.include(amswer)
    display_msg("Invalid option.", :error)
    display_msg("Please enter a valid option (y/n)", :prompt)
  end
  true if answer == 'y'
end

loop do
  points = { player: 0, computer: 0 }
  loop do
    player_choice = eval_player_choice
    computer_choice = VALID_CHOICES.values.sample
    display_msg("You chose '#{player_choice}', computer chose '#{computer_choice}'.", :result)

    calculate(player_choice, computer_choice, points)

    if points[:player] == POINTS_TO_WIN
      display_msg "You won the game!"
      break
    elsif points[:computer] == POINTS_TO_WIN
      display_msg "Game over!"
      break
    end
  end
  break unless play_again?
end

display_msg("Thank you for playing. Good bye!")
