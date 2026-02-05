ALTER TYPE stripe_minimal_customer.bank_account
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE account JSONB,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE available_payout_methods TEXT[],
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE default_for_currency BOOLEAN,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE future_requirements stripe_minimal_customer.bank_account_future_requirement,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE requirements stripe_minimal_customer.bank_account_requirement,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_bank_account(
  "id" TEXT,
  country TEXT,
  currency TEXT,
  last4 TEXT,
  "object" TEXT,
  status TEXT,
  account JSONB DEFAULT NULL,
  account_holder_name TEXT DEFAULT NULL,
  account_holder_type TEXT DEFAULT NULL,
  account_type TEXT DEFAULT NULL,
  available_payout_methods TEXT[] DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  default_for_currency BOOLEAN DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  future_requirements stripe_minimal_customer.bank_account_future_requirement DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  requirements stripe_minimal_customer.bank_account_requirement DEFAULT NULL,
  routing_number TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    country,
    currency,
    last4,
    "object",
    status,
    account,
    account_holder_name,
    account_holder_type,
    account_type,
    available_payout_methods,
    bank_name,
    customer,
    default_for_currency,
    fingerprint,
    future_requirements,
    metadata,
    requirements,
    routing_number
  )::stripe_minimal_customer.bank_account;
$$;

ALTER TYPE stripe_minimal_customer.bank_account_future_requirement
  ADD ATTRIBUTE currently_due TEXT[],
  ADD ATTRIBUTE errors stripe_minimal.account_requirements_error[],
  ADD ATTRIBUTE past_due TEXT[],
  ADD ATTRIBUTE pending_verification TEXT[];

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_bank_account_future_requirement(
  currently_due TEXT[] DEFAULT NULL,
  errors stripe_minimal.account_requirements_error[] DEFAULT NULL,
  past_due TEXT[] DEFAULT NULL,
  pending_verification TEXT[] DEFAULT NULL
)
RETURNS stripe_minimal_customer.bank_account_future_requirement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currently_due, errors, past_due, pending_verification
  )::stripe_minimal_customer.bank_account_future_requirement;
$$;

ALTER TYPE stripe_minimal_customer.bank_account_requirement
  ADD ATTRIBUTE currently_due TEXT[],
  ADD ATTRIBUTE errors stripe_minimal.account_requirements_error[],
  ADD ATTRIBUTE past_due TEXT[],
  ADD ATTRIBUTE pending_verification TEXT[];

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_bank_account_requirement(
  currently_due TEXT[] DEFAULT NULL,
  errors stripe_minimal.account_requirements_error[] DEFAULT NULL,
  past_due TEXT[] DEFAULT NULL,
  pending_verification TEXT[] DEFAULT NULL
)
RETURNS stripe_minimal_customer.bank_account_requirement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currently_due, errors, past_due, pending_verification
  )::stripe_minimal_customer.bank_account_requirement;
$$;

ALTER TYPE stripe_minimal_customer.card
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE account JSONB,
  ADD ATTRIBUTE address_city TEXT,
  ADD ATTRIBUTE address_country TEXT,
  ADD ATTRIBUTE address_line1 TEXT,
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_line2 TEXT,
  ADD ATTRIBUTE address_state TEXT,
  ADD ATTRIBUTE address_zip TEXT,
  ADD ATTRIBUTE address_zip_check TEXT,
  ADD ATTRIBUTE allow_redisplay TEXT,
  ADD ATTRIBUTE available_payout_methods TEXT[],
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE cvc_check TEXT,
  ADD ATTRIBUTE default_for_currency BOOLEAN,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE iin TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE networks stripe_minimal_customer.card_network,
  ADD ATTRIBUTE regulated_status TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE tokenization_method TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_card(
  "id" TEXT,
  brand TEXT,
  exp_month BIGINT,
  exp_year BIGINT,
  funding TEXT,
  last4 TEXT,
  "object" TEXT,
  account JSONB DEFAULT NULL,
  address_city TEXT DEFAULT NULL,
  address_country TEXT DEFAULT NULL,
  address_line1 TEXT DEFAULT NULL,
  address_line1_check TEXT DEFAULT NULL,
  address_line2 TEXT DEFAULT NULL,
  address_state TEXT DEFAULT NULL,
  address_zip TEXT DEFAULT NULL,
  address_zip_check TEXT DEFAULT NULL,
  allow_redisplay TEXT DEFAULT NULL,
  available_payout_methods TEXT[] DEFAULT NULL,
  country TEXT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL,
  default_for_currency BOOLEAN DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  iin TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  networks stripe_minimal_customer.card_network DEFAULT NULL,
  regulated_status TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  tokenization_method TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    brand,
    exp_month,
    exp_year,
    funding,
    last4,
    "object",
    account,
    address_city,
    address_country,
    address_line1,
    address_line1_check,
    address_line2,
    address_state,
    address_zip,
    address_zip_check,
    allow_redisplay,
    available_payout_methods,
    country,
    currency,
    customer,
    cvc_check,
    default_for_currency,
    dynamic_last4,
    fingerprint,
    iin,
    metadata,
    "name",
    networks,
    regulated_status,
    status,
    tokenization_method
  )::stripe_minimal_customer.card;
