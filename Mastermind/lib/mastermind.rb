# frozen_string_literal: true

# class that handles the "mastermind" logic
class Mastermind
  def initialize(code, game)
    @code = code
    @game = game
  end

  def winner?(choice)
    choice == @code
  end

  def display_feedback(player_guess)
    exact_matches, color_matches = player_guess
    if !exact_matches.empty?
      exact_matches.each do |match|
        puts "#{@game.peg_symbols[match]} is in the right place!"
      end
    else
      puts 'No exact macthes :('
    end
    if !color_matches.empty?
      color_matches.each do |color|
        puts "#{@game.peg_symbols[color]} is in the wrong position..."
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
