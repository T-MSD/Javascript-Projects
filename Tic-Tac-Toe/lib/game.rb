# frozen_string_literal: true

require 'colorize'
require_relative 'board'
require_relative 'player'

# class that handles game logic
class Game
  def initialize
    @board = Board.new
    register_players
  end

  def play
    loop do
      player_turn(@p1)
      break if game_over?

      player_turn(@p2)
      break if game_over?
    end
    display_result
  end

  def player_turn(player)
    pos = player.make_move
    @board.update(pos, player.marker)
    @board.draw
  end

  def move(player)
    loop do
      pos = player.make_move
      if valid_move?(pos)
        board.update(pos, player.marker)
        break
      end
      puts 'Invalid move. Either the input is not a number between 1-9 or the cell is already occupied.'
    end
  end

  def valid_move?(pos)
    input.match?(/^[1-9]$/) && !board.cell_occupied?(pos)
  end

  def register_players
    puts 'Player 1, please enter your name:'
    p1_name = gets.chomp
    color = 'green'.colorize(:green)
    puts "Hi #{p1_name}, your marker will be X, and your color is #{color}"

    puts 'Player 2, please enter your name:'
    p2_name = gets.chomp
    color = 'blue'.colorize(:blue)
    puts "Hi #{p2_name}, your marker will be O, and your color is #{color}"

    @p1 = Player.new(p1_name, 'X', :green)
    @p2 = Player.new(p2_name, 'O', :blue)

    @board.draw
  end

  def game_over?
    @board.tie? || @board.check_winner
  end

  def display_result
    marker = @board.check_winner
    if marker
      player = marker == @p1.marker ? @p1 : @p2
      name = player.name.colorize(player.color)
      puts "#{name} wins! Congratulations!"
    else
      puts "It's a tie!"
    end
  end
end
