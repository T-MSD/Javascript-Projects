# frozen_string_literal: true

require_relative 'hangman'
require_relative 'save'

# Class that handles high-level gameplay (rounds, player lives, winning/losing conditions)
class Game
  YES = 'yes'
  NO = 'no'
  LOAD = 'load'
  PLAY = 'play'
  SAVE_COMMAND = 'save!'

  def initialize
    @hangman = Hangman.new(load_dict)
    @save = Save.new
    trap_interrupt
    @saved = false
  end

  def start
    puts "Welcome to the #{'HANGMAN GAME!'.colorize(:magenta)}\n"
    choose_start_option
    play
  end

  private

  def trap_interrupt
    Signal.trap('INT') { handle_interrupt }
  end

  def handle_interrupt
    puts "\n#{'Game interrupted!'.colorize(:yellow)} Are you sure you want to quit? (yes/no)"
    input = prompt_until_valid(YES, NO, 'Invalid input. Please type "yes" or "no".')

    if input == YES
      puts 'Exiting the game. Goodbye!'
      exit
    else
      puts 'Resuming the game.'
    end
  end

  def choose_start_option
    puts "\nTo play a saved game type load.\nTo start a new game type play"
    input = prompt_until_valid(PLAY, LOAD, 'Invalid input. Please type "yes" or "no".')
    return unless input == 'load'

    loaded_hangman = @save.input_load_path
    @hangman = loaded_hangman unless loaded_hangman.nil?
  end

  def play
    loop do
      puts "\nYou have #{@hangman.lives.to_s.colorize(:yellow)} remaining lives. Type your next letter."
      player_input
      break if @saved

      @hangman.display_current
      break if game_over?
    end
  end

  def player_input
    input = prompt_user
    return if @saved

    loop do
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

  def prompt_user
    input = gets.chomp.downcase
    if input == SAVE_COMMAND
      @save.input_save_path(@hangman)
      @saved = true
      puts "\nSaving and exiting..."
    end
    input
  end

  def prompt_until_valid(*valid_inputs, error_message)
    loop do
      input = gets.chomp.downcase
      return input if valid_inputs.include?(input)

      puts error_message
    end
  end
end
