ALTER TYPE stripe_prices.price
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE active BOOLEAN,
  ADD ATTRIBUTE billing_scheme TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE product JSONB,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE currency_options JSONB,
  ADD ATTRIBUTE custom_unit_amount stripe_prices.price_custom_unit_amount,
  ADD ATTRIBUTE lookup_key TEXT,
  ADD ATTRIBUTE nickname TEXT,
  ADD ATTRIBUTE recurring stripe_prices.price_recurring,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE tiers stripe_prices.price_tier[],
  ADD ATTRIBUTE tiers_mode TEXT,
  ADD ATTRIBUTE transform_quantity stripe_prices.price_transform_quantity,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_price(
  id TEXT,
  active BOOLEAN,
  billing_scheme TEXT,
  created BIGINT,
  currency TEXT,
  livemode BOOLEAN,
  metadata JSONB,
  object TEXT,
  product JSONB,
  type TEXT,
  currency_options JSONB DEFAULT NULL,
  custom_unit_amount stripe_prices.price_custom_unit_amount DEFAULT NULL,
  lookup_key TEXT DEFAULT NULL,
  nickname TEXT DEFAULT NULL,
  recurring stripe_prices.price_recurring DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  tiers stripe_prices.price_tier[] DEFAULT NULL,
  tiers_mode TEXT DEFAULT NULL,
  transform_quantity stripe_prices.price_transform_quantity DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_prices.price
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    active,
    billing_scheme,
    created,
    currency,
    livemode,
    metadata,
    object,
    product,
    type,
    currency_options,
    custom_unit_amount,
    lookup_key,
    nickname,
    recurring,
    tax_behavior,
    tiers,
    tiers_mode,
    transform_quantity,
    unit_amount,
    unit_amount_decimal
  )::stripe_prices.price;
$$;

ALTER TYPE stripe_prices.price_custom_unit_amount
  ADD ATTRIBUTE maximum BIGINT,
  ADD ATTRIBUTE minimum BIGINT,
  ADD ATTRIBUTE preset BIGINT;

CREATE OR REPLACE FUNCTION stripe_prices.make_price_custom_unit_amount(
  maximum BIGINT DEFAULT NULL,
  minimum BIGINT DEFAULT NULL,
  preset BIGINT DEFAULT NULL
)
RETURNS stripe_prices.price_custom_unit_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(maximum, minimum, preset)::stripe_prices.price_custom_unit_amount;
$$;

ALTER TYPE stripe_prices.price_recurring
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE interval_count BIGINT,
  ADD ATTRIBUTE usage_type TEXT,
  ADD ATTRIBUTE meter TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_price_recurring(
  "interval" TEXT,
  interval_count BIGINT,
  usage_type TEXT,
  meter TEXT DEFAULT NULL
)
RETURNS stripe_prices.price_recurring
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "interval", interval_count, usage_type, meter
  )::stripe_prices.price_recurring;
$$;

ALTER TYPE stripe_prices.price_tier
  ADD ATTRIBUTE flat_amount BIGINT,
  ADD ATTRIBUTE flat_amount_decimal TEXT,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT,
  ADD ATTRIBUTE up_to BIGINT;

CREATE OR REPLACE FUNCTION stripe_prices.make_price_tier(
  flat_amount BIGINT DEFAULT NULL,
  flat_amount_decimal TEXT DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL,
  up_to BIGINT DEFAULT NULL
)
RETURNS stripe_prices.price_tier
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    flat_amount, flat_amount_decimal, unit_amount, unit_amount_decimal, up_to
  )::stripe_prices.price_tier;
$$;

ALTER TYPE stripe_prices.price_transform_quantity
  ADD ATTRIBUTE divide_by BIGINT, ADD ATTRIBUTE round TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_price_transform_quantity(
  divide_by BIGINT, round TEXT
)
RETURNS stripe_prices.price_transform_quantity
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(divide_by, round)::stripe_prices.price_transform_quantity;
$$;

ALTER TYPE stripe_prices.custom_unit_amount
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE maximum BIGINT,
  ADD ATTRIBUTE minimum BIGINT,
  ADD ATTRIBUTE preset BIGINT;

CREATE OR REPLACE FUNCTION stripe_prices.make_custom_unit_amount(
  enabled BOOLEAN,
  maximum BIGINT DEFAULT NULL,
  minimum BIGINT DEFAULT NULL,
  preset BIGINT DEFAULT NULL
)
RETURNS stripe_prices.custom_unit_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, maximum, minimum, preset
  )::stripe_prices.custom_unit_amount;
$$;

