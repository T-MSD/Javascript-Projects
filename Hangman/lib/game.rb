# frozen_string_literal: true

require_relative('hangman')
require_relative('save')

# Class that handles high-level gameplay (rounds, player lives, winning/losing conditions)
class Game
  def initialize
    @save = Save.new
    trap_interrupt
  end

  # TODO:
  # Serialization / save

  def start
    puts 'Welcome to the Hangman game!'
    choose_start_option
    play
  end

  private

  def trap_interrupt
    Signal.trap('INT') do
      puts "\nGame interrupted! Are you sure you want to quit? (yes/no)"
      loop do
        input = gets.chomp.downcase
        case input
        when 'yes'
          puts 'Saving and exiting the game. Goodbye!'
          # add save method
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

  def choose_start_option
    loop do
      puts "If you want to load a saved game type load.\nIf you want to start playing type play"
      input = gets.chomp.downcase
      if input == 'load'
        @hangman = @save.load_game
        if @hangman.nil?
          word = load_dict
          @hangman = Hangman.new(word)
        end
        break
      end
      break if input == 'play'

      puts 'Invalid input. Please type "load" or "play"'
    end
  end

  def play
    loop do
      puts "You have #{@hangman.lives.to_s.colorize(:yellow)} remaining lives. Type your next letter."
      letter_input
      @hangman.display_current
      break if game_over?
    end
  end

  def letter_input
    letter = gets.chomp.downcase
    @hangman.lives -= 1
    @hangman.check_letter(letter)
  end

  def game_over?
    if @hangman.winner?
      puts 'Congratulations, you WIN!'
      true
    elsif @hangman.loser?
      puts "You lost... The word was: #{@hangman.word.colorize(:cyan)}.\nBetter luck next time!"
      true
    else
      false
    end
  end

  def load_dict
    words = File.readlines('words.txt').map(&:chomp) # &:chomp removes \n
    valid_words = words.select { |word| word.length.between?(5, 12) }
    valid_words.sample # Select random word
  end
end
