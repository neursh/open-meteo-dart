// Go to /en/docs and paste this script.

function fetchResult(variable) {
  console.log([...variable].join(","));
}

function consoleVariable(title, variables) {
  if (variables.size > 0) {
    console.log(`%c${title}:`, "color: blue");
    fetchResult(variables);
  }
}

function collectVariables() {
  const colaspedDocs = document.getElementsByClassName("accordion-button");
  for (let i = 0; i < colaspedDocs.length; i++) {
    colaspedDocs[i].click();
  }

  const hourlyVariables = new Set();
  const dailyVariables = new Set();
  const currentVariables = new Set();

  setTimeout(() => {
    const formDocs = document.getElementsByClassName("form-check-input");
    for (let i = 0; i < formDocs.length; i++) {
      if (formDocs[i].getAttribute("name") === "hourly") {
        hourlyVariables.add(formDocs[i].getAttribute("value"));
      }
      if (formDocs[i].getAttribute("name") === "daily") {
        dailyVariables.add(formDocs[i].getAttribute("value"));
      }
      if (formDocs[i].getAttribute("name") === "current") {
        currentVariables.add(formDocs[i].getAttribute("value"));
      }
    }

    consoleVariable("Hourly", hourlyVariables);
    consoleVariable("Daily", dailyVariables);
    consoleVariable("Current", currentVariables);
  }, 1000);
}

const docPages = [
  "/en/docs",
  "/en/docs/historical-weather-api",
  "/en/docs/ensemble-api",
  "/en/docs/climate-api",
  "/en/docs/marine-weather-api",
  "/en/docs/air-quality-api",
  "/en/docs/flood-api"
];

for (let page = 0; page < docPages.length; page++) {
  setTimeout(() => {
    const button = document.querySelector(`a[href="${docPages[page]}"]`);
    button.click();
    console.log(`%c${button.innerText}`, "color: green; font-size: 20px");
    setTimeout(() => {
      collectVariables();
    }, 1000);
  }, 3000 * page);
}
