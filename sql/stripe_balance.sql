ALTER TYPE stripe_balance.balance_amount
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE source_types stripe_balance.balance_amount_by_source_type;

CREATE OR REPLACE FUNCTION stripe_balance.make_balance_amount(
  amount BIGINT,
  currency TEXT,
  source_types stripe_balance.balance_amount_by_source_type DEFAULT NULL
)
RETURNS stripe_balance.balance_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(amount, currency, source_types)::stripe_balance.balance_amount;
$$;

ALTER TYPE stripe_balance.balance_amount_by_source_type
  ADD ATTRIBUTE bank_account BIGINT,
  ADD ATTRIBUTE card BIGINT,
  ADD ATTRIBUTE fpx BIGINT;

CREATE OR REPLACE FUNCTION stripe_balance.make_balance_amount_by_source_type(
  bank_account BIGINT DEFAULT NULL,
  card BIGINT DEFAULT NULL,
  fpx BIGINT DEFAULT NULL
)
RETURNS stripe_balance.balance_amount_by_source_type
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_account, card, fpx
  )::stripe_balance.balance_amount_by_source_type;
$$;

ALTER TYPE stripe_balance.balance_retrieve_response
  ADD ATTRIBUTE available stripe_balance.balance_amount[],
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE pending stripe_balance.balance_amount[],
  ADD ATTRIBUTE connect_reserved stripe_balance.balance_amount[],
  ADD ATTRIBUTE instant_available stripe_balance.balance_retrieve_response_instant_available[],
  ADD ATTRIBUTE issuing stripe_balance.balance_retrieve_response_issuing,
  ADD ATTRIBUTE refund_and_dispute_prefunding stripe_balance.balance_retrieve_response_refund_and_dispute_prefunding;

CREATE OR REPLACE FUNCTION stripe_balance.make_balance_retrieve_response(
  available stripe_balance.balance_amount[],
  livemode BOOLEAN,
  "object" TEXT,
  pending stripe_balance.balance_amount[],
  connect_reserved stripe_balance.balance_amount[] DEFAULT NULL,
  instant_available stripe_balance.balance_retrieve_response_instant_available[] DEFAULT NULL,
  issuing stripe_balance.balance_retrieve_response_issuing DEFAULT NULL,
  refund_and_dispute_prefunding stripe_balance.balance_retrieve_response_refund_and_dispute_prefunding DEFAULT NULL
)
RETURNS stripe_balance.balance_retrieve_response
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    available,
    livemode,
    "object",
    pending,
    connect_reserved,
    instant_available,
    issuing,
    refund_and_dispute_prefunding
  )::stripe_balance.balance_retrieve_response;
$$;

ALTER TYPE stripe_balance.balance_retrieve_response_instant_available
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE net_available stripe_balance.balance_retrieve_response_instant_available_net_available[],
  ADD ATTRIBUTE source_types stripe_balance.balance_amount_by_source_type;

CREATE OR REPLACE FUNCTION stripe_balance.make_balance_retrieve_response_instant_available(
  amount BIGINT,
  currency TEXT,
  net_available stripe_balance.balance_retrieve_response_instant_available_net_available[] DEFAULT NULL,
  source_types stripe_balance.balance_amount_by_source_type DEFAULT NULL
)
RETURNS stripe_balance.balance_retrieve_response_instant_available
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, currency, net_available, source_types
  )::stripe_balance.balance_retrieve_response_instant_available;
$$;

ALTER TYPE stripe_balance.balance_retrieve_response_instant_available_net_available
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE destination TEXT,
  ADD ATTRIBUTE source_types stripe_balance.balance_amount_by_source_type;

CREATE OR REPLACE FUNCTION stripe_balance.make_balance_retrieve_response_instant_available_net_available(
  amount BIGINT,
  destination TEXT,
  source_types stripe_balance.balance_amount_by_source_type DEFAULT NULL
)
RETURNS stripe_balance.balance_retrieve_response_instant_available_net_available
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, destination, source_types
  )::stripe_balance.balance_retrieve_response_instant_available_net_available;
$$;

ALTER TYPE stripe_balance.balance_retrieve_response_issuing
  ADD ATTRIBUTE available stripe_balance.balance_amount[];

CREATE OR REPLACE FUNCTION stripe_balance.make_balance_retrieve_response_issuing(
  available stripe_balance.balance_amount[]
)
RETURNS stripe_balance.balance_retrieve_response_issuing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(available)::stripe_balance.balance_retrieve_response_issuing;
$$;

ALTER TYPE stripe_balance.balance_retrieve_response_refund_and_dispute_prefunding
  ADD ATTRIBUTE available stripe_balance.balance_amount[],
  ADD ATTRIBUTE pending stripe_balance.balance_amount[];

CREATE OR REPLACE FUNCTION stripe_balance.make_balance_retrieve_response_refund_and_dispute_prefunding(
  available stripe_balance.balance_amount[],
  pending stripe_balance.balance_amount[]
)
RETURNS stripe_balance.balance_retrieve_response_refund_and_dispute_prefunding
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    available, pending
  )::stripe_balance.balance_retrieve_response_refund_and_dispute_prefunding;
$$;

CREATE OR REPLACE FUNCTION stripe_balance._retrieve(expand TEXT[] DEFAULT NULL)
RETURNS JSONB
LANGUAGE plpython3u
STABLE
AS $$
  from stainless_commons_stripe._types import not_given

  response = GD["__stripe_context__"].client.balance.with_raw_response.retrieve(
      expand=not_given if expand is None else expand,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_balance.retrieve(expand TEXT[] DEFAULT NULL)
RETURNS stripe_balance.balance_retrieve_response
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_balance.balance_retrieve_response,
      stripe_balance._retrieve(expand)
    );
  END;
$$;