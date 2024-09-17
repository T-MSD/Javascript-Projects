# frozen_string_literal: true

# class that handles player logic
class Player
  def initialize(game)
    @game = game
  end

  def make_choice
    loop do
      4.times do |i|
        puts "Please enter color number #{i + 1}:"
        input = gets.chomp
        player_colors << input
      end
      if valid_choice?(player_colors)
        display_choice(player_colors)
        break
      end
      puts 'Your colors must be one of the following: black, blue, magenta, white, cyan, light_black.'
    end
  end

  def valid_choice?(choices)
    choices.all? { |choice| @game.colors.include?(choice) }
  end

  def display_choice(choice)
    puts "Round number #{game.round}. This is the code you chose!"
    print choice
  end
end
