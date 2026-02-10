ALTER TYPE stripe_invoiceitem.invoiceitem_create_response
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE discountable BOOLEAN,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "period" stripe_invoiceitem.invoiceitem_create_response_period,
  ADD ATTRIBUTE proration BOOLEAN,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE invoice JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE net_amount BIGINT,
  ADD ATTRIBUTE parent stripe_invoiceitem.invoiceitem_create_response_parent,
  ADD ATTRIBUTE pricing stripe_invoiceitem.invoiceitem_create_response_pricing,
  ADD ATTRIBUTE proration_details stripe_invoiceitem.invoiceitem_create_response_proration_detail,
  ADD ATTRIBUTE tax_rates stripe_invoice.tax_rate[],
  ADD ATTRIBUTE test_clock JSONB;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_invoiceitem_create_response(
  "id" TEXT,
  amount BIGINT,
  currency TEXT,
  customer JSONB,
  "date" BIGINT,
  discountable BOOLEAN,
  livemode BOOLEAN,
  "object" TEXT,
  "period" stripe_invoiceitem.invoiceitem_create_response_period,
  proration BOOLEAN,
  quantity BIGINT,
  customer_account TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discounts JSONB[] DEFAULT NULL,
  invoice JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  net_amount BIGINT DEFAULT NULL,
  parent stripe_invoiceitem.invoiceitem_create_response_parent DEFAULT NULL,
  pricing stripe_invoiceitem.invoiceitem_create_response_pricing DEFAULT NULL,
  proration_details stripe_invoiceitem.invoiceitem_create_response_proration_detail DEFAULT NULL,
  tax_rates stripe_invoice.tax_rate[] DEFAULT NULL,
  test_clock JSONB DEFAULT NULL
)
RETURNS stripe_invoiceitem.invoiceitem_create_response
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    currency,
    customer,
    "date",
    discountable,
    livemode,
    "object",
    "period",
    proration,
    quantity,
    customer_account,
    description,
    discounts,
    invoice,
    metadata,
    net_amount,
    parent,
    pricing,
    proration_details,
    tax_rates,
    test_clock
  )::stripe_invoiceitem.invoiceitem_create_response;
$$;

ALTER TYPE stripe_invoiceitem.invoiceitem_create_response_period
  ADD ATTRIBUTE "end" BIGINT, ADD ATTRIBUTE "start" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_invoiceitem_create_response_period(
  "end" BIGINT, "start" BIGINT
)
RETURNS stripe_invoiceitem.invoiceitem_create_response_period
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "end", "start"
  )::stripe_invoiceitem.invoiceitem_create_response_period;
$$;

ALTER TYPE stripe_invoiceitem.invoiceitem_create_response_parent
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE subscription_details stripe_invoiceitem.invoiceitem_create_response_parent_subscription_detail;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_invoiceitem_create_response_parent(
  "type" TEXT,
  subscription_details stripe_invoiceitem.invoiceitem_create_response_parent_subscription_detail DEFAULT NULL
)
RETURNS stripe_invoiceitem.invoiceitem_create_response_parent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", subscription_details
  )::stripe_invoiceitem.invoiceitem_create_response_parent;
$$;

ALTER TYPE stripe_invoiceitem.invoiceitem_create_response_parent_subscription_detail
  ADD ATTRIBUTE "subscription" TEXT, ADD ATTRIBUTE subscription_item TEXT;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_invoiceitem_create_response_parent_subscription_detail(
  "subscription" TEXT, subscription_item TEXT DEFAULT NULL
)
RETURNS stripe_invoiceitem.invoiceitem_create_response_parent_subscription_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "subscription", subscription_item
  )::stripe_invoiceitem.invoiceitem_create_response_parent_subscription_detail;
$$;

ALTER TYPE stripe_invoiceitem.invoiceitem_create_response_pricing
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE price_details stripe_invoiceitem.invoiceitem_create_response_pricing_price_detail,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_invoiceitem_create_response_pricing(
  "type" TEXT,
  price_details stripe_invoiceitem.invoiceitem_create_response_pricing_price_detail DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_invoiceitem.invoiceitem_create_response_pricing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", price_details, unit_amount_decimal
  )::stripe_invoiceitem.invoiceitem_create_response_pricing;
$$;

