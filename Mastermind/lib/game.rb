# frozen_string_literal: true

require_relative 'player'
require_relative 'mastermind'

# class that handles game logic
class Game
  attr_reader :round, :colors, :peg_symbols

  def initialize
    setup_colors
    setup_peg_symbols
    @round = 0
    random_code
    loading_animation
    initialize_mastermind_and_player
  end

  private

  def setup_colors
    @colors = %i[black blue magenta white cyan light_black]
  end

  def setup_peg_symbols
    @peg_symbols = {
      black: '●'.colorize(:black),
      blue: '●'.colorize(:blue),
      magenta: '●'.colorize(:magenta),
      white: '●'.colorize(:white),
      cyan: '●'.colorize(:cyan),
      light_black: '●'.colorize(:light_black),
      red: '●'.colorize(:red),
      yellow: '●'.colorize(:yellow),
      green: '●'.colorize(:green)
    }
  end

  def loading_animation
    puts 'Welcome to the Mastermind Game!'
    print 'Randomizing game code'
    5.times do
      print '.'
      sleep(1) # Delay of 1 second
    end
    puts "\nGame code generated!"
  end

  def random_code
    @code = Array.new(4) { @colors.sample }
  end
end
