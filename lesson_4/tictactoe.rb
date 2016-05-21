require 'pry'

INITIAL_MARKER = " "
PLAYER_MARKER = "X"
COMPUTER_MARKER = "O"
WINNING_LINES =  [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system "clear"
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

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = INITIAL_MARKER }
  board
end

def empty_squares(brd)
  brd.keys.select { |sqr| brd[sqr] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt("Please choose a square #{empty_squares(brd).join(', ')}.")
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt("Sorry, that's not a valid choice.")
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if  brd[line[0]] == PLAYER_MARKER &&
        brd[line[1]] == PLAYER_MARKER &&
        brd[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif brd[line[0]] == COMPUTER_MARKER &&
          brd[line[1]] == COMPUTER_MARKER &&
          brd[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil
end

def someome_won?(brd)
  !!detect_winner(brd)
end

def board_full?(brd)
  empty_squares(brd).empty?
end

board = initialize_board
#display_board(board)

loop do
  display_board(board)
  player_places_piece!(board)
  break if someome_won?(board) || board_full?(board)
  computer_places_piece!(board)
  break if someome_won?(board) || board_full?(board)
end

display_board(board)
if someome_won?(board)
  prompt("#{detect_winner(board)} won!")
else
  prompt("It's a tie!")
end
