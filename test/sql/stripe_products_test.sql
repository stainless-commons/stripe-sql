SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_products.create(name := 'name');

SELECT *
FROM stripe_products.list()
LIMIT 42;