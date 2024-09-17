# Tic-Tac-Toe Command Line Game

Welcome to Tic-Tac-Toe!\
This classic game is played on a 3x3 grid where two players take turns placing their markers (X and O) 
in an attempt to align three of their markers in a row—either horizontally, vertically, or diagonally. 
The game ends when one player achieves this alignment or when all the spaces on the board are filled, 
resulting in a tie if no player has won.

## Table of Contents

- [Installation](#installation)
- [How to Play](#how-to-play)
- [Features](#features)
- [Technologies](#technologies)

## Installation

### Prerequisites

- Ruby 3.x or above installed on your system.
- Clone this repository to your local machine.

### Setup Instructions

1. Clone the repository:
2. Install Dependencies:
   ```bash
   gem install colorize
   ```
3. Run the game:
   ```bash
   ruby main.rb
   ```

## How to Play
1. Run the game using the command `ruby main.rb`.
2. You will be prompted to enter names for Player 1 and Player 2.
3. Player 1 will be assigned the marker X and color green and Player 2 will be assigned the marker O and color blue.
4. Players will take turns to place their marker on the board. To make a move, input a number between 1 and 9 corresponding to the position on the board.
5. The game board is represented as follows:\
   | 1 | 2 | 3 |\
   --+---+---+--
   | 4 | 5 | 6 |\
   --+---+---+--
   | 7 | 8 | 9 |
6. After the game ends, the result will be displayed. The winning player’s name will be shown in their assigned color,
    or a message indicating a tie will be displayed.

## Features

- Two-player game.
- Board display with markers and options.
- Detects wins (horizontal, vertical, diagonal).
- Detects ties.
- Prevents players from choosing an occupied cell.

## Technologies

- **Ruby**: The game logic is written in Ruby.
- **Colorize Gem**: Used to add color to the game messages and board.

### Code Structure:
- board.rb: Defines the Board class, which handles the game board logic, including checking for a winner and drawing the board.

- game.rb: Defines the Game class, which manages the game flow, including player turns, move validation, and game-over conditions.

- player.rb: Defines the Player class, which handles player logic, including taking turns and making moves.

- main.rb: Entry point of the application. It starts the game by initializing and running an instance of the Game class.
