# frozen_string_literal: true

require_relative('hangman')

# Class that handles high-level gameplay (rounds, player lives, winning/losing conditions)
class Game
  def initialize
    word = load_dict
    @hangman = Hangman.new(word)
    @lives = 12
  end

  def start
    puts @hangman.word
  end

  private

  def load_dict
    words = File.readlines('words.txt').map(&:chomp) # &:chomp removes \n
    valid_words = words.select { |word| word.length.between?(5, 12) }
    valid_words.sample # Select random word
  end

  def loser?
    @lives.zero?
  end
end
