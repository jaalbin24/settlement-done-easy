export default class PasswordConfirmation {
    constructor(e) {
        document.addEventListener("DOMContentLoaded", () => {
            var submitEditUserButton = document.getElementsByName("submit-edit-user-button")[0];
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

            // This event listener controls error messages when changing the user's password
            var changePasswordButton = document.getElementsByName("submit-change-password-button")[0];
            changePasswordButton.addEventListener("click", async event => {
                event.preventDefault();
                event.target.disabled = true;

                var changePasswordForm = document.getElementById("change-password-form");
                let currentPasswordInputElement = changePasswordForm.querySelector("input[name='user[current_password]']");
                let currentPassword = currentPasswordInputElement.value;
                let newPasswordInputElement = document.querySelector("input[name='user[password]']");
                let newPassword = newPasswordInputElement.value;
                let confirmNewPasswordInputElement = document.querySelector("input[name='user[password_confirmation]']");
                let confirmNewPassword = confirmNewPasswordInputElement.value;

                console.log("1");
                PasswordConfirmation.removeAllErrorsFromForm(changePasswordForm);
                console.log("2");
                let incorrectPasswordErrorMessageElement = changePasswordForm.querySelector("div.invalid-feedback[name='incorrect-password-error-message']");
                console.log("3");
                console.log("incorrectPasswordErrorMessageElement=%O", incorrectPasswordErrorMessageElement);
                currentPasswordInputElement.classList.remove("is-invalid");
                // incorrectPasswordErrorMessageElement.style.display = "none";


                if (newPassword != confirmNewPassword || newPassword == "" || newPassword.length < 8) {
                    var newPasswordInputElementHasError = false;
                    var shortPasswordErrorMessageElement = changePasswordForm.querySelector("div.invalid-feedback[name='short-password-error-message']");
                    if (newPassword.length < 8 && newPassword != "") {
                        newPasswordInputElementHasError = true;
                        shortPasswordErrorMessageElement.style.display = "block";
                        newPasswordInputElement.focus();
                    }
                    var blankPasswordErrorMessageElement = changePasswordForm.querySelector("div.invalid-feedback[name='blank-password-error-message']");
                    if (newPassword == "") {
                        newPasswordInputElementHasError = true;
                        newPasswordInputElement.focus();
                        blankPasswordErrorMessageElement.style.display = "block";
                    }
                    var mismatchPasswordErrorMessageElement = changePasswordForm.querySelector("div.invalid-feedback[name='mismatch-password-error-message']");
                    if (newPassword != confirmNewPassword && !newPasswordInputElementHasError) {
                        confirmNewPasswordInputElement.classList.add("is-invalid");
                        confirmNewPasswordInputElement.focus();
                        mismatchPasswordErrorMessageElement.style.display = "block";
                    }
                } else {
                    if (await PasswordConfirmation.currentPasswordIsValid(currentPassword)) {
                        console.log("PW valid");
                        changePasswordForm.submit();
                    } else {
                        console.log("PW invalid");
                        currentPasswordInputElement.classList.add("is-invalid");
                        incorrectPasswordErrorMessageElement.style.display = "block";
                        currentPasswordInputElement.focus();
                    }
                }
                if (newPasswordInputElementHasError) {
                    newPasswordInputElement.classList.add("is-invalid");
                }
                event.target.disabled = false;
            });
        });
    }

    static async currentPasswordIsValid(plaintext_password) {
        let bodyContent = {
            "user[current_password]": String(plaintext_password),
            "authenticity_token": document.querySelector("input[name='authenticity_token']").value
        }
        let res = await fetch("users/validate", {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Accept":       "application/json"
            },
            body: JSON.stringify(bodyContent)
        }).then(res => {
            return res;
        }).catch(error => {
            console.error(error);
        });
        if (res.status == 200) {
            console.log("Returning TRUE");
            return true;
        } else {
            console.log("Returning FALSE");
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
}