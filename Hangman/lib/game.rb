# frozen_string_literal: true

require_relative('hangman')

# Class that handles high-level gameplay (rounds, player lives, winning/losing conditions)
class Game
  def initialize
    word = load_dict
    @hangman = Hangman.new(word)
    @lives = 12
    trap_interrupt
  end

  def trap_interrupt
    Signal.trap('INT') do
      puts "\nGame interrupted! Are you sure you want to quit? (yes/no)"
      loop do
        input = gets.chomp.downcase
        case input
        when 'yes'
          puts 'Exiting the game. Goodbye!'
          exit
        when 'no'
          puts 'Resuming the game.'
          break
        else
          puts 'Invalid input. Please type "yes" or "no".'
        end
      end
    end
  end

  # TODO:
  # Serialization / save
  # Welcome / rules

  def start
    loop do
      puts "You have #{@lives.to_s.colorize(:yellow)} remaining lives. Type your next letter."
      @lives -= 1
      letter = gets.chomp.downcase
      @hangman.check_letter(letter)
      @hangman.display_current
      if @hangman.winner?
        puts 'Congatulations, you WIN!'
        break
      elsif loser?
        puts "You lost... The word was: #{@hangman.word.colorize(:cyan)}.\nBetter luck next time!"
        break
      end
    end
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
