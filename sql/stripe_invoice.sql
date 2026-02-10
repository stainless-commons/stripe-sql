ALTER TYPE stripe_invoice.api_errors
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE advice_code TEXT,
  ADD ATTRIBUTE charge TEXT,
  ADD ATTRIBUTE code TEXT,
  ADD ATTRIBUTE decline_code TEXT,
  ADD ATTRIBUTE doc_url TEXT,
  ADD ATTRIBUTE message TEXT,
  ADD ATTRIBUTE network_advice_code TEXT,
  ADD ATTRIBUTE network_decline_code TEXT,
  ADD ATTRIBUTE param TEXT,
  ADD ATTRIBUTE payment_intent JSONB,
  ADD ATTRIBUTE payment_method JSONB,
  ADD ATTRIBUTE payment_method_type TEXT,
  ADD ATTRIBUTE request_log_url TEXT,
  ADD ATTRIBUTE setup_intent JSONB,
  ADD ATTRIBUTE "source" JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_api_errors(
  "type" TEXT,
  advice_code TEXT DEFAULT NULL,
  charge TEXT DEFAULT NULL,
  code TEXT DEFAULT NULL,
  decline_code TEXT DEFAULT NULL,
  doc_url TEXT DEFAULT NULL,
  message TEXT DEFAULT NULL,
  network_advice_code TEXT DEFAULT NULL,
  network_decline_code TEXT DEFAULT NULL,
  param TEXT DEFAULT NULL,
  payment_intent JSONB DEFAULT NULL,
  payment_method JSONB DEFAULT NULL,
  payment_method_type TEXT DEFAULT NULL,
  request_log_url TEXT DEFAULT NULL,
  setup_intent JSONB DEFAULT NULL,
  "source" JSONB DEFAULT NULL
)
RETURNS stripe_invoice.api_errors
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    advice_code,
    charge,
    code,
    decline_code,
    doc_url,
    message,
    network_advice_code,
    network_decline_code,
    param,
    payment_intent,
    payment_method,
    payment_method_type,
    request_log_url,
    setup_intent,
    "source"
  )::stripe_invoice.api_errors;
$$;

ALTER TYPE stripe_invoice.automatic_tax_invoice
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE disabled_reason TEXT,
  ADD ATTRIBUTE liability JSONB,
  ADD ATTRIBUTE provider TEXT,
  ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_automatic_tax_invoice(
  enabled BOOLEAN,
  disabled_reason TEXT DEFAULT NULL,
  liability JSONB DEFAULT NULL,
  provider TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL
)
RETURNS stripe_invoice.automatic_tax_invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, disabled_reason, liability, provider, status
  )::stripe_invoice.automatic_tax_invoice;
$$;

ALTER TYPE stripe_invoice.billing_bill_resource_invoicing_parents_invoice_parent
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE quote_details stripe_invoice.b_bill_resource_invoicing_parents_invoice_parent_quote_detail,
  ADD ATTRIBUTE subscription_details JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_bill_resource_invoicing_parents_invoice_parent(
  "type" TEXT,
  quote_details stripe_invoice.b_bill_resource_invoicing_parents_invoice_parent_quote_detail DEFAULT NULL,
  subscription_details JSONB DEFAULT NULL
)
RETURNS stripe_invoice.billing_bill_resource_invoicing_parents_invoice_parent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", quote_details, subscription_details
  )::stripe_invoice.billing_bill_resource_invoicing_parents_invoice_parent;
$$;

ALTER TYPE stripe_invoice.b_bill_resource_invoicing_parents_invoice_parent_quote_detail
  ADD ATTRIBUTE "quote" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_b_bill_resource_invoicing_parents_invoice_parent_quote_detail(
  "quote" TEXT
)
RETURNS stripe_invoice.b_bill_resource_invoicing_parents_invoice_parent_quote_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "quote"
  )::stripe_invoice.b_bill_resource_invoicing_parents_invoice_parent_quote_detail;
$$;

ALTER TYPE stripe_invoice.b_bill_resource_invoicing_parents_invoice_subscription_parent
  ADD ATTRIBUTE "subscription" JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE subscription_proration_date BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_b_bill_resource_invoicing_parents_invoice_subscription_parent(
  "subscription" JSONB,
  metadata JSONB DEFAULT NULL,
  subscription_proration_date BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.b_bill_resource_invoicing_parents_invoice_subscription_parent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "subscription", metadata, subscription_proration_date
  )::stripe_invoice.b_bill_resource_invoicing_parents_invoice_subscription_parent;
$$;

ALTER TYPE stripe_invoice.billing_credit_balance_transaction
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE credit_grant JSONB,
  ADD ATTRIBUTE effective_at BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE credit JSONB,
  ADD ATTRIBUTE debit JSONB,
  ADD ATTRIBUTE test_clock JSONB,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_balance_transaction(
  "id" TEXT,
  created BIGINT,
  credit_grant JSONB,
  effective_at BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  credit JSONB DEFAULT NULL,
  debit JSONB DEFAULT NULL,
  test_clock JSONB DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.billing_credit_balance_transaction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    credit_grant,
    effective_at,
    livemode,
    "object",
    credit,
    debit,
    test_clock,
    "type"
  )::stripe_invoice.billing_credit_balance_transaction;
$$;

ALTER TYPE stripe_invoice.billing_credit_grant
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount stripe_invoice.billing_credit_grants_resource_amount,
  ADD ATTRIBUTE applicability_config stripe_invoice.billing_credit_grant_applicability_config,
  ADD ATTRIBUTE category TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE updated BIGINT,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE effective_at BIGINT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE priority BIGINT,
  ADD ATTRIBUTE test_clock JSONB,
  ADD ATTRIBUTE voided_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grant(
  "id" TEXT,
  amount stripe_invoice.billing_credit_grants_resource_amount,
  applicability_config stripe_invoice.billing_credit_grant_applicability_config,
  category TEXT,
  created BIGINT,
  customer JSONB,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  updated BIGINT,
  customer_account TEXT DEFAULT NULL,
  effective_at BIGINT DEFAULT NULL,
  expires_at BIGINT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  priority BIGINT DEFAULT NULL,
  test_clock JSONB DEFAULT NULL,
  voided_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.billing_credit_grant
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    applicability_config,
    category,
    created,
    customer,
    livemode,
    metadata,
    "object",
    updated,
    customer_account,
    effective_at,
    expires_at,
    "name",
    priority,
    test_clock,
    voided_at
  )::stripe_invoice.billing_credit_grant;
$$;

ALTER TYPE stripe_invoice.billing_credit_grant_applicability_config
  ADD ATTRIBUTE "scope" stripe_invoice.billing_credit_grant_applicability_config_scope;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grant_applicability_config(
  "scope" stripe_invoice.billing_credit_grant_applicability_config_scope
)
RETURNS stripe_invoice.billing_credit_grant_applicability_config
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("scope")::stripe_invoice.billing_credit_grant_applicability_config;
$$;

ALTER TYPE stripe_invoice.billing_credit_grant_applicability_config_scope
  ADD ATTRIBUTE price_type TEXT,
  ADD ATTRIBUTE prices stripe_invoice.billing_credit_grant_applicability_config_scope_price[];

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grant_applicability_config_scope(
  price_type TEXT DEFAULT NULL,
  prices stripe_invoice.billing_credit_grant_applicability_config_scope_price[] DEFAULT NULL
)
RETURNS stripe_invoice.billing_credit_grant_applicability_config_scope
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    price_type, prices
  )::stripe_invoice.billing_credit_grant_applicability_config_scope;
$$;

ALTER TYPE stripe_invoice.billing_credit_grant_applicability_config_scope_price
  ADD ATTRIBUTE "id" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grant_applicability_config_scope_price(
  "id" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.billing_credit_grant_applicability_config_scope_price
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id"
  )::stripe_invoice.billing_credit_grant_applicability_config_scope_price;
$$;

ALTER TYPE stripe_invoice.billing_credit_grants_resource_amount
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE monetary stripe_invoice.billing_credit_grants_resource_monetary_amount;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grants_resource_amount(
  "type" TEXT,
  monetary stripe_invoice.billing_credit_grants_resource_monetary_amount DEFAULT NULL
)
RETURNS stripe_invoice.billing_credit_grants_resource_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", monetary
  )::stripe_invoice.billing_credit_grants_resource_amount;
$$;

ALTER TYPE stripe_invoice.billing_credit_grants_resource_balance_credit
  ADD ATTRIBUTE amount stripe_invoice.billing_credit_grants_resource_amount,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE credits_application_invoice_voided JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grants_resource_balance_credit(
  amount stripe_invoice.billing_credit_grants_resource_amount,
  "type" TEXT,
  credits_application_invoice_voided JSONB DEFAULT NULL
)
RETURNS stripe_invoice.billing_credit_grants_resource_balance_credit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, "type", credits_application_invoice_voided
  )::stripe_invoice.billing_credit_grants_resource_balance_credit;
$$;

ALTER TYPE stripe_invoice.b_c_grants_resource_balance_credits_application_invoice_voided
  ADD ATTRIBUTE invoice JSONB, ADD ATTRIBUTE invoice_line_item TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_b_c_g_resource_balance_credits_application_invoice_voided(
  invoice JSONB, invoice_line_item TEXT
)
RETURNS stripe_invoice.b_c_grants_resource_balance_credits_application_invoice_voided
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_item
  )::stripe_invoice.b_c_grants_resource_balance_credits_application_invoice_voided;
$$;

ALTER TYPE stripe_invoice.billing_credit_grants_resource_balance_credits_applied
  ADD ATTRIBUTE invoice JSONB, ADD ATTRIBUTE invoice_line_item TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grants_resource_balance_credits_applied(
  invoice JSONB, invoice_line_item TEXT
)
RETURNS stripe_invoice.billing_credit_grants_resource_balance_credits_applied
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_item
  )::stripe_invoice.billing_credit_grants_resource_balance_credits_applied;
$$;

ALTER TYPE stripe_invoice.billing_credit_grants_resource_balance_debit
  ADD ATTRIBUTE amount stripe_invoice.billing_credit_grants_resource_amount,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE credits_applied JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grants_resource_balance_debit(
  amount stripe_invoice.billing_credit_grants_resource_amount,
  "type" TEXT,
  credits_applied JSONB DEFAULT NULL
)
RETURNS stripe_invoice.billing_credit_grants_resource_balance_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, "type", credits_applied
  )::stripe_invoice.billing_credit_grants_resource_balance_debit;
$$;

ALTER TYPE stripe_invoice.billing_credit_grants_resource_monetary_amount
  ADD ATTRIBUTE currency TEXT, ADD ATTRIBUTE "value" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_billing_credit_grants_resource_monetary_amount(
  currency TEXT, "value" BIGINT
)
RETURNS stripe_invoice.billing_credit_grants_resource_monetary_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, "value"
  )::stripe_invoice.billing_credit_grants_resource_monetary_amount;
$$;

ALTER TYPE stripe_invoice.connect_account_reference
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE account JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_connect_account_reference(
  "type" TEXT, account JSONB DEFAULT NULL
)
RETURNS stripe_invoice.connect_account_reference
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", account)::stripe_invoice.connect_account_reference;
$$;

ALTER TYPE stripe_invoice.deleted_discount
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE deleted BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "source" stripe_invoice.deleted_discount_source,
  ADD ATTRIBUTE "start" BIGINT,
  ADD ATTRIBUTE checkout_session TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE invoice TEXT,
  ADD ATTRIBUTE invoice_item TEXT,
  ADD ATTRIBUTE promotion_code JSONB,
  ADD ATTRIBUTE "subscription" TEXT,
  ADD ATTRIBUTE subscription_item TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_deleted_discount(
  "id" TEXT,
  deleted BOOLEAN,
  "object" TEXT,
  "source" stripe_invoice.deleted_discount_source,
  "start" BIGINT,
  checkout_session TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  invoice TEXT DEFAULT NULL,
  invoice_item TEXT DEFAULT NULL,
  promotion_code JSONB DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL,
  subscription_item TEXT DEFAULT NULL
)
RETURNS stripe_invoice.deleted_discount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    deleted,
    "object",
    "source",
    "start",
    checkout_session,
    customer,
    customer_account,
    invoice,
    invoice_item,
    promotion_code,
    "subscription",
    subscription_item
  )::stripe_invoice.deleted_discount;
$$;

ALTER TYPE stripe_invoice.deleted_discount_source
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE coupon JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_deleted_discount_source(
  "type" TEXT, coupon JSONB DEFAULT NULL
)
RETURNS stripe_invoice.deleted_discount_source
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", coupon)::stripe_invoice.deleted_discount_source;
$$;

ALTER TYPE stripe_invoice.discounts_resource_discount_amount
  ADD ATTRIBUTE amount BIGINT, ADD ATTRIBUTE discount JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_discounts_resource_discount_amount(
  amount BIGINT, discount JSONB
)
RETURNS stripe_invoice.discounts_resource_discount_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, discount
  )::stripe_invoice.discounts_resource_discount_amount;
$$;