ALTER TYPE stripe_prices.product_data
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE active BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE tax_code TEXT,
  ADD ATTRIBUTE unit_label TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_product_data(
  name TEXT,
  id TEXT DEFAULT NULL,
  active BOOLEAN DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  unit_label TEXT DEFAULT NULL
)
RETURNS stripe_prices.product_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    name, id, active, metadata, statement_descriptor, tax_code, unit_label
  )::stripe_prices.product_data;
$$;

ALTER TYPE stripe_prices.recurring
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE interval_count BIGINT,
  ADD ATTRIBUTE meter TEXT,
  ADD ATTRIBUTE usage_type TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_recurring(
  "interval" TEXT,
  interval_count BIGINT DEFAULT NULL,
  meter TEXT DEFAULT NULL,
  usage_type TEXT DEFAULT NULL
)
RETURNS stripe_prices.recurring
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "interval", interval_count, meter, usage_type
  )::stripe_prices.recurring;
$$;

ALTER TYPE stripe_prices.tier
  ADD ATTRIBUTE up_to JSONB,
  ADD ATTRIBUTE flat_amount BIGINT,
  ADD ATTRIBUTE flat_amount_decimal TEXT,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_tier(
  up_to JSONB,
  flat_amount BIGINT DEFAULT NULL,
  flat_amount_decimal TEXT DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_prices.tier
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    up_to, flat_amount, flat_amount_decimal, unit_amount, unit_amount_decimal
  )::stripe_prices.tier;
$$;

ALTER TYPE stripe_prices.transform_quantity
  ADD ATTRIBUTE divide_by BIGINT, ADD ATTRIBUTE round TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_transform_quantity(
  divide_by BIGINT, round TEXT
)
RETURNS stripe_prices.transform_quantity
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(divide_by, round)::stripe_prices.transform_quantity;
$$;

ALTER TYPE stripe_prices.recurring1
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE meter TEXT,
  ADD ATTRIBUTE usage_type TEXT;

CREATE OR REPLACE FUNCTION stripe_prices.make_recurring1(
  "interval" TEXT DEFAULT NULL,
  meter TEXT DEFAULT NULL,
  usage_type TEXT DEFAULT NULL
)
RETURNS stripe_prices.recurring1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("interval", meter, usage_type)::stripe_prices.recurring1;
$$;

