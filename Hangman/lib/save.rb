# frozen_string_literal: true

require 'yaml'
require 'fileutils'
require_relative 'hangman'

# The save class handles game state serialization
class Save
  def input_load_path
    puts "\nPath to the file:"
    path = gets.chomp
    unless File.exist?(path)
      puts "\nThe file does not exist. \nStarting game..."
      return nil
    end
    load_game(path)
  end

  def input_save_path(hangman)
    puts "\nPath to the file:"
    path = gets.chomp
    # Get the directory part of the path
    dir = File.dirname(path)
    # Create the directory if it doesn't exist
    unless Dir.exist?(dir)
      FileUtils.mkdir_p(dir) # This creates nested directories if needed
      puts "Directory #{dir} was created."
    end
    save_game(hangman, path)
  end

  def load_game(path)
    # return hangman instance
    puts "path: #{path}"
    object = File.read(path)
    YAML.safe_load(object, permitted_classes: [Hangman])
  rescue Psych::SyntaxError => e
    puts "Failed to load the game: Invalid file format.\nError: #{e.message}"
    nil
  end

  def save_game(hangman, path)
    # save game to file
    File.write(path, hangman.to_yaml)
    puts "Game saved successfully at #{path.colorize(:cyan)}"
  end
end
