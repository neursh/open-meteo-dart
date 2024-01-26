`
A simple script to parse parameters from the official docs.

Paste this script to DevTools at 'https://open-meteo.com/en/docs' and it will return a string with all available parameters
and could be pasted to enum.

You can ignore this file or use it to update manually if this package haven't update new features yet.
`

contentTitle = document.getElementsByClassName("mt-5");
content = document.getElementsByTagName("tbody");

for (let pat = 1; pat < contentTitle.length; pat++) {
    console.log(`%c${contentTitle[pat].innerText}`, "color:green;font-size: 20px");
    let joint = [];
    Array.from(content[pat + 1].getElementsByTagName("th")).forEach(element => {
        joint = joint.concat(element.innerText.split("\n"));
    });
    console.log(`%c${joint.join(",")}`, "");
}