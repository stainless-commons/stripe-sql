SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_subscriptions.update(
  subscription_exposed_id := 'subscription_exposed_id'
);

SELECT *
FROM stripe_subscriptions.list()
LIMIT 42;

SELECT *
FROM stripe_subscriptions.cancel(
  subscription_exposed_id := 'subscription_exposed_id'
);