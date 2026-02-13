SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_disputes.update(dispute := 'dispute');

SELECT *
FROM stripe_disputes.list()
LIMIT 42;