ALTER TYPE stripe_invoice.invoice
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount_due BIGINT,
  ADD ATTRIBUTE amount_overpaid BIGINT,
  ADD ATTRIBUTE amount_paid BIGINT,
  ADD ATTRIBUTE amount_remaining BIGINT,
  ADD ATTRIBUTE amount_shipping BIGINT,
  ADD ATTRIBUTE attempt_count BIGINT,
  ADD ATTRIBUTE attempted BOOLEAN,
  ADD ATTRIBUTE auto_advance BOOLEAN,
  ADD ATTRIBUTE automatic_tax JSONB,
  ADD ATTRIBUTE collection_method TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE default_tax_rates stripe_invoice.tax_rate[],
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE issuer JSONB,
  ADD ATTRIBUTE lines stripe_invoice.invoice_line,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE payment_settings stripe_invoice.invoice_payment_setting,
  ADD ATTRIBUTE period_end BIGINT,
  ADD ATTRIBUTE period_start BIGINT,
  ADD ATTRIBUTE post_payment_credit_notes_amount BIGINT,
  ADD ATTRIBUTE pre_payment_credit_notes_amount BIGINT,
  ADD ATTRIBUTE starting_balance BIGINT,
  ADD ATTRIBUTE status_transitions stripe_invoice.invoice_status_transition,
  ADD ATTRIBUTE subtotal BIGINT,
  ADD ATTRIBUTE total BIGINT,
  ADD ATTRIBUTE account_country TEXT,
  ADD ATTRIBUTE account_name TEXT,
  ADD ATTRIBUTE account_tax_ids JSONB[],
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE automatically_finalizes_at BIGINT,
  ADD ATTRIBUTE billing_reason TEXT,
  ADD ATTRIBUTE confirmation_secret stripe_invoice.invoice_confirmation_secret,
  ADD ATTRIBUTE custom_fields stripe.invoice_setting_custom_field[],
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE customer_address stripe.address,
  ADD ATTRIBUTE customer_email TEXT,
  ADD ATTRIBUTE customer_name TEXT,
  ADD ATTRIBUTE customer_phone TEXT,
  ADD ATTRIBUTE customer_shipping stripe.shipping,
  ADD ATTRIBUTE customer_tax_exempt TEXT,
  ADD ATTRIBUTE customer_tax_ids stripe_invoice.invoice_customer_tax_id[],
  ADD ATTRIBUTE default_payment_method JSONB,
  ADD ATTRIBUTE default_source JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE due_date BIGINT,
  ADD ATTRIBUTE effective_at BIGINT,
  ADD ATTRIBUTE ending_balance BIGINT,
  ADD ATTRIBUTE footer TEXT,
  ADD ATTRIBUTE from_invoice JSONB,
  ADD ATTRIBUTE hosted_invoice_url TEXT,
  ADD ATTRIBUTE invoice_pdf TEXT,
  ADD ATTRIBUTE last_finalization_error JSONB,
  ADD ATTRIBUTE latest_revision JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE next_payment_attempt BIGINT,
  ADD ATTRIBUTE "number" TEXT,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE parent JSONB,
  ADD ATTRIBUTE payments stripe_invoice.invoice_payment,
  ADD ATTRIBUTE receipt_number TEXT,
  ADD ATTRIBUTE rendering stripe_invoice.invoice_rendering,
  ADD ATTRIBUTE shipping_cost stripe_invoice.invoice_shipping_cost,
  ADD ATTRIBUTE shipping_details stripe.shipping,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE subtotal_excluding_tax BIGINT,
  ADD ATTRIBUTE test_clock JSONB,
  ADD ATTRIBUTE threshold_reason stripe_invoice.invoice_threshold_reason,
  ADD ATTRIBUTE total_discount_amounts JSONB[],
  ADD ATTRIBUTE total_excluding_tax BIGINT,
  ADD ATTRIBUTE total_pretax_credit_amounts JSONB[],
  ADD ATTRIBUTE total_taxes stripe_invoice.invoice_total_tax[],
  ADD ATTRIBUTE webhooks_delivered_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice(
  "id" TEXT,
  amount_due BIGINT,
  amount_overpaid BIGINT,
  amount_paid BIGINT,
  amount_remaining BIGINT,
  amount_shipping BIGINT,
  attempt_count BIGINT,
  attempted BOOLEAN,
  auto_advance BOOLEAN,
  automatic_tax JSONB,
  collection_method TEXT,
  created BIGINT,
  currency TEXT,
  customer JSONB,
  default_tax_rates stripe_invoice.tax_rate[],
  discounts JSONB[],
  issuer JSONB,
  lines stripe_invoice.invoice_line,
  livemode BOOLEAN,
  "object" TEXT,
  payment_settings stripe_invoice.invoice_payment_setting,
  period_end BIGINT,
  period_start BIGINT,
  post_payment_credit_notes_amount BIGINT,
  pre_payment_credit_notes_amount BIGINT,
  starting_balance BIGINT,
  status_transitions stripe_invoice.invoice_status_transition,
  subtotal BIGINT,
  total BIGINT,
  account_country TEXT DEFAULT NULL,
  account_name TEXT DEFAULT NULL,
  account_tax_ids JSONB[] DEFAULT NULL,
  application JSONB DEFAULT NULL,
  automatically_finalizes_at BIGINT DEFAULT NULL,
  billing_reason TEXT DEFAULT NULL,
  confirmation_secret stripe_invoice.invoice_confirmation_secret DEFAULT NULL,
  custom_fields stripe.invoice_setting_custom_field[] DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  customer_address stripe.address DEFAULT NULL,
  customer_email TEXT DEFAULT NULL,
  customer_name TEXT DEFAULT NULL,
  customer_phone TEXT DEFAULT NULL,
  customer_shipping stripe.shipping DEFAULT NULL,
  customer_tax_exempt TEXT DEFAULT NULL,
  customer_tax_ids stripe_invoice.invoice_customer_tax_id[] DEFAULT NULL,
  default_payment_method JSONB DEFAULT NULL,
  default_source JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  due_date BIGINT DEFAULT NULL,
  effective_at BIGINT DEFAULT NULL,
  ending_balance BIGINT DEFAULT NULL,
  footer TEXT DEFAULT NULL,
  from_invoice JSONB DEFAULT NULL,
  hosted_invoice_url TEXT DEFAULT NULL,
  invoice_pdf TEXT DEFAULT NULL,
  last_finalization_error JSONB DEFAULT NULL,
  latest_revision JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  next_payment_attempt BIGINT DEFAULT NULL,
  "number" TEXT DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  parent JSONB DEFAULT NULL,
  payments stripe_invoice.invoice_payment DEFAULT NULL,
  receipt_number TEXT DEFAULT NULL,
  rendering stripe_invoice.invoice_rendering DEFAULT NULL,
  shipping_cost stripe_invoice.invoice_shipping_cost DEFAULT NULL,
  shipping_details stripe.shipping DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  subtotal_excluding_tax BIGINT DEFAULT NULL,
  test_clock JSONB DEFAULT NULL,
  threshold_reason stripe_invoice.invoice_threshold_reason DEFAULT NULL,
  total_discount_amounts JSONB[] DEFAULT NULL,
  total_excluding_tax BIGINT DEFAULT NULL,
  total_pretax_credit_amounts JSONB[] DEFAULT NULL,
  total_taxes stripe_invoice.invoice_total_tax[] DEFAULT NULL,
  webhooks_delivered_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount_due,
    amount_overpaid,
    amount_paid,
    amount_remaining,
    amount_shipping,
    attempt_count,
    attempted,
    auto_advance,
    automatic_tax,
    collection_method,
    created,
    currency,
    customer,
    default_tax_rates,
    discounts,
    issuer,
    lines,
    livemode,
    "object",
    payment_settings,
    period_end,
    period_start,
    post_payment_credit_notes_amount,
    pre_payment_credit_notes_amount,
    starting_balance,
    status_transitions,
    subtotal,
    total,
    account_country,
    account_name,
    account_tax_ids,
    application,
    automatically_finalizes_at,
    billing_reason,
    confirmation_secret,
    custom_fields,
    customer_account,
    customer_address,
    customer_email,
    customer_name,
    customer_phone,
    customer_shipping,
    customer_tax_exempt,
    customer_tax_ids,
    default_payment_method,
    default_source,
    description,
    due_date,
    effective_at,
    ending_balance,
    footer,
    from_invoice,
    hosted_invoice_url,
    invoice_pdf,
    last_finalization_error,
    latest_revision,
    metadata,
    next_payment_attempt,
    "number",
    on_behalf_of,
    parent,
    payments,
    receipt_number,
    rendering,
    shipping_cost,
    shipping_details,
    statement_descriptor,
    status,
    subtotal_excluding_tax,
    test_clock,
    threshold_reason,
    total_discount_amounts,
    total_excluding_tax,
    total_pretax_credit_amounts,
    total_taxes,
    webhooks_delivered_at
  )::stripe_invoice.invoice;
$$;

ALTER TYPE stripe_invoice.invoice_line
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_line(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_invoice.invoice_line
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("data", has_more, "object", url)::stripe_invoice.invoice_line;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting
  ADD ATTRIBUTE default_mandate TEXT,
  ADD ATTRIBUTE payment_method_options stripe_invoice.invoice_payment_setting_payment_method_option,
  ADD ATTRIBUTE payment_method_types TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment_setting(
  default_mandate TEXT DEFAULT NULL,
  payment_method_options stripe_invoice.invoice_payment_setting_payment_method_option DEFAULT NULL,
  payment_method_types TEXT[] DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_mandate, payment_method_options, payment_method_types
  )::stripe_invoice.invoice_payment_setting;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option
  ADD ATTRIBUTE acss_debit stripe_invoice.invoice_payment_setting_payment_method_option_acss_debit,
  ADD ATTRIBUTE bancontact stripe_invoice.invoice_payment_setting_payment_method_option_bancontact,
  ADD ATTRIBUTE card stripe_invoice.invoice_payment_setting_payment_method_option_card,
  ADD ATTRIBUTE customer_balance stripe_invoice.invoice_payment_setting_payment_method_option_customer_balance,
  ADD ATTRIBUTE konbini stripe_invoice.invoice_payment_setting_payment_method_option_konbini,
  ADD ATTRIBUTE payto stripe_invoice.invoice_payment_setting_payment_method_option_payto,
  ADD ATTRIBUTE sepa_debit stripe_invoice.invoice_payment_setting_payment_method_option_sepa_debit,
  ADD ATTRIBUTE us_bank_account stripe_invoice.invoice_payment_setting_payment_method_option_us_bank_account;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment_setting_payment_method_option(
  acss_debit stripe_invoice.invoice_payment_setting_payment_method_option_acss_debit DEFAULT NULL,
  bancontact stripe_invoice.invoice_payment_setting_payment_method_option_bancontact DEFAULT NULL,
  card stripe_invoice.invoice_payment_setting_payment_method_option_card DEFAULT NULL,
  customer_balance stripe_invoice.invoice_payment_setting_payment_method_option_customer_balance DEFAULT NULL,
  konbini stripe_invoice.invoice_payment_setting_payment_method_option_konbini DEFAULT NULL,
  payto stripe_invoice.invoice_payment_setting_payment_method_option_payto DEFAULT NULL,
  sepa_debit stripe_invoice.invoice_payment_setting_payment_method_option_sepa_debit DEFAULT NULL,
  us_bank_account stripe_invoice.invoice_payment_setting_payment_method_option_us_bank_account DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    acss_debit,
    bancontact,
    card,
    customer_balance,
    konbini,
    payto,
    sepa_debit,
    us_bank_account
  )::stripe_invoice.invoice_payment_setting_payment_method_option;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option_acss_debit
  ADD ATTRIBUTE mandate_options stripe_invoice.i_p_setting_payment_method_option_acss_debit_mandate_option,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment_setting_payment_method_option_acss_debit(
  mandate_options stripe_invoice.i_p_setting_payment_method_option_acss_debit_mandate_option DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_invoice.invoice_payment_setting_payment_method_option_acss_debit;
$$;

ALTER TYPE stripe_invoice.i_p_setting_payment_method_option_acss_debit_mandate_option
  ADD ATTRIBUTE transaction_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_p_setting_payment_method_option_acss_debit_mandate_option(
  transaction_type TEXT DEFAULT NULL
)
RETURNS stripe_invoice.i_p_setting_payment_method_option_acss_debit_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_type
  )::stripe_invoice.i_p_setting_payment_method_option_acss_debit_mandate_option;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option_bancontact
  ADD ATTRIBUTE preferred_language TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment_setting_payment_method_option_bancontact(
  preferred_language TEXT
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option_bancontact
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    preferred_language
  )::stripe_invoice.invoice_payment_setting_payment_method_option_bancontact;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option_card
  ADD ATTRIBUTE installments stripe_invoice.invoice_payment_setting_payment_method_option_card_installment,
  ADD ATTRIBUTE request_three_d_secure TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment_setting_payment_method_option_card(
  installments stripe_invoice.invoice_payment_setting_payment_method_option_card_installment DEFAULT NULL,
  request_three_d_secure TEXT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    installments, request_three_d_secure
  )::stripe_invoice.invoice_payment_setting_payment_method_option_card;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option_card_installment
  ADD ATTRIBUTE enabled BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_payment_setting_payment_method_option_card_installment(
  enabled BOOLEAN DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option_card_installment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled
  )::stripe_invoice.invoice_payment_setting_payment_method_option_card_installment;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option_customer_balance
  ADD ATTRIBUTE bank_transfer stripe_invoice.i_p_s_payment_method_option_customer_balance_bank_transfer,
  ADD ATTRIBUTE funding_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_payment_setting_payment_method_option_customer_balance(
  bank_transfer stripe_invoice.i_p_s_payment_method_option_customer_balance_bank_transfer DEFAULT NULL,
  funding_type TEXT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option_customer_balance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_transfer, funding_type
  )::stripe_invoice.invoice_payment_setting_payment_method_option_customer_balance;
$$;

ALTER TYPE stripe_invoice.i_p_s_payment_method_option_customer_balance_bank_transfer
  ADD ATTRIBUTE eu_bank_transfer stripe_invoice.i_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_p_s_payment_method_option_customer_balance_bank_transfer(
  eu_bank_transfer stripe_invoice.i_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.i_p_s_payment_method_option_customer_balance_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    eu_bank_transfer, "type"
  )::stripe_invoice.i_p_s_payment_method_option_customer_balance_bank_transfer;
$$;

ALTER TYPE stripe_invoice.i_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer(
  country TEXT
)
RETURNS stripe_invoice.i_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_invoice.i_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option_payto
  ADD ATTRIBUTE mandate_options stripe_invoice.i_payment_setting_payment_method_option_payto_mandate_option;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment_setting_payment_method_option_payto(
  mandate_options stripe_invoice.i_payment_setting_payment_method_option_payto_mandate_option DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options
  )::stripe_invoice.invoice_payment_setting_payment_method_option_payto;
$$;

ALTER TYPE stripe_invoice.i_payment_setting_payment_method_option_payto_mandate_option
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_payment_setting_payment_method_option_payto_mandate_option(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_invoice.i_payment_setting_payment_method_option_payto_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, amount_type, purpose
  )::stripe_invoice.i_payment_setting_payment_method_option_payto_mandate_option;
$$;

ALTER TYPE stripe_invoice.invoice_payment_setting_payment_method_option_us_bank_account
  ADD ATTRIBUTE financial_connections stripe_invoice.i_p_s_p_method_option_us_bank_account_financial_connection,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_invoice_payment_setting_payment_method_option_us_bank_account(
  financial_connections stripe_invoice.i_p_s_p_method_option_us_bank_account_financial_connection DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_setting_payment_method_option_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    financial_connections, verification_method
  )::stripe_invoice.invoice_payment_setting_payment_method_option_us_bank_account;
$$;

ALTER TYPE stripe_invoice.i_p_s_p_method_option_us_bank_account_financial_connection
  ADD ATTRIBUTE filters stripe_invoice.i_p_s_p_m_option_us_bank_account_financial_connection_filter,
  ADD ATTRIBUTE permissions TEXT[],
  ADD ATTRIBUTE prefetch TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_p_s_p_method_option_us_bank_account_financial_connection(
  filters stripe_invoice.i_p_s_p_m_option_us_bank_account_financial_connection_filter DEFAULT NULL,
  permissions TEXT[] DEFAULT NULL,
  prefetch TEXT[] DEFAULT NULL
)
RETURNS stripe_invoice.i_p_s_p_method_option_us_bank_account_financial_connection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    filters, permissions, prefetch
  )::stripe_invoice.i_p_s_p_method_option_us_bank_account_financial_connection;
$$;

ALTER TYPE stripe_invoice.i_p_s_p_m_option_us_bank_account_financial_connection_filter
  ADD ATTRIBUTE account_subcategories TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoice.m_i_p_s_p_m_option_us_bank_account_financial_connection_filter(
  account_subcategories TEXT[] DEFAULT NULL
)
RETURNS stripe_invoice.i_p_s_p_m_option_us_bank_account_financial_connection_filter
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_subcategories
  )::stripe_invoice.i_p_s_p_m_option_us_bank_account_financial_connection_filter;
$$;

ALTER TYPE stripe_invoice.invoice_status_transition
  ADD ATTRIBUTE finalized_at BIGINT,
  ADD ATTRIBUTE marked_uncollectible_at BIGINT,
  ADD ATTRIBUTE paid_at BIGINT,
  ADD ATTRIBUTE voided_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_status_transition(
  finalized_at BIGINT DEFAULT NULL,
  marked_uncollectible_at BIGINT DEFAULT NULL,
  paid_at BIGINT DEFAULT NULL,
  voided_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_status_transition
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    finalized_at, marked_uncollectible_at, paid_at, voided_at
  )::stripe_invoice.invoice_status_transition;
$$;

ALTER TYPE stripe_invoice.invoice_confirmation_secret
  ADD ATTRIBUTE client_secret TEXT, ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_confirmation_secret(
  client_secret TEXT, "type" TEXT
)
RETURNS stripe_invoice.invoice_confirmation_secret
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(client_secret, "type")::stripe_invoice.invoice_confirmation_secret;
$$;

