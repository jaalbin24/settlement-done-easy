export default class MutuallyExclusiveFormElements {
    constructor(e) {
        document.addEventListener("DOMContentLoaded", () => {
            let forms = document.querySelectorAll("form");
            console.log("1");
            for(const form of forms) {
                console.log("2");
                let inputElements = form.querySelectorAll("input[data-mutually-exclusive-with]");
                console.log("All mutually exclusive input elements: %O", inputElements);
                for(const inputElement of inputElements) {
                    inputElement.addEventListener("click", () => {
                        console.log("Click registered on checkbox switch!");
                        let complementaryElement = form.querySelector("input[type='checkbox'][name='" + inputElement.getAttribute("data-mutually-exclusive-with") + "']");
                        if (inputElement.checked) {
                            complementaryElement.checked = false
                        }
                        console.log("comp element = %O", complementaryElement);
                        complementaryElement.checked = false
                    });
                }
            }
        });
    }
}