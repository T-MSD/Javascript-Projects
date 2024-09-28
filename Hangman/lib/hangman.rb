# frozen_string_literal: true

require 'colorize'

# The Hangman class will handle the word and guessing logic
class Hangman
  attr_reader :current, :word

  def initialize(word)
    @word = word
    @guessed_letters = []
  end

  def check_letter(letter)
    puts "There is no #{letter.colorize(:red)} in the word" unless letter?(letter)
    puts "There are no more #{letter.colorize(:red)} in the word" unless same_letter?(letter)
    @guessed_letters.push(letter) if letter?(letter)
  end

  def display_current
    @current = @word.chars.map do |letter|
      if @guessed_letters.include?(letter)
        "#{letter.colorize(:green)} "
      else
        '_ '
      end
    end.join('')

    puts @current
  end

  def winner?
    !@current.include?('_')
  end

  private

  def letter?(letter)
    @word.include?(letter)
  end

  def same_letter?(letter)
    !@guessed_letters.include?(letter)
  end
end