CREATE OR REPLACE FUNCTION stripe_prices._create(
  currency TEXT,
  active BOOLEAN DEFAULT NULL,
  billing_scheme TEXT DEFAULT NULL,
  currency_options JSONB DEFAULT NULL,
  custom_unit_amount stripe_prices.custom_unit_amount DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  lookup_key TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  nickname TEXT DEFAULT NULL,
  product TEXT DEFAULT NULL,
  product_data stripe_prices.product_data DEFAULT NULL,
  recurring stripe_prices.recurring DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  tiers stripe_prices.tier[] DEFAULT NULL,
  tiers_mode TEXT DEFAULT NULL,
  transfer_lookup_key BOOLEAN DEFAULT NULL,
  transform_quantity stripe_prices.transform_quantity DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stainless_commons_stripe._types import not_given

  response = GD["__stripe_context__"].client.prices.with_raw_response.create(
      currency=currency,
      active=not_given if active is None else active,
      billing_scheme=not_given if billing_scheme is None else billing_scheme,
      currency_options=not_given if currency_options is None else json.loads(currency_options),
      custom_unit_amount=not_given if custom_unit_amount is None else GD["__stripe_context__"].strip_none(custom_unit_amount),
      expand=not_given if expand is None else expand,
      lookup_key=not_given if lookup_key is None else lookup_key,
      metadata=not_given if metadata is None else json.loads(metadata),
      nickname=not_given if nickname is None else nickname,
      product=not_given if product is None else product,
      product_data=not_given if product_data is None else GD["__stripe_context__"].strip_none(product_data),
      recurring=not_given if recurring is None else GD["__stripe_context__"].strip_none(recurring),
      tax_behavior=not_given if tax_behavior is None else tax_behavior,
      tiers=not_given if tiers is None else GD["__stripe_context__"].strip_none(tiers),
      tiers_mode=not_given if tiers_mode is None else tiers_mode,
      transfer_lookup_key=not_given if transfer_lookup_key is None else transfer_lookup_key,
      transform_quantity=not_given if transform_quantity is None else GD["__stripe_context__"].strip_none(transform_quantity),
      unit_amount=not_given if unit_amount is None else unit_amount,
      unit_amount_decimal=not_given if unit_amount_decimal is None else unit_amount_decimal,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_prices.create(
  currency TEXT,
  active BOOLEAN DEFAULT NULL,
  billing_scheme TEXT DEFAULT NULL,
  currency_options JSONB DEFAULT NULL,
  custom_unit_amount stripe_prices.custom_unit_amount DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  lookup_key TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  nickname TEXT DEFAULT NULL,
  product TEXT DEFAULT NULL,
  product_data stripe_prices.product_data DEFAULT NULL,
  recurring stripe_prices.recurring DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  tiers stripe_prices.tier[] DEFAULT NULL,
  tiers_mode TEXT DEFAULT NULL,
  transfer_lookup_key BOOLEAN DEFAULT NULL,
  transform_quantity stripe_prices.transform_quantity DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_prices.price
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_prices.price,
      stripe_prices._create(
        currency,
        active,
        billing_scheme,
        currency_options,
        custom_unit_amount,
        expand,
        lookup_key,
        metadata,
        nickname,
        product,
        product_data,
        recurring,
        tax_behavior,
        tiers,
        tiers_mode,
        transfer_lookup_key,
        transform_quantity,
        unit_amount,
        unit_amount_decimal
      )
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_prices._list_first_page_py(
  active BOOLEAN DEFAULT NULL,
  created JSONB DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  lookup_keys TEXT[] DEFAULT NULL,
  product TEXT DEFAULT NULL,
  recurring stripe_prices.recurring1 DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe._types import not_given
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client.prices.list(
      active=not_given if active is None else active,
      created=not_given if created is None else json.loads(created),
      currency=not_given if currency is None else currency,
      ending_before=not_given if ending_before is None else ending_before,
      expand=not_given if expand is None else expand,
      limit=not_given if limit is None else limit,
      lookup_keys=not_given if lookup_keys is None else lookup_keys,
      product=not_given if product is None else product,
      recurring=not_given if recurring is None else GD["__stripe_context__"].strip_none(recurring),
      starting_after=not_given if starting_after is None else starting_after,
      type=not_given if type is None else type,
  )
  next_page_info = page.next_page_info()
  if next_page_info is None:
      next_request_options = None
  else:
      next_request_options = page._info_to_options(next_page_info).model_dump_json(
        exclude_unset=True,
        exclude={'post_parser'}
      )

  # We convert to JSON instead of letting PL/Python perform data mapping because PL/Python errors for
  # omitted fields instead of defaulting them to NULL, but we want to be more lenient, which we handle
  # in the calling function later.
  type_adapter = TypeAdapter(Any)
  return (
    type_adapter.dump_json(page._get_page_items(), exclude_unset=True).decode("utf-8"),
    next_request_options
  )
$$;

-- A simpler wrapper around `stripe_prices._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_prices._list_first_page(
  active BOOLEAN DEFAULT NULL,
  created JSONB DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  lookup_keys TEXT[] DEFAULT NULL,
  product TEXT DEFAULT NULL,
  recurring stripe_prices.recurring1 DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN stripe_prices._list_first_page_py(
      active,
      created,
      currency,
      ending_before,
      expand,
      "limit",
      lookup_keys,
      product,
      recurring,
      starting_after,
      type
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_prices._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe.types import Price
  from stainless_commons_stripe.pagination import SyncMyCursorIDPage
  from stainless_commons_stripe._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client._request_api_list(
    model=Price,
    page=SyncMyCursorIDPage[Price],
    options=FinalRequestOptions.construct(**json.loads(request_options))
  )
  next_page_info = page.next_page_info()
  if next_page_info is None:
      next_request_options = None
  else:
      next_request_options = page._info_to_options(next_page_info).model_dump_json(
        exclude_unset=True,
        exclude={'post_parser'}
      )

  # We convert to JSON instead of letting PL/Python perform data mapping because PL/Python errors for
  # omitted fields instead of defaulting them to NULL, but we want to be more lenient, which we handle
  # in the calling function later.
  type_adapter = TypeAdapter(Any)
  return (
    type_adapter.dump_json(page._get_page_items(), exclude_unset=True).decode("utf-8"),
    next_request_options
  )
$$;

CREATE OR REPLACE FUNCTION stripe_prices.list(
  active BOOLEAN DEFAULT NULL,
  created JSONB DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  lookup_keys TEXT[] DEFAULT NULL,
  product TEXT DEFAULT NULL,
  recurring stripe_prices.recurring1 DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS SETOF stripe_prices.price
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_prices._list_first_page(
      active,
      created,
      currency,
      ending_before,
      expand,
      "limit",
      lookup_keys,
      product,
      recurring,
      starting_after,
      type
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_prices._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_prices.price, data)).* FROM paginated;
$$;