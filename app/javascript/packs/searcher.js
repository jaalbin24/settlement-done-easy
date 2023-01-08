export default class Searcher {
    constructor(e) {
        document.addEventListener("DOMContentLoaded", () => {
            // Searcher.findResultRenderingArea();
            Searcher.initEventListeners();
        });
    }

    static initEventListeners() {
        console.log("11111111111111111");
        let searchForms = document.querySelectorAll("form[type='search']");
        for(const searchForm of searchForms) {
            let submitButton = searchForm.querySelector("[type='submit']");
            console.log("FOUND SUBMIT BUTTON");
            submitButton.addEventListener("click", async (event) => {
                event.preventDefault();
                let body = Searcher.formHash(searchForm);
                const response = await fetch(searchForm.action, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "Accept":       "application/json"
                    },
                    body: JSON.stringify(body)
                }).then(res => {
                    return res.json();
                }).catch(error => {
                    console.error(error);
                });
                console.log("response=%O", response);
            });
        }
    }

    static formHash(searchForm) {
        let inputFields = searchForm.querySelectorAll("input");
        let hash = {};
        for(const inputField of inputFields) {
            hash[inputField.name] = inputField.value
        }
        return hash
    }
}