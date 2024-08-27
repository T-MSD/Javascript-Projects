const btnRock = document.querySelector('#rock');
const btnPaper = document.querySelector('#paper');
const btnScissors = document.querySelector('#scissors');
const btnRestart = document.querySelector('#restartBtn')
btnRock.addEventListener('click', () => getClick('rock'));
btnPaper.addEventListener('click', () => getClick('paper'));
btnScissors.addEventListener('click', () => getClick('scissors'));
btnRestart.addEventListener('click', () => restartGame());

const pScore = document.querySelector('#pScore');
const cScore = document.querySelector('#cScore');
const tCounter = document.querySelector('#tCounter');
const popup = document.querySelector('#popup');
const container = document.querySelector('#container');
const popupW = document.querySelector('#popupWinner')

let playerScore = 0;
let computerScore = 0;
let tieCounter = 0;

function getComputerChoice() {
  const randomNumber = Math.floor(Math.random() * 3);
  switch (randomNumber) {
  case 0:
      return 'rock';
  case 1:
      return 'paper';
  case 2:
      return 'scissors';
  }
}

function playRound(player) {
  if (!endGame()){
    const computer = getComputerChoice().toLowerCase();
    const playerChoice = player.toLowerCase();
    if (playerChoice === computer) {
      tieCounter++;
      return 'It\'s a tie!';
    }
    if (
      (playerChoice === 'rock' && computer === 'scissors') || 
      (playerChoice === 'paper' && computer === 'rock') ||
      (playerChoice === 'scissors' && computer === 'paper')){
      playerScore++;
      return 'You win!';
    } 
    if (
      (playerChoice === 'rock' && computer === 'paper') ||
      (playerChoice === 'paper' && computer === 'scissors') ||
      (playerChoice === 'scissors' && computer === 'rock')){
      computerScore++;
      return 'You lose!';
    }
  }
}

function getClick(value){
  const result = playRound(value);
  updatePoints();
  console.log(result);
  if (endGame()){
    displayResult();
  }
}

function endGame(){
  return playerScore === 5 || computerScore === 5;
}

function displayResult(){
  openPopup();
  return playerScore > computerScore 
  ?  popupW.textContent = 'Winner: Player'
  :  popupW.textContent = 'Winner: Computer';
}

function updatePoints(){
  pScore.textContent = "Player Score: " + playerScore;
  cScore.textContent = "Computer Score: " + computerScore;
  tCounter.textContent = 'Ties: ' + tieCounter
}

function restartGame(){
  closePopup();
  playerScore = 0;
  computerScore = 0;
  tieCounter = 0;
  popupW.textContent = ''
  tCounter.textContent = 'Ties: 0'
  updatePoints();
}

function openPopup() {
  popup.classList.add("open-popup");
  container.classList.add("blur");
  popup.classList.add("unblur");
}

function closePopup() {
  popup.classList.remove("open-popup");
  container.classList.remove("blur");
  popup.classList.remove("unblur");
}