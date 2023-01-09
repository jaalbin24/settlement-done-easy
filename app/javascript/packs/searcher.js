export default class Searcher {



    constructor(template, anchor) {
        this.template = template;
        this.anchor = anchor;
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
                Searcher.render(response);
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

    static render(json) {
        let anchor = document.querySelector("tbody#user_profile_settlements_table_body")
        while (anchor.firstChild) {
            anchor.removeChild(anchor.firstChild);
        }
        for(const key in json) {
            console.log("key=%s, json[key]=%O", key, json[key]);
            let htmlString = `<table><tr class="clickable" href="${json[key].show_path}">
                <td class="border-bottom-0"><strong>${json[key].public_number}</strong></td>
                <td class="border-bottom-0"><a class="link-dark" href="${json[key].adjuster.profile.show_path}">${json[key].adjuster.profile.first_name} ${json[key].adjuster.profile.last_name}</a></td>
                <td class="border-bottom-0">${json[key].claimant_name}</td>
                <td class="border-bottom-0">$${json[key].amount}</td>
                <td class="border-bottom-0">${json[key].time_elapsed}</td>
                <td class="border-bottom-0"><i class="m-0 fa-solid fa-chevron-right"></i></td>
            </tr></table>`
            let row = new DOMParser().parseFromString(htmlString, "text/html").body.querySelector("tr");
            console.log("row=%O", row)
            anchor.appendChild(row);
            row.addEventListener("click", () => {
                window.location.href = row.getAttribute("href");
            });
        }
    }
}