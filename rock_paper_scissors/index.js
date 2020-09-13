const playerWins = "Player wins!";
const computerWins = "Computer wins!";
const tie = "It's a tie!";

function computerPlay() {
  const randomChoice = ["rock", "paper", "scissors"];
  let randomNum = Math.floor(Math.random() * 3);

  return randomChoice[randomNum];
}

function playRound(playerSelection, computerSelection) {
  // if player selection is rock
  if (playerSelection == "rock") {
    if (computerSelection == "rock") {
      return tie;
    } else if (computerSelection == "paper") {
      return computerWins;
    } else if (computerSelection == "scissors") {
      return playerWins;
    }
    // if player selects paper
  } else if (playerSelection == "paper") {
    if (computerSelection == "rock") {
      return playerWins;
    } else if (computerSelection == "paper") {
      return tie;
    } else if (computerSelection == "scissors") {
      return computerWins;
    }
    // if player selects scissors
  } else if (playerSelection == "scissors") {
    if (computerSelection == "rock") {
      return computerWins;
    } else if (computerSelection == "paper") {
      return playerWins;
    } else if (computerSelection == "scissors") {
      return tie;
    }
  }
}

function playGame(rounds) {
  let playerScore = 0;
  let computerScore = 0;
  let tieScore = 0;

  for (i = 0; i < rounds; i++) {
    let playerSelection = prompt("Rock, paper, or scissors?").toLowerCase();
    let computerSelection = computerPlay();
    let results = playRound(playerSelection, computerSelection);

    if (results == playerWins) {
      console.log(playRound(playerSelection, computerSelection));
      playerScore++;
    } else if (results == computerWins) {
      console.log(playRound(playerSelection, computerSelection));
      computerScore++;
    } else if (results == tie) {
      console.log(playRound(playerSelection, computerSelection));
      tieScore++;
    }
  }

  console.log(
    "Player Score: " +
      playerScore +
      "| Computer Score: " +
      computerScore +
      "| Ties: " +
      tieScore
  );
}

playGame(5);