ALTER TYPE stripe_invoice.invoice_customer_tax_id
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE "value" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_customer_tax_id(
  "type" TEXT, "value" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_customer_tax_id
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", "value")::stripe_invoice.invoice_customer_tax_id;
$$;

ALTER TYPE stripe_invoice.invoice_payment
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_invoice.invoice_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("data", has_more, "object", url)::stripe_invoice.invoice_payment;
$$;

ALTER TYPE stripe_invoice.invoice_rendering
  ADD ATTRIBUTE amount_tax_display TEXT,
  ADD ATTRIBUTE pdf stripe_invoice.invoice_rendering_pdf,
  ADD ATTRIBUTE "template" TEXT,
  ADD ATTRIBUTE template_version BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_rendering(
  amount_tax_display TEXT DEFAULT NULL,
  pdf stripe_invoice.invoice_rendering_pdf DEFAULT NULL,
  "template" TEXT DEFAULT NULL,
  template_version BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_rendering
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_tax_display, pdf, "template", template_version
  )::stripe_invoice.invoice_rendering;
$$;

ALTER TYPE stripe_invoice.invoice_rendering_pdf
  ADD ATTRIBUTE page_size TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_rendering_pdf(
  page_size TEXT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_rendering_pdf
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(page_size)::stripe_invoice.invoice_rendering_pdf;
$$;

ALTER TYPE stripe_invoice.invoice_shipping_cost
  ADD ATTRIBUTE amount_subtotal BIGINT,
  ADD ATTRIBUTE amount_tax BIGINT,
  ADD ATTRIBUTE amount_total BIGINT,
  ADD ATTRIBUTE shipping_rate JSONB,
  ADD ATTRIBUTE taxes stripe_invoice.invoice_shipping_cost_tax[];

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_shipping_cost(
  amount_subtotal BIGINT,
  amount_tax BIGINT,
  amount_total BIGINT,
  shipping_rate JSONB DEFAULT NULL,
  taxes stripe_invoice.invoice_shipping_cost_tax[] DEFAULT NULL
)
RETURNS stripe_invoice.invoice_shipping_cost
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_subtotal, amount_tax, amount_total, shipping_rate, taxes
  )::stripe_invoice.invoice_shipping_cost;
$$;

ALTER TYPE stripe_invoice.invoice_shipping_cost_tax
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE rate stripe_invoice.tax_rate,
  ADD ATTRIBUTE taxability_reason TEXT,
  ADD ATTRIBUTE taxable_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_shipping_cost_tax(
  amount BIGINT,
  rate stripe_invoice.tax_rate,
  taxability_reason TEXT DEFAULT NULL,
  taxable_amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_shipping_cost_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, rate, taxability_reason, taxable_amount
  )::stripe_invoice.invoice_shipping_cost_tax;
$$;

ALTER TYPE stripe_invoice.invoice_threshold_reason
  ADD ATTRIBUTE item_reasons stripe_invoice.invoice_threshold_reason_item_reason[],
  ADD ATTRIBUTE amount_gte BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_threshold_reason(
  item_reasons stripe_invoice.invoice_threshold_reason_item_reason[],
  amount_gte BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_threshold_reason
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(item_reasons, amount_gte)::stripe_invoice.invoice_threshold_reason;
$$;

ALTER TYPE stripe_invoice.invoice_threshold_reason_item_reason
  ADD ATTRIBUTE line_item_ids TEXT[], ADD ATTRIBUTE usage_gte BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_threshold_reason_item_reason(
  line_item_ids TEXT[], usage_gte BIGINT
)
RETURNS stripe_invoice.invoice_threshold_reason_item_reason
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    line_item_ids, usage_gte
  )::stripe_invoice.invoice_threshold_reason_item_reason;
$$;

ALTER TYPE stripe_invoice.invoice_total_tax
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE taxability_reason TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE tax_rate_details stripe_invoice.invoice_total_tax_tax_rate_detail,
  ADD ATTRIBUTE taxable_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_total_tax(
  amount BIGINT,
  tax_behavior TEXT,
  taxability_reason TEXT,
  "type" TEXT,
  tax_rate_details stripe_invoice.invoice_total_tax_tax_rate_detail DEFAULT NULL,
  taxable_amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_total_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    tax_behavior,
    taxability_reason,
    "type",
    tax_rate_details,
    taxable_amount
  )::stripe_invoice.invoice_total_tax;
$$;

ALTER TYPE stripe_invoice.invoice_total_tax_tax_rate_detail
  ADD ATTRIBUTE tax_rate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_total_tax_tax_rate_detail(
  tax_rate TEXT
)
RETURNS stripe_invoice.invoice_total_tax_tax_rate_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_rate)::stripe_invoice.invoice_total_tax_tax_rate_detail;
$$;

ALTER TYPE stripe_invoice.invoice_payment1
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount_requested BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE invoice JSONB,
  ADD ATTRIBUTE is_default BOOLEAN,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE payment JSONB,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE status_transitions stripe_invoice.invoice_payment_status_transition,
  ADD ATTRIBUTE amount_paid BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment1(
  "id" TEXT,
  amount_requested BIGINT,
  created BIGINT,
  currency TEXT,
  invoice JSONB,
  is_default BOOLEAN,
  livemode BOOLEAN,
  "object" TEXT,
  payment JSONB,
  status TEXT,
  status_transitions stripe_invoice.invoice_payment_status_transition,
  amount_paid BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount_requested,
    created,
    currency,
    invoice,
    is_default,
    livemode,
    "object",
    payment,
    status,
    status_transitions,
    amount_paid
  )::stripe_invoice.invoice_payment1;
$$;

ALTER TYPE stripe_invoice.invoice_payment_status_transition
  ADD ATTRIBUTE canceled_at BIGINT, ADD ATTRIBUTE paid_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoice_payment_status_transition(
  canceled_at BIGINT DEFAULT NULL, paid_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.invoice_payment_status_transition
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    canceled_at, paid_at
  )::stripe_invoice.invoice_payment_status_transition;
$$;

ALTER TYPE stripe_invoice.invoices_payments_invoice_payment_associated_payment
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE charge JSONB,
  ADD ATTRIBUTE payment_intent JSONB,
  ADD ATTRIBUTE payment_record JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoices_payments_invoice_payment_associated_payment(
  "type" TEXT,
  charge JSONB DEFAULT NULL,
  payment_intent JSONB DEFAULT NULL,
  payment_record JSONB DEFAULT NULL
)
RETURNS stripe_invoice.invoices_payments_invoice_payment_associated_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", charge, payment_intent, payment_record
  )::stripe_invoice.invoices_payments_invoice_payment_associated_payment;
$$;

ALTER TYPE stripe_invoice.invoices_resource_from_invoice
  ADD ATTRIBUTE "action" TEXT, ADD ATTRIBUTE invoice JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoices_resource_from_invoice(
  "action" TEXT, invoice JSONB
)
RETURNS stripe_invoice.invoices_resource_from_invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("action", invoice)::stripe_invoice.invoices_resource_from_invoice;
$$;

ALTER TYPE stripe_invoice.invoices_resource_pretax_credit_amount
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE credit_balance_transaction JSONB,
  ADD ATTRIBUTE discount JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_invoices_resource_pretax_credit_amount(
  amount BIGINT,
  "type" TEXT,
  credit_balance_transaction JSONB DEFAULT NULL,
  discount JSONB DEFAULT NULL
)
RETURNS stripe_invoice.invoices_resource_pretax_credit_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, "type", credit_balance_transaction, discount
  )::stripe_invoice.invoices_resource_pretax_credit_amount;
$$;

ALTER TYPE stripe_invoice.line_item
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE discountable BOOLEAN,
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "period" stripe_invoice.line_item_period,
  ADD ATTRIBUTE subtotal BIGINT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE discount_amounts JSONB[],
  ADD ATTRIBUTE invoice TEXT,
  ADD ATTRIBUTE parent stripe_invoice.line_item_parent,
  ADD ATTRIBUTE pretax_credit_amounts JSONB[],
  ADD ATTRIBUTE pricing stripe_invoice.line_item_pricing,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE "subscription" JSONB,
  ADD ATTRIBUTE taxes stripe_invoice.line_item_tax[];

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item(
  "id" TEXT,
  amount BIGINT,
  currency TEXT,
  discountable BOOLEAN,
  discounts JSONB[],
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  "period" stripe_invoice.line_item_period,
  subtotal BIGINT,
  description TEXT DEFAULT NULL,
  discount_amounts JSONB[] DEFAULT NULL,
  invoice TEXT DEFAULT NULL,
  parent stripe_invoice.line_item_parent DEFAULT NULL,
  pretax_credit_amounts JSONB[] DEFAULT NULL,
  pricing stripe_invoice.line_item_pricing DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  "subscription" JSONB DEFAULT NULL,
  taxes stripe_invoice.line_item_tax[] DEFAULT NULL
)
RETURNS stripe_invoice.line_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    currency,
    discountable,
    discounts,
    livemode,
    metadata,
    "object",
    "period",
    subtotal,
    description,
    discount_amounts,
    invoice,
    parent,
    pretax_credit_amounts,
    pricing,
    quantity,
    "subscription",
    taxes
  )::stripe_invoice.line_item;
$$;

ALTER TYPE stripe_invoice.line_item_period
  ADD ATTRIBUTE "end" BIGINT, ADD ATTRIBUTE "start" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_period(
  "end" BIGINT, "start" BIGINT
)
RETURNS stripe_invoice.line_item_period
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("end", "start")::stripe_invoice.line_item_period;
$$;

ALTER TYPE stripe_invoice.line_item_parent
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE invoice_item_details stripe_invoice.line_item_parent_invoice_item_detail,
  ADD ATTRIBUTE subscription_item_details stripe_invoice.line_item_parent_subscription_item_detail;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_parent(
  "type" TEXT,
  invoice_item_details stripe_invoice.line_item_parent_invoice_item_detail DEFAULT NULL,
  subscription_item_details stripe_invoice.line_item_parent_subscription_item_detail DEFAULT NULL
)
RETURNS stripe_invoice.line_item_parent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", invoice_item_details, subscription_item_details
  )::stripe_invoice.line_item_parent;
$$;

ALTER TYPE stripe_invoice.line_item_parent_invoice_item_detail
  ADD ATTRIBUTE invoice_item TEXT,
  ADD ATTRIBUTE proration BOOLEAN,
  ADD ATTRIBUTE proration_details stripe_invoice.line_item_parent_invoice_item_detail_proration_detail,
  ADD ATTRIBUTE "subscription" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_parent_invoice_item_detail(
  invoice_item TEXT,
  proration BOOLEAN,
  proration_details stripe_invoice.line_item_parent_invoice_item_detail_proration_detail DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.line_item_parent_invoice_item_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice_item, proration, proration_details, "subscription"
  )::stripe_invoice.line_item_parent_invoice_item_detail;
$$;

ALTER TYPE stripe_invoice.line_item_parent_invoice_item_detail_proration_detail
  ADD ATTRIBUTE credited_items stripe_invoice.l_i_parent_invoice_item_detail_proration_detail_credited_item;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_parent_invoice_item_detail_proration_detail(
  credited_items stripe_invoice.l_i_parent_invoice_item_detail_proration_detail_credited_item DEFAULT NULL
)
RETURNS stripe_invoice.line_item_parent_invoice_item_detail_proration_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    credited_items
  )::stripe_invoice.line_item_parent_invoice_item_detail_proration_detail;
$$;

ALTER TYPE stripe_invoice.l_i_parent_invoice_item_detail_proration_detail_credited_item
  ADD ATTRIBUTE invoice TEXT, ADD ATTRIBUTE invoice_line_items TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoice.m_l_i_parent_invoice_item_detail_proration_detail_credited_item(
  invoice TEXT, invoice_line_items TEXT[]
)
RETURNS stripe_invoice.l_i_parent_invoice_item_detail_proration_detail_credited_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_items
  )::stripe_invoice.l_i_parent_invoice_item_detail_proration_detail_credited_item;
$$;

ALTER TYPE stripe_invoice.line_item_parent_subscription_item_detail
  ADD ATTRIBUTE proration BOOLEAN,
  ADD ATTRIBUTE subscription_item TEXT,
  ADD ATTRIBUTE invoice_item TEXT,
  ADD ATTRIBUTE proration_details stripe_invoice.line_item_parent_subscription_item_detail_proration_detail,
  ADD ATTRIBUTE "subscription" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_parent_subscription_item_detail(
  proration BOOLEAN,
  subscription_item TEXT,
  invoice_item TEXT DEFAULT NULL,
  proration_details stripe_invoice.line_item_parent_subscription_item_detail_proration_detail DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.line_item_parent_subscription_item_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    proration,
    subscription_item,
    invoice_item,
    proration_details,
    "subscription"
  )::stripe_invoice.line_item_parent_subscription_item_detail;
$$;

ALTER TYPE stripe_invoice.line_item_parent_subscription_item_detail_proration_detail
  ADD ATTRIBUTE credited_items stripe_invoice.l_i_p_subscription_item_detail_proration_detail_credited_item;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_parent_subscription_item_detail_proration_detail(
  credited_items stripe_invoice.l_i_p_subscription_item_detail_proration_detail_credited_item DEFAULT NULL
)
RETURNS stripe_invoice.line_item_parent_subscription_item_detail_proration_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    credited_items
  )::stripe_invoice.line_item_parent_subscription_item_detail_proration_detail;
$$;

ALTER TYPE stripe_invoice.l_i_p_subscription_item_detail_proration_detail_credited_item
  ADD ATTRIBUTE invoice TEXT, ADD ATTRIBUTE invoice_line_items TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoice.m_l_i_p_subscription_item_detail_proration_detail_credited_item(
  invoice TEXT, invoice_line_items TEXT[]
)
RETURNS stripe_invoice.l_i_p_subscription_item_detail_proration_detail_credited_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_items
  )::stripe_invoice.l_i_p_subscription_item_detail_proration_detail_credited_item;
$$;

ALTER TYPE stripe_invoice.line_item_pricing
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE price_details stripe_invoice.line_item_pricing_price_detail,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_pricing(
  "type" TEXT,
  price_details stripe_invoice.line_item_pricing_price_detail DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_invoice.line_item_pricing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", price_details, unit_amount_decimal
  )::stripe_invoice.line_item_pricing;
$$;

ALTER TYPE stripe_invoice.line_item_pricing_price_detail
  ADD ATTRIBUTE price JSONB, ADD ATTRIBUTE product TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_pricing_price_detail(
  price JSONB, product TEXT
)
RETURNS stripe_invoice.line_item_pricing_price_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(price, product)::stripe_invoice.line_item_pricing_price_detail;
$$;

ALTER TYPE stripe_invoice.line_item_tax
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE taxability_reason TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE tax_rate_details stripe_invoice.line_item_tax_tax_rate_detail,
  ADD ATTRIBUTE taxable_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_tax(
  amount BIGINT,
  tax_behavior TEXT,
  taxability_reason TEXT,
  "type" TEXT,
  tax_rate_details stripe_invoice.line_item_tax_tax_rate_detail DEFAULT NULL,
  taxable_amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.line_item_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    tax_behavior,
    taxability_reason,
    "type",
    tax_rate_details,
    taxable_amount
  )::stripe_invoice.line_item_tax;
$$;

ALTER TYPE stripe_invoice.line_item_tax_tax_rate_detail
  ADD ATTRIBUTE tax_rate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_line_item_tax_tax_rate_detail(
  tax_rate TEXT
)
RETURNS stripe_invoice.line_item_tax_tax_rate_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_rate)::stripe_invoice.line_item_tax_tax_rate_detail;
$$;

