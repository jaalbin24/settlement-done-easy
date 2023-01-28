const stripe_key = 'pk_test_51KvBlgLjpnfKvSk6FTI71JbrjyOt2JiMNLhUqKR9dJDt4CvnhudKy1yP5zztbuLxsOKSQb9sBhvRLl5qGKpdWxJl00sjgbjMEp';

document.addEventListener("DOMContentLoaded", () => {
    let stripePaymentElement = document.getElementById("stripe_payment_element");
    if (stripePaymentElement == null) {
        return;
    }
    let stripe = Stripe(
        stripe_key,
        {stripeAccount: stripePaymentElement.getAttribute("data-stripe-acct")}
    );
    var elements = stripe.elements({
        clientSecret: stripePaymentElement.getAttribute("data-secret"),
    });
    var paymentElement = elements.create('payment');
    paymentElement.mount("#stripe_payment_element");
    addressElement.mount("#stripe_payment_element");

    let returnURL = stripePaymentElement.getAttribute("data-return-url");

    let submitButton = document.getElementById("submit_elements_button");
    submitButton.addEventListener("click", () => {
        stripe.confirmSetup({
            elements,
            confirmParams: {
                // Return URL where the customer should be redirected after the SetupIntent is confirmed.
                return_url: returnURL,
            },
        }).then((result) => {
            if (result.error) {
                console.log(result.error);
                // Inform the customer that there was an error.
            }
        });
    });
});