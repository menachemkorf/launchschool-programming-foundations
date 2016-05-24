INITIAL_MARKER = " ".freeze
PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
POINTS_TO_WIN = 5
VALID_ANSWERS = %w(y n).freeze

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_board(brd, pnts)
  system "clear"
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts "You won #{pnts['player']} rounds. "\
        "Computer won #{pnts['computer']} rounds."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = INITIAL_MARKER }
  board
end

def empty_squares(brd)
  brd.keys.select { |sqr| brd[sqr] == INITIAL_MARKER }
end

def winning_square(brd, player)
  square = nil
  WINNING_LINES.each do |line|
    next unless brd.values_at(*line).count(player) == 2

    square = brd.select do |sqr, marker|
      line.include?(sqr) && marker == INITIAL_MARKER
    end.keys.first
  end
  square
end

def computer_winning_square(brd)
  winning_square(brd, COMPUTER_MARKER)
end

def player_winning_square(brd)
  winning_square(brd, PLAYER_MARKER)
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Please choose a square (#{joinor(empty_squares(brd))})."
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt("Sorry, that's not a valid choice.")
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = if computer_winning_square(brd)
             computer_winning_square(brd)
           elsif player_winning_square(brd)
             player_winning_square(brd)
           elsif empty_squares(brd).include?(5)
             5
           else
             empty_squares(brd).sample
           end
  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, player)
  player_places_piece!(brd) if player == 'player'
  computer_places_piece!(brd) if player == 'computer'
end

def alternate_player(player)
  player == 'player' ? 'computer' : 'player'
end

def detect_round_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def someome_won_round?(brd)
  !!detect_round_winner(brd)
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def display_results(brd, pnts, result)
  display_board(brd, pnts)
  prompt("#{detect_round_winner(brd)} won!") if result == "won"
  prompt("It's a tie!") if result == "tie"
  prompt("Press enter to continue.")
  gets
end

def joinor(arr, delimiter=', ', word='or')
  if arr.length > 1
    arr[-1] = "#{word} #{arr.last}"
  end
  arr.length > 2 ? arr.join(delimiter) : arr.join(' ')
end

def play_again?
  answer = ''
  loop do
    prompt("Do you want to play again? (y/n)")
    answer = gets.chomp.downcase
    break if VALID_ANSWERS.include?(answer)
    prompt("Invalid option.")
  end
  true if answer == 'y'
end

loop do
  points = { "player" => 0, "computer" => 0 }
  loop do
    board = initialize_board
    current_player = 'player'

    loop do
      display_board(board, points)
      place_piece!(board, current_player)
      break if someome_won_round?(board) || board_full?(board)
      current_player = alternate_player(current_player)
    end

    if someome_won_round?(board)
      points[detect_round_winner(board).downcase] += 1
      display_results(board, points, "won")
    else
      display_results(board, points, "tie")
    end

    break if points.value?(POINTS_TO_WIN)
  end

  prompt("#{points.key(POINTS_TO_WIN).capitalize} won the game!")
  break unless play_again?
end

prompt("Thank you for playng Tic Tac Toe! Good bye!")