ALTER TYPE stripe_invoice.payment_method
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE billing_details stripe_invoice.payment_method_billing_detail,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE acss_debit stripe_invoice.payment_method_acss_debit,
  ADD ATTRIBUTE affirm stripe_invoice.payment_method_affirm,
  ADD ATTRIBUTE afterpay_clearpay stripe_invoice.payment_method_afterpay_clearpay,
  ADD ATTRIBUTE alipay stripe_invoice.payment_method_alipay,
  ADD ATTRIBUTE allow_redisplay TEXT,
  ADD ATTRIBUTE alma stripe_invoice.payment_method_alma,
  ADD ATTRIBUTE amazon_pay stripe_invoice.payment_method_amazon_pay,
  ADD ATTRIBUTE au_becs_debit stripe_invoice.payment_method_au_becs_debit,
  ADD ATTRIBUTE bacs_debit stripe_invoice.payment_method_bacs_debit,
  ADD ATTRIBUTE bancontact stripe_invoice.payment_method_bancontact,
  ADD ATTRIBUTE billie stripe_invoice.payment_method_billie,
  ADD ATTRIBUTE blik stripe_invoice.payment_method_blik,
  ADD ATTRIBUTE boleto stripe_invoice.payment_method_boleto,
  ADD ATTRIBUTE card JSONB,
  ADD ATTRIBUTE card_present stripe_invoice.payment_method_card_present,
  ADD ATTRIBUTE cashapp stripe_invoice.payment_method_cashapp,
  ADD ATTRIBUTE crypto stripe_invoice.payment_method_crypto,
  ADD ATTRIBUTE custom stripe_invoice.payment_method_custom,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE customer_balance stripe_invoice.payment_method_customer_balance,
  ADD ATTRIBUTE eps stripe_invoice.payment_method_ep,
  ADD ATTRIBUTE fpx stripe_invoice.payment_method_fpx,
  ADD ATTRIBUTE giropay stripe_invoice.payment_method_giropay,
  ADD ATTRIBUTE grabpay stripe_invoice.payment_method_grabpay,
  ADD ATTRIBUTE ideal stripe_invoice.payment_method_ideal,
  ADD ATTRIBUTE interac_present stripe_invoice.payment_method_interac_present,
  ADD ATTRIBUTE kakao_pay stripe_invoice.payment_method_kakao_pay,
  ADD ATTRIBUTE klarna stripe_invoice.payment_method_klarna,
  ADD ATTRIBUTE konbini stripe_invoice.payment_method_konbini,
  ADD ATTRIBUTE kr_card stripe_invoice.payment_method_kr_card,
  ADD ATTRIBUTE "link" stripe_invoice.payment_method_link,
  ADD ATTRIBUTE mb_way stripe_invoice.payment_method_mb_way,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE mobilepay stripe_invoice.payment_method_mobilepay,
  ADD ATTRIBUTE multibanco stripe_invoice.payment_method_multibanco,
  ADD ATTRIBUTE naver_pay stripe_invoice.payment_method_naver_pay,
  ADD ATTRIBUTE nz_bank_account stripe_invoice.payment_method_nz_bank_account,
  ADD ATTRIBUTE oxxo stripe_invoice.payment_method_oxxo,
  ADD ATTRIBUTE p24 stripe_invoice.payment_method_p24,
  ADD ATTRIBUTE pay_by_bank stripe_invoice.payment_method_pay_by_bank,
  ADD ATTRIBUTE payco stripe_invoice.payment_method_payco,
  ADD ATTRIBUTE paynow stripe_invoice.payment_method_paynow,
  ADD ATTRIBUTE paypal stripe_invoice.payment_method_paypal,
  ADD ATTRIBUTE payto stripe_invoice.payment_method_payto,
  ADD ATTRIBUTE pix stripe_invoice.payment_method_pix,
  ADD ATTRIBUTE promptpay stripe_invoice.payment_method_promptpay,
  ADD ATTRIBUTE radar_options stripe_invoice.payment_method_radar_option,
  ADD ATTRIBUTE revolut_pay stripe_invoice.payment_method_revolut_pay,
  ADD ATTRIBUTE samsung_pay stripe_invoice.payment_method_samsung_pay,
  ADD ATTRIBUTE satispay stripe_invoice.payment_method_satispay,
  ADD ATTRIBUTE sepa_debit JSONB,
  ADD ATTRIBUTE sofort stripe_invoice.payment_method_sofort,
  ADD ATTRIBUTE swish stripe_invoice.payment_method_swish,
  ADD ATTRIBUTE twint stripe_invoice.payment_method_twint,
  ADD ATTRIBUTE us_bank_account stripe_invoice.payment_method_us_bank_account,
  ADD ATTRIBUTE wechat_pay stripe_invoice.payment_method_wechat_pay,
  ADD ATTRIBUTE zip stripe_invoice.payment_method_zip;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method(
  "id" TEXT,
  billing_details stripe_invoice.payment_method_billing_detail,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  "type" TEXT,
  acss_debit stripe_invoice.payment_method_acss_debit DEFAULT NULL,
  affirm stripe_invoice.payment_method_affirm DEFAULT NULL,
  afterpay_clearpay stripe_invoice.payment_method_afterpay_clearpay DEFAULT NULL,
  alipay stripe_invoice.payment_method_alipay DEFAULT NULL,
  allow_redisplay TEXT DEFAULT NULL,
  alma stripe_invoice.payment_method_alma DEFAULT NULL,
  amazon_pay stripe_invoice.payment_method_amazon_pay DEFAULT NULL,
  au_becs_debit stripe_invoice.payment_method_au_becs_debit DEFAULT NULL,
  bacs_debit stripe_invoice.payment_method_bacs_debit DEFAULT NULL,
  bancontact stripe_invoice.payment_method_bancontact DEFAULT NULL,
  billie stripe_invoice.payment_method_billie DEFAULT NULL,
  blik stripe_invoice.payment_method_blik DEFAULT NULL,
  boleto stripe_invoice.payment_method_boleto DEFAULT NULL,
  card JSONB DEFAULT NULL,
  card_present stripe_invoice.payment_method_card_present DEFAULT NULL,
  cashapp stripe_invoice.payment_method_cashapp DEFAULT NULL,
  crypto stripe_invoice.payment_method_crypto DEFAULT NULL,
  custom stripe_invoice.payment_method_custom DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  customer_balance stripe_invoice.payment_method_customer_balance DEFAULT NULL,
  eps stripe_invoice.payment_method_ep DEFAULT NULL,
  fpx stripe_invoice.payment_method_fpx DEFAULT NULL,
  giropay stripe_invoice.payment_method_giropay DEFAULT NULL,
  grabpay stripe_invoice.payment_method_grabpay DEFAULT NULL,
  ideal stripe_invoice.payment_method_ideal DEFAULT NULL,
  interac_present stripe_invoice.payment_method_interac_present DEFAULT NULL,
  kakao_pay stripe_invoice.payment_method_kakao_pay DEFAULT NULL,
  klarna stripe_invoice.payment_method_klarna DEFAULT NULL,
  konbini stripe_invoice.payment_method_konbini DEFAULT NULL,
  kr_card stripe_invoice.payment_method_kr_card DEFAULT NULL,
  "link" stripe_invoice.payment_method_link DEFAULT NULL,
  mb_way stripe_invoice.payment_method_mb_way DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  mobilepay stripe_invoice.payment_method_mobilepay DEFAULT NULL,
  multibanco stripe_invoice.payment_method_multibanco DEFAULT NULL,
  naver_pay stripe_invoice.payment_method_naver_pay DEFAULT NULL,
  nz_bank_account stripe_invoice.payment_method_nz_bank_account DEFAULT NULL,
  oxxo stripe_invoice.payment_method_oxxo DEFAULT NULL,
  p24 stripe_invoice.payment_method_p24 DEFAULT NULL,
  pay_by_bank stripe_invoice.payment_method_pay_by_bank DEFAULT NULL,
  payco stripe_invoice.payment_method_payco DEFAULT NULL,
  paynow stripe_invoice.payment_method_paynow DEFAULT NULL,
  paypal stripe_invoice.payment_method_paypal DEFAULT NULL,
  payto stripe_invoice.payment_method_payto DEFAULT NULL,
  pix stripe_invoice.payment_method_pix DEFAULT NULL,
  promptpay stripe_invoice.payment_method_promptpay DEFAULT NULL,
  radar_options stripe_invoice.payment_method_radar_option DEFAULT NULL,
  revolut_pay stripe_invoice.payment_method_revolut_pay DEFAULT NULL,
  samsung_pay stripe_invoice.payment_method_samsung_pay DEFAULT NULL,
  satispay stripe_invoice.payment_method_satispay DEFAULT NULL,
  sepa_debit JSONB DEFAULT NULL,
  sofort stripe_invoice.payment_method_sofort DEFAULT NULL,
  swish stripe_invoice.payment_method_swish DEFAULT NULL,
  twint stripe_invoice.payment_method_twint DEFAULT NULL,
  us_bank_account stripe_invoice.payment_method_us_bank_account DEFAULT NULL,
  wechat_pay stripe_invoice.payment_method_wechat_pay DEFAULT NULL,
  zip stripe_invoice.payment_method_zip DEFAULT NULL
)
RETURNS stripe_invoice.payment_method
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    billing_details,
    created,
    livemode,
    "object",
    "type",
    acss_debit,
    affirm,
    afterpay_clearpay,
    alipay,
    allow_redisplay,
    alma,
    amazon_pay,
    au_becs_debit,
    bacs_debit,
    bancontact,
    billie,
    blik,
    boleto,
    card,
    card_present,
    cashapp,
    crypto,
    custom,
    customer,
    customer_account,
    customer_balance,
    eps,
    fpx,
    giropay,
    grabpay,
    ideal,
    interac_present,
    kakao_pay,
    klarna,
    konbini,
    kr_card,
    "link",
    mb_way,
    metadata,
    mobilepay,
    multibanco,
    naver_pay,
    nz_bank_account,
    oxxo,
    p24,
    pay_by_bank,
    payco,
    paynow,
    paypal,
    payto,
    pix,
    promptpay,
    radar_options,
    revolut_pay,
    samsung_pay,
    satispay,
    sepa_debit,
    sofort,
    swish,
    twint,
    us_bank_account,
    wechat_pay,
    zip
  )::stripe_invoice.payment_method;
$$;

ALTER TYPE stripe_invoice.payment_method_billing_detail
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_billing_detail(
  address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  tax_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_billing_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, email, "name", phone, tax_id
  )::stripe_invoice.payment_method_billing_detail;
$$;

ALTER TYPE stripe_invoice.payment_method_acss_debit
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE institution_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE transit_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_acss_debit(
  bank_name TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  institution_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  transit_number TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_name, fingerprint, institution_number, last4, transit_number
  )::stripe_invoice.payment_method_acss_debit;
$$;

ALTER TYPE stripe_invoice.payment_method_au_becs_debit
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_au_becs_debit(
  bsb_number TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_au_becs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, fingerprint, last4
  )::stripe_invoice.payment_method_au_becs_debit;
$$;

ALTER TYPE stripe_invoice.payment_method_bacs_debit
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE sort_code TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_bacs_debit(
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  sort_code TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_bacs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, last4, sort_code
  )::stripe_invoice.payment_method_bacs_debit;
$$;

ALTER TYPE stripe_invoice.payment_method_boleto
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_boleto(
  tax_id TEXT
)
RETURNS stripe_invoice.payment_method_boleto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_id)::stripe_invoice.payment_method_boleto;
$$;

ALTER TYPE stripe_invoice.payment_method_card_present
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE brand_product TEXT,
  ADD ATTRIBUTE cardholder_name TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE issuer TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE networks stripe_invoice.payment_method_card_present_network,
  ADD ATTRIBUTE offline stripe.payment_method_details_card_present_offline,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE read_method TEXT,
  ADD ATTRIBUTE wallet stripe.p_flows_private_payment_methods_card_present_common_wallet;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_present(
  exp_month BIGINT,
  exp_year BIGINT,
  brand TEXT DEFAULT NULL,
  brand_product TEXT DEFAULT NULL,
  cardholder_name TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  issuer TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  networks stripe_invoice.payment_method_card_present_network DEFAULT NULL,
  offline stripe.payment_method_details_card_present_offline DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  read_method TEXT DEFAULT NULL,
  wallet stripe.p_flows_private_payment_methods_card_present_common_wallet DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    exp_month,
    exp_year,
    brand,
    brand_product,
    cardholder_name,
    country,
    description,
    fingerprint,
    funding,
    issuer,
    last4,
    networks,
    offline,
    preferred_locales,
    read_method,
    wallet
  )::stripe_invoice.payment_method_card_present;
$$;

ALTER TYPE stripe_invoice.payment_method_card_present_network
  ADD ATTRIBUTE available TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_present_network(
  available TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_present_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    available, preferred
  )::stripe_invoice.payment_method_card_present_network;
$$;

