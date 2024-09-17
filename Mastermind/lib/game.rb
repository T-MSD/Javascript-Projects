# frozen_string_literal: true

# class that handles game logic
class Game
  def initialize
    @colors = %i[black blue magenta white cyan light_black]
  end

  def loading_animation
    puts 'Welcome to the Mastermind Game!'
    print 'Randomizing game code'
    5.times do
      print '.'
      sleep(1) # Delay of 0.5 seconds
    end
    puts "\nGame code generated!"
  end

  def random_code
    @code = Array.new(4) { @colors.sample }
  end

  def play
    random_code
    loading_animation
  end
end