$$;

ALTER TYPE stripe_minimal_customer.card_network
  ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_card_network(
  preferred TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.card_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(preferred)::stripe_minimal_customer.card_network;
$$;

ALTER TYPE stripe_minimal_customer.customer
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE address stripe_minimal.address,
  ADD ATTRIBUTE balance BIGINT,
  ADD ATTRIBUTE business_name TEXT,
  ADD ATTRIBUTE cash_balance stripe_minimal_customer.customer_cash_balance,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE default_source JSONB,
  ADD ATTRIBUTE delinquent BOOLEAN,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE discount JSONB,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE individual_name TEXT,
  ADD ATTRIBUTE invoice_credit_balance JSONB,
  ADD ATTRIBUTE invoice_prefix TEXT,
  ADD ATTRIBUTE invoice_settings JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE next_invoice_sequence BIGINT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE shipping stripe_minimal.shipping,
  ADD ATTRIBUTE sources stripe_minimal_customer.customer_source,
  ADD ATTRIBUTE subscriptions stripe_minimal_customer.customer_subscription,
  ADD ATTRIBUTE tax stripe_minimal_customer.customer_tax,
  ADD ATTRIBUTE tax_exempt TEXT,
  ADD ATTRIBUTE tax_ids stripe_minimal_customer.customer_tax_id,
  ADD ATTRIBUTE test_clock JSONB;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer(
  "id" TEXT,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  address stripe_minimal.address DEFAULT NULL,
  balance BIGINT DEFAULT NULL,
  business_name TEXT DEFAULT NULL,
  cash_balance stripe_minimal_customer.customer_cash_balance DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  default_source JSONB DEFAULT NULL,
  delinquent BOOLEAN DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discount JSONB DEFAULT NULL,
  email TEXT DEFAULT NULL,
  individual_name TEXT DEFAULT NULL,
  invoice_credit_balance JSONB DEFAULT NULL,
  invoice_prefix TEXT DEFAULT NULL,
  invoice_settings JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  next_invoice_sequence BIGINT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  shipping stripe_minimal.shipping DEFAULT NULL,
  sources stripe_minimal_customer.customer_source DEFAULT NULL,
  subscriptions stripe_minimal_customer.customer_subscription DEFAULT NULL,
  tax stripe_minimal_customer.customer_tax DEFAULT NULL,
  tax_exempt TEXT DEFAULT NULL,
  tax_ids stripe_minimal_customer.customer_tax_id DEFAULT NULL,
  test_clock JSONB DEFAULT NULL
)
RETURNS stripe_minimal_customer.customer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    livemode,
    "object",
    address,
    balance,
    business_name,
    cash_balance,
    currency,
    customer_account,
    default_source,
    delinquent,
    description,
    discount,
    email,
    individual_name,
    invoice_credit_balance,
    invoice_prefix,
    invoice_settings,
    metadata,
    "name",
    next_invoice_sequence,
    phone,
    preferred_locales,
    shipping,
    sources,
    subscriptions,
    tax,
    tax_exempt,
    tax_ids,
    test_clock
  )::stripe_minimal_customer.customer;
