function changeBackground(e) {
  e.target.style.cssText = "background-color: black";
}

function getRandomColor() {
  let x = Math.floor(Math.random() * 256);
  let y = Math.floor(Math.random() * 256);
  let z = Math.floor(Math.random() * 256);

  return `rgb(${x}, ${y}, ${z})`;
}

function resetBoard(divList) {
  for (let h = 0; h < divList.length; h++) {
    divList[h].style.cssText = "background-color: white";
  }
  for (let k = 0; k < allSquares.length; k++) {
    allSquares[k].onmouseenter = (e) => changeBackground(e);
  }
}

function createGrid(arr, size) {
  let createDiv;

  arr = [[,]];
  createDiv = [[,]];

  for (let i = 0; i < size; i++) {
    arr.push([,]);
  }

  //adds divs to empty slots in array & assigns classnames & IDs
  for (let j = 0; j < size; j++) {
    for (let i = 0; i < size; i++) {
      createDiv = arr[j][i];
      createDiv = document.createElement("div");
      createDiv.id = "grid" + "-" + j + "-" + i;
      createDiv.className = "grid-squares";
      mainContainer.appendChild(createDiv);
    }
  }

  allSquares = document.querySelectorAll(".grid-squares");

  // cycles through all nodes in nodeLust and adds the onmouseenter event
  for (let k = 0; k < allSquares.length; k++) {
    allSquares[k].onmouseenter = (e) => changeBackground(e);
  }
}

let txtSize = document.getElementById("grid-input");
let btnReset = document.getElementById("reset-button");
let btnRandomColor = document.getElementById("random-color");
let gridHeader = document.getElementById("grid-size-header");
let mainContainer = document.createElement("div");
let gridLength = 16;
let allSquares;
let arrGrids = [[,]];

// assigns id to main-container & adds it to body
mainContainer.id = "main-container";
mainContainer.className = "main-main";
document.body.appendChild(mainContainer);

// creates grids
createGrid(arrGrids, gridLength);

btnReset.onclick = () => resetBoard(allSquares);
btnRandomColor.onclick = (e) => {
  // cycles through all elements in the class & adds event listener onmouseenter
  for (let k = 0; k < allSquares.length; k++) {
    allSquares[k].onmouseenter = (e) => {
      e.target.style.backgroundColor = getRandomColor();
    };
  }
};
