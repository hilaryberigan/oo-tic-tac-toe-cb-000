class TicTacToe
  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)

    if valid_move?(index)
      move(index)
      display_board
    else
      turn
    end
  end

  def move(index, player = current_player)
    @board[index] = player
  end

  def display_board
    board = @board
    puts " #{board[0]} | #{board[1]} | #{board[2]}  "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]}  "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]}  "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def valid_move?(index)
    return true if index.between?(0,10) && valid_position?(index)
    return false
  end

  def valid_position?(index)
    return true if @board[index].empty? || @board[index].nil? || @board[index] == ' '
    return false
  end

  def current_player
    turns = turn_count
    if turns.even?
      return "X"
    else
      return "O"
    end
  end

  def turn_count
    turns = 0
    @board.each do |element|
      if element != "" && element != " " && element != nil
        turns += 1
      end
    end
    return turns
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
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

  def won?
    row = Array.new
    return false if @board.none?{|i| i == "X" || i == "O"}

    WIN_COMBINATIONS.each do |combo|
      return combo if combo.all?{|index| position_taken?(index) && @board[index] == "X"}
      return combo if combo.all?{|index| position_taken?(index) && @board[index] == "O"}
    end
    return false
  end

  def full?
    @board.none?{|i| i == "" || i == " " || i == nil}
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won?|| draw?
  end

  def winner
    winning = won?
    if winning.is_a?(Array)
      return @board[winning[0]]
    else
      return nil
    end
  end
end
