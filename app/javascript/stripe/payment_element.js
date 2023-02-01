import FormErrorStyling from "../packs/form_error_styling";

const stripe_key = 'pk_test_51KvBlgLjpnfKvSk6FTI71JbrjyOt2JiMNLhUqKR9dJDt4CvnhudKy1yP5zztbuLxsOKSQb9sBhvRLl5qGKpdWxJl00sjgbjMEp';


document.addEventListener("DOMContentLoaded", () => {
    let newBankAccountForm = document.getElementById("new_bank_account_form");
    let stripe = Stripe(stripe_key);
    if (newBankAccountForm != null) {
        let submitButton = newBankAccountForm.querySelector("input.btn-primary[type='submit']");
        let routingNumberField = newBankAccountForm.querySelector("input[name='routing_number']");
        let accountNumberField = newBankAccountForm.querySelector("input[name='account_number']");
        let submissionURL = newBankAccountForm.action;
        submitButton.addEventListener("click", async (e) => {
            FormErrorStyling.removeAllErrorsFromForm(newBankAccountForm);
            e.preventDefault();
            let inputs = newBankAccountForm.querySelectorAll("input.form-control");
            for (const input of inputs) {
                if (input.value) {
                    if (input.name == "account_number_confirmation") {
                        if (input.value != accountNumberField.value) {
                            FormErrorStyling.styleInputAsInvalid(input, "The account numbers don't match");
                        }
                    } else if (isNaN(input.value)) {
                        FormErrorStyling.styleInputAsInvalid(input, `This is not a valid ${input.name.replace("_", " ")}`);
                    }
                } else {
                    FormErrorStyling.styleInputAsInvalid(input, "This field can't be blank");
                }
            }
            console.log("Payment Element");
            if (newBankAccountForm.querySelector(".is-invalid") != null) {
                return;
            }
            let result = await stripe.createToken('bank_account', {
                country: 'US',
                currency: 'usd',
                routing_number: routingNumberField.value,
                account_number: accountNumberField.value,
                account_holder_type: 'company',
            }).then((result) => {
                console.log(result);
                return result;
                // Handle result.error or result.token
            });
            if (result.error) {
                if (result.error.code == "account_number_invalid") {
                    FormErrorStyling.styleInputAsInvalid(accountNumberField, "This is not a valid account number");
                } else if (result.error.code == "routing_number_invalid") {
                    FormErrorStyling.styleInputAsInvalid(routingNumberField, "This is not a valid routing number");
                }
            } else if (result.token) {
                let submittableForm = document.createElement("form");
                let tokenField = document.createElement("input");
                tokenField.type = "hidden";
                tokenField.name = "token";
                tokenField.value = result.token.id;
                let authenticityTokenField = document.createElement("input");
                authenticityTokenField.type = "hidden";
                authenticityTokenField.name = "authenticity_token";
                authenticityTokenField.value = document.querySelector("input[type='hidden'][name='authenticity_token']").value;
                submittableForm.appendChild(authenticityTokenField);
                if (document.querySelector("#continue_path_button") != null) {
                    let continueField = document.createElement("input");
                    continueField.type = "hidden";
                    continueField.name = "continue_path";
                    continueField.value = document.querySelector("#continue_path_button").getAttribute("href");
                    submittableForm.appendChild(continueField);
                }
                submittableForm.appendChild(tokenField);
                cloneAttributes(submittableForm, newBankAccountForm);
                submittableForm.style.display = "none";
                // let inputs = newBankAccountForm.querySelectorAll("input.form-control[type='text']");
                // newBankAccountForm.style.display = "none";
                // for(const input of inputs) {
                //     input.remove();
                // }
                document.querySelector("div").appendChild(submittableForm);
                submittableForm.submit();
            }
        });
    } else {
        return;
    }
});

function cloneAttributes(target, source) {
    [...source.attributes].forEach( attr => { target.setAttribute(attr.nodeName === "id" ? 'data-id' : attr.nodeName ,attr.nodeValue) })
}