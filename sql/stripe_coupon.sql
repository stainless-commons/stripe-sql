ALTER TYPE stripe_coupon.coupon
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE duration TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE times_redeemed BIGINT,
  ADD ATTRIBUTE "valid" BOOLEAN,
  ADD ATTRIBUTE amount_off BIGINT,
  ADD ATTRIBUTE applies_to stripe_coupon.coupon_applies_to,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE currency_options JSONB,
  ADD ATTRIBUTE duration_in_months BIGINT,
  ADD ATTRIBUTE max_redemptions BIGINT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE percent_off DOUBLE PRECISION,
  ADD ATTRIBUTE redeem_by BIGINT;

CREATE OR REPLACE FUNCTION stripe_coupon.make_coupon(
  "id" TEXT,
  created BIGINT,
  duration TEXT,
  livemode BOOLEAN,
  "object" TEXT,
  times_redeemed BIGINT,
  "valid" BOOLEAN,
  amount_off BIGINT DEFAULT NULL,
  applies_to stripe_coupon.coupon_applies_to DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  currency_options JSONB DEFAULT NULL,
  duration_in_months BIGINT DEFAULT NULL,
  max_redemptions BIGINT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  percent_off DOUBLE PRECISION DEFAULT NULL,
  redeem_by BIGINT DEFAULT NULL
)
RETURNS stripe_coupon.coupon
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    duration,
    livemode,
    "object",
    times_redeemed,
    "valid",
    amount_off,
    applies_to,
    currency,
    currency_options,
    duration_in_months,
    max_redemptions,
    metadata,
    "name",
    percent_off,
    redeem_by
  )::stripe_coupon.coupon;
$$;

ALTER TYPE stripe_coupon.coupon_applies_to
  ADD ATTRIBUTE products TEXT[];

CREATE OR REPLACE FUNCTION stripe_coupon.make_coupon_applies_to(products TEXT[])
RETURNS stripe_coupon.coupon_applies_to
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(products)::stripe_coupon.coupon_applies_to;
$$;

ALTER TYPE stripe_coupon.applies_to
  ADD ATTRIBUTE products TEXT[];

CREATE OR REPLACE FUNCTION stripe_coupon.make_applies_to(
  products TEXT[] DEFAULT NULL
)
RETURNS stripe_coupon.applies_to
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(products)::stripe_coupon.applies_to;
$$;

CREATE OR REPLACE FUNCTION stripe_coupon._create(
  "id" TEXT DEFAULT NULL,
  amount_off BIGINT DEFAULT NULL,
  applies_to stripe_coupon.applies_to DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  currency_options JSONB DEFAULT NULL,
  duration TEXT DEFAULT NULL,
  duration_in_months BIGINT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  max_redemptions BIGINT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  percent_off DOUBLE PRECISION DEFAULT NULL,
  redeem_by BIGINT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stripe_minimal._types import not_given

  response = GD["__stripe_context__"].client.coupons.with_raw_response.create(
      id=not_given if id is None else id,
      amount_off=not_given if amount_off is None else amount_off,
      applies_to=not_given if applies_to is None else GD["__stripe_context__"].strip_none(applies_to),
      currency=not_given if currency is None else currency,
      currency_options=not_given if currency_options is None else json.loads(currency_options),
      duration=not_given if duration is None else duration,
      duration_in_months=not_given if duration_in_months is None else duration_in_months,
      expand=not_given if expand is None else expand,
      max_redemptions=not_given if max_redemptions is None else max_redemptions,
      metadata=not_given if metadata is None else json.loads(metadata),
      name=not_given if name is None else name,
      percent_off=not_given if percent_off is None else percent_off,
      redeem_by=not_given if redeem_by is None else redeem_by,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_coupon.create(
  "id" TEXT DEFAULT NULL,
  amount_off BIGINT DEFAULT NULL,
  applies_to stripe_coupon.applies_to DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  currency_options JSONB DEFAULT NULL,
  duration TEXT DEFAULT NULL,
  duration_in_months BIGINT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  max_redemptions BIGINT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  percent_off DOUBLE PRECISION DEFAULT NULL,
  redeem_by BIGINT DEFAULT NULL
)
RETURNS stripe_coupon.coupon
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_coupon.coupon,
      stripe_coupon._create(
        "id",
        amount_off,
        applies_to,
        currency,
        currency_options,
        duration,
        duration_in_months,
        expand,
        max_redemptions,
        metadata,
        "name",
        percent_off,
        redeem_by
      )
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_coupon._list_first_page_py(
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal._types import not_given
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client.coupons.list(
      created=not_given if created is None else json.loads(created),
      ending_before=not_given if ending_before is None else ending_before,
      expand=not_given if expand is None else expand,
      limit=not_given if limit is None else limit,
      starting_after=not_given if starting_after is None else starting_after,
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

-- A simpler wrapper around `stripe_coupon._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_coupon._list_first_page(
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN stripe_coupon._list_first_page_py(
      created, ending_before, expand, "limit", starting_after
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_coupon._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal.types import Coupon
  from stripe_minimal.pagination import SyncMyCursorIDPage
  from stripe_minimal._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client._request_api_list(
    model=Coupon,
    page=SyncMyCursorIDPage[Coupon],
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

CREATE OR REPLACE FUNCTION stripe_coupon.list(
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL
)
RETURNS SETOF stripe_coupon.coupon
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_coupon._list_first_page(
      created, ending_before, expand, "limit", starting_after
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_coupon._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_coupon.coupon, "data")).* FROM paginated;
$$;