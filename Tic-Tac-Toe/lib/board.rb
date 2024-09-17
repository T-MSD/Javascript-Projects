# frozen_string_literal: true

# class that handles board logic
class Board
  def initialize
    @board = Array.new(9, ' ')
    @winning_combinations = [
      [0, 1, 2], # Top row
      [3, 4, 5],  # Middle row
      [6, 7, 8],  # Bottom row
      [0, 3, 6],  # Left column
      [1, 4, 7],  # Middle column
      [2, 5, 8],  # Right column
      [0, 4, 8],  # Left diagonal
      [2, 4, 6]   # Right diagonal
    ]
  end

  def draw
    @board.each_slice(3).with_index do |row, index|
      puts row.join(' | ')
      puts '--+---+--' unless index == @board.size / 3 - 1
    end
  end

  def update(pos, symbol)
    @board[pos] = symbol
  end

  def cell_occupied?(pos)
    @board[pos] != ' '
  end

  def tie?
    !@board.include?(' ')
  end

  # Method to check for a winner
  def check_winner
    @winning_combinations.each do |combo|
      # Check if all three positions in a winning combination have the same mark (and not empty)
      if @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && @board[combo[0]] != ' '
        return @board[combo[0]] # Return 'X' or 'O' as the winner
      end
    end
    nil # Return nil if there is no winner
  end
end
