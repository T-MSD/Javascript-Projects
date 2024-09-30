# frozen_string_literal: true

require_relative 'hangman'
require_relative 'save'

# Class that handles high-level gameplay (rounds, player lives, winning/losing conditions)
class Game
  def initialize
    word = load_dict
    @hangman = Hangman.new(word)
    @save = Save.new
    trap_interrupt
  end

  def start
    puts "Welcome to the HANGMAN GAME!\n"
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

  def choose_start_option
    loop do
      puts "\nTo play a saved game type load.\nTo start a new game type play"
      input = gets.chomp.downcase
      if input == 'load'
        loaded_hangman = @save.input_load_path
        @hangman = loaded_hangman unless loaded_hangman.nil?
        break
      end
      break if input == 'play'

      puts 'Invalid input. Please type "load" or "play"'
    end
  end

  def save?
    loop do
      puts "\nDo you want to save the game and exit? (yes/no)"
      input = gets.chomp.downcase
      if input == 'yes'
        @save.input_save_path(@hangman)
        puts 'Saving and exiting...'
        return true
      elsif input == 'no'
        return false
      else
        puts 'Type either yes or no.'
      end
    end
  end

  def play
    loop do
      break if save?

      puts "\nYou have #{@hangman.lives.to_s.colorize(:yellow)} remaining lives. Type your next letter."
      player_input
      @hangman.display_current
      break if game_over?
    end
  end

  def player_input
    loop do
      input = gets.chomp.downcase
      unless @hangman.valid_input?(input)
        puts "Invalid input, only alphabetic characters!\n"
        next
      end

      @hangman.lives -= 1
      @hangman.check_letter(input) if input.length == 1
      @hangman.check_word(input) if input.length > 1
      break
    end
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
