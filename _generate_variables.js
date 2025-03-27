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
  const hourlyVariables = new Set();
  const dailyVariables = new Set();
  const currentVariables = new Set();

  setTimeout(() => {
    const variables = document.getElementsByClassName("peer-disabled:cursor-not-allowed peer-disabled:opacity-70 ml-[0.42rem] cursor-pointer truncate py-[0.1rem]");
    for (let i = 0; i < variables.length; i++) {
      const label = variables[i].getAttribute("for");

      if (label.endsWith("hourly")) {
        hourlyVariables.add(label.slice(0, -7));
      }
      if (label.endsWith("daily")) {
        dailyVariables.add(label.slice(0, -6));
      }
      if (label.endsWith("current")) {
        currentVariables.add(label.slice(0, -8));
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
