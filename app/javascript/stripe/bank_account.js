const stripe_key = 'pk_test_51KvBlgLjpnfKvSk6FTI71JbrjyOt2JiMNLhUqKR9dJDt4CvnhudKy1yP5zztbuLxsOKSQb9sBhvRLl5qGKpdWxJl00sjgbjMEp';

document.addEventListener("DOMContentLoaded", async () => {
    let bankAccountForm = document.querySelector("#bank_account_form");
    if (bankAccountForm == null) {
        return;
    }
    let bankAccountSubmitButton = document.querySelector("#bank_account_submit_button");
    let response = await fetch(bankAccountForm.getAttribute("data-secret-path"), {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            "Accept":       "application/json"
        },
    }).then(res => {
        return res.json();
    }).catch(error => {
        console.error(error);
    });
    let stripe = Stripe(stripe_key, {stripeAccount: response.stripe_account});
    var elements = stripe.elements({
        clientSecret: response.secret,
    });
    let paymentElement = elements.create("payment");
    paymentElement.mount(bankAccountForm);

    bankAccountSubmitButton.addEventListener("click", () => {
        stripe.confirmSetup({
            elements,
            confirmParams: {
                return_url: response.continue_url,
            },
        }).then((result) => {
            if (result.error) {
                console.log(result);
                // Inform the customer that there was an error.
            }
        });
    });
});
