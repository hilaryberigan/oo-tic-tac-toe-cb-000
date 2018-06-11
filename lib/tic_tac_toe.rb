class TicTacToe
  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def play(board)
    until over?(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)

    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def move(board, index, token)
    board[index] = token
    return board
  end

  def display_board(board)

    puts " #{board[0]} | #{board[1]} | #{board[2]}  "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]}  "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]}  "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def valid_move?(board, index)
    return true if index.between?(0,10) && valid_position?(board, index)
    return false
  end

  def valid_position?(board,index)
    return true if board[index].empty? || board[index].nil?
    return false
  end

  def current_player(board)
    turns = turn_count(board)
    if turns.even?
      return "X"
    else
      return "O"
    end
  end

  def turn_count(board)
    turns = 0
    board.each do |element|
      if element != "" && element != " " && element != nil
        turns += 1
      end
    end
    return turns
  end

  def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]

  def won?(board)
    row = Array.new
    return false if board.none?{|i| i == "X" || i == "O"}

    WIN_COMBINATIONS.each do |combo|
      return combo if combo.all?{|index| position_taken?(board, index) && board[index] == "X"}
      return combo if combo.all?{|index| position_taken?(board, index) && board[index] == "O"}
    end
    return false
  end

  def full?(board)
    board.none?{|i| i == "" || i == " " || i == nil}
  end

  def draw?(board)
    full?(board) && !won?(board)
  end

  def over?(board)
    full?(board) || won?(board) || draw?(board)
  end

  def winner(board)
    winning = won?(board)
    if winning.is_a?(Array)
      return board[winning[0]]
    else
      return nil
    end
  end
end
