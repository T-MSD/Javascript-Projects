const grid = {
  width: 1000,
  height: 1000,
  size: 0,
};

const mode = {
  rainbow: false,
  color: false,
  eraser: false,
};

const gridContainer = document.getElementById('grid-container'); 
const displayDiv = document.getElementById('display-size');
const colorPickerDiv = document.getElementById('colorpicker-div');
const buttons = {
  grid: document.getElementById('grid-button'),
  rainbow: document.getElementById('rainbow-button'),
  color: document.getElementById('color-button'),
  eraser: document.getElementById('eraser-button'),
  plus: document.getElementById('plus-button'),
  minus: document.getElementById('minus-button'),
  picker: document.getElementById('colorpicker'),
};

buttons['grid'].addEventListener('click', () => updateGrid());
buttons['rainbow'].addEventListener('click', () => changeMode('rainbow', buttons['rainbow']));
buttons['color'].addEventListener('click', () => changeMode('color', buttons['color']));
buttons['eraser'].addEventListener('click', () => changeMode('eraser', buttons['eraser']));
buttons['plus'].addEventListener('click', () => resizeGrid(1));
buttons['minus'].addEventListener('click', () => resizeGrid(-1));

function createGrid(number = 16){
  grid.size = number;
  gridSize = grid.width / number;
  isMouseDown = false;
  for (row = 0; row < number; row++){
    const cellRow = document.createElement('div');
    cellRow.classList.add('cell-row');
    for (col = 0; col < number; col++){
      const cell = document.createElement('div');
      cell.classList.add('grid-cell');
      cell.style.opacity = 1.0;
      cell.style.width = String(gridSize) + 'px';
      cell.style.height = String(gridSize) + 'px'
      cell.addEventListener('mouseenter', () => {
        if (isMouseDown){
          getMode(cell)
        }
      });
      cell.addEventListener('mousedown', () => {
        isMouseDown = true;
        getMode(cell);
      });
      cell.addEventListener('mouseup', () => {
        isMouseDown = false;
      });
      cellRow.appendChild(cell);
    }
    gridContainer.appendChild(cellRow);
    gridContainer.classList.add('grid-container')
  }
  mode['rainbow'] = true;
  buttons['rainbow'].classList.add('selected');
  colorPickerDiv.style.display = 'none'
  displaySize();
}

function changeBackgroundRandomColor(cell){
  if (!cell.style.backgroundColor || cell.style.backgroundColor == 'white'){
    color = getRandomHexColor();
    cell.style.backgroundColor = color;
  }
  else if (cell.style.backgroundColor != 'black'){
    cell.style.backgroundColor = darkenColor(cell.style.backgroundColor);
    }
  }

function changeBackgroundColor(cell){
  const color = buttons['picker'].value;
  cell.style.backgroundColor = color;
}

function deleteGrid(){
  while (gridContainer.firstChild) {
    gridContainer.removeChild(gridContainer.firstChild);
  }
}

function getSquares(){
  const input = prompt("Number of squares:");
  if (input === null || input.trim() === "") {
    return false;
  }
  const size = Math.min(100, parseInt(input));
  grid.size = size;
  return true;
}

function updateGrid(){
  if (getSquares()){
    m = getPreviousMode()
    mode[m] = false;
    buttons[m].classList.remove('selected');
    deleteGrid();
    createGrid(grid.size);
  }
}

function getRandomHexColor() {
  const hex = Math.floor(Math.random() * 16777215).toString(16);
  return "#" + hex.padStart(6, '0');
}

function darkenColor(color) {
  const regex = /rgb\((\d+), (\d+), (\d+)\)/;
  const match = color.match(regex);
  const [_, r, g, b] = match;
  red = parseInt(r);
  green = parseInt(g);
  blue = parseInt(b);
  darkenFactor = 0.1;
  const darkenedR = Math.max(0, Math.floor(red * (1 - darkenFactor)));
  const darkenedG = Math.max(0, Math.floor(green * (1 - darkenFactor)));
  const darkenedB = Math.max(0, Math.floor(blue * (1 - darkenFactor)));
  return `rgb(${darkenedR}, ${darkenedG}, ${darkenedB})`;
}

function getMode(cell) {
  if (mode.rainbow){
    return changeBackgroundRandomColor(cell);
  }
  if (mode.color){
    return changeBackgroundColor(cell);
  }
  if (mode.eraser){
    return erase(cell);
  }
}

function erase(cell) {
  cell.style.backgroundColor = 'white';
  cell.style.border = 'border: 1px solid #ccc;'
}

function getPreviousMode() {
  for (let m in mode) {
    if (mode[m] == true) {
      return m
    }
  }
}

function changeMode(thisMode, button){
  m = getPreviousMode()
  mode[m] = false;
  buttons[m].classList.remove('selected');
  mode[thisMode] = true;
  if (!mode['color']){
    colorPickerDiv.style.display = 'none';
  }
  else {
    colorPickerDiv.style.display = 'flex';
  }
  button.classList.add('selected');
}

function displaySize(){
  displayDiv.textContent = grid.size + ' x ' + grid.size;
}

function resizeGrid(number){
  const newSize = grid.size + number
  if (grid.size < newSize){
    grow(newSize);
  }
  else if (grid.size > newSize){
    shrink(newSize);
  }
  displaySize();
}

function grow(newSize){
  if (newSize > 100){
    return;
  }
  // Resize all existing cells
  document.querySelectorAll('.grid-cell').forEach((cell) => {
    cell.style.width = String(grid.width / newSize) + 'px';
    cell.style.height = String(grid.width / newSize) + 'px';
  });
  // Add a new row with new columns
  const newRow = document.createElement('div');
  newRow.classList.add('cell-row');
  for (let i = 0; i < newSize - 1; i++) {
    const newCell = document.createElement('div');
    newCell.classList.add('grid-cell');
    newCell.style.opacity = 1.0;
    newCell.style.width = String(grid.width / newSize) + 'px';
    newCell.style.height = String(grid.width / newSize) + 'px';
    newCell.addEventListener('mouseenter', () => getMode(newCell));
    newRow.appendChild(newCell);
  }
  gridContainer.appendChild(newRow);
  // Cycle through existing rows and add a new column to each
  document.querySelectorAll('.cell-row').forEach((row) => {
    const newCell = document.createElement('div');
    newCell.classList.add('grid-cell');
    newCell.style.opacity = 1.0;
    newCell.style.width = String(grid.width / newSize) + 'px';
    newCell.style.height = String(grid.width / newSize) + 'px';
    newCell.addEventListener('mouseenter', () => getMode(newCell));
    row.appendChild(newCell);
  });
  grid.size = newSize;
}

function shrink(newSize){
  if (newSize < 1){
    return
  }
  // Remove one column from each row
  document.querySelectorAll('.cell-row').forEach((row) => {
    row.removeChild(row.lastChild);
  });
  // Remove the last row
  gridContainer.removeChild(gridContainer.lastChild);
  // Resize all remaining cells
  document.querySelectorAll('.grid-cell').forEach((cell) => {
    cell.style.width = String(grid.width / newSize) + 'px';
    cell.style.height = String(grid.width / newSize) + 'px';
  });
  grid.size = newSize;
}

createGrid();