export default class ClickableTableRows {
    constructor() {
        document.addEventListener("DOMContentLoaded", () => {
            let clickableTableRows = document.querySelectorAll("tr.clickable");

            for(const row of clickableTableRows) {
                console.log("row=%O", row)
                row.addEventListener("click", () => {
                    window.location.href = row.getAttribute("href");
                });
            }
        });
    }
}