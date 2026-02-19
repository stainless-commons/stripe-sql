ALTER TYPE stripe_products.product
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE active BOOLEAN,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE images TEXT[],
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE marketing_features stripe_products.product_marketing_feature[],
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE updated BIGINT,
  ADD ATTRIBUTE default_price JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE package_dimensions stripe_products.product_package_dimension,
  ADD ATTRIBUTE shippable BOOLEAN,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE tax_code JSONB,
  ADD ATTRIBUTE unit_label TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_products.make_product(
  id TEXT,
  active BOOLEAN,
  created BIGINT,
  images TEXT[],
  livemode BOOLEAN,
  marketing_features stripe_products.product_marketing_feature[],
  metadata JSONB,
  name TEXT,
  object TEXT,
  updated BIGINT,
  default_price JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  package_dimensions stripe_products.product_package_dimension DEFAULT NULL,
  shippable BOOLEAN DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  tax_code JSONB DEFAULT NULL,
  unit_label TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_products.product
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    active,
    created,
    images,
    livemode,
    marketing_features,
    metadata,
    name,
    object,
    updated,
    default_price,
    description,
    package_dimensions,
    shippable,
    statement_descriptor,
    tax_code,
    unit_label,
    url
  )::stripe_products.product;
$$;

ALTER TYPE stripe_products.product_marketing_feature
  ADD ATTRIBUTE name TEXT;

CREATE OR REPLACE FUNCTION stripe_products.make_product_marketing_feature(
  name TEXT DEFAULT NULL
)
RETURNS stripe_products.product_marketing_feature
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(name)::stripe_products.product_marketing_feature;
$$;

ALTER TYPE stripe_products.product_package_dimension
  ADD ATTRIBUTE height DOUBLE PRECISION,
  ADD ATTRIBUTE length DOUBLE PRECISION,
  ADD ATTRIBUTE weight DOUBLE PRECISION,
  ADD ATTRIBUTE width DOUBLE PRECISION;

CREATE OR REPLACE FUNCTION stripe_products.make_product_package_dimension(
  height DOUBLE PRECISION,
  length DOUBLE PRECISION,
  weight DOUBLE PRECISION,
  width DOUBLE PRECISION
)
RETURNS stripe_products.product_package_dimension
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    height, length, weight, width
  )::stripe_products.product_package_dimension;
$$;

ALTER TYPE stripe_products.default_price_data
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE currency_options JSONB,
  ADD ATTRIBUTE custom_unit_amount stripe_products.default_price_data_custom_unit_amount,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE recurring stripe_products.default_price_data_recurring,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_products.make_default_price_data(
  currency TEXT,
  currency_options JSONB DEFAULT NULL,
  custom_unit_amount stripe_products.default_price_data_custom_unit_amount DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  recurring stripe_products.default_price_data_recurring DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_products.default_price_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency,
    currency_options,
    custom_unit_amount,
    metadata,
    recurring,
    tax_behavior,
    unit_amount,
    unit_amount_decimal
  )::stripe_products.default_price_data;
$$;

ALTER TYPE stripe_products.default_price_data_custom_unit_amount
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE maximum BIGINT,
  ADD ATTRIBUTE minimum BIGINT,
  ADD ATTRIBUTE preset BIGINT;

CREATE OR REPLACE FUNCTION stripe_products.make_default_price_data_custom_unit_amount(
  enabled BOOLEAN,
  maximum BIGINT DEFAULT NULL,
  minimum BIGINT DEFAULT NULL,
  preset BIGINT DEFAULT NULL
)
RETURNS stripe_products.default_price_data_custom_unit_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, maximum, minimum, preset
  )::stripe_products.default_price_data_custom_unit_amount;
$$;

ALTER TYPE stripe_products.default_price_data_recurring
  ADD ATTRIBUTE "interval" TEXT, ADD ATTRIBUTE interval_count BIGINT;

CREATE OR REPLACE FUNCTION stripe_products.make_default_price_data_recurring(
  "interval" TEXT, interval_count BIGINT DEFAULT NULL
)
RETURNS stripe_products.default_price_data_recurring
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "interval", interval_count
  )::stripe_products.default_price_data_recurring;
$$;

ALTER TYPE stripe_products.marketing_feature
  ADD ATTRIBUTE name TEXT;

CREATE OR REPLACE FUNCTION stripe_products.make_marketing_feature(name TEXT)
RETURNS stripe_products.marketing_feature
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(name)::stripe_products.marketing_feature;
$$;

