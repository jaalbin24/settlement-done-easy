export default class FormErrorStyling {
    constructor(e) {
        document.addEventListener("DOMContentLoaded", () => {

            // Find all form elements on the DOM and iterate through them
            let forms = document.querySelectorAll("form[data-js-styling='true']");
            for(const FORM of forms) {
                var submitButton;
                // Find the form's submit button.
                if (!!FORM.querySelector("input[type='submit']")) {
                    submitButton = FORM.querySelector("input[type='submit']");
                    console.log("Submit button detected on a dynamically styling form: %O", submitButton);
                } else {
                    console.log("Submit button detected on a dynamically styling form: %O", submitButton);
                    continue;
                }
                submitButton.addEventListener("click", async event => {
                    event.preventDefault();
                    console.log("Form Styling");
                    event.target.disabled = true;
                    FormErrorStyling.removeAllErrorsFromForm(FORM);
                    let inputFields = FORM.querySelectorAll("input.form-control");
                    // Iterate through all inputs in the FORM
                    let formHasErrors = false;
                    for (const inputField of inputFields) {
                        if (inputField.required && inputField.value === "") { // If a required field is blank
                            FormErrorStyling.styleInputAsInvalid(inputField, "Cannot be blank");
                            formHasErrors = true;
                        } else if (inputField.type == "email") {
                            console.log("Detected email input: %O", inputField);
                            if (!FormErrorStyling.emailIsFormattedCorrectly(inputField.value)) { // If an email is incorrectly formatted (i.e. qwerty@, q@q, @qwerty.com, etc.)
                                FormErrorStyling.styleInputAsInvalid(inputField, "Please enter a valid email");
                                formHasErrors = true;
                            } else if (inputField.hasAttribute("data-verify-unique")) { // If an email should be ensured unique by the server
                                console.log("Email input field %O has data-verify-unique attribute", inputField);
                                if (await FormErrorStyling.emailIsTaken(inputField.value)) { // If an email is already taken
                                    FormErrorStyling.styleInputAsInvalid(inputField, "This email is already taken");
                                    formHasErrors = true;
                                }
                            }
                        } else if (inputField.type == "tel") {
                            if (!FormErrorStyling.phoneNumberIsFormattedCorrectly(inputField.value)) {
                                FormErrorStyling.styleInputAsInvalid(inputField, "Please enter a valid phone number");
                                formHasErrors = true;
                            }
                        } else if (inputField.name == "user[password]" && !!FORM.querySelector("input[name='user[password_confirmation]']")) {
                            if (inputField.value.length < 8) {
                                FormErrorStyling.styleInputAsInvalid(inputField, "Must have 8 or more characters");
                                formHasErrors = true;
                            }
                        } else if (inputField.name == "user[password_confirmation]") {
                            let newPasswordInputField = inputField.form.querySelector("input[name='user[password]']");
                            if (inputField.value != newPasswordInputField.value) {
                                FormErrorStyling.styleInputAsInvalid(inputField, "Does not match");
                                formHasErrors = true;
                            }
                        } else if (inputField.name == "user[current_password]") {
                            if (await FormErrorStyling.currentPasswordIsValid(inputField.value)) {
                                console.log("PASSWORD VALID");
                            } else {
                                console.log("PASSWORD INVALID");
                                FormErrorStyling.styleInputAsInvalid(inputField, "Incorrect password");
                                formHasErrors = true;
                            }
                        }
                    }
                    if (formHasErrors) {
                        if (FORM.hasAttribute("data-wait-before-resubmit")) {
                            event.target.disabled = true;
                            const originalSubmitButtonText = event.target.value;
                            for (var i=5; i--; i>1) {
                                event.target.value = String(i+1) + " " + originalSubmitButtonText;
                                await new Promise(resolve => setTimeout(resolve, 1000));
                            }
                            event.target.value = originalSubmitButtonText;
                        }
                        event.target.disabled = false;
                    } else {
                        FORM.submit();
                    }
                });
            }
        });
    }

    static async currentPasswordIsValid(currentPassword) {
        let bodyContent = {
            "user[current_password]":   String(currentPassword),
            "authenticity_token":       document.querySelector("input[name='authenticity_token']").value
        }
        let res = await fetch("/user/validate", {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Accept":       "application/json"
            },
            body: JSON.stringify(bodyContent)
        }).then(res => {
            return res.json();
        }).catch(error => {
            console.error(error);
        });
        if (res['current_password_valid']) {
            return true;
        } else {
            return false;
        }
    }

    static async emailIsTaken(email) {
        let bodyContent = {
            "user[email]":          String(email),
            "authenticity_token":   document.querySelector("input[name='authenticity_token']").value
        }
        let res = await fetch("/user/validate", {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Accept":       "application/json"
            },
            body: JSON.stringify(bodyContent)
        }).then(res => {
            return res.json();
        }).catch(error => {
            console.error(error);
        });
        if(res['email_taken']) {
            return true;
        } else {
            return false;
        }
    }

    static removeAllErrorsFromForm(form) {
        let inputs = form.querySelectorAll("input");
        let errorMessages = form.querySelectorAll("invalid-feedback")

        for(const message of errorMessages) {
            message.remove();
        }
        for(const input of inputs) {
            input.classList.remove("is-invalid");
            input.style.color = "";
        }
    }

    static async removeErrorFromInput(inputElement) {
        await Array.from(inputElement.parentElement.parentElement.querySelectorAll("div.invalid-feedback")).forEach(el => el.remove());
        inputElement.classList.remove("is-invalid");
        inputElement.style.color = "";
    }

    static async styleInputAsInvalid(inputElement, message) {
        console.log(`Styling ${inputElement.name}: 1, message=${message}`);
        await FormErrorStyling.removeErrorFromInput(inputElement);
        inputElement.classList.add("is-invalid");
        inputElement.style.color = "#da292e";
        let errorMessageElement = document.createElement("div");
        errorMessageElement.setAttribute("data-test-id", inputElement.name + "_" + message.toLowerCase().split(" ").join("_"))
        errorMessageElement.innerHTML = message;
        errorMessageElement.classList.add("invalid-feedback");
        let parent = inputElement.parentElement;
        let grandparent = parent.parentElement;

        if (Array.from(parent.classList).includes("form-group")) {
            console.log(`Styling ${inputElement.name}: 2`);
            parent.appendChild(errorMessageElement);
        } else if (Array.from(grandparent.classList).includes("form-group")) {
            console.log(`Styling ${inputElement.name}: 3`);
            grandparent.appendChild(errorMessageElement);
        }
        errorMessageElement.style.display = "block";
    }

    static emailIsFormattedCorrectly (email) {
        return String(email)
            .toLowerCase()
            .match(
                /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/g
            );
    }

    static phoneNumberIsFormattedCorrectly (phoneNumber) {
        return String(phoneNumber)
            .match(
                /^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$/
            );
    }
}