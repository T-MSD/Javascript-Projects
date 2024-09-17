# frozen_string_literal: true

require 'colorize'

# class that handles player logic
class Player
  attr_reader :name, :marker, :color

  def initialize(name, marker, color)
    @board = Board.new
    @name = name
    @marker = marker
    @color = color
  end

  def make_move
    puts "#{@name}'s turn, please choose where you want to place your marker".colorize(@color)
    puts 'Please enter a number from 1 to 9 to identify your option:'
    gets.chomp.to_i
  end
end
