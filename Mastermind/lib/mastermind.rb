# frozen_string_literal: true

# class that handles the "mastermind" logic
class Mastermind
  attr_reader :code, :colors, :peg_symbols

  def initialize
    setup_colors
    setup_peg_symbols
    @code = random_code
  end

  def winner?(guess)
    guess == @code
  end

  def display_feedback(player_guess)
    exact_matches, color_matches = player_guess
    if !exact_matches.empty?
      exact_matches.each do |match|
        puts "#{@peg_symbols[match]} is in the right place!"
      end
    else
      puts 'No exact macthes :('
    end
    if !color_matches.empty?
      color_matches.each do |color|
        puts "#{@peg_symbols[color]} is in the wrong place..."
      end
    else
      puts 'No color matches :('
    end
  end

  def matches(player_guess)
    exact_matches, remaining = find_exact_matches(player_guess)
    color_matches = find_color_matches(remaining)
    [exact_matches, color_matches]
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

  def random_code
    Array.new(4) { @colors.sample }
  end

  def find_exact_matches(player_guess)
    exact_matches = []
    remaining_code = @code.dup
    remaining_guess = player_guess.dup

    remaining_guess.each_with_index do |color, index|
      next unless remaining_code[index] == color

      exact_matches << color
      remaining_code[index] = nil  # Mark the exact match in the code
      remaining_guess[index] = nil # Mark the exact match in the guess
    end

    [exact_matches, remaining_guess]
  end

  def find_color_matches(player_guess)
    color_matches = []
    remaining_code = @code.dup
    remaining_guess = player_guess.dup

    remaining_guess.compact.each do |color|
      if remaining_code.include?(color)
        color_matches << color
        remaining_code[remaining_code.index(color)] = nil # Remove first occurrence
      end
    end

    color_matches
  end
end
