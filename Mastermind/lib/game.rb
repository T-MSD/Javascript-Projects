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
    win = false
    quit = false
    loop do
      choice = @player.make_choice
      matches = @mastermind.matches(choice)
      @mastermind.display_feedback(matches)

      if @mastermind.winner?(choice)
        win = true
        break
      end

      unless next_round?
        quit = true
        break
      end
    end
    puts 'You Win! You guessed the right Code!' if win
    puts 'Good luck next time!' if quit
  end

  private

  def setup_colors
    @colors = %i[black blue magenta white cyan light_black red yellow green]
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

  def initialize_mastermind_and_player
    @player = Player.new(self)
    @mastermind = Mastermind.new(@code)
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
    puts "code: #{@code}"
  end

  def next_round?
    loop do
      puts 'Ready for another round?'
      input = gets.chomp.downcase
      return true if input == 'yes'
      return false if input == 'no'

      puts 'Invalid input. Please type "yes" or "no".'
    end
  end
end
