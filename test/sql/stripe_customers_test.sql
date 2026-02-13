SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_customers.create();

SELECT *
FROM stripe_customers.list()
LIMIT 42;