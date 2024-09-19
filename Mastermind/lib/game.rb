# frozen_string_literal: true

require 'colorize'
require 'io/console'
require_relative 'player'
require_relative 'mastermind'

# class that handles game logic
class Game
  attr_reader :round

  def initialize
    trap_interrupt
    @round = 0
    initialize_mastermind_and_player
  end

  def trap_interrupt
    Signal.trap('INT') do
      puts "\nGame interrupted! Are you sure you want to quit? (yes/no)"
      loop do
        input = gets.chomp.downcase
        case input
        when 'yes'
          puts 'Exiting the game. Goodbye!'
          exit
        when 'no'
          puts 'Resuming the game.'
          break
        else
          puts 'Invalid input. Please type "yes" or "no".'
        end
      end
    end
  end

  def rules
    puts "\nWelcome to Mastermind!\n#{'Rules:'.colorize(:yellow)}
    There are 8 colors you can choose from:

    🟢 - Green
    🔴 - Red
    🟡 - Yellow
    🔵 - Blue
    🟣 - Purple
    ⚫ - Black
    ⚪ - White
    🟠 - Orange

    You have to select 4 random colors until guess the correct code.
    You will be prompted 4 times, one for each color and your guess will follow that order. Like this:

    Round number 1
    Please enter color number 1:
    Please enter color number 2:
    ...

    All you have to do is type the color like 'green' or 'white'.

    #{'You have 12 attempts to guess the code'.colorize(:cyan)}

    The game will give you feedback like this:

    ⚪ is in the right place!
    🟢 is in the wrong place...

    You can quit at any time by pressing ctrl+c, then type 'yes' to quit and 'no' to continue the game.

    #{'Good Luck!'.colorize(:green)}
    "
  end

  def start
    rules
    loop do
      key = $stdin.getch
      break if key == "\r"

      puts 'Please press Enter.'
    end
    loading_animation
    play
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
    print "Game starting\nRandomizing game code"
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