$$;

ALTER TYPE stripe_minimal_customer.customer_cash_balance
  ADD ATTRIBUTE customer TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE settings stripe_minimal_customer.customer_cash_balance_setting,
  ADD ATTRIBUTE available JSONB,
  ADD ATTRIBUTE customer_account TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer_cash_balance(
  customer TEXT,
  livemode BOOLEAN,
  "object" TEXT,
  settings stripe_minimal_customer.customer_cash_balance_setting,
  available JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.customer_cash_balance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    customer, livemode, "object", settings, available, customer_account
  )::stripe_minimal_customer.customer_cash_balance;
$$;

ALTER TYPE stripe_minimal_customer.customer_cash_balance_setting
  ADD ATTRIBUTE reconciliation_mode TEXT,
  ADD ATTRIBUTE using_merchant_default BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer_cash_balance_setting(
  reconciliation_mode TEXT, using_merchant_default BOOLEAN
)
RETURNS stripe_minimal_customer.customer_cash_balance_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reconciliation_mode, using_merchant_default
  )::stripe_minimal_customer.customer_cash_balance_setting;
$$;

ALTER TYPE stripe_minimal_customer.customer_source
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer_source(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_minimal_customer.customer_source
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_minimal_customer.customer_source;
$$;

ALTER TYPE stripe_minimal_customer.customer_subscription
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer_subscription(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_minimal_customer.customer_subscription
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_minimal_customer.customer_subscription;
$$;

ALTER TYPE stripe_minimal_customer.customer_tax
  ADD ATTRIBUTE automatic_tax TEXT,
  ADD ATTRIBUTE provider TEXT,
  ADD ATTRIBUTE ip_address TEXT,
  ADD ATTRIBUTE "location" stripe_minimal_customer.customer_tax_location;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer_tax(
  automatic_tax TEXT,
  provider TEXT,
  ip_address TEXT DEFAULT NULL,
  "location" stripe_minimal_customer.customer_tax_location DEFAULT NULL
)
RETURNS stripe_minimal_customer.customer_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    automatic_tax, provider, ip_address, "location"
  )::stripe_minimal_customer.customer_tax;
$$;

ALTER TYPE stripe_minimal_customer.customer_tax_location
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE "source" TEXT,
  ADD ATTRIBUTE "state" TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer_tax_location(
  country TEXT, "source" TEXT, "state" TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.customer_tax_location
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country, "source", "state"
  )::stripe_minimal_customer.customer_tax_location;
$$;

ALTER TYPE stripe_minimal_customer.customer_tax_id
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_customer_tax_id(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_minimal_customer.customer_tax_id
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_minimal_customer.customer_tax_id;
$$;

ALTER TYPE stripe_minimal_customer.discount
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "source" stripe_minimal_customer.discount_source,
  ADD ATTRIBUTE "start" BIGINT,
  ADD ATTRIBUTE checkout_session TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE "end" BIGINT,
  ADD ATTRIBUTE invoice TEXT,
  ADD ATTRIBUTE invoice_item TEXT,
  ADD ATTRIBUTE promotion_code JSONB,
  ADD ATTRIBUTE "subscription" TEXT,
  ADD ATTRIBUTE subscription_item TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_discount(
  "id" TEXT,
  "object" TEXT,
  "source" stripe_minimal_customer.discount_source,
  "start" BIGINT,
  checkout_session TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  "end" BIGINT DEFAULT NULL,
  invoice TEXT DEFAULT NULL,
  invoice_item TEXT DEFAULT NULL,
  promotion_code JSONB DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL,
  subscription_item TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.discount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    "object",
    "source",
    "start",
    checkout_session,
    customer,
    customer_account,
    "end",
    invoice,
    invoice_item,
    promotion_code,
    "subscription",
    subscription_item
  )::stripe_minimal_customer.discount;
$$;

ALTER TYPE stripe_minimal_customer.discount_source
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE coupon JSONB;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_discount_source(
  "type" TEXT, coupon JSONB DEFAULT NULL
)
RETURNS stripe_minimal_customer.discount_source
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", coupon)::stripe_minimal_customer.discount_source;
$$;

ALTER TYPE stripe_minimal_customer.invoice_setting
  ADD ATTRIBUTE custom_fields stripe_minimal.invoice_setting_custom_field[],
  ADD ATTRIBUTE default_payment_method JSONB,
  ADD ATTRIBUTE footer TEXT,
  ADD ATTRIBUTE rendering_options stripe_minimal_customer.invoice_setting_rendering_option;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_invoice_setting(
  custom_fields stripe_minimal.invoice_setting_custom_field[] DEFAULT NULL,
  default_payment_method JSONB DEFAULT NULL,
  footer TEXT DEFAULT NULL,
  rendering_options stripe_minimal_customer.invoice_setting_rendering_option DEFAULT NULL
)
RETURNS stripe_minimal_customer.invoice_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    custom_fields, default_payment_method, footer, rendering_options
  )::stripe_minimal_customer.invoice_setting;
$$;

ALTER TYPE stripe_minimal_customer.invoice_setting_rendering_option
  ADD ATTRIBUTE amount_tax_display TEXT, ADD ATTRIBUTE "template" TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_invoice_setting_rendering_option(
  amount_tax_display TEXT DEFAULT NULL, "template" TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.invoice_setting_rendering_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_tax_display, "template"
  )::stripe_minimal_customer.invoice_setting_rendering_option;
$$;

ALTER TYPE stripe_minimal_customer.promotion_code
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE active BOOLEAN,
  ADD ATTRIBUTE code TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE promotion stripe_minimal_customer.promotion_code_promotion,
  ADD ATTRIBUTE restrictions stripe_minimal_customer.promotion_code_restriction,
  ADD ATTRIBUTE times_redeemed BIGINT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE max_redemptions BIGINT,
  ADD ATTRIBUTE metadata JSONB;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_promotion_code(
  "id" TEXT,
  active BOOLEAN,
  code TEXT,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  promotion stripe_minimal_customer.promotion_code_promotion,
  restrictions stripe_minimal_customer.promotion_code_restriction,
  times_redeemed BIGINT,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  expires_at BIGINT DEFAULT NULL,
  max_redemptions BIGINT DEFAULT NULL,
  metadata JSONB DEFAULT NULL
)
RETURNS stripe_minimal_customer.promotion_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    active,
    code,
    created,
    livemode,
    "object",
    promotion,
    restrictions,
    times_redeemed,
    customer,
    customer_account,
    expires_at,
    max_redemptions,
    metadata
  )::stripe_minimal_customer.promotion_code;
