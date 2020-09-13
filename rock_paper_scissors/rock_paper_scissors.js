//storing buttons & paragraphs into variables
const btnRock = document.getElementById("rock");
const btnPaper = document.getElementById("paper");
const btnScissors = document.getElementById("scissors");
const btnRestart = document.getElementById("restart");

let paraPlayerScore = document.getElementById("player-score");
let paraComputerScore = document.getElementById("computer-score");
let roundHeader = document.getElementById("rounds");
let paraTieScore = document.getElementById("tie-score");

let playerScore = 0;
let computerScore = 0;
let tieScore = 0;
let rounds = 0;

btnRock.onclick = () => playRound(btnRock.id);
btnPaper.onclick = () => playRound(btnPaper.id);
btnScissors.onclick = () => playRound(btnScissors.id);
btnRestart.onclick = () => restartGame();

// randomly picks the choice for computer
function computerPlay() {
  const randomChoice = ["rock", "paper", "scissors"];
  let randomNum = Math.floor(Math.random() * 3);

  return randomChoice[randomNum];
}

function updatePlayerScore() {
  playerScore++;
  paraPlayerScore.textContent = "Player Score: " + playerScore;
}

function updateComputerScore() {
  computerScore++;
  paraComputerScore.textContent = "Computer Score: " + computerScore;
}

function updateTieScore() {
  tieScore++;
  paraTieScore.textContent = "Ties: " + tieScore;
}

function updateRounds() {
  rounds++;
  roundHeader.textContent = "Round: " + rounds;
}

function restartGame() {
  rounds = 0;
  computerScore = 0;
  playerScore = 0;
  tieScore = 0;

  paraPlayerScore.textContent = "Player Score: 0";
  paraComputerScore.textContent = "Computer Score: 0";
  paraTieScore.textContent = "Ties: 0";
  roundHeader.textContent = "Rounds: 0";
}

function displayWinner() {
  if (playerScore == computerScore) {
    return alert("It's a tie!");
  } else if (Math.max(tieScore, playerScore, computerScore) == playerScore) {
    return alert("The winner is User!");
  } else if (Math.max(tieScore, playerScore, computerScore) == computerScore) {
    return alert("The winner is Computer!");
  } else if (Math.max(tieScore, playerScore, computerScore) == tieScore) {
    return alert("It's a tie!");
  }
}

function playRound(name) {
  let computerSelection = computerPlay();
  let playerSelection = name;

  if (rounds < 5) {
    updateRounds();

    if (playerSelection == "rock") {
      if (computerSelection == "rock") {
        updateTieScore();
      } else if (computerSelection == "paper") {
        updateComputerScore();
      } else if (computerSelection == "scissors") {
        updatePlayerScore();
      }
      // if player selects paper
    } else if (playerSelection == "paper") {
      if (computerSelection == "rock") {
        updatePlayerScore();
      } else if (computerSelection == "paper") {
        updateTieScore();
      } else if (computerSelection == "scissors") {
        updateComputerScore();
      }
      // if player selects scissors
    } else if (playerSelection == "scissors") {
      if (computerSelection == "rock") {
        updateComputerScore();
      } else if (computerSelection == "paper") {
        updatePlayerScore();
      } else if (computerSelection == "scissors") {
        updateTieScore();
      }
    }
  } else {
    displayWinner();
  }
}
