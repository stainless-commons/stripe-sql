SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_prices.create(currency := 'currency');

SELECT *
FROM stripe_prices.list()
LIMIT 42;