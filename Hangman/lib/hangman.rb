# frozen_string_literal: true

require 'colorize'

# The Hangman class will handle the word and guessing logic
class Hangman
  attr_reader :current, :word
  attr_accessor :lives

  def initialize(word)
    @word = word
    @lives = 12
    @guessed_letters = []
  end

  def valid_input?(input)
    !!(input =~ /\A[a-zA-Z]+\z/)
  end

  def check_letter(letter)
    puts "There is no #{letter.colorize(:red)} in the word" unless letter?(letter)
    puts "There are no more #{letter.colorize(:red)} in the word" unless same_letter?(letter)
    @guessed_letters.push(letter) if letter?(letter)
  end

  def check_word(word)
    if word == @word
      @current = word
      word.each_char do |letter|
        @guessed_letters << letter unless @guessed_letters.include?(letter)
      end

    else
      puts 'Wrong word!'
    end
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

  def loser?
    @lives.zero?
  end

  private

  def letter?(letter)
    @word.include?(letter)
  end

  def same_letter?(letter)
    !@guessed_letters.include?(letter)
  end
end
