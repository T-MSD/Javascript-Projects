# frozen_string_literal: true

# The save class handles game state serialization
class Save
  def input_load_path
    puts 'Path to the file:'
    path = gets.chomp
    puts 'The file does not exist. Starting game...' unless File.exist?(path)
    load_game(path) if File.exist?(path)
  end

  def input_save_path
    # get the path to save
  end

  def load_game(path)
    # return hangman instance
  end

  def save_game(game, path)
    # save game to file
  end

  def serialize(object)
    # serialize hangman instance
  end

  def deserialize(object)
    # deserialize hangman instance
  end
end