$$;

ALTER TYPE stripe_minimal_customer.promotion_code_promotion
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE coupon JSONB;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_promotion_code_promotion(
  "type" TEXT, coupon JSONB DEFAULT NULL
)
RETURNS stripe_minimal_customer.promotion_code_promotion
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", coupon)::stripe_minimal_customer.promotion_code_promotion;
$$;

ALTER TYPE stripe_minimal_customer.promotion_code_restriction
  ADD ATTRIBUTE first_time_transaction BOOLEAN,
  ADD ATTRIBUTE currency_options JSONB,
  ADD ATTRIBUTE minimum_amount BIGINT,
  ADD ATTRIBUTE minimum_amount_currency TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_promotion_code_restriction(
  first_time_transaction BOOLEAN,
  currency_options JSONB DEFAULT NULL,
  minimum_amount BIGINT DEFAULT NULL,
  minimum_amount_currency TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.promotion_code_restriction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    first_time_transaction,
    currency_options,
    minimum_amount,
    minimum_amount_currency
  )::stripe_minimal_customer.promotion_code_restriction;
$$;

ALTER TYPE stripe_minimal_customer.tax_id
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE "value" TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE "owner" JSONB,
  ADD ATTRIBUTE verification stripe_minimal_customer.tax_id_verification;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_tax_id(
  "id" TEXT,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  "type" TEXT,
  "value" TEXT,
  country TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  "owner" JSONB DEFAULT NULL,
  verification stripe_minimal_customer.tax_id_verification DEFAULT NULL
)
RETURNS stripe_minimal_customer.tax_id
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    livemode,
    "object",
    "type",
    "value",
    country,
    customer,
    customer_account,
    "owner",
    verification
  )::stripe_minimal_customer.tax_id;
