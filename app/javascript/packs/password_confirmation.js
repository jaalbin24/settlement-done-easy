export default class PasswordConfirmation {
    constructor(e) {
        document.addEventListener("DOMContentLoaded", () => {
            if (!!document.getElementsByName("submit-edit-user-button")[0]) {
                let submitEditUserButton = document.getElementsByName("submit-edit-user-button")[0]
                submitEditUserButton.addEventListener("click", async event => {
                    event.preventDefault();
                    event.target.disabled = true;

                    var editUserForm = document.getElementById("edit-user-form");
                    var passwordConfirmationForm = document.getElementById("password-confirmation-form");
                    var passwordConfirmationFormData = new FormData(passwordConfirmationForm);

                    for(const e of passwordConfirmationFormData) {
                        if (e[0] == "user[current_password]") {
                            let currentPassword = String(e[1]);
                            if (await PasswordConfirmation.currentPasswordIsValid(currentPassword)) {
                                console.log("PW valid");
                                var currentPasswordField = document.createElement("input");
                                currentPasswordField.type = "hidden";
                                currentPasswordField.name = "user[current_password]";
                                currentPasswordField.value = currentPassword;
                                editUserForm.appendChild(currentPasswordField);
                                editUserForm.submit();
                            } else {
                                console.log("PW invalid");
                                var currentPasswordInputField = passwordConfirmationForm.querySelector("input[name='user[current_password]']");
                                var incorrectPasswordErrorMessageElement = passwordConfirmationForm.querySelector("div[name='incorrect-password-error-message']");
                                currentPasswordInputField.classList.add("is-invalid");
                                incorrectPasswordErrorMessageElement.style.display = "block";
                                currentPasswordInputField.focus();
                                document.getElementsByName("submit-edit-user-button")[0].disabled = false;
                            }
                            break;
                        }
                    }
                });
            }

            let currentPasswordFields = document.getElementsByName("user[current_password]");
            for(const currentPasswordField of currentPasswordFields) {
                var submitButton;
                if (!!currentPasswordField.form.querySelector("input[type='submit']")) {
                    submitButton = currentPasswordField.form.querySelector("input[type='submit']");
                    console.log("SUBMIT BUTTON DETECTED: %O", submitButton);
                } else {
                    console.log("NO SUBMIT BUTTON DETECTED");
                    continue;
                }
                submitButton.addEventListener("click", async event => {
                    event.preventDefault();
                    event.target.disabled = true;
                    let formHasErrors = false;
                    PasswordConfirmation.removeAllErrorsFromForm(event.target.form);
                    let currentPassword = currentPasswordField.value;
                    console.log("currentPassword=%s", currentPassword);
                    let inputFields = currentPasswordField.form.querySelectorAll("input.form-control");
                    for (const inputField of inputFields) {
                        if (inputField.required == true && inputField.value == "") {
                            PasswordConfirmation.styleInputAsInvalid(inputField, "Cannot be blank");
                            formHasErrors = true;
                        } else if (inputField.type == "email") {
                            if (!PasswordConfirmation.emailIsFormattedCorrectly(inputField.value)) {
                                PasswordConfirmation.styleInputAsInvalid(inputField, "Please enter a valid email");
                                formHasErrors = true;
                            } else if (inputField.hasAttribute("data-verify-unique")) {
                                if (await PasswordConfirmation.emailIsTaken(inputField.value)) {
                                    PasswordConfirmation.styleInputAsInvalid(inputField, "This email is already taken");
                                    formHasErrors = true;
                                }
                            }
                        } else if (inputField.type == "tel") {
                            if (!PasswordConfirmation.phoneNumberIsFormattedCorrectly(inputField.value)) {
                                PasswordConfirmation.styleInputAsInvalid(inputField, "Please enter a valid phone number");
                                formHasErrors = true;
                            }
                        } else if (inputField.name == "user[password]") {
                            if (inputField.value.length < 8) {
                                PasswordConfirmation.styleInputAsInvalid(inputField, "Must have 8 or more characters");
                                formHasErrors = true;
                            }
                        } else if (inputField.name == "user[password_confirmation]") {
                            let newPasswordInputField = inputField.form.querySelector("input[name='user[password]']");
                            if (inputField.value != newPasswordInputField.value) {
                                PasswordConfirmation.styleInputAsInvalid(inputField, "Does not match new password");
                                formHasErrors = true;
                            }
                        }
                    }
                    if (formHasErrors) {
                        event.target.disabled = false;
                        return;
                    }
                    if (currentPassword == null || currentPassword == "") {
                        // Incorrect message was already shown
                    } else if (await PasswordConfirmation.currentPasswordIsValid(currentPassword)) {
                        console.log("PASSWORD VALID");
                        event.target.form.submit();
                    } else {
                        console.log("PASSWORD INVALID");
                        PasswordConfirmation.styleInputAsInvalid(currentPasswordField, "Incorrect password");
                    }
                    event.target.disabled = false;
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
        if (res['email_taken']) {
            return true;
        } else {
            return false;
        }
    }

    static removeAllErrorsFromForm(form) {
        let errorMessages = form.querySelectorAll("div.invalid-feedback");
        let inputs = form.querySelectorAll("input");

        for(const message of errorMessages) {
            message.style.display = "none";
        }
        for(const input of inputs) {
            input.classList.remove("is-invalid");
        }
    }

    static styleInputAsInvalid(inputElement, message) {
        inputElement.classList.add("is-invalid");
        let errorMessageElement = document.createElement("div");
        errorMessageElement.innerHTML = message;
        errorMessageElement.classList.add("invalid-feedback");
        inputElement.parentElement.appendChild(errorMessageElement);
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