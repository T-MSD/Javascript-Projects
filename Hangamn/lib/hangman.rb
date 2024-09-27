# frozen_string_literal: true

# Class that handles hangman logic
class Hangman
  attr_reader :current

  def initialize(word)
    @word = word
    @guessed_letters = []
  end

  def add_letter(letter)
    @guessed_letters.push(letter) if letter?(letter)
  end

  def display_current(guessed_letters)
    @current = @word.chars.map { |letter| guessed_letters.include?(letter) ? letter : '_' }.join(' ')
  end

  def winner?
    !@current.include?('_')
  end

  private

  def letter?(letter)
    @word.include?(letter)
  end
end