ALTER TYPE stripe_invoice.payment_method_cashapp
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE cashtag TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_cashapp(
  buyer_id TEXT DEFAULT NULL, cashtag TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_cashapp
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(buyer_id, cashtag)::stripe_invoice.payment_method_cashapp;
$$;

ALTER TYPE stripe_invoice.payment_method_custom
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE display_name TEXT,
  ADD ATTRIBUTE logo stripe_invoice.payment_method_custom_logo;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_custom(
  "type" TEXT,
  display_name TEXT DEFAULT NULL,
  logo stripe_invoice.payment_method_custom_logo DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_custom
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", display_name, logo)::stripe_invoice.payment_method_custom;
$$;

ALTER TYPE stripe_invoice.payment_method_custom_logo
  ADD ATTRIBUTE url TEXT, ADD ATTRIBUTE content_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_custom_logo(
  url TEXT, content_type TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_custom_logo
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(url, content_type)::stripe_invoice.payment_method_custom_logo;
$$;

ALTER TYPE stripe_invoice.payment_method_ep
  ADD ATTRIBUTE bank TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_ep(
  bank TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_ep
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank)::stripe_invoice.payment_method_ep;
$$;

ALTER TYPE stripe_invoice.payment_method_fpx
  ADD ATTRIBUTE bank TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_fpx(bank TEXT)
RETURNS stripe_invoice.payment_method_fpx
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank)::stripe_invoice.payment_method_fpx;
$$;

ALTER TYPE stripe_invoice.payment_method_ideal
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE bic TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_ideal(
  bank TEXT DEFAULT NULL, bic TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_ideal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank, bic)::stripe_invoice.payment_method_ideal;
$$;

ALTER TYPE stripe_invoice.payment_method_interac_present
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE cardholder_name TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE issuer TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE networks stripe_invoice.payment_method_interac_present_network,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE read_method TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_interac_present(
  exp_month BIGINT,
  exp_year BIGINT,
  brand TEXT DEFAULT NULL,
  cardholder_name TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  issuer TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  networks stripe_invoice.payment_method_interac_present_network DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  read_method TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_interac_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    exp_month,
    exp_year,
    brand,
    cardholder_name,
    country,
    description,
    fingerprint,
    funding,
    issuer,
    last4,
    networks,
    preferred_locales,
    read_method
  )::stripe_invoice.payment_method_interac_present;
$$;

ALTER TYPE stripe_invoice.payment_method_interac_present_network
  ADD ATTRIBUTE available TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_interac_present_network(
  available TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_interac_present_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    available, preferred
  )::stripe_invoice.payment_method_interac_present_network;
$$;

ALTER TYPE stripe_invoice.payment_method_klarna
  ADD ATTRIBUTE dob stripe_invoice.payment_method_klarna_dob;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_klarna(
  dob stripe_invoice.payment_method_klarna_dob DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(dob)::stripe_invoice.payment_method_klarna;
$$;

ALTER TYPE stripe_invoice.payment_method_klarna_dob
  ADD ATTRIBUTE "day" BIGINT,
  ADD ATTRIBUTE "month" BIGINT,
  ADD ATTRIBUTE "year" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_klarna_dob(
  "day" BIGINT DEFAULT NULL,
  "month" BIGINT DEFAULT NULL,
  "year" BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_klarna_dob
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("day", "month", "year")::stripe_invoice.payment_method_klarna_dob;
$$;

ALTER TYPE stripe_invoice.payment_method_kr_card
  ADD ATTRIBUTE brand TEXT, ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_kr_card(
  brand TEXT DEFAULT NULL, last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_kr_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(brand, last4)::stripe_invoice.payment_method_kr_card;
$$;

ALTER TYPE stripe_invoice.payment_method_link
  ADD ATTRIBUTE email TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_link(
  email TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_link
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(email)::stripe_invoice.payment_method_link;
$$;

ALTER TYPE stripe_invoice.payment_method_naver_pay
  ADD ATTRIBUTE funding TEXT, ADD ATTRIBUTE buyer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_naver_pay(
  funding TEXT, buyer_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_naver_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(funding, buyer_id)::stripe_invoice.payment_method_naver_pay;
$$;

ALTER TYPE stripe_invoice.payment_method_nz_bank_account
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE suffix TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_nz_bank_account(
  bank_code TEXT,
  bank_name TEXT,
  branch_code TEXT,
  last4 TEXT,
  account_holder_name TEXT DEFAULT NULL,
  suffix TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_nz_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, bank_name, branch_code, last4, account_holder_name, suffix
  )::stripe_invoice.payment_method_nz_bank_account;
$$;

ALTER TYPE stripe_invoice.payment_method_p24
  ADD ATTRIBUTE bank TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_p24(
  bank TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank)::stripe_invoice.payment_method_p24;
$$;

ALTER TYPE stripe_invoice.payment_method_paypal
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE payer_email TEXT,
  ADD ATTRIBUTE payer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_paypal(
  country TEXT DEFAULT NULL,
  payer_email TEXT DEFAULT NULL,
  payer_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country, payer_email, payer_id
  )::stripe_invoice.payment_method_paypal;
$$;

ALTER TYPE stripe_invoice.payment_method_payto
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE pay_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_payto(
  bsb_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  pay_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bsb_number, last4, pay_id)::stripe_invoice.payment_method_payto;
$$;

ALTER TYPE stripe_invoice.payment_method_radar_option
  ADD ATTRIBUTE "session" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_radar_option(
  "session" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_radar_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("session")::stripe_invoice.payment_method_radar_option;
$$;

ALTER TYPE stripe_invoice.payment_method_sofort
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_sofort(
  country TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_sofort
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(country)::stripe_invoice.payment_method_sofort;
$$;

ALTER TYPE stripe_invoice.payment_method_us_bank_account
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE financial_connections_account TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE networks stripe_invoice.payment_method_us_bank_account_network,
  ADD ATTRIBUTE routing_number TEXT,
  ADD ATTRIBUTE status_details stripe_invoice.payment_method_us_bank_account_status_detail;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_us_bank_account(
  account_holder_type TEXT DEFAULT NULL,
  account_type TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  financial_connections_account TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  networks stripe_invoice.payment_method_us_bank_account_network DEFAULT NULL,
  routing_number TEXT DEFAULT NULL,
  status_details stripe_invoice.payment_method_us_bank_account_status_detail DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_type,
    account_type,
    bank_name,
    financial_connections_account,
    fingerprint,
    last4,
    networks,
    routing_number,
    status_details
  )::stripe_invoice.payment_method_us_bank_account;
$$;

ALTER TYPE stripe_invoice.payment_method_us_bank_account_network
  ADD ATTRIBUTE supported TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_us_bank_account_network(
  supported TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_us_bank_account_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    supported, preferred
  )::stripe_invoice.payment_method_us_bank_account_network;
$$;

ALTER TYPE stripe_invoice.payment_method_us_bank_account_status_detail
  ADD ATTRIBUTE "blocked" stripe_invoice.payment_method_us_bank_account_status_detail_blocked;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_us_bank_account_status_detail(
  "blocked" stripe_invoice.payment_method_us_bank_account_status_detail_blocked DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_us_bank_account_status_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "blocked"
  )::stripe_invoice.payment_method_us_bank_account_status_detail;
$$;

ALTER TYPE stripe_invoice.payment_method_us_bank_account_status_detail_blocked
  ADD ATTRIBUTE network_code TEXT, ADD ATTRIBUTE reason TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_us_bank_account_status_detail_blocked(
  network_code TEXT DEFAULT NULL, reason TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_us_bank_account_status_detail_blocked
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    network_code, reason
  )::stripe_invoice.payment_method_us_bank_account_status_detail_blocked;
$$;

ALTER TYPE stripe_invoice.payment_method_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE checks stripe_invoice.payment_method_card_check,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE display_brand TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE generated_from JSONB,
  ADD ATTRIBUTE networks stripe_invoice.payment_method_card_network,
  ADD ATTRIBUTE regulated_status TEXT,
  ADD ATTRIBUTE three_d_secure_usage stripe_invoice.payment_method_card_three_d_secure_usage,
  ADD ATTRIBUTE wallet stripe_invoice.payment_method_card_wallet;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card(
  brand TEXT,
  exp_month BIGINT,
  exp_year BIGINT,
  funding TEXT,
  last4 TEXT,
  checks stripe_invoice.payment_method_card_check DEFAULT NULL,
  country TEXT DEFAULT NULL,
  display_brand TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  generated_from JSONB DEFAULT NULL,
  networks stripe_invoice.payment_method_card_network DEFAULT NULL,
  regulated_status TEXT DEFAULT NULL,
  three_d_secure_usage stripe_invoice.payment_method_card_three_d_secure_usage DEFAULT NULL,
  wallet stripe_invoice.payment_method_card_wallet DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand,
    exp_month,
    exp_year,
    funding,
    last4,
    checks,
    country,
    display_brand,
    fingerprint,
    generated_from,
    networks,
    regulated_status,
    three_d_secure_usage,
    wallet
  )::stripe_invoice.payment_method_card;
$$;

ALTER TYPE stripe_invoice.payment_method_card_check
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_postal_code_check TEXT,
  ADD ATTRIBUTE cvc_check TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_check(
  address_line1_check TEXT DEFAULT NULL,
  address_postal_code_check TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_check
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check, address_postal_code_check, cvc_check
  )::stripe_invoice.payment_method_card_check;
$$;

ALTER TYPE stripe_invoice.payment_method_card_network
  ADD ATTRIBUTE available TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_network(
  available TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(available, preferred)::stripe_invoice.payment_method_card_network;
$$;

ALTER TYPE stripe_invoice.payment_method_card_three_d_secure_usage
  ADD ATTRIBUTE supported BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_three_d_secure_usage(
  supported BOOLEAN
)
RETURNS stripe_invoice.payment_method_card_three_d_secure_usage
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    supported
  )::stripe_invoice.payment_method_card_three_d_secure_usage;
$$;

ALTER TYPE stripe_invoice.payment_method_card_wallet
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE amex_express_checkout stripe_invoice.payment_method_card_wallet_amex_express_checkout,
  ADD ATTRIBUTE apple_pay stripe_invoice.payment_method_card_wallet_apple_pay,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE google_pay stripe_invoice.payment_method_card_wallet_google_pay,
  ADD ATTRIBUTE "link" stripe_invoice.payment_method_card_wallet_link,
  ADD ATTRIBUTE masterpass stripe_invoice.payment_method_card_wallet_masterpass,
  ADD ATTRIBUTE samsung_pay stripe_invoice.payment_method_card_wallet_samsung_pay,
  ADD ATTRIBUTE visa_checkout stripe_invoice.payment_method_card_wallet_visa_checkout;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_wallet(
  "type" TEXT,
  amex_express_checkout stripe_invoice.payment_method_card_wallet_amex_express_checkout DEFAULT NULL,
  apple_pay stripe_invoice.payment_method_card_wallet_apple_pay DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  google_pay stripe_invoice.payment_method_card_wallet_google_pay DEFAULT NULL,
  "link" stripe_invoice.payment_method_card_wallet_link DEFAULT NULL,
  masterpass stripe_invoice.payment_method_card_wallet_masterpass DEFAULT NULL,
  samsung_pay stripe_invoice.payment_method_card_wallet_samsung_pay DEFAULT NULL,
  visa_checkout stripe_invoice.payment_method_card_wallet_visa_checkout DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_wallet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    amex_express_checkout,
    apple_pay,
    dynamic_last4,
    google_pay,
    "link",
    masterpass,
    samsung_pay,
    visa_checkout
  )::stripe_invoice.payment_method_card_wallet;
$$;

ALTER TYPE stripe_invoice.payment_method_card_wallet_masterpass
  ADD ATTRIBUTE billing_address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE shipping_address stripe.address;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_wallet_masterpass(
  billing_address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  shipping_address stripe.address DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_wallet_masterpass
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_address, email, "name", shipping_address
  )::stripe_invoice.payment_method_card_wallet_masterpass;
$$;

ALTER TYPE stripe_invoice.payment_method_card_wallet_visa_checkout
  ADD ATTRIBUTE billing_address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE shipping_address stripe.address;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_wallet_visa_checkout(
  billing_address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  shipping_address stripe.address DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_wallet_visa_checkout
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_address, email, "name", shipping_address
  )::stripe_invoice.payment_method_card_wallet_visa_checkout;
$$;

ALTER TYPE stripe_invoice.payment_method_card_generated_card
  ADD ATTRIBUTE charge TEXT,
  ADD ATTRIBUTE payment_method_details stripe_invoice.payment_method_card_generated_card_payment_method_detail,
  ADD ATTRIBUTE setup_attempt JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_generated_card(
  charge TEXT DEFAULT NULL,
  payment_method_details stripe_invoice.payment_method_card_generated_card_payment_method_detail DEFAULT NULL,
  setup_attempt JSONB DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_generated_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    charge, payment_method_details, setup_attempt
  )::stripe_invoice.payment_method_card_generated_card;
$$;

ALTER TYPE stripe_invoice.payment_method_card_generated_card_payment_method_detail
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE card_present stripe.payment_method_details_card_present;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_card_generated_card_payment_method_detail(
  "type" TEXT,
  card_present stripe.payment_method_details_card_present DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_card_generated_card_payment_method_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", card_present
  )::stripe_invoice.payment_method_card_generated_card_payment_method_detail;
$$;

ALTER TYPE stripe_invoice.payment_method_details_payment_record_us_bank_account
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate JSONB,
  ADD ATTRIBUTE payment_reference TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_details_payment_record_us_bank_account(
  account_holder_type TEXT DEFAULT NULL,
  account_type TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate JSONB DEFAULT NULL,
  payment_reference TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_details_payment_record_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_type,
    account_type,
    bank_name,
    expected_debit_date,
    fingerprint,
    last4,
    mandate,
    payment_reference,
    routing_number
  )::stripe_invoice.payment_method_details_payment_record_us_bank_account;
$$;

ALTER TYPE stripe_invoice.payment_method_sepa_debit
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE generated_from JSONB,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_method_sepa_debit(
  bank_code TEXT DEFAULT NULL,
  branch_code TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  generated_from JSONB DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_method_sepa_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, branch_code, country, fingerprint, generated_from, last4
  )::stripe_invoice.payment_method_sepa_debit;
$$;

ALTER TYPE stripe_invoice.payment_record
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount stripe_invoice.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_authorized stripe_invoice.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_canceled stripe_invoice.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_failed stripe_invoice.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_guaranteed stripe_invoice.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_refunded stripe_invoice.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_requested stripe_invoice.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE processor_details stripe_invoice.payment_record_processor_detail,
  ADD ATTRIBUTE reported_by TEXT,
  ADD ATTRIBUTE application TEXT,
  ADD ATTRIBUTE customer_details stripe_invoice.payment_record_customer_detail,
  ADD ATTRIBUTE customer_presence TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE latest_payment_attempt_record TEXT,
  ADD ATTRIBUTE payment_method_details JSONB,
  ADD ATTRIBUTE shipping_details stripe_invoice.payment_record_shipping_detail;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_record(
  "id" TEXT,
  amount stripe_invoice.payments_primitives_payment_records_resource_amount,
  amount_authorized stripe_invoice.payments_primitives_payment_records_resource_amount,
  amount_canceled stripe_invoice.payments_primitives_payment_records_resource_amount,
  amount_failed stripe_invoice.payments_primitives_payment_records_resource_amount,
  amount_guaranteed stripe_invoice.payments_primitives_payment_records_resource_amount,
  amount_refunded stripe_invoice.payments_primitives_payment_records_resource_amount,
  amount_requested stripe_invoice.payments_primitives_payment_records_resource_amount,
  created BIGINT,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  processor_details stripe_invoice.payment_record_processor_detail,
  reported_by TEXT,
  application TEXT DEFAULT NULL,
  customer_details stripe_invoice.payment_record_customer_detail DEFAULT NULL,
  customer_presence TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  latest_payment_attempt_record TEXT DEFAULT NULL,
  payment_method_details JSONB DEFAULT NULL,
  shipping_details stripe_invoice.payment_record_shipping_detail DEFAULT NULL
)
RETURNS stripe_invoice.payment_record
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    amount_authorized,
    amount_canceled,
    amount_failed,
    amount_guaranteed,
    amount_refunded,
    amount_requested,
    created,
    livemode,
    metadata,
    "object",
    processor_details,
    reported_by,
    application,
    customer_details,
    customer_presence,
    description,
    latest_payment_attempt_record,
    payment_method_details,
    shipping_details
  )::stripe_invoice.payment_record;
$$;

ALTER TYPE stripe_invoice.payment_record_processor_detail
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE custom stripe_invoice.payment_record_processor_detail_custom;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_record_processor_detail(
  "type" TEXT,
  custom stripe_invoice.payment_record_processor_detail_custom DEFAULT NULL
)
RETURNS stripe_invoice.payment_record_processor_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", custom)::stripe_invoice.payment_record_processor_detail;
$$;

ALTER TYPE stripe_invoice.payment_record_processor_detail_custom
  ADD ATTRIBUTE payment_reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_record_processor_detail_custom(
  payment_reference TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_record_processor_detail_custom
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_reference
  )::stripe_invoice.payment_record_processor_detail_custom;
$$;

ALTER TYPE stripe_invoice.payment_record_customer_detail
  ADD ATTRIBUTE customer TEXT,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_record_customer_detail(
  customer TEXT DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_record_customer_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    customer, email, "name", phone
  )::stripe_invoice.payment_record_customer_detail;
$$;

ALTER TYPE stripe_invoice.payment_record_shipping_detail
  ADD ATTRIBUTE address stripe_invoice.payment_record_shipping_detail_address,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_record_shipping_detail(
  address stripe_invoice.payment_record_shipping_detail_address,
  "name" TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_record_shipping_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, "name", phone
  )::stripe_invoice.payment_record_shipping_detail;
$$;

ALTER TYPE stripe_invoice.payment_record_shipping_detail_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_record_shipping_detail_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.payment_record_shipping_detail_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, "state"
  )::stripe_invoice.payment_record_shipping_detail_address;
$$;

ALTER TYPE stripe_invoice.payments_primitives_payment_records_resource_amount
  ADD ATTRIBUTE currency TEXT, ADD ATTRIBUTE "value" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payments_primitives_payment_records_resource_amount(
  currency TEXT, "value" BIGINT
)
RETURNS stripe_invoice.payments_primitives_payment_records_resource_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, "value"
  )::stripe_invoice.payments_primitives_payment_records_resource_amount;
$$;

ALTER TYPE stripe_invoice.p_primitives_payment_records_resource_payment_method_details
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE ach_credit_transfer stripe_invoice.p_p_p_r_resource_payment_method_details_ach_credit_transfer,
  ADD ATTRIBUTE ach_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_ach_debit,
  ADD ATTRIBUTE acss_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_acss_debit,
  ADD ATTRIBUTE affirm stripe_invoice.p_p_payment_records_resource_payment_method_details_affirm,
  ADD ATTRIBUTE afterpay_clearpay stripe_invoice.p_p_p_records_resource_payment_method_details_afterpay_clearpay,
  ADD ATTRIBUTE alipay stripe_invoice.p_p_payment_records_resource_payment_method_details_alipay,
  ADD ATTRIBUTE alma stripe_invoice.p_p_payment_records_resource_payment_method_details_alma,
  ADD ATTRIBUTE amazon_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_amazon_pay,
  ADD ATTRIBUTE au_becs_debit stripe_invoice.p_p_p_records_resource_payment_method_details_au_becs_debit,
  ADD ATTRIBUTE bacs_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_bacs_debit,
  ADD ATTRIBUTE bancontact JSONB,
  ADD ATTRIBUTE billie stripe_invoice.p_p_payment_records_resource_payment_method_details_billie,
  ADD ATTRIBUTE billing_details stripe_invoice.p_p_p_records_resource_payment_method_details_billing_detail,
  ADD ATTRIBUTE blik stripe_invoice.p_p_payment_records_resource_payment_method_details_blik,
  ADD ATTRIBUTE boleto stripe_invoice.p_p_payment_records_resource_payment_method_details_boleto,
  ADD ATTRIBUTE card stripe_invoice.p_p_payment_records_resource_payment_method_details_card,
  ADD ATTRIBUTE card_present stripe.payment_method_details_card_present,
  ADD ATTRIBUTE cashapp stripe_invoice.p_p_payment_records_resource_payment_method_details_cashapp,
  ADD ATTRIBUTE crypto stripe_invoice.p_p_payment_records_resource_payment_method_details_crypto,
  ADD ATTRIBUTE custom stripe_invoice.p_p_payment_records_resource_payment_method_details_custom,
  ADD ATTRIBUTE customer_balance stripe_invoice.p_p_p_records_resource_payment_method_details_customer_balance,
  ADD ATTRIBUTE eps stripe_invoice.p_primitives_payment_records_resource_payment_method_details_ep,
  ADD ATTRIBUTE fpx stripe_invoice.p_p_payment_records_resource_payment_method_details_fpx,
  ADD ATTRIBUTE giropay stripe_invoice.p_p_payment_records_resource_payment_method_details_giropay,
  ADD ATTRIBUTE grabpay stripe_invoice.p_p_payment_records_resource_payment_method_details_grabpay,
  ADD ATTRIBUTE ideal JSONB,
  ADD ATTRIBUTE interac_present stripe_invoice.p_p_p_records_resource_payment_method_details_interac_present,
  ADD ATTRIBUTE kakao_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_kakao_pay,
  ADD ATTRIBUTE klarna stripe_invoice.p_p_payment_records_resource_payment_method_details_klarna,
  ADD ATTRIBUTE konbini stripe_invoice.p_p_payment_records_resource_payment_method_details_konbini,
  ADD ATTRIBUTE kr_card stripe_invoice.p_p_payment_records_resource_payment_method_details_kr_card,
  ADD ATTRIBUTE "link" stripe_invoice.p_p_payment_records_resource_payment_method_details_link,
  ADD ATTRIBUTE mb_way stripe_invoice.p_p_payment_records_resource_payment_method_details_mb_way,
  ADD ATTRIBUTE mobilepay stripe_invoice.p_p_payment_records_resource_payment_method_details_mobilepay,
  ADD ATTRIBUTE multibanco stripe_invoice.p_p_payment_records_resource_payment_method_details_multibanco,
  ADD ATTRIBUTE naver_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_naver_pay,
  ADD ATTRIBUTE nz_bank_account stripe_invoice.p_p_p_records_resource_payment_method_details_nz_bank_account,
  ADD ATTRIBUTE oxxo stripe_invoice.p_p_payment_records_resource_payment_method_details_oxxo,
  ADD ATTRIBUTE p24 stripe_invoice.p_p_payment_records_resource_payment_method_details_p24,
  ADD ATTRIBUTE pay_by_bank stripe_invoice.p_p_payment_records_resource_payment_method_details_pay_by_bank,
  ADD ATTRIBUTE payco stripe_invoice.p_p_payment_records_resource_payment_method_details_payco,
  ADD ATTRIBUTE payment_method TEXT,
  ADD ATTRIBUTE paynow stripe_invoice.p_p_payment_records_resource_payment_method_details_paynow,
  ADD ATTRIBUTE paypal stripe_invoice.p_p_payment_records_resource_payment_method_details_paypal,
  ADD ATTRIBUTE payto stripe_invoice.p_p_payment_records_resource_payment_method_details_payto,
  ADD ATTRIBUTE pix stripe_invoice.p_p_payment_records_resource_payment_method_details_pix,
  ADD ATTRIBUTE promptpay stripe_invoice.p_p_payment_records_resource_payment_method_details_promptpay,
  ADD ATTRIBUTE revolut_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_revolut_pay,
  ADD ATTRIBUTE samsung_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_samsung_pay,
  ADD ATTRIBUTE satispay stripe_invoice.p_p_payment_records_resource_payment_method_details_satispay,
  ADD ATTRIBUTE sepa_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_sepa_debit,
  ADD ATTRIBUTE sofort JSONB,
  ADD ATTRIBUTE stripe_account stripe_invoice.p_p_p_records_resource_payment_method_details_stripe_account,
  ADD ATTRIBUTE swish stripe_invoice.p_p_payment_records_resource_payment_method_details_swish,
  ADD ATTRIBUTE twint stripe_invoice.p_p_payment_records_resource_payment_method_details_twint,
  ADD ATTRIBUTE us_bank_account JSONB,
  ADD ATTRIBUTE wechat stripe_invoice.p_p_payment_records_resource_payment_method_details_wechat,
  ADD ATTRIBUTE wechat_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_wechat_pay,
  ADD ATTRIBUTE zip stripe_invoice.p_p_payment_records_resource_payment_method_details_zip;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_primitives_payment_records_resource_payment_method_details(
  "type" TEXT,
  ach_credit_transfer stripe_invoice.p_p_p_r_resource_payment_method_details_ach_credit_transfer DEFAULT NULL,
  ach_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_ach_debit DEFAULT NULL,
  acss_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_acss_debit DEFAULT NULL,
  affirm stripe_invoice.p_p_payment_records_resource_payment_method_details_affirm DEFAULT NULL,
  afterpay_clearpay stripe_invoice.p_p_p_records_resource_payment_method_details_afterpay_clearpay DEFAULT NULL,
  alipay stripe_invoice.p_p_payment_records_resource_payment_method_details_alipay DEFAULT NULL,
  alma stripe_invoice.p_p_payment_records_resource_payment_method_details_alma DEFAULT NULL,
  amazon_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_amazon_pay DEFAULT NULL,
  au_becs_debit stripe_invoice.p_p_p_records_resource_payment_method_details_au_becs_debit DEFAULT NULL,
  bacs_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_bacs_debit DEFAULT NULL,
  bancontact JSONB DEFAULT NULL,
  billie stripe_invoice.p_p_payment_records_resource_payment_method_details_billie DEFAULT NULL,
  billing_details stripe_invoice.p_p_p_records_resource_payment_method_details_billing_detail DEFAULT NULL,
  blik stripe_invoice.p_p_payment_records_resource_payment_method_details_blik DEFAULT NULL,
  boleto stripe_invoice.p_p_payment_records_resource_payment_method_details_boleto DEFAULT NULL,
  card stripe_invoice.p_p_payment_records_resource_payment_method_details_card DEFAULT NULL,
  card_present stripe.payment_method_details_card_present DEFAULT NULL,
  cashapp stripe_invoice.p_p_payment_records_resource_payment_method_details_cashapp DEFAULT NULL,
  crypto stripe_invoice.p_p_payment_records_resource_payment_method_details_crypto DEFAULT NULL,
  custom stripe_invoice.p_p_payment_records_resource_payment_method_details_custom DEFAULT NULL,
  customer_balance stripe_invoice.p_p_p_records_resource_payment_method_details_customer_balance DEFAULT NULL,
  eps stripe_invoice.p_primitives_payment_records_resource_payment_method_details_ep DEFAULT NULL,
  fpx stripe_invoice.p_p_payment_records_resource_payment_method_details_fpx DEFAULT NULL,
  giropay stripe_invoice.p_p_payment_records_resource_payment_method_details_giropay DEFAULT NULL,
  grabpay stripe_invoice.p_p_payment_records_resource_payment_method_details_grabpay DEFAULT NULL,
  ideal JSONB DEFAULT NULL,
  interac_present stripe_invoice.p_p_p_records_resource_payment_method_details_interac_present DEFAULT NULL,
  kakao_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_kakao_pay DEFAULT NULL,
  klarna stripe_invoice.p_p_payment_records_resource_payment_method_details_klarna DEFAULT NULL,
  konbini stripe_invoice.p_p_payment_records_resource_payment_method_details_konbini DEFAULT NULL,
  kr_card stripe_invoice.p_p_payment_records_resource_payment_method_details_kr_card DEFAULT NULL,
  "link" stripe_invoice.p_p_payment_records_resource_payment_method_details_link DEFAULT NULL,
  mb_way stripe_invoice.p_p_payment_records_resource_payment_method_details_mb_way DEFAULT NULL,
  mobilepay stripe_invoice.p_p_payment_records_resource_payment_method_details_mobilepay DEFAULT NULL,
  multibanco stripe_invoice.p_p_payment_records_resource_payment_method_details_multibanco DEFAULT NULL,
  naver_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_naver_pay DEFAULT NULL,
  nz_bank_account stripe_invoice.p_p_p_records_resource_payment_method_details_nz_bank_account DEFAULT NULL,
  oxxo stripe_invoice.p_p_payment_records_resource_payment_method_details_oxxo DEFAULT NULL,
  p24 stripe_invoice.p_p_payment_records_resource_payment_method_details_p24 DEFAULT NULL,
  pay_by_bank stripe_invoice.p_p_payment_records_resource_payment_method_details_pay_by_bank DEFAULT NULL,
  payco stripe_invoice.p_p_payment_records_resource_payment_method_details_payco DEFAULT NULL,
  payment_method TEXT DEFAULT NULL,
  paynow stripe_invoice.p_p_payment_records_resource_payment_method_details_paynow DEFAULT NULL,
  paypal stripe_invoice.p_p_payment_records_resource_payment_method_details_paypal DEFAULT NULL,
  payto stripe_invoice.p_p_payment_records_resource_payment_method_details_payto DEFAULT NULL,
  pix stripe_invoice.p_p_payment_records_resource_payment_method_details_pix DEFAULT NULL,
  promptpay stripe_invoice.p_p_payment_records_resource_payment_method_details_promptpay DEFAULT NULL,
  revolut_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_revolut_pay DEFAULT NULL,
  samsung_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_samsung_pay DEFAULT NULL,
  satispay stripe_invoice.p_p_payment_records_resource_payment_method_details_satispay DEFAULT NULL,
  sepa_debit stripe_invoice.p_p_payment_records_resource_payment_method_details_sepa_debit DEFAULT NULL,
  sofort JSONB DEFAULT NULL,
  stripe_account stripe_invoice.p_p_p_records_resource_payment_method_details_stripe_account DEFAULT NULL,
  swish stripe_invoice.p_p_payment_records_resource_payment_method_details_swish DEFAULT NULL,
  twint stripe_invoice.p_p_payment_records_resource_payment_method_details_twint DEFAULT NULL,
  us_bank_account JSONB DEFAULT NULL,
  wechat stripe_invoice.p_p_payment_records_resource_payment_method_details_wechat DEFAULT NULL,
  wechat_pay stripe_invoice.p_p_payment_records_resource_payment_method_details_wechat_pay DEFAULT NULL,
  zip stripe_invoice.p_p_payment_records_resource_payment_method_details_zip DEFAULT NULL
)
RETURNS stripe_invoice.p_primitives_payment_records_resource_payment_method_details
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    ach_credit_transfer,
    ach_debit,
    acss_debit,
    affirm,
    afterpay_clearpay,
    alipay,
    alma,
    amazon_pay,
    au_becs_debit,
    bacs_debit,
    bancontact,
    billie,
    billing_details,
    blik,
    boleto,
    card,
    card_present,
    cashapp,
    crypto,
    custom,
    customer_balance,
    eps,
    fpx,
    giropay,
    grabpay,
    ideal,
    interac_present,
    kakao_pay,
    klarna,
    konbini,
    kr_card,
    "link",
    mb_way,
    mobilepay,
    multibanco,
    naver_pay,
    nz_bank_account,
    oxxo,
    p24,
    pay_by_bank,
    payco,
    payment_method,
    paynow,
    paypal,
    payto,
    pix,
    promptpay,
    revolut_pay,
    samsung_pay,
    satispay,
    sepa_debit,
    sofort,
    stripe_account,
    swish,
    twint,
    us_bank_account,
    wechat,
    wechat_pay,
    zip
  )::stripe_invoice.p_primitives_payment_records_resource_payment_method_details;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_ach_credit_transfer
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE routing_number TEXT,
  ADD ATTRIBUTE swift_code TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_ach_credit_transfer(
  account_number TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL,
  swift_code TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_ach_credit_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_number, bank_name, routing_number, swift_code
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_ach_credit_transfer;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_ach_debit
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_ach_debit(
  account_holder_type TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_ach_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_type, bank_name, country, fingerprint, last4, routing_number
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_ach_debit;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_acss_debit
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE institution_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE transit_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_acss_debit(
  bank_name TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  institution_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  transit_number TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_name,
    expected_debit_date,
    fingerprint,
    institution_number,
    last4,
    mandate,
    transit_number
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_acss_debit;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_affirm
  ADD ATTRIBUTE "location" TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_affirm(
  "location" TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_affirm
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "location", reader, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_affirm;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_afterpay_clearpay
  ADD ATTRIBUTE order_id TEXT, ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_afterpay_clearpay(
  order_id TEXT DEFAULT NULL, reference TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_afterpay_clearpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    order_id, reference
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_afterpay_clearpay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_alipay
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_alipay(
  buyer_id TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_alipay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, fingerprint, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_alipay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_alma
  ADD ATTRIBUTE installments stripe_invoice.p_p_p_records_resource_payment_method_details_alma_installment,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_alma(
  installments stripe_invoice.p_p_p_records_resource_payment_method_details_alma_installment DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_alma
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    installments, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_alma;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_alma_installment
  ADD ATTRIBUTE "count" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_alma_installment(
  "count" BIGINT
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_alma_installment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "count"
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_alma_installment;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_amazon_pay
  ADD ATTRIBUTE funding stripe_invoice.p_p_p_r_resource_payment_method_details_amazon_pay_funding,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_amazon_pay(
  funding stripe_invoice.p_p_p_r_resource_payment_method_details_amazon_pay_funding DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_amazon_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    funding, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_amazon_pay;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_amazon_pay_funding
  ADD ATTRIBUTE card stripe.payment_method_details_passthrough_card,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_amazon_pay_funding(
  card stripe.payment_method_details_passthrough_card DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_amazon_pay_funding
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card, "type"
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_amazon_pay_funding;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_au_becs_debit
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_au_becs_debit(
  bsb_number TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_au_becs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, expected_debit_date, fingerprint, last4, mandate
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_au_becs_debit;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_bacs_debit
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE sort_code TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_bacs_debit(
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  sort_code TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_bacs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expected_debit_date, fingerprint, last4, mandate, sort_code
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_bacs_debit;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_billie
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_billie(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_billie
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_billie;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_billing_detail
  ADD ATTRIBUTE address stripe_invoice.p_p_p_r_resource_payment_method_details_billing_detail_address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_billing_detail(
  address stripe_invoice.p_p_p_r_resource_payment_method_details_billing_detail_address,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_billing_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, email, "name", phone
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_billing_detail;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_billing_detail_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_r_payment_method_details_billing_detail_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_billing_detail_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, "state"
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_billing_detail_address;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_blik
  ADD ATTRIBUTE buyer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_blik(
  buyer_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_blik
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_blik;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_boleto
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_boleto(
  tax_id TEXT
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_boleto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    tax_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_boleto;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE capture_before BIGINT,
  ADD ATTRIBUTE checks stripe_invoice.p_p_payment_records_resource_payment_method_details_card_check,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE iin TEXT,
  ADD ATTRIBUTE installments stripe_invoice.p_p_p_records_resource_payment_method_details_card_installment,
  ADD ATTRIBUTE issuer TEXT,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE network_advice_code TEXT,
  ADD ATTRIBUTE network_decline_code TEXT,
  ADD ATTRIBUTE network_token stripe_invoice.p_p_p_r_resource_payment_method_details_card_network_token,
  ADD ATTRIBUTE network_transaction_id TEXT,
  ADD ATTRIBUTE stored_credential_usage TEXT,
  ADD ATTRIBUTE three_d_secure stripe_invoice.p_p_p_r_resource_payment_method_details_card_three_d_secure,
  ADD ATTRIBUTE wallet stripe_invoice.p_p_payment_records_resource_payment_method_details_card_wallet;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_card(
  brand TEXT,
  exp_month BIGINT,
  exp_year BIGINT,
  funding TEXT,
  last4 TEXT,
  authorization_code TEXT DEFAULT NULL,
  capture_before BIGINT DEFAULT NULL,
  checks stripe_invoice.p_p_payment_records_resource_payment_method_details_card_check DEFAULT NULL,
  country TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  iin TEXT DEFAULT NULL,
  installments stripe_invoice.p_p_p_records_resource_payment_method_details_card_installment DEFAULT NULL,
  issuer TEXT DEFAULT NULL,
  network TEXT DEFAULT NULL,
  network_advice_code TEXT DEFAULT NULL,
  network_decline_code TEXT DEFAULT NULL,
  network_token stripe_invoice.p_p_p_r_resource_payment_method_details_card_network_token DEFAULT NULL,
  network_transaction_id TEXT DEFAULT NULL,
  stored_credential_usage TEXT DEFAULT NULL,
  three_d_secure stripe_invoice.p_p_p_r_resource_payment_method_details_card_three_d_secure DEFAULT NULL,
  wallet stripe_invoice.p_p_payment_records_resource_payment_method_details_card_wallet DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand,
    exp_month,
    exp_year,
    funding,
    last4,
    authorization_code,
    capture_before,
    checks,
    country,
    description,
    fingerprint,
    iin,
    installments,
    issuer,
    network,
    network_advice_code,
    network_decline_code,
    network_token,
    network_transaction_id,
    stored_credential_usage,
    three_d_secure,
    wallet
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_card;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_card_check
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_postal_code_check TEXT,
  ADD ATTRIBUTE cvc_check TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_card_check(
  address_line1_check TEXT DEFAULT NULL,
  address_postal_code_check TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_card_check
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check, address_postal_code_check, cvc_check
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_card_check;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_card_installment
  ADD ATTRIBUTE "plan" stripe_invoice.p_p_p_r_resource_payment_method_details_card_installment_plan;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_card_installment(
  "plan" stripe_invoice.p_p_p_r_resource_payment_method_details_card_installment_plan DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_card_installment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "plan"
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_card_installment;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_card_installment_plan
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE "count" BIGINT,
  ADD ATTRIBUTE "interval" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_card_installment_plan(
  "type" TEXT, "count" BIGINT DEFAULT NULL, "interval" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_card_installment_plan
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", "count", "interval"
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_card_installment_plan;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_card_network_token
  ADD ATTRIBUTE used BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_card_network_token(
  used BOOLEAN
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_card_network_token
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    used
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_card_network_token;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_card_three_d_secure
  ADD ATTRIBUTE authentication_flow TEXT,
  ADD ATTRIBUTE "result" TEXT,
  ADD ATTRIBUTE result_reason TEXT,
  ADD ATTRIBUTE "version" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_card_three_d_secure(
  authentication_flow TEXT DEFAULT NULL,
  "result" TEXT DEFAULT NULL,
  result_reason TEXT DEFAULT NULL,
  "version" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_card_three_d_secure
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    authentication_flow, "result", result_reason, "version"
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_card_three_d_secure;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_card_wallet
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE apple_pay stripe_invoice.p_p_p_r_resource_payment_method_details_card_wallet_apple_pay,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE google_pay stripe_invoice.p_p_p_r_resource_payment_method_details_card_wallet_google_pay;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_card_wallet(
  "type" TEXT,
  apple_pay stripe_invoice.p_p_p_r_resource_payment_method_details_card_wallet_apple_pay DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  google_pay stripe_invoice.p_p_p_r_resource_payment_method_details_card_wallet_google_pay DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_card_wallet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", apple_pay, dynamic_last4, google_pay
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_card_wallet;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_card_wallet_apple_pay
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_card_wallet_apple_pay(
  "type" TEXT
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_card_wallet_apple_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type"
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_card_wallet_apple_pay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_cashapp
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE cashtag TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_cashapp(
  buyer_id TEXT DEFAULT NULL,
  cashtag TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_cashapp
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, cashtag, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_cashapp;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_crypto
  ADD ATTRIBUTE buyer_address TEXT,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE token_currency TEXT,
  ADD ATTRIBUTE transaction_hash TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_crypto(
  buyer_address TEXT DEFAULT NULL,
  network TEXT DEFAULT NULL,
  token_currency TEXT DEFAULT NULL,
  transaction_hash TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_crypto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_address, network, token_currency, transaction_hash
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_crypto;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_custom
  ADD ATTRIBUTE display_name TEXT, ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_custom(
  display_name TEXT, "type" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_custom
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    display_name, "type"
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_custom;
$$;

ALTER TYPE stripe_invoice.p_primitives_payment_records_resource_payment_method_details_ep
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_ep(
  bank TEXT DEFAULT NULL, verified_name TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_primitives_payment_records_resource_payment_method_details_ep
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, verified_name
  )::stripe_invoice.p_primitives_payment_records_resource_payment_method_details_ep;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_fpx
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_fpx(
  bank TEXT, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_fpx
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_fpx;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_giropay
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_giropay(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_giropay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, bank_name, bic, verified_name
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_giropay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_grabpay
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_grabpay(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_grabpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_grabpay;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_interac_present
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE cardholder_name TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE emv_auth_data TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE generated_card TEXT,
  ADD ATTRIBUTE issuer TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE network_transaction_id TEXT,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE read_method TEXT,
  ADD ATTRIBUTE receipt stripe_invoice.p_p_p_r_resource_payment_method_details_interac_present_receipt;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_interac_present(
  exp_month BIGINT,
  exp_year BIGINT,
  brand TEXT DEFAULT NULL,
  cardholder_name TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  emv_auth_data TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  generated_card TEXT DEFAULT NULL,
  issuer TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  network TEXT DEFAULT NULL,
  network_transaction_id TEXT DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  read_method TEXT DEFAULT NULL,
  receipt stripe_invoice.p_p_p_r_resource_payment_method_details_interac_present_receipt DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_interac_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    exp_month,
    exp_year,
    brand,
    cardholder_name,
    country,
    description,
    emv_auth_data,
    fingerprint,
    funding,
    generated_card,
    issuer,
    last4,
    network,
    network_transaction_id,
    preferred_locales,
    read_method,
    receipt
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_interac_present;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_interac_present_receipt
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE application_cryptogram TEXT,
  ADD ATTRIBUTE application_preferred_name TEXT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE authorization_response_code TEXT,
  ADD ATTRIBUTE cardholder_verification_method TEXT,
  ADD ATTRIBUTE dedicated_file_name TEXT,
  ADD ATTRIBUTE terminal_verification_results TEXT,
  ADD ATTRIBUTE transaction_status_information TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_r_payment_method_details_interac_present_receipt(
  account_type TEXT DEFAULT NULL,
  application_cryptogram TEXT DEFAULT NULL,
  application_preferred_name TEXT DEFAULT NULL,
  authorization_code TEXT DEFAULT NULL,
  authorization_response_code TEXT DEFAULT NULL,
  cardholder_verification_method TEXT DEFAULT NULL,
  dedicated_file_name TEXT DEFAULT NULL,
  terminal_verification_results TEXT DEFAULT NULL,
  transaction_status_information TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_interac_present_receipt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_type,
    application_cryptogram,
    application_preferred_name,
    authorization_code,
    authorization_response_code,
    cardholder_verification_method,
    dedicated_file_name,
    terminal_verification_results,
    transaction_status_information
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_interac_present_receipt;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_kakao_pay
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_kakao_pay(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_kakao_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_kakao_pay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_klarna
  ADD ATTRIBUTE payer_details stripe_invoice.p_p_p_r_resource_payment_method_details_klarna_payer_detail,
  ADD ATTRIBUTE payment_method_category TEXT,
  ADD ATTRIBUTE preferred_locale TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_klarna(
  payer_details stripe_invoice.p_p_p_r_resource_payment_method_details_klarna_payer_detail DEFAULT NULL,
  payment_method_category TEXT DEFAULT NULL,
  preferred_locale TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payer_details, payment_method_category, preferred_locale
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_klarna;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_klarna_payer_detail
  ADD ATTRIBUTE address stripe_invoice.p_p_p_r_r_payment_method_details_klarna_payer_detail_address;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_klarna_payer_detail(
  address stripe_invoice.p_p_p_r_r_payment_method_details_klarna_payer_detail_address DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_klarna_payer_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_klarna_payer_detail;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_r_payment_method_details_klarna_payer_detail_address
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_r_payment_method_details_klarna_payer_detail_address(
  country TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_r_payment_method_details_klarna_payer_detail_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_invoice.p_p_p_r_r_payment_method_details_klarna_payer_detail_address;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_konbini
  ADD ATTRIBUTE store stripe_invoice.p_p_p_records_resource_payment_method_details_konbini_store;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_konbini(
  store stripe_invoice.p_p_p_records_resource_payment_method_details_konbini_store DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_konbini
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    store
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_konbini;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_konbini_store
  ADD ATTRIBUTE "chain" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_konbini_store(
  "chain" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_konbini_store
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "chain"
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_konbini_store;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_kr_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_kr_card(
  brand TEXT DEFAULT NULL,
  buyer_id TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_kr_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, buyer_id, last4, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_kr_card;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_link
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_link(
  country TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_link
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_link;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_mobilepay
  ADD ATTRIBUTE card stripe_invoice.p_p_p_records_resource_payment_method_details_mobilepay_card;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_mobilepay(
  card stripe_invoice.p_p_p_records_resource_payment_method_details_mobilepay_card DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_mobilepay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_mobilepay;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_mobilepay_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_mobilepay_card(
  brand TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_mobilepay_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, country, exp_month, exp_year, last4
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_mobilepay_card;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_multibanco
  ADD ATTRIBUTE entity TEXT, ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_multibanco(
  entity TEXT DEFAULT NULL, reference TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_multibanco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    entity, reference
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_multibanco;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_naver_pay
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_naver_pay(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_naver_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_naver_pay;
$$;

ALTER TYPE stripe_invoice.p_p_p_records_resource_payment_method_details_nz_bank_account
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE suffix TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_nz_bank_account(
  bank_code TEXT,
  bank_name TEXT,
  branch_code TEXT,
  last4 TEXT,
  account_holder_name TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  suffix TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_records_resource_payment_method_details_nz_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    bank_name,
    branch_code,
    last4,
    account_holder_name,
    expected_debit_date,
    suffix
  )::stripe_invoice.p_p_p_records_resource_payment_method_details_nz_bank_account;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_oxxo
  ADD ATTRIBUTE "number" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_oxxo(
  "number" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_oxxo
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "number"
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_oxxo;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_p24
  ADD ATTRIBUTE bank TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_p24(
  bank TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, reference, verified_name
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_p24;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_payco
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_payco(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_payco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_payco;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_paynow
  ADD ATTRIBUTE "location" TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_paynow(
  "location" TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_paynow
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "location", reader, reference
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_paynow;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_paypal
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE payer_email TEXT,
  ADD ATTRIBUTE payer_id TEXT,
  ADD ATTRIBUTE payer_name TEXT,
  ADD ATTRIBUTE seller_protection stripe_invoice.p_p_p_r_r_payment_method_details_paypal_seller_protection,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_paypal(
  country TEXT DEFAULT NULL,
  payer_email TEXT DEFAULT NULL,
  payer_id TEXT DEFAULT NULL,
  payer_name TEXT DEFAULT NULL,
  seller_protection stripe_invoice.p_p_p_r_r_payment_method_details_paypal_seller_protection DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country,
    payer_email,
    payer_id,
    payer_name,
    seller_protection,
    transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_paypal;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_r_payment_method_details_paypal_seller_protection
  ADD ATTRIBUTE status TEXT, ADD ATTRIBUTE dispute_categories TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_r_payment_method_details_paypal_seller_protection(
  status TEXT, dispute_categories TEXT[] DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_r_payment_method_details_paypal_seller_protection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status, dispute_categories
  )::stripe_invoice.p_p_p_r_r_payment_method_details_paypal_seller_protection;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_payto
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE pay_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_payto(
  bsb_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  pay_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, last4, mandate, pay_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_payto;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_pix
  ADD ATTRIBUTE bank_transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_pix(
  bank_transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_pix
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_pix;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_promptpay
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_promptpay(
  reference TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_promptpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_promptpay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_revolut_pay
  ADD ATTRIBUTE funding stripe_invoice.p_p_p_r_resource_payment_method_details_revolut_pay_funding,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_revolut_pay(
  funding stripe_invoice.p_p_p_r_resource_payment_method_details_revolut_pay_funding DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_revolut_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    funding, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_revolut_pay;
$$;

ALTER TYPE stripe_invoice.p_p_p_r_resource_payment_method_details_revolut_pay_funding
  ADD ATTRIBUTE card stripe.payment_method_details_passthrough_card,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_r_resource_payment_method_details_revolut_pay_funding(
  card stripe.payment_method_details_passthrough_card DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_p_r_resource_payment_method_details_revolut_pay_funding
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card, "type"
  )::stripe_invoice.p_p_p_r_resource_payment_method_details_revolut_pay_funding;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_samsung_pay
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_samsung_pay(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_samsung_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_samsung_pay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_satispay
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_satispay(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_satispay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_satispay;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_sepa_debit
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_sepa_debit(
  bank_code TEXT DEFAULT NULL,
  branch_code TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_sepa_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    branch_code,
    country,
    expected_debit_date,
    fingerprint,
    last4,
    mandate
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_sepa_debit;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_swish
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE payment_reference TEXT,
  ADD ATTRIBUTE verified_phone_last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_payment_records_resource_payment_method_details_swish(
  fingerprint TEXT DEFAULT NULL,
  payment_reference TEXT DEFAULT NULL,
  verified_phone_last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_swish
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, payment_reference, verified_phone_last4
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_swish;
$$;

ALTER TYPE stripe_invoice.p_p_payment_records_resource_payment_method_details_wechat_pay
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE "location" TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.m_p_p_p_records_resource_payment_method_details_wechat_pay(
  fingerprint TEXT DEFAULT NULL,
  "location" TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoice.p_p_payment_records_resource_payment_method_details_wechat_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, "location", reader, transaction_id
  )::stripe_invoice.p_p_payment_records_resource_payment_method_details_wechat_pay;
$$;

ALTER TYPE stripe_invoice.sepa_debit_generated_from
  ADD ATTRIBUTE charge JSONB, ADD ATTRIBUTE setup_attempt JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_sepa_debit_generated_from(
  charge JSONB DEFAULT NULL, setup_attempt JSONB DEFAULT NULL
)
RETURNS stripe_invoice.sepa_debit_generated_from
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(charge, setup_attempt)::stripe_invoice.sepa_debit_generated_from;
$$;

ALTER TYPE stripe_invoice.shipping_rate_delivery_estimate_bound
  ADD ATTRIBUTE unit TEXT, ADD ATTRIBUTE "value" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_rate_delivery_estimate_bound(
  unit TEXT, "value" BIGINT
)
RETURNS stripe_invoice.shipping_rate_delivery_estimate_bound
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    unit, "value"
  )::stripe_invoice.shipping_rate_delivery_estimate_bound;
$$;

ALTER TYPE stripe_invoice.tax_rate
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE active BOOLEAN,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE display_name TEXT,
  ADD ATTRIBUTE inclusive BOOLEAN,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE percentage DOUBLE PRECISION,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE effective_percentage DOUBLE PRECISION,
  ADD ATTRIBUTE flat_amount stripe_invoice.tax_rate_flat_amount,
  ADD ATTRIBUTE jurisdiction TEXT,
  ADD ATTRIBUTE jurisdiction_level TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE rate_type TEXT,
  ADD ATTRIBUTE "state" TEXT,
  ADD ATTRIBUTE tax_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_tax_rate(
  "id" TEXT,
  active BOOLEAN,
  created BIGINT,
  display_name TEXT,
  inclusive BOOLEAN,
  livemode BOOLEAN,
  "object" TEXT,
  percentage DOUBLE PRECISION,
  country TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  effective_percentage DOUBLE PRECISION DEFAULT NULL,
  flat_amount stripe_invoice.tax_rate_flat_amount DEFAULT NULL,
  jurisdiction TEXT DEFAULT NULL,
  jurisdiction_level TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  rate_type TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL,
  tax_type TEXT DEFAULT NULL
)
RETURNS stripe_invoice.tax_rate
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    active,
    created,
    display_name,
    inclusive,
    livemode,
    "object",
    percentage,
    country,
    description,
    effective_percentage,
    flat_amount,
    jurisdiction,
    jurisdiction_level,
    metadata,
    rate_type,
    "state",
    tax_type
  )::stripe_invoice.tax_rate;
$$;

ALTER TYPE stripe_invoice.tax_rate_flat_amount
  ADD ATTRIBUTE amount BIGINT, ADD ATTRIBUTE currency TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_tax_rate_flat_amount(
  amount BIGINT, currency TEXT
)
RETURNS stripe_invoice.tax_rate_flat_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(amount, currency)::stripe_invoice.tax_rate_flat_amount;
$$;

ALTER TYPE stripe_invoice.automatic_tax
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE liability stripe_invoice.automatic_tax_liability;

CREATE OR REPLACE FUNCTION stripe_invoice.make_automatic_tax(
  enabled BOOLEAN, liability stripe_invoice.automatic_tax_liability DEFAULT NULL
)
RETURNS stripe_invoice.automatic_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled, liability)::stripe_invoice.automatic_tax;
$$;

ALTER TYPE stripe_invoice.automatic_tax_liability
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_automatic_tax_liability(
  "type" TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_invoice.automatic_tax_liability
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", account)::stripe_invoice.automatic_tax_liability;
$$;

ALTER TYPE stripe_invoice.from_invoice
  ADD ATTRIBUTE "action" TEXT, ADD ATTRIBUTE invoice TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_from_invoice(
  "action" TEXT, invoice TEXT
)
RETURNS stripe_invoice.from_invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("action", invoice)::stripe_invoice.from_invoice;
$$;

ALTER TYPE stripe_invoice.issuer
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_issuer(
  "type" TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_invoice.issuer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", account)::stripe_invoice.issuer;
$$;

ALTER TYPE stripe_invoice.payment_setting
  ADD ATTRIBUTE default_mandate TEXT,
  ADD ATTRIBUTE payment_method_options stripe_invoice.payment_setting_payment_method_option,
  ADD ATTRIBUTE payment_method_types JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_setting(
  default_mandate TEXT DEFAULT NULL,
  payment_method_options stripe_invoice.payment_setting_payment_method_option DEFAULT NULL,
  payment_method_types JSONB DEFAULT NULL
)
RETURNS stripe_invoice.payment_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_mandate, payment_method_options, payment_method_types
  )::stripe_invoice.payment_setting;
$$;

ALTER TYPE stripe_invoice.payment_setting_payment_method_option
  ADD ATTRIBUTE acss_debit JSONB,
  ADD ATTRIBUTE bancontact JSONB,
  ADD ATTRIBUTE card JSONB,
  ADD ATTRIBUTE customer_balance JSONB,
  ADD ATTRIBUTE konbini JSONB,
  ADD ATTRIBUTE payto JSONB,
  ADD ATTRIBUTE sepa_debit JSONB,
  ADD ATTRIBUTE us_bank_account JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_payment_setting_payment_method_option(
  acss_debit JSONB DEFAULT NULL,
  bancontact JSONB DEFAULT NULL,
  card JSONB DEFAULT NULL,
  customer_balance JSONB DEFAULT NULL,
  konbini JSONB DEFAULT NULL,
  payto JSONB DEFAULT NULL,
  sepa_debit JSONB DEFAULT NULL,
  us_bank_account JSONB DEFAULT NULL
)
RETURNS stripe_invoice.payment_setting_payment_method_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    acss_debit,
    bancontact,
    card,
    customer_balance,
    konbini,
    payto,
    sepa_debit,
    us_bank_account
  )::stripe_invoice.payment_setting_payment_method_option;
$$;

ALTER TYPE stripe_invoice.rendering
  ADD ATTRIBUTE amount_tax_display TEXT,
  ADD ATTRIBUTE pdf stripe_invoice.rendering_pdf,
  ADD ATTRIBUTE "template" TEXT,
  ADD ATTRIBUTE template_version JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_rendering(
  amount_tax_display TEXT DEFAULT NULL,
  pdf stripe_invoice.rendering_pdf DEFAULT NULL,
  "template" TEXT DEFAULT NULL,
  template_version JSONB DEFAULT NULL
)
RETURNS stripe_invoice.rendering
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_tax_display, pdf, "template", template_version
  )::stripe_invoice.rendering;
$$;

ALTER TYPE stripe_invoice.rendering_pdf
  ADD ATTRIBUTE page_size TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_rendering_pdf(
  page_size TEXT DEFAULT NULL
)
RETURNS stripe_invoice.rendering_pdf
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(page_size)::stripe_invoice.rendering_pdf;
$$;

ALTER TYPE stripe_invoice.shipping_cost
  ADD ATTRIBUTE shipping_rate TEXT,
  ADD ATTRIBUTE shipping_rate_data stripe_invoice.shipping_cost_shipping_rate_data;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_cost(
  shipping_rate TEXT DEFAULT NULL,
  shipping_rate_data stripe_invoice.shipping_cost_shipping_rate_data DEFAULT NULL
)
RETURNS stripe_invoice.shipping_cost
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(shipping_rate, shipping_rate_data)::stripe_invoice.shipping_cost;
$$;

ALTER TYPE stripe_invoice.shipping_cost_shipping_rate_data
  ADD ATTRIBUTE display_name TEXT,
  ADD ATTRIBUTE delivery_estimate stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate,
  ADD ATTRIBUTE fixed_amount stripe_invoice.shipping_cost_shipping_rate_data_fixed_amount,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE tax_code TEXT,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_cost_shipping_rate_data(
  display_name TEXT,
  delivery_estimate stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate DEFAULT NULL,
  fixed_amount stripe_invoice.shipping_cost_shipping_rate_data_fixed_amount DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.shipping_cost_shipping_rate_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    display_name,
    delivery_estimate,
    fixed_amount,
    metadata,
    tax_behavior,
    tax_code,
    "type"
  )::stripe_invoice.shipping_cost_shipping_rate_data;
$$;

ALTER TYPE stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate
  ADD ATTRIBUTE maximum stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_maximum,
  ADD ATTRIBUTE minimum stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_minimum;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_cost_shipping_rate_data_delivery_estimate(
  maximum stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_maximum DEFAULT NULL,
  minimum stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_minimum DEFAULT NULL
)
RETURNS stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    maximum, minimum
  )::stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate;
$$;

ALTER TYPE stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_maximum
  ADD ATTRIBUTE unit TEXT, ADD ATTRIBUTE "value" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_cost_shipping_rate_data_delivery_estimate_maximum(
  unit TEXT, "value" BIGINT
)
RETURNS stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_maximum
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    unit, "value"
  )::stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_maximum;
$$;

ALTER TYPE stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_minimum
  ADD ATTRIBUTE unit TEXT, ADD ATTRIBUTE "value" BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_cost_shipping_rate_data_delivery_estimate_minimum(
  unit TEXT, "value" BIGINT
)
RETURNS stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_minimum
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    unit, "value"
  )::stripe_invoice.shipping_cost_shipping_rate_data_delivery_estimate_minimum;
$$;

ALTER TYPE stripe_invoice.shipping_cost_shipping_rate_data_fixed_amount
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE currency_options JSONB;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_cost_shipping_rate_data_fixed_amount(
  amount BIGINT, currency TEXT, currency_options JSONB DEFAULT NULL
)
RETURNS stripe_invoice.shipping_cost_shipping_rate_data_fixed_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, currency, currency_options
  )::stripe_invoice.shipping_cost_shipping_rate_data_fixed_amount;
$$;

ALTER TYPE stripe_invoice.shipping_detail
  ADD ATTRIBUTE address stripe_invoice.shipping_detail_address,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_detail(
  address stripe_invoice.shipping_detail_address,
  "name" TEXT,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoice.shipping_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(address, "name", phone)::stripe_invoice.shipping_detail;
$$;

ALTER TYPE stripe_invoice.shipping_detail_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_shipping_detail_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL
)
RETURNS stripe_invoice.shipping_detail_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, "state"
  )::stripe_invoice.shipping_detail_address;
$$;

ALTER TYPE stripe_invoice.transfer_data
  ADD ATTRIBUTE destination TEXT, ADD ATTRIBUTE amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoice.make_transfer_data(
  destination TEXT, amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoice.transfer_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(destination, amount)::stripe_invoice.transfer_data;
$$;

CREATE OR REPLACE FUNCTION stripe_invoice._create(
  account_tax_ids JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  auto_advance BOOLEAN DEFAULT NULL,
  automatic_tax stripe_invoice.automatic_tax DEFAULT NULL,
  automatically_finalizes_at BIGINT DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  custom_fields JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  days_until_due BIGINT DEFAULT NULL,
  default_payment_method TEXT DEFAULT NULL,
  default_source TEXT DEFAULT NULL,
  default_tax_rates TEXT[] DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discounts JSONB DEFAULT NULL,
  due_date BIGINT DEFAULT NULL,
  effective_at BIGINT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  footer TEXT DEFAULT NULL,
  from_invoice stripe_invoice.from_invoice DEFAULT NULL,
  issuer stripe_invoice.issuer DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "number" TEXT DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  payment_settings stripe_invoice.payment_setting DEFAULT NULL,
  pending_invoice_items_behavior TEXT DEFAULT NULL,
  rendering stripe_invoice.rendering DEFAULT NULL,
  shipping_cost stripe_invoice.shipping_cost DEFAULT NULL,
  shipping_details stripe_invoice.shipping_detail DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL,
  transfer_data stripe_invoice.transfer_data DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stripe_minimal._types import not_given

  response = GD["__stripe_context__"].client.invoices.with_raw_response.create(
      account_tax_ids=not_given if account_tax_ids is None else json.loads(account_tax_ids),
      application_fee_amount=not_given if application_fee_amount is None else application_fee_amount,
      auto_advance=not_given if auto_advance is None else auto_advance,
      automatic_tax=not_given if automatic_tax is None else GD["__stripe_context__"].strip_none(automatic_tax),
      automatically_finalizes_at=not_given if automatically_finalizes_at is None else automatically_finalizes_at,
      collection_method=not_given if collection_method is None else collection_method,
      currency=not_given if currency is None else currency,
      custom_fields=not_given if custom_fields is None else json.loads(custom_fields),
      customer=not_given if customer is None else customer,
      customer_account=not_given if customer_account is None else customer_account,
      days_until_due=not_given if days_until_due is None else days_until_due,
      default_payment_method=not_given if default_payment_method is None else default_payment_method,
      default_source=not_given if default_source is None else default_source,
      default_tax_rates=not_given if default_tax_rates is None else default_tax_rates,
      description=not_given if description is None else description,
      discounts=not_given if discounts is None else json.loads(discounts),
      due_date=not_given if due_date is None else due_date,
      effective_at=not_given if effective_at is None else effective_at,
      expand=not_given if expand is None else expand,
      footer=not_given if footer is None else footer,
      from_invoice=not_given if from_invoice is None else GD["__stripe_context__"].strip_none(from_invoice),
      issuer=not_given if issuer is None else GD["__stripe_context__"].strip_none(issuer),
      metadata=not_given if metadata is None else json.loads(metadata),
      number=not_given if number is None else number,
      on_behalf_of=not_given if on_behalf_of is None else on_behalf_of,
      payment_settings=not_given if payment_settings is None else GD["__stripe_context__"].strip_none(payment_settings),
      pending_invoice_items_behavior=not_given if pending_invoice_items_behavior is None else pending_invoice_items_behavior,
      rendering=not_given if rendering is None else GD["__stripe_context__"].strip_none(rendering),
      shipping_cost=not_given if shipping_cost is None else GD["__stripe_context__"].strip_none(shipping_cost),
      shipping_details=not_given if shipping_details is None else GD["__stripe_context__"].strip_none(shipping_details),
      statement_descriptor=not_given if statement_descriptor is None else statement_descriptor,
      subscription=not_given if subscription is None else subscription,
      transfer_data=not_given if transfer_data is None else GD["__stripe_context__"].strip_none(transfer_data),
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_invoice.create(
  account_tax_ids JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  auto_advance BOOLEAN DEFAULT NULL,
  automatic_tax stripe_invoice.automatic_tax DEFAULT NULL,
  automatically_finalizes_at BIGINT DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  custom_fields JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  days_until_due BIGINT DEFAULT NULL,
  default_payment_method TEXT DEFAULT NULL,
  default_source TEXT DEFAULT NULL,
  default_tax_rates TEXT[] DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discounts JSONB DEFAULT NULL,
  due_date BIGINT DEFAULT NULL,
  effective_at BIGINT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  footer TEXT DEFAULT NULL,
  from_invoice stripe_invoice.from_invoice DEFAULT NULL,
  issuer stripe_invoice.issuer DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "number" TEXT DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  payment_settings stripe_invoice.payment_setting DEFAULT NULL,
  pending_invoice_items_behavior TEXT DEFAULT NULL,
  rendering stripe_invoice.rendering DEFAULT NULL,
  shipping_cost stripe_invoice.shipping_cost DEFAULT NULL,
  shipping_details stripe_invoice.shipping_detail DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL,
  transfer_data stripe_invoice.transfer_data DEFAULT NULL
)
RETURNS stripe_invoice.invoice
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_invoice.invoice,
      stripe_invoice._create(
        account_tax_ids,
        application_fee_amount,
        auto_advance,
        automatic_tax,
        automatically_finalizes_at,
        collection_method,
        currency,
        custom_fields,
        customer,
        customer_account,
        days_until_due,
        default_payment_method,
        default_source,
        default_tax_rates,
        description,
        discounts,
        due_date,
        effective_at,
        expand,
        footer,
        from_invoice,
        issuer,
        metadata,
        "number",
        on_behalf_of,
        payment_settings,
        pending_invoice_items_behavior,
        rendering,
        shipping_cost,
        shipping_details,
        statement_descriptor,
        "subscription",
        transfer_data
      )
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_invoice._list_first_page_py(
  collection_method TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  due_date JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal._types import not_given
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client.invoices.list(
      collection_method=not_given if collection_method is None else collection_method,
      created=not_given if created is None else json.loads(created),
      customer=not_given if customer is None else customer,
      customer_account=not_given if customer_account is None else customer_account,
      due_date=not_given if due_date is None else json.loads(due_date),
      ending_before=not_given if ending_before is None else ending_before,
      expand=not_given if expand is None else expand,
      limit=not_given if limit is None else limit,
      starting_after=not_given if starting_after is None else starting_after,
      status=not_given if status is None else status,
      subscription=not_given if subscription is None else subscription,
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

-- A simpler wrapper around `stripe_invoice._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_invoice._list_first_page(
  collection_method TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  due_date JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN stripe_invoice._list_first_page_py(
      collection_method,
      created,
      customer,
      customer_account,
      due_date,
      ending_before,
      expand,
      "limit",
      starting_after,
      status,
      "subscription"
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_invoice._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal.types import Invoice
  from stripe_minimal.pagination import SyncMyCursorIDPage
  from stripe_minimal._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client._request_api_list(
    model=Invoice,
    page=SyncMyCursorIDPage[Invoice],
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

CREATE OR REPLACE FUNCTION stripe_invoice.list(
  collection_method TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  due_date JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  "subscription" TEXT DEFAULT NULL
)
RETURNS SETOF stripe_invoice.invoice
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_invoice._list_first_page(
      collection_method,
      created,
      customer,
      customer_account,
      due_date,
      ending_before,
      expand,
      "limit",
      starting_after,
      status,
      "subscription"
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_invoice._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_invoice.invoice, "data")).* FROM paginated;
$$;

CREATE OR REPLACE FUNCTION stripe_invoice._finalize(
  invoice TEXT, auto_advance BOOLEAN DEFAULT NULL, expand TEXT[] DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  from stripe_minimal._types import not_given

  response = GD["__stripe_context__"].client.invoices.with_raw_response.finalize(
      invoice=invoice,
      auto_advance=not_given if auto_advance is None else auto_advance,
      expand=not_given if expand is None else expand,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_invoice.finalize(
  invoice TEXT, auto_advance BOOLEAN DEFAULT NULL, expand TEXT[] DEFAULT NULL
)
RETURNS stripe_invoice.invoice
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_invoice.invoice,
      stripe_invoice._finalize(invoice, auto_advance, expand)
    );
  END;
$$;