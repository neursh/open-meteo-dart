// Go to /en/docs and paste this script.

const hourly_variables = new Set();
const daily_variables = new Set();
const current_variables = new Set();

function fetchResult(variable) {
  console.log([...variable].join(","));
}

function collectVariables() {
  const colasped_docs = document.getElementsByClassName("accordion-button");
  for (let i = 0; i < colasped_docs.length; i++) {
    colasped_docs[i].click();
  }

  setTimeout(() => {
    const form_docs = document.getElementsByClassName("form-check-input");
    for (let i = 0; i < form_docs.length; i++) {
      if (form_docs[i].getAttribute("name") === "hourly") {
        hourly_variables.add(form_docs[i].getAttribute("value"));
      }
      if (form_docs[i].getAttribute("name") === "daily") {
        daily_variables.add(form_docs[i].getAttribute("value"));
      }
      if (form_docs[i].getAttribute("name") === "current") {
        current_variables.add(form_docs[i].getAttribute("value"));
      }
    }
  }, 500);
}

const doc_pages = [
  "/en/docs",
  "/en/docs/historical-weather-api",
  "/en/docs/ensemble-api",
  "/en/docs/climate-api",
  "/en/docs/marine-weather-api",
  "/en/docs/air-quality-api",
  "/en/docs/flood-api"
];

for (let page = 0; page < doc_pages.length; page++) {
  setTimeout(() => {
    document.querySelector(`a[href="${doc_pages[page]}"]`).click();
    setTimeout(() => {
      collectVariables();
    }, 1000);
    setTimeout(() => {
      console.log(`[TASK] ${doc_pages[page]} done. [hourly: ${hourly_variables.size} | daily: ${daily_variables.size} | current: ${current_variables.size}]`);
    }, 2000);
  }, 3000 * page);
}

setTimeout(() => {
  console.log(`[RESULT]\nHourly: ${hourly_variables.size}\nDaily: ${daily_variables.size}\nCurrent: ${current_variables.size}\nRun fetchResult(<variable>) to log every values in the variable.`);
}, 3000 * doc_pages.length);