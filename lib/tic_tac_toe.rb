require 'pry'
class TicTacToe

  WIN_COMBINATIONS = [
      [0,1,2], # top_row
      [3,4,5], # middle_row
      [6,7,8], # bottom_row
      [0,3,6], # left_column
      [1,4,7], # center_column
      [2,5,8], # right_column
      [0,4,8], # left_diagonal
      [6,4,2] # right_diagonal
      ]

  def initialize
    @board = Array.new(9, " ")  #creates a new, empty array with 9 spacea
  end

  def display_board       #this creates the board that users will play in.
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(str_input) #this takes in the users number
    str_input.to_i - 1      #this convers the users number from an integer into a string
  end

  def move(idx, char)   #this takes in the users move, the index of the array and the character that the user adds
    @board[idx] = char    #this takes the index of the @board (array) and adds the coresponding number
  end

  def position_taken?(idx)    #this checks to see if a position is taken on the board
    #if @board[idx] == " "
    #  return false
    #else
    #  return true
    (@board[idx] == " ") ? false : true   #this takes the @board's index and if it is == to an empty spot, returns false (as the position is open)
  end

  def valid_move?(idx)
    idx.between?(0, 8) && !(self.position_taken?(idx))
    #(0..8).to_a.include?(idx)
  end

  def turn_count
    @board.count('X') + @board.count('O')
  end

  def current_player
    (self.turn_count.even?) ? 'X' : 'O'
  end

  def turn
    input = gets.chomp #ask user to input (where they want to move on the baord 1 - 9
    puts input

    index  = self.input_to_index(input)
    token = self.current_player
    if self.valid_move?(index) #validate user index
      self.move(index, token)
      self.display_board
    else
      self.turn
    end
  end

  def won?
    win_combo = nil
    WIN_COMBINATIONS.each do |arr|
      if @board[arr[0]] == @board[arr[1]] &&
        @board[arr[1]] == @board[arr[2]] &&
        position_taken?(arr[0])
        win_combo = arr
      end
    end
    win_combo
  end


  def full?
    !@board.include?(" ")
    #!@board.any?{|n| n == " "} checks to see if any of the elements include a blank space.
  end

  def draw? #if no winning combination found and @board is full == draw
    !(self.won?) && self.full?
  end

  def over?
    self.draw? || self.won?
  end

  def winner
    #need a character of winner of return nil
    if won?
          @board[won?[0]] == "X" ? "X" : "O"
        else
          nil
        end
  end


  def play
    # until over? == true
    turn until over?
    if winner
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end


end
