# frozen_string_literal: true

# The save class handles game state serialization
class Save
  def input_load_path
    puts "\nPath to the file:"
    path = gets.chomp
    unless File.exist?(path)
      puts "\nThe file does not exist. \nStarting game..."
      return nil
    end
    load_game(path) if File.exist?(path)
  end

  # missing method call in game
  def input_save_path(game)
    puts 'Path to the file:'
    path = gets.chomp
    # Get the directory part of the path
    dir = File.dirname(path)
    # Create the directory if it doesn't exist
    unless Dir.exist?(dir)
      FileUtils.mkdir_p(dir) # This creates nested directories if needed
      puts "Directory #{dir} was created."
    end
    save_game(game, path)
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
