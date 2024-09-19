# frozen_string_literal: true

require 'colorize'
require_relative 'player'
require_relative 'mastermind'

# class that handles game logic
class Game
  attr_reader :round, :colors, :peg_symbols

  def initialize
    setup_colors
    setup_peg_symbols
    @round = 0
    loading_animation
    random_code
    initialize_mastermind_and_player
  end

  def play
    loop do
      @round += 1
      choice = @player.make_choice
      matches = @mastermind.matches(choice)
      @mastermind.display_feedback(matches)

      if @mastermind.winner?(choice)
        puts 'YOU WIN!'.colorize(:green)
        puts "Congratulations! You've cracked the code in #{@round} rounds!"
        break
      end

      next if next_round?

      puts 'GAME OVER!'.colorize(:red)
      puts "You ran out of guesses! The code was #{format_code(@code)}"
      break
    end
  end

  private

  def setup_colors
    @colors = %i[black blue purple white orange red yellow green]
  end

  def setup_peg_symbols
    @peg_symbols = {
      black: '⚫',
      blue: '🔵',
      purple: '🟣',
      white: '⚪',
      orange: '🟠',
      red: '🔴',
      yellow: '🟡',
      green: '🟢'
    }
  end

  def initialize_mastermind_and_player
    @player = Player.new(self)
    @mastermind = Mastermind.new(@code, self)
  end

  def loading_animation
    puts 'Welcome to the Mastermind Game!'
    print 'Randomizing game code'
    5.times do
      print '.'
      sleep(0.6) # Delay of 1 second
    end
    puts "\nGame code generated!"
  end

  def random_code
    @code = Array.new(4) { @colors.sample }
  end

  def next_round?
    @round < 12
  end

  def format_code(code)
    code.map { |color| @peg_symbols[color] }.join(' ')
  end
end
