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
                        if (await PasswordConfirmation.passwordIsValid(currentPassword)) {
                            console.log("PW valid");
                            var currentPasswordField = document.createElement("input");
                            currentPasswordField.type = "hidden";
                            currentPasswordField.name = "user[current_password]";
                            currentPasswordField.value = currentPassword;
                            editUserForm.appendChild(currentPasswordField);
                            editUserForm.submit();
                        } else {
                            console.log("PW invalid");
                            var currentPasswordInputField = document.getElementById("user_current_password");
                            var incorrectPasswordErrorMessageElement = document.getElementsByName("incorrect-password-error-message")[0];
                            currentPasswordInputField.classList.add("is-invalid");
                            incorrectPasswordErrorMessageElement.style.display = "block";
                            currentPasswordInputField.focus();
                            document.getElementsByName("submit-edit-user-button")[0].disabled = false;
                        }
                        break;
                    }
                }
            });









            var changePasswordButton = document.getElementsByName("submit-change-password-button")[0];
            changePasswordButton.addEventListener("click", async event => {
                event.preventDefault();
                event.target.disabled = true;

                var changePasswordForm = document.getElementById("change-password-form");
                let currentPasswordInputElement = document.querySelector("input[id='change-password-current-password-field']");
                let currentPassword = currentPasswordInputElement.value;
                let newPasswordInputElement = document.querySelector("input[id='change-password-new-password-field']");
                let newPassword = newPasswordInputElement.value;
                let confirmNewPasswordInputElement = document.querySelector("input[id='change-password-password-confirmation-field']");
                let confirmNewPassword = confirmNewPasswordInputElement.value;
                if (newPassword != confirmNewPassword) {
                    var mismatchPasswordErrorMessageElement = document.getElementsByName("mismatch-password-error-message")[0];
                    confirmNewPasswordInputElement.classList.add("is-invalid");
                    confirmNewPasswordInputElement.focus();
                    mismatchPasswordErrorMessageElement.style.display = "block";
                    event.target.disabled = false;
                } else if (newPassword == "") {
                    var blankPasswordErrorMessageElement = document.getElementsByName("blank-password-error-message")[0];
                    newPasswordInputElement.classList.add("is-invalid");
                    newPasswordInputElement.focus();
                    blankPasswordErrorMessageElement.style.display = "block";
                    event.target.disabled = false;
                } else {
                    if (await PasswordConfirmation.passwordIsValid(currentPassword)) {
                        console.log("PW valid");
                        changePasswordForm.submit();
                    } else {
                        console.log("PW invalid");
                        var currentPasswordInputField = document.getElementById("user_current_password");
                        var incorrectPasswordErrorMessageElement = changePasswordForm.querySelector("div.invalid-feedback");
                        currentPasswordInputElement.classList.add("is-invalid");
                        incorrectPasswordErrorMessageElement.style.display = "block";
                        currentPasswordInputElement.focus();
                        event.target.disabled = false;    
                    }
                }
            });
        });
    }

    static async passwordIsValid(plaintext_password) {
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
}