ALTER TYPE stripe_invoiceitem.invoiceitem_create_response_pricing_price_detail
  ADD ATTRIBUTE price JSONB, ADD ATTRIBUTE product TEXT;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_invoiceitem_create_response_pricing_price_detail(
  price JSONB, product TEXT
)
RETURNS stripe_invoiceitem.invoiceitem_create_response_pricing_price_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    price, product
  )::stripe_invoiceitem.invoiceitem_create_response_pricing_price_detail;
$$;

ALTER TYPE stripe_invoiceitem.invoiceitem_create_response_proration_detail
  ADD ATTRIBUTE discount_amounts stripe_invoice.discounts_resource_discount_amount[];

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_invoiceitem_create_response_proration_detail(
  discount_amounts stripe_invoice.discounts_resource_discount_amount[]
)
RETURNS stripe_invoiceitem.invoiceitem_create_response_proration_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    discount_amounts
  )::stripe_invoiceitem.invoiceitem_create_response_proration_detail;
$$;

ALTER TYPE stripe_invoiceitem.period
  ADD ATTRIBUTE "end" BIGINT, ADD ATTRIBUTE "start" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_period(
  "end" BIGINT, "start" BIGINT
)
RETURNS stripe_invoiceitem.period
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("end", "start")::stripe_invoiceitem.period;
$$;

ALTER TYPE stripe_invoiceitem.price_data
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE product TEXT,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_price_data(
  currency TEXT,
  product TEXT,
  tax_behavior TEXT DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_invoiceitem.price_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, product, tax_behavior, unit_amount, unit_amount_decimal
  )::stripe_invoiceitem.price_data;
$$;

ALTER TYPE stripe_invoiceitem.pricing
  ADD ATTRIBUTE price TEXT;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.make_pricing(
  price TEXT DEFAULT NULL
)
RETURNS stripe_invoiceitem.pricing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(price)::stripe_invoiceitem.pricing;
$$;

CREATE OR REPLACE FUNCTION stripe_invoiceitem._create(
  amount BIGINT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discountable BOOLEAN DEFAULT NULL,
  discounts JSONB DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  invoice TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "period" stripe_invoiceitem.period DEFAULT NULL,
  price_data stripe_invoiceitem.price_data DEFAULT NULL,
  pricing stripe_invoiceitem.pricing DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  tax_rates TEXT[] DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stripe_minimal._types import not_given

  response = GD["__stripe_context__"].client.invoiceitems.with_raw_response.create(
      amount=not_given if amount is None else amount,
      currency=not_given if currency is None else currency,
      customer=not_given if customer is None else customer,
      customer_account=not_given if customer_account is None else customer_account,
      description=not_given if description is None else description,
      discountable=not_given if discountable is None else discountable,
      discounts=not_given if discounts is None else json.loads(discounts),
      expand=not_given if expand is None else expand,
      invoice=not_given if invoice is None else invoice,
      metadata=not_given if metadata is None else json.loads(metadata),
      period=not_given if period is None else GD["__stripe_context__"].strip_none(period),
      price_data=not_given if price_data is None else GD["__stripe_context__"].strip_none(price_data),
      pricing=not_given if pricing is None else GD["__stripe_context__"].strip_none(pricing),
      quantity=not_given if quantity is None else quantity,
      subscription=not_given if subscription is None else subscription,
      tax_behavior=not_given if tax_behavior is None else tax_behavior,
      tax_code=not_given if tax_code is None else tax_code,
      tax_rates=not_given if tax_rates is None else tax_rates,
      unit_amount_decimal=not_given if unit_amount_decimal is None else unit_amount_decimal,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_invoiceitem.create(
  amount BIGINT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discountable BOOLEAN DEFAULT NULL,
  discounts JSONB DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  invoice TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "period" stripe_invoiceitem.period DEFAULT NULL,
  price_data stripe_invoiceitem.price_data DEFAULT NULL,
  pricing stripe_invoiceitem.pricing DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  tax_rates TEXT[] DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_invoiceitem.invoiceitem_create_response
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_invoiceitem.invoiceitem_create_response,
      stripe_invoiceitem._create(
        amount,
        currency,
        customer,
        customer_account,
        description,
        discountable,
        discounts,
        expand,
        invoice,
        metadata,
        "period",
        price_data,
        pricing,
        quantity,
        "subscription",
        tax_behavior,
        tax_code,
        tax_rates,
        unit_amount_decimal
      )
    );
  END;
$$;