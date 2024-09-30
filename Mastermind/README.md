# Mastermind Command Line Game

Welcome to **Mastermind!**\
This is a command-line implementation of the classic code-breaking game Mastermind. The player tries 
to guess a secret code of four colors, and the game provides feedback on how accurate the guess is. 
The objective is to guess the correct code within a limited number of rounds.

## Table of Contents

- [Installation](#installation)
- [How to Play](#how-to-play)
- [Features](#features)
- [Technologies](#technologies)
- [License](#license)

## Installation

### Prerequisites

- Ruby 2.5+ or above installed on your system.
- Clone this repository to your local machine.

### Setup Instructions

1. Clone the repository:
   ```sh
    git clone <repository-url>
   cd Mastermind
    ```
3. Install the required gems:
    ```sh
    bundle install
    ```
4. Run the game:
   ```bash
   ruby main.rb
   ```

## How to Play
1. Run the game using the command `ruby main.rb`.
2. Read the rules and then press Enter.
3. You, the player, will attempt to guess the code by entering four colors.\
   ⚫ 🔵 🟣 ⚪ 🟠 🔴 🟡 🟢
4. After each guess, you will receive feedback on:
     - Exact matches: colors that are correct and in the right position.
     - Color matches: colors that are correct but in the wrong position.
5. You have 12 rounds to guess the code correctly.
6. The game will show a victory message if you guess the code, or a game-over message along with the correct
   code if you run out of rounds.

## Features

- Randomly generates a 4-color code from a set of colors.
- Provides feedback on each guess, indicating exact matches (correct color and position) and color matches
  (correct color, wrong position).
- A maximum of 12 rounds for the player to guess the code.
- A loading animation simulates code generation at the start of the game.
- Colored peg symbols to visually represent the player's choices and feedback using the colorize gem.

## Technologies

- **Ruby**: The game logic is written in Ruby.
- **Colorize Gem**: Used to add color to the game messages.

### Code Structure:
```
Mastermind/
│
├── lib/
│   ├── game.rb          # Main game logic
│   ├── mastermind.rb    # Mastermind class that generates and evaluates the code
│   ├── player.rb        # Player class for player input and guess validation
│
├── main.rb              # Entry point to run the game
├── README.md            # Project documentation
```
- game.rb: The main game logic, handling the rounds, random code generation, and overall flow of the game.

- mastermind.rb: Handles the code-breaking logic, including finding exact and color matches.

- player.rb: Manages the player input, including validating the guesses and displaying choices.

- main.rb: Entry point of the application. It starts the game by initializing and running an instance of the Game class.

## License

This project is open-source and available under the [MIT License](https://github.com/T-MSD/Learning-Projects/blob/main/LICENSE).
