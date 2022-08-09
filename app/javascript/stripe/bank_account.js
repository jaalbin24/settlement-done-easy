const stripe = Stripe('pk_test_51KvBlgLjpnfKvSk6FTI71JbrjyOt2JiMNLhUqKR9dJDt4CvnhudKy1yP5zztbuLxsOKSQb9sBhvRLl5qGKpdWxJl00sjgbjMEp');

document.addEventListener("DOMContentLoaded", function () {
    const add_bank_account_button = document.getElementById('add_bank_account');

    add_bank_account_button.addEventListener("click", async function () {

        const secret = await fetch('/bank_account_secret').then(res => {
            return res.json();
        }).then( obj => {
            console.log(obj);
            return String(obj.client_secret);
        }).catch( error => {
            console.error(error);
        });

        stripe.collectBankAccountToken({
            clientSecret: secret
        }).then(function(result) {
            console.log(result);
            if (result.error) {
                // Inform your user that there was an error.
                console.log(result.error.message);
            } else {
                if(result.token) {
                   
                    // POST bank_account to SDE server
                    let authToken = String(document.getElementsByName("authenticity_token")[0].getAttribute("value"));
                    let bankToken = String(result.token.id);

                    fetch("/bank_account", {
                        method: "POST",
                        headers: {'Content-Type': 'application/json'}, 
                        body: JSON.stringify({authenticity_token: authToken, bank_token: bankToken, client_secret: secret})
                    }).then(res => {
                        console.log("Request complete! response:", res);
                        location.reload();
                    }); 
                }
            }
        });
    })
});
