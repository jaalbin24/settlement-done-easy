# README

Settlement Done Easy (SDE) is a settlement mediator between law firms and insurance companies designed to make processing settlements easier and faster by processing documents and associated settlement proceeds electronically.

SDE facilitates the exchange of the electronically signed release documents for an ACH settlement e-check deposited instantly in the law firm’s escrow account. The electronic payment of settlement the SDE is permitted by all State Bar Associations in the U.S.,
though some states, do have specific requirements.

For Law Firms:
SDE shortens the time to conclude a settlement with ACH e-checks deposited into a law firms escrow account from days or weeks to minutes. After the first such ACH transfer, monies clear the bank in 2 business days. (First ACH Transfer can take
up to 7 business days to clear.) A settlement concluded through SDE on a Tuesday could be disbursed to a client the same week.

For Insurance Companies:
SDE allows adjusters to resolve claims and transmit e-checks remotely, from any-where they have internet access. No more lost/delayed checks, FedEx overnight charges, or calls from angry lawyers looking for settlement checks. SDE does all this at a rate cheaper and faster than the carrier’s postage/FedEx budget.

---

This app requires postgresql, so you should already have it installed on your machine.

Run the following commands in this order from the parent directory:

<code>bundle install</code>

<code>yarn install</code>

<code>rails db:migrate:reset db:seed</code>

Then, run SDE locally with foreman using the following command:
<code>foreman start -f Procfile.dev</code>

This will run the rails server, the redis server, and the SideKiq process simultaneously. You should be able to go to <code>localhost:3000</code> and find the app there.
