# README

To run SDE, follow these instructions...

1. Clone the repository into your local machine using "git clone [SSH link]". A folder called "settlement-done-easy" will be created. Navigate into that folder using the command "cd settlement-done-easy"

2. Run the following commands in this order
    1) bundle install
    2) yarn install
    3) yarn add bootstrap jquery popper.js
    4) yarn add bootswatch
    5) yarn add autosize
    6) sudo service postgresql start
    7) rails db:migrate:reset db:seed
    8) rails server

3. Configure the config/appsettings.yml file with DocuSign & Stripe account data. An account with DocuSign and Stripe are required to run Settlement Done Easy.

4. Open a browser. In your URL field, type "localhost:3000" and press enter. The page should load for a while then show the application.

5. You're set up! :)