ALTER TYPE stripe_products.package_dimension
  ADD ATTRIBUTE height DOUBLE PRECISION,
  ADD ATTRIBUTE length DOUBLE PRECISION,
  ADD ATTRIBUTE weight DOUBLE PRECISION,
  ADD ATTRIBUTE width DOUBLE PRECISION;

CREATE OR REPLACE FUNCTION stripe_products.make_package_dimension(
  height DOUBLE PRECISION,
  length DOUBLE PRECISION,
  weight DOUBLE PRECISION,
  width DOUBLE PRECISION
)
RETURNS stripe_products.package_dimension
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(height, length, weight, width)::stripe_products.package_dimension;
$$;

CREATE OR REPLACE FUNCTION stripe_products._create(
  name TEXT,
  id TEXT DEFAULT NULL,
  active BOOLEAN DEFAULT NULL,
  default_price_data stripe_products.default_price_data DEFAULT NULL,
  description TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  images TEXT[] DEFAULT NULL,
  marketing_features stripe_products.marketing_feature[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  package_dimensions stripe_products.package_dimension DEFAULT NULL,
  shippable BOOLEAN DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  unit_label TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stainless_commons_stripe._types import not_given

  response = GD["__stripe_context__"].client.products.with_raw_response.create(
      name=name,
      id=not_given if id is None else id,
      active=not_given if active is None else active,
      default_price_data=not_given if default_price_data is None else GD["__stripe_context__"].strip_none(default_price_data),
      description=not_given if description is None else description,
      expand=not_given if expand is None else expand,
      images=not_given if images is None else images,
      marketing_features=not_given if marketing_features is None else GD["__stripe_context__"].strip_none(marketing_features),
      metadata=not_given if metadata is None else json.loads(metadata),
      package_dimensions=not_given if package_dimensions is None else GD["__stripe_context__"].strip_none(package_dimensions),
      shippable=not_given if shippable is None else shippable,
      statement_descriptor=not_given if statement_descriptor is None else statement_descriptor,
      tax_code=not_given if tax_code is None else tax_code,
      unit_label=not_given if unit_label is None else unit_label,
      url=not_given if url is None else url,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_products.create(
  name TEXT,
  id TEXT DEFAULT NULL,
  active BOOLEAN DEFAULT NULL,
  default_price_data stripe_products.default_price_data DEFAULT NULL,
  description TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  images TEXT[] DEFAULT NULL,
  marketing_features stripe_products.marketing_feature[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  package_dimensions stripe_products.package_dimension DEFAULT NULL,
  shippable BOOLEAN DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  unit_label TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_products.product
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_products.product,
      stripe_products._create(
        name,
        id,
        active,
        default_price_data,
        description,
        expand,
        images,
        marketing_features,
        metadata,
        package_dimensions,
        shippable,
        statement_descriptor,
        tax_code,
        unit_label,
        url
      )
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_products._list_first_page_py(
  active BOOLEAN DEFAULT NULL,
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  ids TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  shippable BOOLEAN DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe._types import not_given
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client.products.list(
      active=not_given if active is None else active,
      created=not_given if created is None else json.loads(created),
      ending_before=not_given if ending_before is None else ending_before,
      expand=not_given if expand is None else expand,
      ids=not_given if ids is None else ids,
      limit=not_given if limit is None else limit,
      shippable=not_given if shippable is None else shippable,
      starting_after=not_given if starting_after is None else starting_after,
      url=not_given if url is None else url,
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

-- A simpler wrapper around `stripe_products._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_products._list_first_page(
  active BOOLEAN DEFAULT NULL,
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  ids TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  shippable BOOLEAN DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN stripe_products._list_first_page_py(
      active,
      created,
      ending_before,
      expand,
      ids,
      "limit",
      shippable,
      starting_after,
      url
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_products._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe.types import Product
  from stainless_commons_stripe.pagination import SyncMyCursorIDPage
  from stainless_commons_stripe._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client._request_api_list(
    model=Product,
    page=SyncMyCursorIDPage[Product],
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

CREATE OR REPLACE FUNCTION stripe_products.list(
  active BOOLEAN DEFAULT NULL,
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  ids TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  shippable BOOLEAN DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS SETOF stripe_products.product
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_products._list_first_page(
      active,
      created,
      ending_before,
      expand,
      ids,
      "limit",
      shippable,
      starting_after,
      url
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_products._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_products.product, data)).* FROM paginated;
$$;