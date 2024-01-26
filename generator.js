`
A simple file to parse parameters from the official docs.

Paste this code to DevTools at 'https://open-meteo.com/en/docs' and it will return a string with all available parameters
and could be pasted to enum.
`

let contentTitle = document.getElementsByClassName("mt-5");
let content = document.getElementsByTagName("tbody");

for (let pat = 1; pat < contentTitle.length; pat++) {
    console.log(`%c${contentTitle[pat].innerText}`, "color:green;font-size: 20px");
    let joint = [];
    Array.from(content[pat + 1].getElementsByTagName("th")).forEach(element => {
        joint = joint.concat(element.innerText.split("\n"));
    });
    console.log(`%c${joint.join(",")}`, "");
}