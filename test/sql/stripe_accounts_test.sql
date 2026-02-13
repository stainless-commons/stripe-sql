SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_accounts.retrieve();