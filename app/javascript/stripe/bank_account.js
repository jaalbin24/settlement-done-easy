var stripe = Stripe('pk_test_51KvBlgLjpnfKvSk6FTI71JbrjyOt2JiMNLhUqKR9dJDt4CvnhudKy1yP5zztbuLxsOKSQb9sBhvRLl5qGKpdWxJl00sjgbjMEp');

document.addEventListener("DOMContentLoaded", () => {
    const addBankAccountButton = document.getElementById('add-bank-account-button');
    const mandateModal = new bootstrap.Modal(document.getElementById('mandate-modal'));
    const mandateAcceptButton = document.getElementById('mandate-accept-button');

    


    addBankAccountButton.addEventListener("click", async (event) => {
        event.preventDefault();

        const response = await fetch('/bank_account_secret').then(res => {
            return res.json();
        }).then( obj => {
            console.log(obj);
            return obj;
        }).catch( error => {
            console.error(error);
        });

        const secret = response.client_secret;
        const connectAccountId = response.connect_account_id;
        stripe = Stripe(
            'pk_test_51KvBlgLjpnfKvSk6FTI71JbrjyOt2JiMNLhUqKR9dJDt4CvnhudKy1yP5zztbuLxsOKSQb9sBhvRLl5qGKpdWxJl00sjgbjMEp',
            {stripeAccount: connectAccountId}
        );

        const setupIntent = await stripe.collectBankAccountForSetup({
            clientSecret: secret,
            params: {
                payment_method_type: 'us_bank_account',
                payment_method_data: {
                    billing_details: {
                        name: "John Smith"
                    },
                },
            },
            expand: ['payment_method']
        }).then(({setupIntent, error}) => {
            console.log("THEN WHAT???");
            console.log("setupIntent=%O", setupIntent);
            console.log("error=%O", error);
            if (error != null) {
                console.error(error.message);
                // PaymentMethod collection failed for some reason.
            } else if (setupIntent.status === 'requires_payment_method') {
                console.log("REQUIRES PAYMENT METHOD");
                // Customer canceled the hosted verification modal. Present them with other
                // payment method type options.
            } else if (setupIntent.status === 'requires_confirmation') {
                console.log("REQUIRES CONFIRMATION");
                // We collected an account - possibly instantly verified, but possibly
                // manually-entered. Display payment method details and mandate text
                // to the customer and confirm the intent once they accept
                // the mandate.

                mandateModal.show();
                mandateAcceptButton.addEventListener("click", async (event) => {
                    event.preventDefault();

                    stripe.confirmUsBankAccountSetup(
                        secret,
                        {
                            payment_method: setupIntent.payment_method.id,
                        }
                    ).then((result) => {
                        if (result.error) {
                            // Inform the customer that there was an error.
                            console.log(result.error.message);
                            console.log("result=%O", result);
                        } else {
                            // Handle next step based on SetupIntent's status.
                        }
                    });
                });
            }
        });
        console.log("%O", setupIntent);
    });
});
