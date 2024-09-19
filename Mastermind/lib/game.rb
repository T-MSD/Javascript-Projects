# frozen_string_literal: true

require 'colorize'
require_relative 'player'
require_relative 'mastermind'

# class that handles game logic
class Game
  attr_reader :round, :colors, :peg_symbols

  def initialize
    @round = 0
    loading_animation
    initialize_mastermind_and_player
  end

  def play
    loop do
      @round += 1
      puts "\nRound number #{@round}".colorize(:cyan)
      guess = @player.make_guess
      matches = @mastermind.matches(guess)
      @mastermind.display_feedback(matches)

      if @mastermind.winner?(guess)
        puts 'YOU WIN!'.colorize(:green)
        puts "Congratulations! You've cracked the code in #{@round} rounds!"
        break
      end

      next if next_round?

      puts 'GAME OVER!'.colorize(:red)
      puts "You ran out of guesses! The code was #{format_code(@mastermind.code)}"
      break
    end
  end

  private

  def initialize_mastermind_and_player
    @mastermind = Mastermind.new
    @player = Player.new(self, @mastermind)
  end

  def loading_animation
    puts 'Welcome to the Mastermind Game!'
    print 'Randomizing game code'
    5.times do
      print '.'
      sleep(0.6) # Delay of 0.6 second, 3 total
    end
    puts "\nGame code generated!"
  end

  def next_round?
    @round < 12
  end

  def format_code(code)
    code.map { |color| @mastermind.peg_symbols[color] }.join(' ')
  end
end
