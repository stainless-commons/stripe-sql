SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_invoices.create();

SELECT *
FROM stripe_invoices.list()
LIMIT 42;

SELECT *
FROM stripe_invoices.finalize(invoice := 'invoice');