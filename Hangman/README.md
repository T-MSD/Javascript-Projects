# Hangman Game

Welcome to the **Hangman Game!**\
This is a command-line implementation of the classic word-guessing game Hangman. 
The player tries to guess a hidden word, one letter at a time, while keeping track of incorrect guesses. 
The objective is to reveal the entire word before running out of lives. Guess wisely and see if you can solve the word in time!

## Table of Contents

- [Installation](#installation)
- [How to Play](#how-to-play)
- [Features](#features)
- [Technologies](#technologies)
- [License](#license)

## Installation

### Prerequisites

- Ruby 3.3.5 or above installed on your system.

1. Clone the repository:
    ```sh
    git clone <repository-url>
    ```
2. Install the required gems:
    ```sh
    bundle install
    ```
3. Run the game:
   ```bash
   ruby main.rb
   ```

## How to Play

1. Run the game using the command `ruby main.rb`.
2. Type play or load to choose to start a new game or a saved one.
   - You will be prompted for the path to the file that you want to load. For example: saves/1.yaml
   - You can save the game by typing "save!" when the game prompts you for a new guess.
   - Please load and save **.yaml** files. 
4. Guess a letter (or the whole word). After each guess you will receive a feedback.
5. You have 12 attempts, after that you lose.
6. You can quit at any time by pressing ctrl+c, but the game will not be saved.
7. The game will show a victory message if you guess the word, or a game-over message along with the correct
 word if you run out of rounds.

## Features

1. Randomly chooses a word between 5-12 characters long from the [words.txt](https://github.com/T-MSD/Learning-Projects/blob/main/Hangman/words.txt) file.
2. Provides visual feedback after every guess.
3. Saving and loading your game. Only **YAML** files.

## Technologies

- **Ruby**: The game logic is written in Ruby.
- **Colorize Gem**: Used to add color to the game messages.

### Code Structure:
```
Hangman/
│
├── lib/
│   ├── game.rb          # Main game logic
│   ├── hangman.rb       # Hangman class handles the word and guessing logic
│   ├── save.rb          # Save class handles game state serialization
│
├── main.rb              # Entry point to run the game
├── README.md            # Project documentation
```
- game.rb: The main game logic, handling the rounds, random word generation, and overall flow of the game.

- hangman.rb: Handles the code-breaking logic, including finding letter or word matches.

- save.rb: Handles file serialization, deserialization, saving and loading.

- main.rb: Entry point of the application. It starts the game by initializing and running an instance of the Game class.

## License

This project is open-source and available under the [MIT License](https://github.com/T-MSD/Learning-Projects/blob/main/LICENSE).
