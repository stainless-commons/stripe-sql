SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_coupons.create();

SELECT *
FROM stripe_coupons.list()
LIMIT 42;