$$;

ALTER TYPE stripe_minimal_customer.tax_id_verification
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE verified_address TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_tax_id_verification(
  status TEXT,
  verified_address TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.tax_id_verification
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status, verified_address, verified_name
  )::stripe_minimal_customer.tax_id_verification;
$$;

ALTER TYPE stripe_minimal_customer.tax_ids_owner
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE account JSONB,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_tax_ids_owner(
  "type" TEXT,
  account JSONB DEFAULT NULL,
  application JSONB DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.tax_ids_owner
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", account, application, customer, customer_account
  )::stripe_minimal_customer.tax_ids_owner;
$$;

ALTER TYPE stripe_minimal_customer.cash_balance
  ADD ATTRIBUTE settings stripe_minimal_customer.cash_balance_setting;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_cash_balance(
  settings stripe_minimal_customer.cash_balance_setting DEFAULT NULL
)
RETURNS stripe_minimal_customer.cash_balance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(settings)::stripe_minimal_customer.cash_balance;
$$;

ALTER TYPE stripe_minimal_customer.cash_balance_setting
  ADD ATTRIBUTE reconciliation_mode TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_cash_balance_setting(
  reconciliation_mode TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.cash_balance_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(reconciliation_mode)::stripe_minimal_customer.cash_balance_setting;
$$;

ALTER TYPE stripe_minimal_customer.invoice_setting1
  ADD ATTRIBUTE custom_fields JSONB,
  ADD ATTRIBUTE default_payment_method TEXT,
  ADD ATTRIBUTE footer TEXT,
  ADD ATTRIBUTE rendering_options JSONB;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_invoice_setting1(
  custom_fields JSONB DEFAULT NULL,
  default_payment_method TEXT DEFAULT NULL,
  footer TEXT DEFAULT NULL,
  rendering_options JSONB DEFAULT NULL
)
RETURNS stripe_minimal_customer.invoice_setting1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    custom_fields, default_payment_method, footer, rendering_options
  )::stripe_minimal_customer.invoice_setting1;
$$;

