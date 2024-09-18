# frozen_string_literal: true

# class that handles the "mastermind" logic
class Mastermind
  def initialize(code)
    @code = code
  end

  def winner?(choice)
    choice == code
  end

  def display_feedback(player_guess)
    exact_matches, color_matches = matches(player_guess)
    exact_matches.each do |match|
      puts "#{@peg_symbols[match]} is in the right place!"
    end
    color_matches.each do |color|
      puts "#{@peg_symbols[color]} is in the wrong position..."
    end
  end

  def matches(player_guess)
    exact_matches = find_exact_matches(player_guess)
    color_matches = find_color_matches(player_guess)
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

    exact_matches
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
