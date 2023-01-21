export default class Searcher {
    constructor(template, anchor) {
        this.template = template;
        this.anchor = anchor;
        document.addEventListener("DOMContentLoaded", () => {
            Searcher.initEventListeners();
        });
    }

    static initEventListeners() {
        let searchForms = document.querySelectorAll("form[type='search']");
        for(const searchForm of searchForms) {
            let submitButton = searchForm.querySelector("[type='submit']");
            console.log("FOUND SUBMIT BUTTON");
            submitButton.addEventListener("click", async (event) => {
                event.preventDefault();
                console.log("1");
                if (submitButton.id != "reset_search_results_button") {
                    Searcher.hideOtherWhatsNextMessages(submitButton);
                    console.log("7");
                    Searcher.showResetButton();
                    console.log("11");
                }
                let body = Searcher.formHash(searchForm);
                let response = fetch(searchForm.action, {
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
                response.then(res => {
                    console.log("response=%O", res);
                    Searcher.render(res);
                });
            });
        }
        let resetButton = document.querySelector("button[id='reset_search_results_button']")
        resetButton.addEventListener("click", () => {
            console.log("INFINITY");
            resetButton.style.display = 'none';
            Searcher.showAllWhatsNextMessages();
        });
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
                <td class="border-bottom-0"><a class="link-dark" href="${json[key].attorney.profile.show_path}">${json[key].attorney.profile.first_name} ${json[key].attorney.profile.last_name}</a></td>
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

    static showResetButton() {
        document.querySelector("button[id='reset_search_results_button']").style.display = "block";
    }

    static hideOtherWhatsNextMessages(submit_button) {
        console.log("2     submit_button=%O", submit_button);
        let whats_next_message_forms = document.getElementById("whats_next_messages").querySelectorAll("form[type='search']");
        console.log("3");
        for(const whats_next_message_form of whats_next_message_forms) {
            console.log("4(repeated)");
            if (submit_button.form == whats_next_message_form) {
                console.log("It's equal!");
                continue;
            } else {
                whats_next_message_form.style.display = "none";
            }
        }
        console.log("5");
        document.getElementById("whats_next_wait_list").style.display = "none";
        console.log("6");
    }

    static showAllWhatsNextMessages() {
        let whats_next_message_forms = document.getElementById("whats_next_messages").querySelectorAll("form[type='search']");
        for(const whats_next_message_form of whats_next_message_forms) {
            whats_next_message_form.style.display = "block";
        }
        document.getElementById("whats_next_wait_list").style.display = "block";
    }
}