ALTER TYPE stripe_minimal_customer.tax
  ADD ATTRIBUTE ip_address TEXT, ADD ATTRIBUTE validate_location TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_tax(
  ip_address TEXT DEFAULT NULL, validate_location TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(ip_address, validate_location)::stripe_minimal_customer.tax;
$$;

ALTER TYPE stripe_minimal_customer.tax_id_data
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE "value" TEXT;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.make_tax_id_data(
  "type" TEXT, "value" TEXT
)
RETURNS stripe_minimal_customer.tax_id_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", "value")::stripe_minimal_customer.tax_id_data;
$$;

CREATE OR REPLACE FUNCTION stripe_minimal_customer._create(
  address JSONB DEFAULT NULL,
  balance BIGINT DEFAULT NULL,
  business_name TEXT DEFAULT NULL,
  cash_balance stripe_minimal_customer.cash_balance DEFAULT NULL,
  description TEXT DEFAULT NULL,
  email TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  individual_name TEXT DEFAULT NULL,
  invoice_prefix TEXT DEFAULT NULL,
  invoice_settings stripe_minimal_customer.invoice_setting1 DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  next_invoice_sequence BIGINT DEFAULT NULL,
  payment_method TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  shipping JSONB DEFAULT NULL,
  "source" TEXT DEFAULT NULL,
  tax stripe_minimal_customer.tax DEFAULT NULL,
  tax_exempt TEXT DEFAULT NULL,
  tax_id_data stripe_minimal_customer.tax_id_data[] DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stripe_minimal._types import not_given

  response = GD["__stripe_minimal_context__"].client.customers.with_raw_response.create(
      address=not_given if address is None else json.loads(address),
      balance=not_given if balance is None else balance,
      business_name=not_given if business_name is None else business_name,
      cash_balance=not_given if cash_balance is None else GD["__stripe_minimal_context__"].strip_none(cash_balance),
      description=not_given if description is None else description,
      email=not_given if email is None else email,
      expand=not_given if expand is None else expand,
      individual_name=not_given if individual_name is None else individual_name,
      invoice_prefix=not_given if invoice_prefix is None else invoice_prefix,
      invoice_settings=not_given if invoice_settings is None else GD["__stripe_minimal_context__"].strip_none(invoice_settings),
      metadata=not_given if metadata is None else json.loads(metadata),
      name=not_given if name is None else name,
      next_invoice_sequence=not_given if next_invoice_sequence is None else next_invoice_sequence,
      payment_method=not_given if payment_method is None else payment_method,
      phone=not_given if phone is None else phone,
      preferred_locales=not_given if preferred_locales is None else preferred_locales,
      shipping=not_given if shipping is None else json.loads(shipping),
      source=not_given if source is None else source,
      tax=not_given if tax is None else GD["__stripe_minimal_context__"].strip_none(tax),
      tax_exempt=not_given if tax_exempt is None else tax_exempt,
      tax_id_data=not_given if tax_id_data is None else GD["__stripe_minimal_context__"].strip_none(tax_id_data),
      test_clock=not_given if test_clock is None else test_clock,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_minimal_customer.create(
  address JSONB DEFAULT NULL,
  balance BIGINT DEFAULT NULL,
  business_name TEXT DEFAULT NULL,
  cash_balance stripe_minimal_customer.cash_balance DEFAULT NULL,
  description TEXT DEFAULT NULL,
  email TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  individual_name TEXT DEFAULT NULL,
  invoice_prefix TEXT DEFAULT NULL,
  invoice_settings stripe_minimal_customer.invoice_setting1 DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  next_invoice_sequence BIGINT DEFAULT NULL,
  payment_method TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  shipping JSONB DEFAULT NULL,
  "source" TEXT DEFAULT NULL,
  tax stripe_minimal_customer.tax DEFAULT NULL,
  tax_exempt TEXT DEFAULT NULL,
  tax_id_data stripe_minimal_customer.tax_id_data[] DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS stripe_minimal_customer.customer
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_minimal_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_minimal_customer.customer,
      stripe_minimal_customer._create(
        address,
        balance,
        business_name,
        cash_balance,
        description,
        email,
        expand,
        individual_name,
        invoice_prefix,
        invoice_settings,
        metadata,
        "name",
        next_invoice_sequence,
        payment_method,
        phone,
        preferred_locales,
        shipping,
        "source",
        tax,
        tax_exempt,
        tax_id_data,
        test_clock
      )
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_minimal_customer._list_first_page_py(
  created JSONB DEFAULT NULL,
  email TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS stripe_minimal_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal._types import not_given
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_minimal_context__"].client.customers.list(
      created=not_given if created is None else json.loads(created),
      email=not_given if email is None else email,
      ending_before=not_given if ending_before is None else ending_before,
      expand=not_given if expand is None else expand,
      limit=not_given if limit is None else limit,
      starting_after=not_given if starting_after is None else starting_after,
      test_clock=not_given if test_clock is None else test_clock,
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

-- A simpler wrapper around `stripe_minimal_customer._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_minimal_customer._list_first_page(
  created JSONB DEFAULT NULL,
  email TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS stripe_minimal_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_minimal_internal.ensure_context();
    RETURN stripe_minimal_customer._list_first_page_py(
      created, email, ending_before, expand, "limit", starting_after, test_clock
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_minimal_customer._list_next_page(request_options JSONB)
RETURNS stripe_minimal_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal.types import Customer
  from stripe_minimal.pagination import SyncMyCursorIDPage
  from stripe_minimal._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_minimal_context__"].client._request_api_list(
    model=Customer,
    page=SyncMyCursorIDPage[Customer],
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

CREATE OR REPLACE FUNCTION stripe_minimal_customer.list(
  created JSONB DEFAULT NULL,
  email TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS SETOF stripe_minimal_customer.customer
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_minimal_customer._list_first_page(
      created, email, ending_before, expand, "limit", starting_after, test_clock
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_minimal_customer._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_minimal_customer.customer, "data")).* FROM paginated;
$$;