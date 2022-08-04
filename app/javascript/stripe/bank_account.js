const stripe = Stripe('pk_test_51KvBlgLjpnfKvSk6FTI71JbrjyOt2JiMNLhUqKR9dJDt4CvnhudKy1yP5zztbuLxsOKSQb9sBhvRLl5qGKpdWxJl00sjgbjMEp');
document.addEventListener("DOMContentLoaded", function () {

    secret = document.getElementById('payment-element').getAttribute('secret');
    
    stripe.collectBankAccountToken({
        clientSecret: secret
    }).then(function(result) {
        console.log(result);
        if (result.error) {
            // Inform your user that there was an error.
            console.log(result.error.message);
        } else {
            if(result.token) {
                console.log(result.token);
                // Create bank account from result.token
            }
            // Get Financial Connections accounts along with data from result.financialConnectionsSession.accounts you requested when creating FinancialConnectionsSession in Step 2.
            result.financialConnectionsSession.accounts
        }
    });
});
//////////////////////////////////////////////////////////////