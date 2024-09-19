# frozen_string_literal: true

# class that handles player logic
class Player
  def initialize(game, mastermind)
    @game = game
    @mastermind = mastermind
  end

  def make_guess
    player_colors = []
    loop do
      4.times do |i|
        puts "Please enter color number #{i + 1}:"
        input = gets.chomp.downcase
        player_colors << input
      end
      symbols_array = player_colors.map(&:to_sym)
      if valid_guess?(symbols_array)
        display_guess(symbols_array)
        return symbols_array
      end
      puts 'Your colors must be one of the following: black, blue, purple, white, orange,
      red, yellow, green.'
    end
  end

  def display_guess(guess)
    puts "Round number #{@game.round}. Your attempt:"
    display = guess.map { |color| @mastermind.peg_symbols[color] }
    puts display.join(' ')
  end

  private

  def valid_guess?(guesses)
    guesses.all? { |guess| @mastermind.colors.include?(guess) }
  end
end
