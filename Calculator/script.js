let result = 0, previous = "", firstNum = "", secondNum = "", operator = "";

const last = document.querySelector(".previous");
const input = document.querySelector(".display");
const numbers = document.querySelectorAll(".numbers");
const operators = document.querySelectorAll(".operation");
const dot = document.querySelector(".dot");
const clear = document.querySelector(".clear");
const del = document.querySelector(".del");
const signal = document.querySelector(".signal");

document.addEventListener("keydown", function(event) {
  const key = event.key;
  // Check if the key is a number
  if (!isNaN(key)) {
    if (operator === "") {
      firstNum += key;
    } else {
      secondNum += key;
    }
    display();
  }
  
  // Check if the key is an operator
  if (["+", "-", "*", "/", "%"].includes(key)) {
    if (operator === "") {
      operator = key;
    }
    display();
  }
  
  // Handle special keys
  switch (key) {
    case "Enter":
      calculate();
      break;
    case "=":
      calculate();
      break;
    case "Backspace":
      del.click(); // Trigger the delete button action
      break;
    case ".":
      dot.click(); // Trigger the dot button action
      break;
    case "Escape":
      clear.click(); // Trigger the clear button action
      break;
    case "±": // Handle the +/- key
      signal.click();
      break;
  }
});

signal.addEventListener("click", () => {
  if (operator === "") {
    firstNum = "-" + firstNum;
  }
  else {
    secondNum = "-" + secondNum;
  }
  display();
});

dot.addEventListener("click", () => {
  if (operator === ""){
    if (firstNum === ""){
      firstNum += "0."
    }
    else {
      firstNum += "."
    }
  }
  else {
    if (secondNum === ""){
      secondNum += "0."
    }
    else {
      secondNum += "."
    }
  }
  display();
});

clear.addEventListener("click", () => {
  firstNum = "";
  secondNum = "";
  operator = "";
  result = 0;
  previous = "";
  display();
});

del.addEventListener("click", () => {
  if (operator === "") {
    firstNum = firstNum.slice(0, -1);
  } 
  else if (operator !== "" && secondNum === "") {
    operator = "";
  }
  else {
    secondNum = secondNum.slice(0, -1);
  }
  display();
});

numbers.forEach(number => {
  number.addEventListener("click", e => {
      if (operator === "") { // Read first number if no operator set yet
          firstNum += e.target.innerText;
      } else { // Read second number
          secondNum += e.target.innerText;
      }
      display();
  });
});

operators.forEach(op => {
  op.addEventListener("click", e => {
    if (e.target.innerText !== "="){
      operator = e.target.innerText;
      display();
    }
    else {
      calculate();
    }
  });
});

function calculate() {
  let n1 = numType(firstNum);
  let n2 = numType(secondNum);
  result = operate(operator, n1, n2);
  if (isFloat(result)){
    result.toFixed(2);
  }
  if (result.toString().length > 10) {  // Adjust the length as needed
    result = result.toExponential(2); // 5 decimal places
  }
  previous = firstNum + operator + secondNum;
  firstNum = result.toString();
  secondNum = "";
  operator = "";
  display();
  result = 0;
};

function isFloat(num) {
  return num === +num && num !== (num|0);
};

function numType(num){
  if (num.includes(".")){
    return parseFloat(num);
  }
  else {
    return parseInt(num);
  }
};

function operate(operator, n1, n2) {
  switch (operator) {
    case "+":
      return add(n1, n2);
    case "-":
      return subtract(n1, n2);
    case "*":
      return multiply(n1, n2);
    case "/":
      return divide(n1, n2);
    case "%":
      return modulo(n1, n2);
  }
};

function add(n1, n2) { return n1 + n2; };
function subtract(n1, n2) { return n1 - n2; };
function multiply(n1, n2) { return n1 * n2; };
function divide(n1, n2) { return n1 / n2; };
function modulo(n1, n2) { return n1 % n2; };

function display(){
  if (result === 0) {
    input.innerHTML = firstNum + operator + secondNum;
  }
  else {
    input.innerHTML = result;
  }
  last.innerHTML = previous;
  adjustDisplay();
};

function adjustDisplay() {
  input.scrollLeft = input.scrollWidth; // Scroll to the rightmost part of the text
};