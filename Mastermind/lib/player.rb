# frozen_string_literal: true

# class that handles player logic
class Player
  def initialize(game)
    @game = game
  end

  def make_choice
    player_colors = []
    loop do
      4.times do |i|
        puts "Please enter color number #{i + 1}:"
        input = gets.chomp
        player_colors << input
      end
      symbols_array = player_colors.map(&:to_sym)
      if valid_choice?(symbols_array)
        display_choice(symbols_array)
        break
      end
      puts 'Your colors must be one of the following: black, blue, magenta, white, cyan,
      light_black, red, yellow, green.'
    end
  end

  def display_choice(choice)
    puts "Round number #{@game.round + 1}. Your attempt:"
    display = choice.map { |color| @game.peg_symbols[color] }
    puts display.join(' ')
  end

  private

  def valid_choice?(choices)
    choices.all? { |choice| @game.colors.include?(choice) }
  end
end
