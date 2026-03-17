ALTER TYPE stripe_invoices.api_errors
  ADD ATTRIBUTE type TEXT,
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
  ADD ATTRIBUTE source JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_api_errors(
  type TEXT,
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
  source JSONB DEFAULT NULL
)
RETURNS stripe_invoices.api_errors
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type,
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
    source
  )::stripe_invoices.api_errors;
$$;

ALTER TYPE stripe_invoices.automatic_tax_invoice
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE disabled_reason TEXT,
  ADD ATTRIBUTE liability JSONB,
  ADD ATTRIBUTE provider TEXT,
  ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_automatic_tax_invoice(
  enabled BOOLEAN,
  disabled_reason TEXT DEFAULT NULL,
  liability JSONB DEFAULT NULL,
  provider TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL
)
RETURNS stripe_invoices.automatic_tax_invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, disabled_reason, liability, provider, status
  )::stripe_invoices.automatic_tax_invoice;
$$;

ALTER TYPE stripe_invoices.billing_bill_resource_invoicing_parents_invoice_parent
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE quote_details stripe_invoices.blling_bll_rsource_invicing_parents_invoice_parent_quote_detail,
  ADD ATTRIBUTE subscription_details JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_bill_resource_invoicing_parents_invoice_parent(
  type TEXT,
  quote_details stripe_invoices.blling_bll_rsource_invicing_parents_invoice_parent_quote_detail DEFAULT NULL,
  subscription_details JSONB DEFAULT NULL
)
RETURNS stripe_invoices.billing_bill_resource_invoicing_parents_invoice_parent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, quote_details, subscription_details
  )::stripe_invoices.billing_bill_resource_invoicing_parents_invoice_parent;
$$;

ALTER TYPE stripe_invoices.blling_bll_rsource_invicing_parents_invoice_parent_quote_detail
  ADD ATTRIBUTE quote TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_blling_bll_rsource_invicing_prents_invice_prent_qote_detail(
  quote TEXT
)
RETURNS stripe_invoices.blling_bll_rsource_invicing_parents_invoice_parent_quote_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    quote
  )::stripe_invoices.blling_bll_rsource_invicing_parents_invoice_parent_quote_detail;
$$;

ALTER TYPE stripe_invoices.blling_bll_rsource_invicing_parents_invoice_subscription_parent
  ADD ATTRIBUTE subscription JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE subscription_proration_date BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_blling_bll_rsource_invicing_prents_invice_sbscription_prent(
  subscription JSONB,
  metadata JSONB DEFAULT NULL,
  subscription_proration_date BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.blling_bll_rsource_invicing_parents_invoice_subscription_parent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    subscription, metadata, subscription_proration_date
  )::stripe_invoices.blling_bll_rsource_invicing_parents_invoice_subscription_parent;
$$;

ALTER TYPE stripe_invoices.billing_credit_balance_transaction
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE credit_grant JSONB,
  ADD ATTRIBUTE effective_at BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE credit JSONB,
  ADD ATTRIBUTE debit JSONB,
  ADD ATTRIBUTE test_clock JSONB,
  ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_balance_transaction(
  id TEXT,
  created BIGINT,
  credit_grant JSONB,
  effective_at BIGINT,
  livemode BOOLEAN,
  object TEXT,
  credit JSONB DEFAULT NULL,
  debit JSONB DEFAULT NULL,
  test_clock JSONB DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.billing_credit_balance_transaction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    created,
    credit_grant,
    effective_at,
    livemode,
    object,
    credit,
    debit,
    test_clock,
    type
  )::stripe_invoices.billing_credit_balance_transaction;
$$;

ALTER TYPE stripe_invoices.billing_credit_grant
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE amount stripe_invoices.billing_credit_grants_resource_amount,
  ADD ATTRIBUTE applicability_config stripe_invoices.billing_credit_grant_applicability_config,
  ADD ATTRIBUTE category TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE updated BIGINT,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE effective_at BIGINT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE priority BIGINT,
  ADD ATTRIBUTE test_clock JSONB,
  ADD ATTRIBUTE voided_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grant(
  id TEXT,
  amount stripe_invoices.billing_credit_grants_resource_amount,
  applicability_config stripe_invoices.billing_credit_grant_applicability_config,
  category TEXT,
  created BIGINT,
  customer JSONB,
  livemode BOOLEAN,
  metadata JSONB,
  object TEXT,
  updated BIGINT,
  customer_account TEXT DEFAULT NULL,
  effective_at BIGINT DEFAULT NULL,
  expires_at BIGINT DEFAULT NULL,
  name TEXT DEFAULT NULL,
  priority BIGINT DEFAULT NULL,
  test_clock JSONB DEFAULT NULL,
  voided_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.billing_credit_grant
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    amount,
    applicability_config,
    category,
    created,
    customer,
    livemode,
    metadata,
    object,
    updated,
    customer_account,
    effective_at,
    expires_at,
    name,
    priority,
    test_clock,
    voided_at
  )::stripe_invoices.billing_credit_grant;
$$;

ALTER TYPE stripe_invoices.billing_credit_grant_applicability_config
  ADD ATTRIBUTE scope stripe_invoices.billing_credit_grant_applicability_config_scope;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grant_applicability_config(
  scope stripe_invoices.billing_credit_grant_applicability_config_scope
)
RETURNS stripe_invoices.billing_credit_grant_applicability_config
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(scope)::stripe_invoices.billing_credit_grant_applicability_config;
$$;

ALTER TYPE stripe_invoices.billing_credit_grant_applicability_config_scope
  ADD ATTRIBUTE price_type TEXT,
  ADD ATTRIBUTE prices stripe_invoices.billing_credit_grant_applicability_config_scope_price[];

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grant_applicability_config_scope(
  price_type TEXT DEFAULT NULL,
  prices stripe_invoices.billing_credit_grant_applicability_config_scope_price[] DEFAULT NULL
)
RETURNS stripe_invoices.billing_credit_grant_applicability_config_scope
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    price_type, prices
  )::stripe_invoices.billing_credit_grant_applicability_config_scope;
$$;

ALTER TYPE stripe_invoices.billing_credit_grant_applicability_config_scope_price
  ADD ATTRIBUTE id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grant_applicability_config_scope_price(
  id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.billing_credit_grant_applicability_config_scope_price
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id
  )::stripe_invoices.billing_credit_grant_applicability_config_scope_price;
$$;

ALTER TYPE stripe_invoices.billing_credit_grants_resource_amount
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE monetary stripe_invoices.billing_credit_grants_resource_monetary_amount;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grants_resource_amount(
  type TEXT,
  monetary stripe_invoices.billing_credit_grants_resource_monetary_amount DEFAULT NULL
)
RETURNS stripe_invoices.billing_credit_grants_resource_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, monetary
  )::stripe_invoices.billing_credit_grants_resource_amount;
$$;

ALTER TYPE stripe_invoices.billing_credit_grants_resource_balance_credit
  ADD ATTRIBUTE amount stripe_invoices.billing_credit_grants_resource_amount,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE credits_application_invoice_voided JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grants_resource_balance_credit(
  amount stripe_invoices.billing_credit_grants_resource_amount,
  type TEXT,
  credits_application_invoice_voided JSONB DEFAULT NULL
)
RETURNS stripe_invoices.billing_credit_grants_resource_balance_credit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, type, credits_application_invoice_voided
  )::stripe_invoices.billing_credit_grants_resource_balance_credit;
$$;

ALTER TYPE stripe_invoices.bllng_crdit_grnts_rsource_blance_crdits_applcation_invice_vided
  ADD ATTRIBUTE invoice JSONB, ADD ATTRIBUTE invoice_line_item TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_bllng_crdt_grnts_rsurce_blnce_crdts_applcation_invice_vided(
  invoice JSONB, invoice_line_item TEXT
)
RETURNS stripe_invoices.bllng_crdit_grnts_rsource_blance_crdits_applcation_invice_vided
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_item
  )::stripe_invoices.bllng_crdit_grnts_rsource_blance_crdits_applcation_invice_vided;
$$;

ALTER TYPE stripe_invoices.billing_credit_grants_resource_balance_credits_applied
  ADD ATTRIBUTE invoice JSONB, ADD ATTRIBUTE invoice_line_item TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grants_resource_balance_credits_applied(
  invoice JSONB, invoice_line_item TEXT
)
RETURNS stripe_invoices.billing_credit_grants_resource_balance_credits_applied
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_item
  )::stripe_invoices.billing_credit_grants_resource_balance_credits_applied;
$$;

ALTER TYPE stripe_invoices.billing_credit_grants_resource_balance_debit
  ADD ATTRIBUTE amount stripe_invoices.billing_credit_grants_resource_amount,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE credits_applied JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grants_resource_balance_debit(
  amount stripe_invoices.billing_credit_grants_resource_amount,
  type TEXT,
  credits_applied JSONB DEFAULT NULL
)
RETURNS stripe_invoices.billing_credit_grants_resource_balance_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, type, credits_applied
  )::stripe_invoices.billing_credit_grants_resource_balance_debit;
$$;

ALTER TYPE stripe_invoices.billing_credit_grants_resource_monetary_amount
  ADD ATTRIBUTE currency TEXT, ADD ATTRIBUTE value BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_billing_credit_grants_resource_monetary_amount(
  currency TEXT, value BIGINT
)
RETURNS stripe_invoices.billing_credit_grants_resource_monetary_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, value
  )::stripe_invoices.billing_credit_grants_resource_monetary_amount;
$$;

ALTER TYPE stripe_invoices.connect_account_reference
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE account JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_connect_account_reference(
  type TEXT, account JSONB DEFAULT NULL
)
RETURNS stripe_invoices.connect_account_reference
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(type, account)::stripe_invoices.connect_account_reference;
$$;

ALTER TYPE stripe_invoices.deleted_discount
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE deleted BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE source stripe_invoices.deleted_discount_source,
  ADD ATTRIBUTE start BIGINT,
  ADD ATTRIBUTE checkout_session TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE invoice TEXT,
  ADD ATTRIBUTE invoice_item TEXT,
  ADD ATTRIBUTE promotion_code JSONB,
  ADD ATTRIBUTE subscription TEXT,
  ADD ATTRIBUTE subscription_item TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_deleted_discount(
  id TEXT,
  deleted BOOLEAN,
  object TEXT,
  source stripe_invoices.deleted_discount_source,
  start BIGINT,
  checkout_session TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  invoice TEXT DEFAULT NULL,
  invoice_item TEXT DEFAULT NULL,
  promotion_code JSONB DEFAULT NULL,
  subscription TEXT DEFAULT NULL,
  subscription_item TEXT DEFAULT NULL
)
RETURNS stripe_invoices.deleted_discount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    deleted,
    object,
    source,
    start,
    checkout_session,
    customer,
    customer_account,
    invoice,
    invoice_item,
    promotion_code,
    subscription,
    subscription_item
  )::stripe_invoices.deleted_discount;
$$;

ALTER TYPE stripe_invoices.deleted_discount_source
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE coupon JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_deleted_discount_source(
  type TEXT, coupon JSONB DEFAULT NULL
)
RETURNS stripe_invoices.deleted_discount_source
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(type, coupon)::stripe_invoices.deleted_discount_source;
$$;

ALTER TYPE stripe_invoices.discounts_resource_discount_amount
  ADD ATTRIBUTE amount BIGINT, ADD ATTRIBUTE discount JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_discounts_resource_discount_amount(
  amount BIGINT, discount JSONB
)
RETURNS stripe_invoices.discounts_resource_discount_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, discount
  )::stripe_invoices.discounts_resource_discount_amount;
$$;

ALTER TYPE stripe_invoices.invoice
  ADD ATTRIBUTE id TEXT,
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
  ADD ATTRIBUTE default_tax_rates stripe_invoices.tax_rate[],
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE issuer JSONB,
  ADD ATTRIBUTE lines stripe_invoices.invoice_line,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE payment_settings stripe_invoices.invoice_payment_setting,
  ADD ATTRIBUTE period_end BIGINT,
  ADD ATTRIBUTE period_start BIGINT,
  ADD ATTRIBUTE post_payment_credit_notes_amount BIGINT,
  ADD ATTRIBUTE pre_payment_credit_notes_amount BIGINT,
  ADD ATTRIBUTE starting_balance BIGINT,
  ADD ATTRIBUTE status_transitions stripe_invoices.invoice_status_transition,
  ADD ATTRIBUTE subtotal BIGINT,
  ADD ATTRIBUTE total BIGINT,
  ADD ATTRIBUTE account_country TEXT,
  ADD ATTRIBUTE account_name TEXT,
  ADD ATTRIBUTE account_tax_ids JSONB[],
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE automatically_finalizes_at BIGINT,
  ADD ATTRIBUTE billing_reason TEXT,
  ADD ATTRIBUTE confirmation_secret stripe_invoices.invoice_confirmation_secret,
  ADD ATTRIBUTE custom_fields stripe.invoice_setting_custom_field[],
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE customer_address stripe.address,
  ADD ATTRIBUTE customer_email TEXT,
  ADD ATTRIBUTE customer_name TEXT,
  ADD ATTRIBUTE customer_phone TEXT,
  ADD ATTRIBUTE customer_shipping stripe.shipping,
  ADD ATTRIBUTE customer_tax_exempt TEXT,
  ADD ATTRIBUTE customer_tax_ids stripe_invoices.invoice_customer_tax_id[],
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
  ADD ATTRIBUTE number TEXT,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE parent JSONB,
  ADD ATTRIBUTE payments stripe_invoices.invoice_payment,
  ADD ATTRIBUTE receipt_number TEXT,
  ADD ATTRIBUTE rendering stripe_invoices.invoice_rendering,
  ADD ATTRIBUTE shipping_cost stripe_invoices.invoice_shipping_cost,
  ADD ATTRIBUTE shipping_details stripe.shipping,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE subtotal_excluding_tax BIGINT,
  ADD ATTRIBUTE test_clock JSONB,
  ADD ATTRIBUTE threshold_reason stripe_invoices.invoice_threshold_reason,
  ADD ATTRIBUTE total_discount_amounts JSONB[],
  ADD ATTRIBUTE total_excluding_tax BIGINT,
  ADD ATTRIBUTE total_pretax_credit_amounts JSONB[],
  ADD ATTRIBUTE total_taxes stripe_invoices.invoice_total_tax[],
  ADD ATTRIBUTE webhooks_delivered_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice(
  id TEXT,
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
  default_tax_rates stripe_invoices.tax_rate[],
  discounts JSONB[],
  issuer JSONB,
  lines stripe_invoices.invoice_line,
  livemode BOOLEAN,
  object TEXT,
  payment_settings stripe_invoices.invoice_payment_setting,
  period_end BIGINT,
  period_start BIGINT,
  post_payment_credit_notes_amount BIGINT,
  pre_payment_credit_notes_amount BIGINT,
  starting_balance BIGINT,
  status_transitions stripe_invoices.invoice_status_transition,
  subtotal BIGINT,
  total BIGINT,
  account_country TEXT DEFAULT NULL,
  account_name TEXT DEFAULT NULL,
  account_tax_ids JSONB[] DEFAULT NULL,
  application JSONB DEFAULT NULL,
  automatically_finalizes_at BIGINT DEFAULT NULL,
  billing_reason TEXT DEFAULT NULL,
  confirmation_secret stripe_invoices.invoice_confirmation_secret DEFAULT NULL,
  custom_fields stripe.invoice_setting_custom_field[] DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  customer_address stripe.address DEFAULT NULL,
  customer_email TEXT DEFAULT NULL,
  customer_name TEXT DEFAULT NULL,
  customer_phone TEXT DEFAULT NULL,
  customer_shipping stripe.shipping DEFAULT NULL,
  customer_tax_exempt TEXT DEFAULT NULL,
  customer_tax_ids stripe_invoices.invoice_customer_tax_id[] DEFAULT NULL,
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
  number TEXT DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  parent JSONB DEFAULT NULL,
  payments stripe_invoices.invoice_payment DEFAULT NULL,
  receipt_number TEXT DEFAULT NULL,
  rendering stripe_invoices.invoice_rendering DEFAULT NULL,
  shipping_cost stripe_invoices.invoice_shipping_cost DEFAULT NULL,
  shipping_details stripe.shipping DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  subtotal_excluding_tax BIGINT DEFAULT NULL,
  test_clock JSONB DEFAULT NULL,
  threshold_reason stripe_invoices.invoice_threshold_reason DEFAULT NULL,
  total_discount_amounts JSONB[] DEFAULT NULL,
  total_excluding_tax BIGINT DEFAULT NULL,
  total_pretax_credit_amounts JSONB[] DEFAULT NULL,
  total_taxes stripe_invoices.invoice_total_tax[] DEFAULT NULL,
  webhooks_delivered_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
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
    object,
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
    number,
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
  )::stripe_invoices.invoice;
$$;

ALTER TYPE stripe_invoices.invoice_line
  ADD ATTRIBUTE data JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_line(
  data JSONB[], has_more BOOLEAN, object TEXT, url TEXT
)
RETURNS stripe_invoices.invoice_line
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(data, has_more, object, url)::stripe_invoices.invoice_line;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting
  ADD ATTRIBUTE default_mandate TEXT,
  ADD ATTRIBUTE payment_method_options stripe_invoices.invoice_payment_setting_payment_method_option,
  ADD ATTRIBUTE payment_method_types TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment_setting(
  default_mandate TEXT DEFAULT NULL,
  payment_method_options stripe_invoices.invoice_payment_setting_payment_method_option DEFAULT NULL,
  payment_method_types TEXT[] DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_mandate, payment_method_options, payment_method_types
  )::stripe_invoices.invoice_payment_setting;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option
  ADD ATTRIBUTE acss_debit stripe_invoices.invoice_payment_setting_payment_method_option_acss_debit,
  ADD ATTRIBUTE bancontact stripe_invoices.invoice_payment_setting_payment_method_option_bancontact,
  ADD ATTRIBUTE card stripe_invoices.invoice_payment_setting_payment_method_option_card,
  ADD ATTRIBUTE customer_balance stripe_invoices.invoice_payment_setting_payment_method_option_customer_balance,
  ADD ATTRIBUTE konbini stripe_invoices.invoice_payment_setting_payment_method_option_konbini,
  ADD ATTRIBUTE payto stripe_invoices.invoice_payment_setting_payment_method_option_payto,
  ADD ATTRIBUTE sepa_debit stripe_invoices.invoice_payment_setting_payment_method_option_sepa_debit,
  ADD ATTRIBUTE us_bank_account stripe_invoices.invoice_payment_setting_payment_method_option_us_bank_account;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment_setting_payment_method_option(
  acss_debit stripe_invoices.invoice_payment_setting_payment_method_option_acss_debit DEFAULT NULL,
  bancontact stripe_invoices.invoice_payment_setting_payment_method_option_bancontact DEFAULT NULL,
  card stripe_invoices.invoice_payment_setting_payment_method_option_card DEFAULT NULL,
  customer_balance stripe_invoices.invoice_payment_setting_payment_method_option_customer_balance DEFAULT NULL,
  konbini stripe_invoices.invoice_payment_setting_payment_method_option_konbini DEFAULT NULL,
  payto stripe_invoices.invoice_payment_setting_payment_method_option_payto DEFAULT NULL,
  sepa_debit stripe_invoices.invoice_payment_setting_payment_method_option_sepa_debit DEFAULT NULL,
  us_bank_account stripe_invoices.invoice_payment_setting_payment_method_option_us_bank_account DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option
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
  )::stripe_invoices.invoice_payment_setting_payment_method_option;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option_acss_debit
  ADD ATTRIBUTE mandate_options stripe_invoices.invice_pyment_stting_pyment_mthod_opton_acss_dbit_mndate_option,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment_setting_payment_method_option_acss_debit(
  mandate_options stripe_invoices.invice_pyment_stting_pyment_mthod_opton_acss_dbit_mndate_option DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_invoices.invoice_payment_setting_payment_method_option_acss_debit;
$$;

ALTER TYPE stripe_invoices.invice_pyment_stting_pyment_mthod_opton_acss_dbit_mndate_option
  ADD ATTRIBUTE transaction_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_invce_pymnt_sttng_pyment_mthod_opton_acss_dbit_mndate_opton(
  transaction_type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invice_pyment_stting_pyment_mthod_opton_acss_dbit_mndate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_type
  )::stripe_invoices.invice_pyment_stting_pyment_mthod_opton_acss_dbit_mndate_option;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option_bancontact
  ADD ATTRIBUTE preferred_language TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment_setting_payment_method_option_bancontact(
  preferred_language TEXT
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option_bancontact
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    preferred_language
  )::stripe_invoices.invoice_payment_setting_payment_method_option_bancontact;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option_card
  ADD ATTRIBUTE installments stripe_invoices.invoice_payment_setting_payment_method_option_card_installment,
  ADD ATTRIBUTE request_three_d_secure TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment_setting_payment_method_option_card(
  installments stripe_invoices.invoice_payment_setting_payment_method_option_card_installment DEFAULT NULL,
  request_three_d_secure TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    installments, request_three_d_secure
  )::stripe_invoices.invoice_payment_setting_payment_method_option_card;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option_card_installment
  ADD ATTRIBUTE enabled BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_invice_pyment_stting_payment_method_option_card_installment(
  enabled BOOLEAN DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option_card_installment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled
  )::stripe_invoices.invoice_payment_setting_payment_method_option_card_installment;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option_customer_balance
  ADD ATTRIBUTE bank_transfer stripe_invoices.invce_pymnt_sttng_pyment_mthod_opton_cstomer_blance_bnk_trnsfer,
  ADD ATTRIBUTE funding_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_invice_pyment_stting_payment_method_option_customer_balance(
  bank_transfer stripe_invoices.invce_pymnt_sttng_pyment_mthod_opton_cstomer_blance_bnk_trnsfer DEFAULT NULL,
  funding_type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option_customer_balance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_transfer, funding_type
  )::stripe_invoices.invoice_payment_setting_payment_method_option_customer_balance;
$$;

ALTER TYPE stripe_invoices.invce_pymnt_sttng_pyment_mthod_opton_cstomer_blance_bnk_trnsfer
  ADD ATTRIBUTE eu_bank_transfer stripe_invoices.i_p_sttng_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr,
  ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_invce_pymnt_sttng_pymnt_mthd_optn_cstmer_blance_bnk_trnsfer(
  eu_bank_transfer stripe_invoices.i_p_sttng_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invce_pymnt_sttng_pyment_mthod_opton_cstomer_blance_bnk_trnsfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    eu_bank_transfer, type
  )::stripe_invoices.invce_pymnt_sttng_pyment_mthod_opton_cstomer_blance_bnk_trnsfer;
$$;

ALTER TYPE stripe_invoices.i_p_sttng_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_i_p_s_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr(
  country TEXT
)
RETURNS stripe_invoices.i_p_sttng_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_invoices.i_p_sttng_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option_payto
  ADD ATTRIBUTE mandate_options stripe_invoices.invice_pyment_stting_payment_method_option_payto_mandate_option;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment_setting_payment_method_option_payto(
  mandate_options stripe_invoices.invice_pyment_stting_payment_method_option_payto_mandate_option DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options
  )::stripe_invoices.invoice_payment_setting_payment_method_option_payto;
$$;

ALTER TYPE stripe_invoices.invice_pyment_stting_payment_method_option_payto_mandate_option
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_invice_pyment_stting_pyment_mthod_opton_pyto_mandate_option(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invice_pyment_stting_payment_method_option_payto_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, amount_type, purpose
  )::stripe_invoices.invice_pyment_stting_payment_method_option_payto_mandate_option;
$$;

ALTER TYPE stripe_invoices.invoice_payment_setting_payment_method_option_us_bank_account
  ADD ATTRIBUTE financial_connections stripe_invoices.invce_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncial_cnnction,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_invice_pyment_setting_payment_method_option_us_bank_account(
  financial_connections stripe_invoices.invce_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncial_cnnction DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_setting_payment_method_option_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    financial_connections, verification_method
  )::stripe_invoices.invoice_payment_setting_payment_method_option_us_bank_account;
$$;

ALTER TYPE stripe_invoices.invce_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncial_cnnction
  ADD ATTRIBUTE filters stripe_invoices.i_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr,
  ADD ATTRIBUTE permissions TEXT[],
  ADD ATTRIBUTE prefetch TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoices.mke_invce_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn(
  filters stripe_invoices.i_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr DEFAULT NULL,
  permissions TEXT[] DEFAULT NULL,
  prefetch TEXT[] DEFAULT NULL
)
RETURNS stripe_invoices.invce_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncial_cnnction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    filters, permissions, prefetch
  )::stripe_invoices.invce_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncial_cnnction;
$$;

ALTER TYPE stripe_invoices.i_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr
  ADD ATTRIBUTE account_subcategories TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoices.m_i_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr(
  account_subcategories TEXT[] DEFAULT NULL
)
RETURNS stripe_invoices.i_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_subcategories
  )::stripe_invoices.i_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr;
$$;

ALTER TYPE stripe_invoices.invoice_status_transition
  ADD ATTRIBUTE finalized_at BIGINT,
  ADD ATTRIBUTE marked_uncollectible_at BIGINT,
  ADD ATTRIBUTE paid_at BIGINT,
  ADD ATTRIBUTE voided_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_status_transition(
  finalized_at BIGINT DEFAULT NULL,
  marked_uncollectible_at BIGINT DEFAULT NULL,
  paid_at BIGINT DEFAULT NULL,
  voided_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_status_transition
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    finalized_at, marked_uncollectible_at, paid_at, voided_at
  )::stripe_invoices.invoice_status_transition;
$$;

ALTER TYPE stripe_invoices.invoice_confirmation_secret
  ADD ATTRIBUTE client_secret TEXT, ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_confirmation_secret(
  client_secret TEXT, type TEXT
)
RETURNS stripe_invoices.invoice_confirmation_secret
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(client_secret, type)::stripe_invoices.invoice_confirmation_secret;
$$;

ALTER TYPE stripe_invoices.invoice_customer_tax_id
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE value TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_customer_tax_id(
  type TEXT, value TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_customer_tax_id
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(type, value)::stripe_invoices.invoice_customer_tax_id;
$$;

ALTER TYPE stripe_invoices.invoice_payment
  ADD ATTRIBUTE data JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment(
  data JSONB[], has_more BOOLEAN, object TEXT, url TEXT
)
RETURNS stripe_invoices.invoice_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(data, has_more, object, url)::stripe_invoices.invoice_payment;
$$;

ALTER TYPE stripe_invoices.invoice_rendering
  ADD ATTRIBUTE amount_tax_display TEXT,
  ADD ATTRIBUTE pdf stripe_invoices.invoice_rendering_pdf,
  ADD ATTRIBUTE template TEXT,
  ADD ATTRIBUTE template_version BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_rendering(
  amount_tax_display TEXT DEFAULT NULL,
  pdf stripe_invoices.invoice_rendering_pdf DEFAULT NULL,
  template TEXT DEFAULT NULL,
  template_version BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_rendering
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_tax_display, pdf, template, template_version
  )::stripe_invoices.invoice_rendering;
$$;

ALTER TYPE stripe_invoices.invoice_rendering_pdf
  ADD ATTRIBUTE page_size TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_rendering_pdf(
  page_size TEXT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_rendering_pdf
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(page_size)::stripe_invoices.invoice_rendering_pdf;
$$;

ALTER TYPE stripe_invoices.invoice_shipping_cost
  ADD ATTRIBUTE amount_subtotal BIGINT,
  ADD ATTRIBUTE amount_tax BIGINT,
  ADD ATTRIBUTE amount_total BIGINT,
  ADD ATTRIBUTE shipping_rate JSONB,
  ADD ATTRIBUTE taxes stripe_invoices.invoice_shipping_cost_tax[];

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_shipping_cost(
  amount_subtotal BIGINT,
  amount_tax BIGINT,
  amount_total BIGINT,
  shipping_rate JSONB DEFAULT NULL,
  taxes stripe_invoices.invoice_shipping_cost_tax[] DEFAULT NULL
)
RETURNS stripe_invoices.invoice_shipping_cost
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_subtotal, amount_tax, amount_total, shipping_rate, taxes
  )::stripe_invoices.invoice_shipping_cost;
$$;

ALTER TYPE stripe_invoices.invoice_shipping_cost_tax
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE rate stripe_invoices.tax_rate,
  ADD ATTRIBUTE taxability_reason TEXT,
  ADD ATTRIBUTE taxable_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_shipping_cost_tax(
  amount BIGINT,
  rate stripe_invoices.tax_rate,
  taxability_reason TEXT DEFAULT NULL,
  taxable_amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_shipping_cost_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, rate, taxability_reason, taxable_amount
  )::stripe_invoices.invoice_shipping_cost_tax;
$$;

ALTER TYPE stripe_invoices.invoice_threshold_reason
  ADD ATTRIBUTE item_reasons stripe_invoices.invoice_threshold_reason_item_reason[],
  ADD ATTRIBUTE amount_gte BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_threshold_reason(
  item_reasons stripe_invoices.invoice_threshold_reason_item_reason[],
  amount_gte BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_threshold_reason
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    item_reasons, amount_gte
  )::stripe_invoices.invoice_threshold_reason;
$$;

ALTER TYPE stripe_invoices.invoice_threshold_reason_item_reason
  ADD ATTRIBUTE line_item_ids TEXT[], ADD ATTRIBUTE usage_gte BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_threshold_reason_item_reason(
  line_item_ids TEXT[], usage_gte BIGINT
)
RETURNS stripe_invoices.invoice_threshold_reason_item_reason
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    line_item_ids, usage_gte
  )::stripe_invoices.invoice_threshold_reason_item_reason;
$$;

ALTER TYPE stripe_invoices.invoice_total_tax
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE taxability_reason TEXT,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE tax_rate_details stripe_invoices.invoice_total_tax_tax_rate_detail,
  ADD ATTRIBUTE taxable_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_total_tax(
  amount BIGINT,
  tax_behavior TEXT,
  taxability_reason TEXT,
  type TEXT,
  tax_rate_details stripe_invoices.invoice_total_tax_tax_rate_detail DEFAULT NULL,
  taxable_amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_total_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    tax_behavior,
    taxability_reason,
    type,
    tax_rate_details,
    taxable_amount
  )::stripe_invoices.invoice_total_tax;
$$;

ALTER TYPE stripe_invoices.invoice_total_tax_tax_rate_detail
  ADD ATTRIBUTE tax_rate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_total_tax_tax_rate_detail(
  tax_rate TEXT
)
RETURNS stripe_invoices.invoice_total_tax_tax_rate_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_rate)::stripe_invoices.invoice_total_tax_tax_rate_detail;
$$;

ALTER TYPE stripe_invoices.invoice_payment1
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE amount_requested BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE invoice JSONB,
  ADD ATTRIBUTE is_default BOOLEAN,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE payment JSONB,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE status_transitions stripe_invoices.invoice_payment_status_transition,
  ADD ATTRIBUTE amount_paid BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment1(
  id TEXT,
  amount_requested BIGINT,
  created BIGINT,
  currency TEXT,
  invoice JSONB,
  is_default BOOLEAN,
  livemode BOOLEAN,
  object TEXT,
  payment JSONB,
  status TEXT,
  status_transitions stripe_invoices.invoice_payment_status_transition,
  amount_paid BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    amount_requested,
    created,
    currency,
    invoice,
    is_default,
    livemode,
    object,
    payment,
    status,
    status_transitions,
    amount_paid
  )::stripe_invoices.invoice_payment1;
$$;

ALTER TYPE stripe_invoices.invoice_payment_status_transition
  ADD ATTRIBUTE canceled_at BIGINT, ADD ATTRIBUTE paid_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoice_payment_status_transition(
  canceled_at BIGINT DEFAULT NULL, paid_at BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.invoice_payment_status_transition
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    canceled_at, paid_at
  )::stripe_invoices.invoice_payment_status_transition;
$$;

ALTER TYPE stripe_invoices.invoices_payments_invoice_payment_associated_payment
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE charge JSONB,
  ADD ATTRIBUTE payment_intent JSONB,
  ADD ATTRIBUTE payment_record JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoices_payments_invoice_payment_associated_payment(
  type TEXT,
  charge JSONB DEFAULT NULL,
  payment_intent JSONB DEFAULT NULL,
  payment_record JSONB DEFAULT NULL
)
RETURNS stripe_invoices.invoices_payments_invoice_payment_associated_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, charge, payment_intent, payment_record
  )::stripe_invoices.invoices_payments_invoice_payment_associated_payment;
$$;

ALTER TYPE stripe_invoices.invoices_resource_from_invoice
  ADD ATTRIBUTE action TEXT, ADD ATTRIBUTE invoice JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoices_resource_from_invoice(
  action TEXT, invoice JSONB
)
RETURNS stripe_invoices.invoices_resource_from_invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(action, invoice)::stripe_invoices.invoices_resource_from_invoice;
$$;

ALTER TYPE stripe_invoices.invoices_resource_pretax_credit_amount
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE credit_balance_transaction JSONB,
  ADD ATTRIBUTE discount JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_invoices_resource_pretax_credit_amount(
  amount BIGINT,
  type TEXT,
  credit_balance_transaction JSONB DEFAULT NULL,
  discount JSONB DEFAULT NULL
)
RETURNS stripe_invoices.invoices_resource_pretax_credit_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, type, credit_balance_transaction, discount
  )::stripe_invoices.invoices_resource_pretax_credit_amount;
$$;

ALTER TYPE stripe_invoices.line_item
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE discountable BOOLEAN,
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE period stripe_invoices.line_item_period,
  ADD ATTRIBUTE subtotal BIGINT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE discount_amounts JSONB[],
  ADD ATTRIBUTE invoice TEXT,
  ADD ATTRIBUTE parent stripe_invoices.line_item_parent,
  ADD ATTRIBUTE pretax_credit_amounts JSONB[],
  ADD ATTRIBUTE pricing stripe_invoices.line_item_pricing,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE subscription JSONB,
  ADD ATTRIBUTE taxes stripe_invoices.line_item_tax[];

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item(
  id TEXT,
  amount BIGINT,
  currency TEXT,
  discountable BOOLEAN,
  discounts JSONB[],
  livemode BOOLEAN,
  metadata JSONB,
  object TEXT,
  period stripe_invoices.line_item_period,
  subtotal BIGINT,
  description TEXT DEFAULT NULL,
  discount_amounts JSONB[] DEFAULT NULL,
  invoice TEXT DEFAULT NULL,
  parent stripe_invoices.line_item_parent DEFAULT NULL,
  pretax_credit_amounts JSONB[] DEFAULT NULL,
  pricing stripe_invoices.line_item_pricing DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  subscription JSONB DEFAULT NULL,
  taxes stripe_invoices.line_item_tax[] DEFAULT NULL
)
RETURNS stripe_invoices.line_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    amount,
    currency,
    discountable,
    discounts,
    livemode,
    metadata,
    object,
    period,
    subtotal,
    description,
    discount_amounts,
    invoice,
    parent,
    pretax_credit_amounts,
    pricing,
    quantity,
    subscription,
    taxes
  )::stripe_invoices.line_item;
$$;

ALTER TYPE stripe_invoices.line_item_period
  ADD ATTRIBUTE "end" BIGINT, ADD ATTRIBUTE start BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_period(
  "end" BIGINT, start BIGINT
)
RETURNS stripe_invoices.line_item_period
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("end", start)::stripe_invoices.line_item_period;
$$;

ALTER TYPE stripe_invoices.line_item_parent
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE invoice_item_details stripe_invoices.line_item_parent_invoice_item_detail,
  ADD ATTRIBUTE subscription_item_details stripe_invoices.line_item_parent_subscription_item_detail;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_parent(
  type TEXT,
  invoice_item_details stripe_invoices.line_item_parent_invoice_item_detail DEFAULT NULL,
  subscription_item_details stripe_invoices.line_item_parent_subscription_item_detail DEFAULT NULL
)
RETURNS stripe_invoices.line_item_parent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, invoice_item_details, subscription_item_details
  )::stripe_invoices.line_item_parent;
$$;

ALTER TYPE stripe_invoices.line_item_parent_invoice_item_detail
  ADD ATTRIBUTE invoice_item TEXT,
  ADD ATTRIBUTE proration BOOLEAN,
  ADD ATTRIBUTE proration_details stripe_invoices.line_item_parent_invoice_item_detail_proration_detail,
  ADD ATTRIBUTE subscription TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_parent_invoice_item_detail(
  invoice_item TEXT,
  proration BOOLEAN,
  proration_details stripe_invoices.line_item_parent_invoice_item_detail_proration_detail DEFAULT NULL,
  subscription TEXT DEFAULT NULL
)
RETURNS stripe_invoices.line_item_parent_invoice_item_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice_item, proration, proration_details, subscription
  )::stripe_invoices.line_item_parent_invoice_item_detail;
$$;

ALTER TYPE stripe_invoices.line_item_parent_invoice_item_detail_proration_detail
  ADD ATTRIBUTE credited_items stripe_invoices.lne_itm_prent_invice_item_detail_proration_detail_credited_item;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_parent_invoice_item_detail_proration_detail(
  credited_items stripe_invoices.lne_itm_prent_invice_item_detail_proration_detail_credited_item DEFAULT NULL
)
RETURNS stripe_invoices.line_item_parent_invoice_item_detail_proration_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    credited_items
  )::stripe_invoices.line_item_parent_invoice_item_detail_proration_detail;
$$;

ALTER TYPE stripe_invoices.lne_itm_prent_invice_item_detail_proration_detail_credited_item
  ADD ATTRIBUTE invoice TEXT, ADD ATTRIBUTE invoice_line_items TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoices.mke_lne_itm_prent_invice_itm_dtail_prration_dtail_credited_item(
  invoice TEXT, invoice_line_items TEXT[]
)
RETURNS stripe_invoices.lne_itm_prent_invice_item_detail_proration_detail_credited_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_items
  )::stripe_invoices.lne_itm_prent_invice_item_detail_proration_detail_credited_item;
$$;

ALTER TYPE stripe_invoices.line_item_parent_subscription_item_detail
  ADD ATTRIBUTE proration BOOLEAN,
  ADD ATTRIBUTE subscription_item TEXT,
  ADD ATTRIBUTE invoice_item TEXT,
  ADD ATTRIBUTE proration_details stripe_invoices.line_item_parent_subscription_item_detail_proration_detail,
  ADD ATTRIBUTE subscription TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_parent_subscription_item_detail(
  proration BOOLEAN,
  subscription_item TEXT,
  invoice_item TEXT DEFAULT NULL,
  proration_details stripe_invoices.line_item_parent_subscription_item_detail_proration_detail DEFAULT NULL,
  subscription TEXT DEFAULT NULL
)
RETURNS stripe_invoices.line_item_parent_subscription_item_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    proration, subscription_item, invoice_item, proration_details, subscription
  )::stripe_invoices.line_item_parent_subscription_item_detail;
$$;

ALTER TYPE stripe_invoices.line_item_parent_subscription_item_detail_proration_detail
  ADD ATTRIBUTE credited_items stripe_invoices.lne_itm_prent_sbscription_itm_dtail_prration_dtail_crdited_item;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_parent_subscription_item_detail_proration_detail(
  credited_items stripe_invoices.lne_itm_prent_sbscription_itm_dtail_prration_dtail_crdited_item DEFAULT NULL
)
RETURNS stripe_invoices.line_item_parent_subscription_item_detail_proration_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    credited_items
  )::stripe_invoices.line_item_parent_subscription_item_detail_proration_detail;
$$;

ALTER TYPE stripe_invoices.lne_itm_prent_sbscription_itm_dtail_prration_dtail_crdited_item
  ADD ATTRIBUTE invoice TEXT, ADD ATTRIBUTE invoice_line_items TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoices.mke_lne_itm_prnt_sbscrption_itm_dtil_prration_dtail_crdited_itm(
  invoice TEXT, invoice_line_items TEXT[]
)
RETURNS stripe_invoices.lne_itm_prent_sbscription_itm_dtail_prration_dtail_crdited_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice, invoice_line_items
  )::stripe_invoices.lne_itm_prent_sbscription_itm_dtail_prration_dtail_crdited_item;
$$;

ALTER TYPE stripe_invoices.line_item_pricing
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE price_details stripe_invoices.line_item_pricing_price_detail,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_pricing(
  type TEXT,
  price_details stripe_invoices.line_item_pricing_price_detail DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_invoices.line_item_pricing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, price_details, unit_amount_decimal
  )::stripe_invoices.line_item_pricing;
$$;

ALTER TYPE stripe_invoices.line_item_pricing_price_detail
  ADD ATTRIBUTE price JSONB, ADD ATTRIBUTE product TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_pricing_price_detail(
  price JSONB, product TEXT
)
RETURNS stripe_invoices.line_item_pricing_price_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(price, product)::stripe_invoices.line_item_pricing_price_detail;
$$;

ALTER TYPE stripe_invoices.line_item_tax
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE taxability_reason TEXT,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE tax_rate_details stripe_invoices.line_item_tax_tax_rate_detail,
  ADD ATTRIBUTE taxable_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_tax(
  amount BIGINT,
  tax_behavior TEXT,
  taxability_reason TEXT,
  type TEXT,
  tax_rate_details stripe_invoices.line_item_tax_tax_rate_detail DEFAULT NULL,
  taxable_amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.line_item_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    tax_behavior,
    taxability_reason,
    type,
    tax_rate_details,
    taxable_amount
  )::stripe_invoices.line_item_tax;
$$;

ALTER TYPE stripe_invoices.line_item_tax_tax_rate_detail
  ADD ATTRIBUTE tax_rate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_line_item_tax_tax_rate_detail(
  tax_rate TEXT
)
RETURNS stripe_invoices.line_item_tax_tax_rate_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_rate)::stripe_invoices.line_item_tax_tax_rate_detail;
$$;

ALTER TYPE stripe_invoices.payment_method
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE billing_details stripe_invoices.payment_method_billing_detail,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE acss_debit stripe_invoices.payment_method_acss_debit,
  ADD ATTRIBUTE affirm stripe_invoices.payment_method_affirm,
  ADD ATTRIBUTE afterpay_clearpay stripe_invoices.payment_method_afterpay_clearpay,
  ADD ATTRIBUTE alipay stripe_invoices.payment_method_alipay,
  ADD ATTRIBUTE allow_redisplay TEXT,
  ADD ATTRIBUTE alma stripe_invoices.payment_method_alma,
  ADD ATTRIBUTE amazon_pay stripe_invoices.payment_method_amazon_pay,
  ADD ATTRIBUTE au_becs_debit stripe_invoices.payment_method_au_becs_debit,
  ADD ATTRIBUTE bacs_debit stripe_invoices.payment_method_bacs_debit,
  ADD ATTRIBUTE bancontact stripe_invoices.payment_method_bancontact,
  ADD ATTRIBUTE billie stripe_invoices.payment_method_billie,
  ADD ATTRIBUTE blik stripe_invoices.payment_method_blik,
  ADD ATTRIBUTE boleto stripe_invoices.payment_method_boleto,
  ADD ATTRIBUTE card JSONB,
  ADD ATTRIBUTE card_present stripe_invoices.payment_method_card_present,
  ADD ATTRIBUTE cashapp stripe_invoices.payment_method_cashapp,
  ADD ATTRIBUTE crypto stripe_invoices.payment_method_crypto,
  ADD ATTRIBUTE custom stripe_invoices.payment_method_custom,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE customer_balance stripe_invoices.payment_method_customer_balance,
  ADD ATTRIBUTE eps stripe_invoices.payment_method_ep,
  ADD ATTRIBUTE fpx stripe_invoices.payment_method_fpx,
  ADD ATTRIBUTE giropay stripe_invoices.payment_method_giropay,
  ADD ATTRIBUTE grabpay stripe_invoices.payment_method_grabpay,
  ADD ATTRIBUTE ideal stripe_invoices.payment_method_ideal,
  ADD ATTRIBUTE interac_present stripe_invoices.payment_method_interac_present,
  ADD ATTRIBUTE kakao_pay stripe_invoices.payment_method_kakao_pay,
  ADD ATTRIBUTE klarna stripe_invoices.payment_method_klarna,
  ADD ATTRIBUTE konbini stripe_invoices.payment_method_konbini,
  ADD ATTRIBUTE kr_card stripe_invoices.payment_method_kr_card,
  ADD ATTRIBUTE link stripe_invoices.payment_method_link,
  ADD ATTRIBUTE mb_way stripe_invoices.payment_method_mb_way,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE mobilepay stripe_invoices.payment_method_mobilepay,
  ADD ATTRIBUTE multibanco stripe_invoices.payment_method_multibanco,
  ADD ATTRIBUTE naver_pay stripe_invoices.payment_method_naver_pay,
  ADD ATTRIBUTE nz_bank_account stripe_invoices.payment_method_nz_bank_account,
  ADD ATTRIBUTE oxxo stripe_invoices.payment_method_oxxo,
  ADD ATTRIBUTE p24 stripe_invoices.payment_method_p24,
  ADD ATTRIBUTE pay_by_bank stripe_invoices.payment_method_pay_by_bank,
  ADD ATTRIBUTE payco stripe_invoices.payment_method_payco,
  ADD ATTRIBUTE paynow stripe_invoices.payment_method_paynow,
  ADD ATTRIBUTE paypal stripe_invoices.payment_method_paypal,
  ADD ATTRIBUTE payto stripe_invoices.payment_method_payto,
  ADD ATTRIBUTE pix stripe_invoices.payment_method_pix,
  ADD ATTRIBUTE promptpay stripe_invoices.payment_method_promptpay,
  ADD ATTRIBUTE radar_options stripe_invoices.payment_method_radar_option,
  ADD ATTRIBUTE revolut_pay stripe_invoices.payment_method_revolut_pay,
  ADD ATTRIBUTE samsung_pay stripe_invoices.payment_method_samsung_pay,
  ADD ATTRIBUTE satispay stripe_invoices.payment_method_satispay,
  ADD ATTRIBUTE sepa_debit JSONB,
  ADD ATTRIBUTE sofort stripe_invoices.payment_method_sofort,
  ADD ATTRIBUTE swish stripe_invoices.payment_method_swish,
  ADD ATTRIBUTE twint stripe_invoices.payment_method_twint,
  ADD ATTRIBUTE us_bank_account stripe_invoices.payment_method_us_bank_account,
  ADD ATTRIBUTE wechat_pay stripe_invoices.payment_method_wechat_pay,
  ADD ATTRIBUTE zip stripe_invoices.payment_method_zip;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method(
  id TEXT,
  billing_details stripe_invoices.payment_method_billing_detail,
  created BIGINT,
  livemode BOOLEAN,
  object TEXT,
  type TEXT,
  acss_debit stripe_invoices.payment_method_acss_debit DEFAULT NULL,
  affirm stripe_invoices.payment_method_affirm DEFAULT NULL,
  afterpay_clearpay stripe_invoices.payment_method_afterpay_clearpay DEFAULT NULL,
  alipay stripe_invoices.payment_method_alipay DEFAULT NULL,
  allow_redisplay TEXT DEFAULT NULL,
  alma stripe_invoices.payment_method_alma DEFAULT NULL,
  amazon_pay stripe_invoices.payment_method_amazon_pay DEFAULT NULL,
  au_becs_debit stripe_invoices.payment_method_au_becs_debit DEFAULT NULL,
  bacs_debit stripe_invoices.payment_method_bacs_debit DEFAULT NULL,
  bancontact stripe_invoices.payment_method_bancontact DEFAULT NULL,
  billie stripe_invoices.payment_method_billie DEFAULT NULL,
  blik stripe_invoices.payment_method_blik DEFAULT NULL,
  boleto stripe_invoices.payment_method_boleto DEFAULT NULL,
  card JSONB DEFAULT NULL,
  card_present stripe_invoices.payment_method_card_present DEFAULT NULL,
  cashapp stripe_invoices.payment_method_cashapp DEFAULT NULL,
  crypto stripe_invoices.payment_method_crypto DEFAULT NULL,
  custom stripe_invoices.payment_method_custom DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  customer_balance stripe_invoices.payment_method_customer_balance DEFAULT NULL,
  eps stripe_invoices.payment_method_ep DEFAULT NULL,
  fpx stripe_invoices.payment_method_fpx DEFAULT NULL,
  giropay stripe_invoices.payment_method_giropay DEFAULT NULL,
  grabpay stripe_invoices.payment_method_grabpay DEFAULT NULL,
  ideal stripe_invoices.payment_method_ideal DEFAULT NULL,
  interac_present stripe_invoices.payment_method_interac_present DEFAULT NULL,
  kakao_pay stripe_invoices.payment_method_kakao_pay DEFAULT NULL,
  klarna stripe_invoices.payment_method_klarna DEFAULT NULL,
  konbini stripe_invoices.payment_method_konbini DEFAULT NULL,
  kr_card stripe_invoices.payment_method_kr_card DEFAULT NULL,
  link stripe_invoices.payment_method_link DEFAULT NULL,
  mb_way stripe_invoices.payment_method_mb_way DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  mobilepay stripe_invoices.payment_method_mobilepay DEFAULT NULL,
  multibanco stripe_invoices.payment_method_multibanco DEFAULT NULL,
  naver_pay stripe_invoices.payment_method_naver_pay DEFAULT NULL,
  nz_bank_account stripe_invoices.payment_method_nz_bank_account DEFAULT NULL,
  oxxo stripe_invoices.payment_method_oxxo DEFAULT NULL,
  p24 stripe_invoices.payment_method_p24 DEFAULT NULL,
  pay_by_bank stripe_invoices.payment_method_pay_by_bank DEFAULT NULL,
  payco stripe_invoices.payment_method_payco DEFAULT NULL,
  paynow stripe_invoices.payment_method_paynow DEFAULT NULL,
  paypal stripe_invoices.payment_method_paypal DEFAULT NULL,
  payto stripe_invoices.payment_method_payto DEFAULT NULL,
  pix stripe_invoices.payment_method_pix DEFAULT NULL,
  promptpay stripe_invoices.payment_method_promptpay DEFAULT NULL,
  radar_options stripe_invoices.payment_method_radar_option DEFAULT NULL,
  revolut_pay stripe_invoices.payment_method_revolut_pay DEFAULT NULL,
  samsung_pay stripe_invoices.payment_method_samsung_pay DEFAULT NULL,
  satispay stripe_invoices.payment_method_satispay DEFAULT NULL,
  sepa_debit JSONB DEFAULT NULL,
  sofort stripe_invoices.payment_method_sofort DEFAULT NULL,
  swish stripe_invoices.payment_method_swish DEFAULT NULL,
  twint stripe_invoices.payment_method_twint DEFAULT NULL,
  us_bank_account stripe_invoices.payment_method_us_bank_account DEFAULT NULL,
  wechat_pay stripe_invoices.payment_method_wechat_pay DEFAULT NULL,
  zip stripe_invoices.payment_method_zip DEFAULT NULL
)
RETURNS stripe_invoices.payment_method
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    billing_details,
    created,
    livemode,
    object,
    type,
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
    link,
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
  )::stripe_invoices.payment_method;
$$;

ALTER TYPE stripe_invoices.payment_method_billing_detail
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_billing_detail(
  address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  name TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  tax_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_billing_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, email, name, phone, tax_id
  )::stripe_invoices.payment_method_billing_detail;
$$;

ALTER TYPE stripe_invoices.payment_method_acss_debit
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE institution_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE transit_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_acss_debit(
  bank_name TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  institution_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  transit_number TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_name, fingerprint, institution_number, last4, transit_number
  )::stripe_invoices.payment_method_acss_debit;
$$;

ALTER TYPE stripe_invoices.payment_method_au_becs_debit
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_au_becs_debit(
  bsb_number TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_au_becs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, fingerprint, last4
  )::stripe_invoices.payment_method_au_becs_debit;
$$;

ALTER TYPE stripe_invoices.payment_method_bacs_debit
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE sort_code TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_bacs_debit(
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  sort_code TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_bacs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, last4, sort_code
  )::stripe_invoices.payment_method_bacs_debit;
$$;

ALTER TYPE stripe_invoices.payment_method_boleto
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_boleto(
  tax_id TEXT
)
RETURNS stripe_invoices.payment_method_boleto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_id)::stripe_invoices.payment_method_boleto;
$$;

ALTER TYPE stripe_invoices.payment_method_card_present
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
  ADD ATTRIBUTE networks stripe_invoices.payment_method_card_present_network,
  ADD ATTRIBUTE offline stripe.payment_method_details_card_present_offline,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE read_method TEXT,
  ADD ATTRIBUTE wallet stripe.pyment_flows_private_payment_methods_card_present_common_wallet;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_present(
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
  networks stripe_invoices.payment_method_card_present_network DEFAULT NULL,
  offline stripe.payment_method_details_card_present_offline DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  read_method TEXT DEFAULT NULL,
  wallet stripe.pyment_flows_private_payment_methods_card_present_common_wallet DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_present
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
  )::stripe_invoices.payment_method_card_present;
$$;

ALTER TYPE stripe_invoices.payment_method_card_present_network
  ADD ATTRIBUTE available TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_present_network(
  available TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_present_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    available, preferred
  )::stripe_invoices.payment_method_card_present_network;
$$;

ALTER TYPE stripe_invoices.payment_method_cashapp
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE cashtag TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_cashapp(
  buyer_id TEXT DEFAULT NULL, cashtag TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_cashapp
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(buyer_id, cashtag)::stripe_invoices.payment_method_cashapp;
$$;

ALTER TYPE stripe_invoices.payment_method_custom
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE display_name TEXT,
  ADD ATTRIBUTE logo stripe_invoices.payment_method_custom_logo;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_custom(
  type TEXT,
  display_name TEXT DEFAULT NULL,
  logo stripe_invoices.payment_method_custom_logo DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_custom
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(type, display_name, logo)::stripe_invoices.payment_method_custom;
$$;

ALTER TYPE stripe_invoices.payment_method_custom_logo
  ADD ATTRIBUTE url TEXT, ADD ATTRIBUTE content_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_custom_logo(
  url TEXT, content_type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_custom_logo
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(url, content_type)::stripe_invoices.payment_method_custom_logo;
$$;

ALTER TYPE stripe_invoices.payment_method_ep
  ADD ATTRIBUTE bank TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_ep(
  bank TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_ep
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank)::stripe_invoices.payment_method_ep;
$$;

ALTER TYPE stripe_invoices.payment_method_fpx
  ADD ATTRIBUTE bank TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_fpx(bank TEXT)
RETURNS stripe_invoices.payment_method_fpx
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank)::stripe_invoices.payment_method_fpx;
$$;

ALTER TYPE stripe_invoices.payment_method_ideal
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE bic TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_ideal(
  bank TEXT DEFAULT NULL, bic TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_ideal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank, bic)::stripe_invoices.payment_method_ideal;
$$;

ALTER TYPE stripe_invoices.payment_method_interac_present
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
  ADD ATTRIBUTE networks stripe_invoices.payment_method_interac_present_network,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE read_method TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_interac_present(
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
  networks stripe_invoices.payment_method_interac_present_network DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  read_method TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_interac_present
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
  )::stripe_invoices.payment_method_interac_present;
$$;

ALTER TYPE stripe_invoices.payment_method_interac_present_network
  ADD ATTRIBUTE available TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_interac_present_network(
  available TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_interac_present_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    available, preferred
  )::stripe_invoices.payment_method_interac_present_network;
$$;

ALTER TYPE stripe_invoices.payment_method_klarna
  ADD ATTRIBUTE dob stripe_invoices.payment_method_klarna_dob;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_klarna(
  dob stripe_invoices.payment_method_klarna_dob DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(dob)::stripe_invoices.payment_method_klarna;
$$;

ALTER TYPE stripe_invoices.payment_method_klarna_dob
  ADD ATTRIBUTE day BIGINT,
  ADD ATTRIBUTE month BIGINT,
  ADD ATTRIBUTE year BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_klarna_dob(
  day BIGINT DEFAULT NULL, month BIGINT DEFAULT NULL, year BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_klarna_dob
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(day, month, year)::stripe_invoices.payment_method_klarna_dob;
$$;

ALTER TYPE stripe_invoices.payment_method_kr_card
  ADD ATTRIBUTE brand TEXT, ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_kr_card(
  brand TEXT DEFAULT NULL, last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_kr_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(brand, last4)::stripe_invoices.payment_method_kr_card;
$$;

ALTER TYPE stripe_invoices.payment_method_link
  ADD ATTRIBUTE email TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_link(
  email TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_link
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(email)::stripe_invoices.payment_method_link;
$$;

ALTER TYPE stripe_invoices.payment_method_naver_pay
  ADD ATTRIBUTE funding TEXT, ADD ATTRIBUTE buyer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_naver_pay(
  funding TEXT, buyer_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_naver_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(funding, buyer_id)::stripe_invoices.payment_method_naver_pay;
$$;

ALTER TYPE stripe_invoices.payment_method_nz_bank_account
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE suffix TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_nz_bank_account(
  bank_code TEXT,
  bank_name TEXT,
  branch_code TEXT,
  last4 TEXT,
  account_holder_name TEXT DEFAULT NULL,
  suffix TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_nz_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, bank_name, branch_code, last4, account_holder_name, suffix
  )::stripe_invoices.payment_method_nz_bank_account;
$$;

ALTER TYPE stripe_invoices.payment_method_p24
  ADD ATTRIBUTE bank TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_p24(
  bank TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank)::stripe_invoices.payment_method_p24;
$$;

ALTER TYPE stripe_invoices.payment_method_paypal
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE payer_email TEXT,
  ADD ATTRIBUTE payer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_paypal(
  country TEXT DEFAULT NULL,
  payer_email TEXT DEFAULT NULL,
  payer_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country, payer_email, payer_id
  )::stripe_invoices.payment_method_paypal;
$$;

ALTER TYPE stripe_invoices.payment_method_payto
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE pay_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_payto(
  bsb_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  pay_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bsb_number, last4, pay_id)::stripe_invoices.payment_method_payto;
$$;

ALTER TYPE stripe_invoices.payment_method_radar_option
  ADD ATTRIBUTE session TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_radar_option(
  session TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_radar_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(session)::stripe_invoices.payment_method_radar_option;
$$;

ALTER TYPE stripe_invoices.payment_method_sofort
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_sofort(
  country TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_sofort
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(country)::stripe_invoices.payment_method_sofort;
$$;

ALTER TYPE stripe_invoices.payment_method_us_bank_account
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE financial_connections_account TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE networks stripe_invoices.payment_method_us_bank_account_network,
  ADD ATTRIBUTE routing_number TEXT,
  ADD ATTRIBUTE status_details stripe_invoices.payment_method_us_bank_account_status_detail;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_us_bank_account(
  account_holder_type TEXT DEFAULT NULL,
  account_type TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  financial_connections_account TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  networks stripe_invoices.payment_method_us_bank_account_network DEFAULT NULL,
  routing_number TEXT DEFAULT NULL,
  status_details stripe_invoices.payment_method_us_bank_account_status_detail DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_us_bank_account
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
  )::stripe_invoices.payment_method_us_bank_account;
$$;

ALTER TYPE stripe_invoices.payment_method_us_bank_account_network
  ADD ATTRIBUTE supported TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_us_bank_account_network(
  supported TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_us_bank_account_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    supported, preferred
  )::stripe_invoices.payment_method_us_bank_account_network;
$$;

ALTER TYPE stripe_invoices.payment_method_us_bank_account_status_detail
  ADD ATTRIBUTE blocked stripe_invoices.payment_method_us_bank_account_status_detail_blocked;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_us_bank_account_status_detail(
  blocked stripe_invoices.payment_method_us_bank_account_status_detail_blocked DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_us_bank_account_status_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    blocked
  )::stripe_invoices.payment_method_us_bank_account_status_detail;
$$;

ALTER TYPE stripe_invoices.payment_method_us_bank_account_status_detail_blocked
  ADD ATTRIBUTE network_code TEXT, ADD ATTRIBUTE reason TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_us_bank_account_status_detail_blocked(
  network_code TEXT DEFAULT NULL, reason TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_us_bank_account_status_detail_blocked
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    network_code, reason
  )::stripe_invoices.payment_method_us_bank_account_status_detail_blocked;
$$;

ALTER TYPE stripe_invoices.payment_method_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE checks stripe_invoices.payment_method_card_check,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE display_brand TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE generated_from JSONB,
  ADD ATTRIBUTE networks stripe_invoices.payment_method_card_network,
  ADD ATTRIBUTE regulated_status TEXT,
  ADD ATTRIBUTE three_d_secure_usage stripe_invoices.payment_method_card_three_d_secure_usage,
  ADD ATTRIBUTE wallet stripe_invoices.payment_method_card_wallet;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card(
  brand TEXT,
  exp_month BIGINT,
  exp_year BIGINT,
  funding TEXT,
  last4 TEXT,
  checks stripe_invoices.payment_method_card_check DEFAULT NULL,
  country TEXT DEFAULT NULL,
  display_brand TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  generated_from JSONB DEFAULT NULL,
  networks stripe_invoices.payment_method_card_network DEFAULT NULL,
  regulated_status TEXT DEFAULT NULL,
  three_d_secure_usage stripe_invoices.payment_method_card_three_d_secure_usage DEFAULT NULL,
  wallet stripe_invoices.payment_method_card_wallet DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card
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
  )::stripe_invoices.payment_method_card;
$$;

ALTER TYPE stripe_invoices.payment_method_card_check
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_postal_code_check TEXT,
  ADD ATTRIBUTE cvc_check TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_check(
  address_line1_check TEXT DEFAULT NULL,
  address_postal_code_check TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_check
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check, address_postal_code_check, cvc_check
  )::stripe_invoices.payment_method_card_check;
$$;

ALTER TYPE stripe_invoices.payment_method_card_network
  ADD ATTRIBUTE available TEXT[], ADD ATTRIBUTE preferred TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_network(
  available TEXT[], preferred TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_network
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(available, preferred)::stripe_invoices.payment_method_card_network;
$$;

ALTER TYPE stripe_invoices.payment_method_card_three_d_secure_usage
  ADD ATTRIBUTE supported BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_three_d_secure_usage(
  supported BOOLEAN
)
RETURNS stripe_invoices.payment_method_card_three_d_secure_usage
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    supported
  )::stripe_invoices.payment_method_card_three_d_secure_usage;
$$;

ALTER TYPE stripe_invoices.payment_method_card_wallet
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE amex_express_checkout stripe_invoices.payment_method_card_wallet_amex_express_checkout,
  ADD ATTRIBUTE apple_pay stripe_invoices.payment_method_card_wallet_apple_pay,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE google_pay stripe_invoices.payment_method_card_wallet_google_pay,
  ADD ATTRIBUTE link stripe_invoices.payment_method_card_wallet_link,
  ADD ATTRIBUTE masterpass stripe_invoices.payment_method_card_wallet_masterpass,
  ADD ATTRIBUTE samsung_pay stripe_invoices.payment_method_card_wallet_samsung_pay,
  ADD ATTRIBUTE visa_checkout stripe_invoices.payment_method_card_wallet_visa_checkout;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_wallet(
  type TEXT,
  amex_express_checkout stripe_invoices.payment_method_card_wallet_amex_express_checkout DEFAULT NULL,
  apple_pay stripe_invoices.payment_method_card_wallet_apple_pay DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  google_pay stripe_invoices.payment_method_card_wallet_google_pay DEFAULT NULL,
  link stripe_invoices.payment_method_card_wallet_link DEFAULT NULL,
  masterpass stripe_invoices.payment_method_card_wallet_masterpass DEFAULT NULL,
  samsung_pay stripe_invoices.payment_method_card_wallet_samsung_pay DEFAULT NULL,
  visa_checkout stripe_invoices.payment_method_card_wallet_visa_checkout DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_wallet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type,
    amex_express_checkout,
    apple_pay,
    dynamic_last4,
    google_pay,
    link,
    masterpass,
    samsung_pay,
    visa_checkout
  )::stripe_invoices.payment_method_card_wallet;
$$;

ALTER TYPE stripe_invoices.payment_method_card_wallet_masterpass
  ADD ATTRIBUTE billing_address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE shipping_address stripe.address;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_wallet_masterpass(
  billing_address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  name TEXT DEFAULT NULL,
  shipping_address stripe.address DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_wallet_masterpass
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_address, email, name, shipping_address
  )::stripe_invoices.payment_method_card_wallet_masterpass;
$$;

ALTER TYPE stripe_invoices.payment_method_card_wallet_visa_checkout
  ADD ATTRIBUTE billing_address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE shipping_address stripe.address;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_wallet_visa_checkout(
  billing_address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  name TEXT DEFAULT NULL,
  shipping_address stripe.address DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_wallet_visa_checkout
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_address, email, name, shipping_address
  )::stripe_invoices.payment_method_card_wallet_visa_checkout;
$$;

ALTER TYPE stripe_invoices.payment_method_card_generated_card
  ADD ATTRIBUTE charge TEXT,
  ADD ATTRIBUTE payment_method_details stripe_invoices.payment_method_card_generated_card_payment_method_detail,
  ADD ATTRIBUTE setup_attempt JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_generated_card(
  charge TEXT DEFAULT NULL,
  payment_method_details stripe_invoices.payment_method_card_generated_card_payment_method_detail DEFAULT NULL,
  setup_attempt JSONB DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_generated_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    charge, payment_method_details, setup_attempt
  )::stripe_invoices.payment_method_card_generated_card;
$$;

ALTER TYPE stripe_invoices.payment_method_card_generated_card_payment_method_detail
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE card_present stripe.payment_method_details_card_present;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_card_generated_card_payment_method_detail(
  type TEXT,
  card_present stripe.payment_method_details_card_present DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_card_generated_card_payment_method_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, card_present
  )::stripe_invoices.payment_method_card_generated_card_payment_method_detail;
$$;

ALTER TYPE stripe_invoices.payment_method_details_payment_record_us_bank_account
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate JSONB,
  ADD ATTRIBUTE payment_reference TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_details_payment_record_us_bank_account(
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
RETURNS stripe_invoices.payment_method_details_payment_record_us_bank_account
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
  )::stripe_invoices.payment_method_details_payment_record_us_bank_account;
$$;

ALTER TYPE stripe_invoices.payment_method_sepa_debit
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE generated_from JSONB,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_method_sepa_debit(
  bank_code TEXT DEFAULT NULL,
  branch_code TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  generated_from JSONB DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_method_sepa_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, branch_code, country, fingerprint, generated_from, last4
  )::stripe_invoices.payment_method_sepa_debit;
$$;

ALTER TYPE stripe_invoices.payment_record
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE amount stripe_invoices.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_authorized stripe_invoices.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_canceled stripe_invoices.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_failed stripe_invoices.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_guaranteed stripe_invoices.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_refunded stripe_invoices.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE amount_requested stripe_invoices.payments_primitives_payment_records_resource_amount,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE processor_details stripe_invoices.payment_record_processor_detail,
  ADD ATTRIBUTE reported_by TEXT,
  ADD ATTRIBUTE application TEXT,
  ADD ATTRIBUTE customer_details stripe_invoices.payment_record_customer_detail,
  ADD ATTRIBUTE customer_presence TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE latest_payment_attempt_record TEXT,
  ADD ATTRIBUTE payment_method_details JSONB,
  ADD ATTRIBUTE shipping_details stripe_invoices.payment_record_shipping_detail;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_record(
  id TEXT,
  amount stripe_invoices.payments_primitives_payment_records_resource_amount,
  amount_authorized stripe_invoices.payments_primitives_payment_records_resource_amount,
  amount_canceled stripe_invoices.payments_primitives_payment_records_resource_amount,
  amount_failed stripe_invoices.payments_primitives_payment_records_resource_amount,
  amount_guaranteed stripe_invoices.payments_primitives_payment_records_resource_amount,
  amount_refunded stripe_invoices.payments_primitives_payment_records_resource_amount,
  amount_requested stripe_invoices.payments_primitives_payment_records_resource_amount,
  created BIGINT,
  livemode BOOLEAN,
  metadata JSONB,
  object TEXT,
  processor_details stripe_invoices.payment_record_processor_detail,
  reported_by TEXT,
  application TEXT DEFAULT NULL,
  customer_details stripe_invoices.payment_record_customer_detail DEFAULT NULL,
  customer_presence TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  latest_payment_attempt_record TEXT DEFAULT NULL,
  payment_method_details JSONB DEFAULT NULL,
  shipping_details stripe_invoices.payment_record_shipping_detail DEFAULT NULL
)
RETURNS stripe_invoices.payment_record
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
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
    object,
    processor_details,
    reported_by,
    application,
    customer_details,
    customer_presence,
    description,
    latest_payment_attempt_record,
    payment_method_details,
    shipping_details
  )::stripe_invoices.payment_record;
$$;

ALTER TYPE stripe_invoices.payment_record_processor_detail
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE custom stripe_invoices.payment_record_processor_detail_custom;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_record_processor_detail(
  type TEXT,
  custom stripe_invoices.payment_record_processor_detail_custom DEFAULT NULL
)
RETURNS stripe_invoices.payment_record_processor_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(type, custom)::stripe_invoices.payment_record_processor_detail;
$$;

ALTER TYPE stripe_invoices.payment_record_processor_detail_custom
  ADD ATTRIBUTE payment_reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_record_processor_detail_custom(
  payment_reference TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_record_processor_detail_custom
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_reference
  )::stripe_invoices.payment_record_processor_detail_custom;
$$;

ALTER TYPE stripe_invoices.payment_record_customer_detail
  ADD ATTRIBUTE customer TEXT,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_record_customer_detail(
  customer TEXT DEFAULT NULL,
  email TEXT DEFAULT NULL,
  name TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_record_customer_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    customer, email, name, phone
  )::stripe_invoices.payment_record_customer_detail;
$$;

ALTER TYPE stripe_invoices.payment_record_shipping_detail
  ADD ATTRIBUTE address stripe_invoices.payment_record_shipping_detail_address,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_record_shipping_detail(
  address stripe_invoices.payment_record_shipping_detail_address,
  name TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_record_shipping_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, name, phone
  )::stripe_invoices.payment_record_shipping_detail;
$$;

ALTER TYPE stripe_invoices.payment_record_shipping_detail_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE state TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payment_record_shipping_detail_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  state TEXT DEFAULT NULL
)
RETURNS stripe_invoices.payment_record_shipping_detail_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, state
  )::stripe_invoices.payment_record_shipping_detail_address;
$$;

ALTER TYPE stripe_invoices.payments_primitives_payment_records_resource_amount
  ADD ATTRIBUTE currency TEXT, ADD ATTRIBUTE value BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_payments_primitives_payment_records_resource_amount(
  currency TEXT, value BIGINT
)
RETURNS stripe_invoices.payments_primitives_payment_records_resource_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, value
  )::stripe_invoices.payments_primitives_payment_records_resource_amount;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_resource_payment_method_details
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE ach_credit_transfer stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_ach_crdt_trnsfr,
  ADD ATTRIBUTE ach_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_ach_dbit,
  ADD ATTRIBUTE acss_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_acss_dbit,
  ADD ATTRIBUTE affirm stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_affrm,
  ADD ATTRIBUTE afterpay_clearpay stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_aftrpy_clrpay,
  ADD ATTRIBUTE alipay stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_alpay,
  ADD ATTRIBUTE alma stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_alma,
  ADD ATTRIBUTE amazon_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_amzon_py,
  ADD ATTRIBUTE au_becs_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_au_bcs_dbit,
  ADD ATTRIBUTE bacs_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_bcs_dbit,
  ADD ATTRIBUTE bancontact JSONB,
  ADD ATTRIBUTE billie stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bllie,
  ADD ATTRIBUTE billing_details stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_bllng_dtail,
  ADD ATTRIBUTE blik stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_blk,
  ADD ATTRIBUTE boleto stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bleto,
  ADD ATTRIBUTE card stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_crd,
  ADD ATTRIBUTE card_present stripe.payment_method_details_card_present,
  ADD ATTRIBUTE cashapp stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_cshapp,
  ADD ATTRIBUTE crypto stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_crypto,
  ADD ATTRIBUTE custom stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_cstom,
  ADD ATTRIBUTE customer_balance stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_cstmer_blnce,
  ADD ATTRIBUTE eps stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_details_ep,
  ADD ATTRIBUTE fpx stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_fpx,
  ADD ATTRIBUTE giropay stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_gropay,
  ADD ATTRIBUTE grabpay stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_grbpay,
  ADD ATTRIBUTE ideal JSONB,
  ADD ATTRIBUTE interac_present stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_intrc_prsnt,
  ADD ATTRIBUTE kakao_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_kkao_py,
  ADD ATTRIBUTE klarna stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_klrna,
  ADD ATTRIBUTE konbini stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_knbini,
  ADD ATTRIBUTE kr_card stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_kr_crd,
  ADD ATTRIBUTE link stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_lnk,
  ADD ATTRIBUTE mb_way stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_mb_wy,
  ADD ATTRIBUTE mobilepay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_mbilepay,
  ADD ATTRIBUTE multibanco stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_mltibanco,
  ADD ATTRIBUTE naver_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_nver_py,
  ADD ATTRIBUTE nz_bank_account stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_nz_bnk_accnt,
  ADD ATTRIBUTE oxxo stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_oxxo,
  ADD ATTRIBUTE p24 stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_p24,
  ADD ATTRIBUTE pay_by_bank stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_py_by_bnk,
  ADD ATTRIBUTE payco stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyco,
  ADD ATTRIBUTE payment_method TEXT,
  ADD ATTRIBUTE paynow stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pynow,
  ADD ATTRIBUTE paypal stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pypal,
  ADD ATTRIBUTE payto stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyto,
  ADD ATTRIBUTE pix stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pix,
  ADD ATTRIBUTE promptpay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_prmptpay,
  ADD ATTRIBUTE revolut_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_rvolut_py,
  ADD ATTRIBUTE samsung_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_smsung_py,
  ADD ATTRIBUTE satispay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_stispay,
  ADD ATTRIBUTE sepa_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_spa_dbit,
  ADD ATTRIBUTE sofort JSONB,
  ADD ATTRIBUTE stripe_account stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_strpe_accnt,
  ADD ATTRIBUTE swish stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_swsh,
  ADD ATTRIBUTE twint stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_twnt,
  ADD ATTRIBUTE us_bank_account JSONB,
  ADD ATTRIBUTE wechat stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_wchat,
  ADD ATTRIBUTE wechat_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_wchat_py,
  ADD ATTRIBUTE zip stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_zip;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails(
  type TEXT,
  ach_credit_transfer stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_ach_crdt_trnsfr DEFAULT NULL,
  ach_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_ach_dbit DEFAULT NULL,
  acss_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_acss_dbit DEFAULT NULL,
  affirm stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_affrm DEFAULT NULL,
  afterpay_clearpay stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_aftrpy_clrpay DEFAULT NULL,
  alipay stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_alpay DEFAULT NULL,
  alma stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_alma DEFAULT NULL,
  amazon_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_amzon_py DEFAULT NULL,
  au_becs_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_au_bcs_dbit DEFAULT NULL,
  bacs_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_bcs_dbit DEFAULT NULL,
  bancontact JSONB DEFAULT NULL,
  billie stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bllie DEFAULT NULL,
  billing_details stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_bllng_dtail DEFAULT NULL,
  blik stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_blk DEFAULT NULL,
  boleto stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bleto DEFAULT NULL,
  card stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_crd DEFAULT NULL,
  card_present stripe.payment_method_details_card_present DEFAULT NULL,
  cashapp stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_cshapp DEFAULT NULL,
  crypto stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_crypto DEFAULT NULL,
  custom stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_cstom DEFAULT NULL,
  customer_balance stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_cstmer_blnce DEFAULT NULL,
  eps stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_details_ep DEFAULT NULL,
  fpx stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_fpx DEFAULT NULL,
  giropay stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_gropay DEFAULT NULL,
  grabpay stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_grbpay DEFAULT NULL,
  ideal JSONB DEFAULT NULL,
  interac_present stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_intrc_prsnt DEFAULT NULL,
  kakao_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_kkao_py DEFAULT NULL,
  klarna stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_klrna DEFAULT NULL,
  konbini stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_knbini DEFAULT NULL,
  kr_card stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_kr_crd DEFAULT NULL,
  link stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_lnk DEFAULT NULL,
  mb_way stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_mb_wy DEFAULT NULL,
  mobilepay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_mbilepay DEFAULT NULL,
  multibanco stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_mltibanco DEFAULT NULL,
  naver_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_nver_py DEFAULT NULL,
  nz_bank_account stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_nz_bnk_accnt DEFAULT NULL,
  oxxo stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_oxxo DEFAULT NULL,
  p24 stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_p24 DEFAULT NULL,
  pay_by_bank stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_py_by_bnk DEFAULT NULL,
  payco stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyco DEFAULT NULL,
  payment_method TEXT DEFAULT NULL,
  paynow stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pynow DEFAULT NULL,
  paypal stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pypal DEFAULT NULL,
  payto stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyto DEFAULT NULL,
  pix stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pix DEFAULT NULL,
  promptpay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_prmptpay DEFAULT NULL,
  revolut_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_rvolut_py DEFAULT NULL,
  samsung_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_smsung_py DEFAULT NULL,
  satispay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_stispay DEFAULT NULL,
  sepa_debit stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_spa_dbit DEFAULT NULL,
  sofort JSONB DEFAULT NULL,
  stripe_account stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_strpe_accnt DEFAULT NULL,
  swish stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_swsh DEFAULT NULL,
  twint stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_twnt DEFAULT NULL,
  us_bank_account JSONB DEFAULT NULL,
  wechat stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_wchat DEFAULT NULL,
  wechat_pay stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_wchat_py DEFAULT NULL,
  zip stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_zip DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_resource_payment_method_details
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type,
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
    link,
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
  )::stripe_invoices.pyments_prmitives_pyment_rcords_resource_payment_method_details;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_ach_crdt_trnsfr
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE routing_number TEXT,
  ADD ATTRIBUTE swift_code TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_ach_crdt_trnsfr(
  account_number TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL,
  swift_code TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_ach_crdt_trnsfr
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_number, bank_name, routing_number, swift_code
  )::stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_ach_crdt_trnsfr;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_ach_dbit
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_ach_dbt(
  account_holder_type TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_ach_dbit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_type, bank_name, country, fingerprint, last4, routing_number
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_ach_dbit;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_acss_dbit
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE institution_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE transit_number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_acss_dbt(
  bank_name TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  institution_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  transit_number TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_acss_dbit
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
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_acss_dbit;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_affrm
  ADD ATTRIBUTE location TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_affrm(
  location TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_affrm
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    location, reader, transaction_id
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_affrm;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_aftrpy_clrpay
  ADD ATTRIBUTE order_id TEXT, ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_aftrpy_clrpy(
  order_id TEXT DEFAULT NULL, reference TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_aftrpy_clrpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    order_id, reference
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_aftrpy_clrpay;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_alpay
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_alpay(
  buyer_id TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_alpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, fingerprint, transaction_id
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_alpay;
$$;

ALTER TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_alma
  ADD ATTRIBUTE installments stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_alma_instllmnt,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_alma(
  installments stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_alma_instllmnt DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_alma
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    installments, transaction_id
  )::stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_alma;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_alma_instllmnt
  ADD ATTRIBUTE count BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_alma_instllmnt(
  count BIGINT
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_alma_instllmnt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    count
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_alma_instllmnt;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_amzon_py
  ADD ATTRIBUTE funding stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_amzn_py_fndng,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_amzn_py(
  funding stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_amzn_py_fndng DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_amzon_py
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    funding, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_amzon_py;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_amzn_py_fndng
  ADD ATTRIBUTE card stripe.payment_method_details_passthrough_card,
  ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_amzn_py_fndng(
  card stripe.payment_method_details_passthrough_card DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_amzn_py_fndng
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card, type
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_amzn_py_fndng;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_au_bcs_dbit
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_au_bcs_dbt(
  bsb_number TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_au_bcs_dbit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, expected_debit_date, fingerprint, last4, mandate
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_au_bcs_dbit;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_bcs_dbit
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE sort_code TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_bcs_dbt(
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  sort_code TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_bcs_dbit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expected_debit_date, fingerprint, last4, mandate, sort_code
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_bcs_dbit;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bllie
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_bllie(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bllie
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_id
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bllie;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_bllng_dtail
  ADD ATTRIBUTE address stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtl_addrss,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtil(
  address stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtl_addrss,
  email TEXT DEFAULT NULL,
  name TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_bllng_dtail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, email, name, phone
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_bllng_dtail;
$$;

ALTER TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtl_addrss
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE state TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtl_addrss(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  state TEXT DEFAULT NULL
)
RETURNS stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtl_addrss
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, state
  )::stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtl_addrss;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_blk
  ADD ATTRIBUTE buyer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_blk(
  buyer_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_blk
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id
  )::stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_blk;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bleto
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_bleto(
  tax_id TEXT
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bleto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    tax_id
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bleto;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_crd
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE capture_before BIGINT,
  ADD ATTRIBUTE checks stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_crd_chck,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE iin TEXT,
  ADD ATTRIBUTE installments stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_instllmnt,
  ADD ATTRIBUTE issuer TEXT,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE network_advice_code TEXT,
  ADD ATTRIBUTE network_decline_code TEXT,
  ADD ATTRIBUTE network_token stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_ntwrk_tkn,
  ADD ATTRIBUTE network_transaction_id TEXT,
  ADD ATTRIBUTE stored_credential_usage TEXT,
  ADD ATTRIBUTE three_d_secure stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_thre_d_scre,
  ADD ATTRIBUTE wallet stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_crd_wllet;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_crd(
  brand TEXT,
  exp_month BIGINT,
  exp_year BIGINT,
  funding TEXT,
  last4 TEXT,
  authorization_code TEXT DEFAULT NULL,
  capture_before BIGINT DEFAULT NULL,
  checks stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_crd_chck DEFAULT NULL,
  country TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  iin TEXT DEFAULT NULL,
  installments stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_instllmnt DEFAULT NULL,
  issuer TEXT DEFAULT NULL,
  network TEXT DEFAULT NULL,
  network_advice_code TEXT DEFAULT NULL,
  network_decline_code TEXT DEFAULT NULL,
  network_token stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_ntwrk_tkn DEFAULT NULL,
  network_transaction_id TEXT DEFAULT NULL,
  stored_credential_usage TEXT DEFAULT NULL,
  three_d_secure stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_thre_d_scre DEFAULT NULL,
  wallet stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_crd_wllet DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_crd
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
  )::stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_crd;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_crd_chck
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_postal_code_check TEXT,
  ADD ATTRIBUTE cvc_check TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_crd_chck(
  address_line1_check TEXT DEFAULT NULL,
  address_postal_code_check TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_crd_chck
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check, address_postal_code_check, cvc_check
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_crd_chck;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_instllmnt
  ADD ATTRIBUTE plan stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt_pln;

CREATE OR REPLACE FUNCTION stripe_invoices.m_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt(
  plan stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt_pln DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_instllmnt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    plan
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_instllmnt;
$$;

ALTER TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt_pln
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE count BIGINT,
  ADD ATTRIBUTE "interval" TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt_pln(
  type TEXT, count BIGINT DEFAULT NULL, "interval" TEXT DEFAULT NULL
)
RETURNS stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt_pln
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, count, "interval"
  )::stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt_pln;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_ntwrk_tkn
  ADD ATTRIBUTE used BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_invoices.m_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_ntwrk_tkn(
  used BOOLEAN
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_ntwrk_tkn
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    used
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_ntwrk_tkn;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_thre_d_scre
  ADD ATTRIBUTE authentication_flow TEXT,
  ADD ATTRIBUTE result TEXT,
  ADD ATTRIBUTE result_reason TEXT,
  ADD ATTRIBUTE version TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_thre_d_scre(
  authentication_flow TEXT DEFAULT NULL,
  result TEXT DEFAULT NULL,
  result_reason TEXT DEFAULT NULL,
  version TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_thre_d_scre
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    authentication_flow, result, result_reason, version
  )::stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_thre_d_scre;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_crd_wllet
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE apple_pay stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_apple_py,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE google_pay stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_ggle_py;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_crd_wllt(
  type TEXT,
  apple_pay stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_apple_py DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  google_pay stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_ggle_py DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_crd_wllet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, apple_pay, dynamic_last4, google_pay
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_crd_wllet;
$$;

ALTER TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_apple_py
  ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_apple_py(
  type TEXT
)
RETURNS stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_apple_py
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type
  )::stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_apple_py;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_cshapp
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE cashtag TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtails_cshapp(
  buyer_id TEXT DEFAULT NULL,
  cashtag TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_cshapp
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, cashtag, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_cshapp;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_crypto
  ADD ATTRIBUTE buyer_address TEXT,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE token_currency TEXT,
  ADD ATTRIBUTE transaction_hash TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtails_crypto(
  buyer_address TEXT DEFAULT NULL,
  network TEXT DEFAULT NULL,
  token_currency TEXT DEFAULT NULL,
  transaction_hash TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_crypto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_address, network, token_currency, transaction_hash
  )::stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_crypto;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_cstom
  ADD ATTRIBUTE display_name TEXT, ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_cstom(
  display_name TEXT, type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_cstom
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    display_name, type
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_cstom;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_details_ep
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_ep(
  bank TEXT DEFAULT NULL, verified_name TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_details_ep
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, verified_name
  )::stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_details_ep;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_fpx
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_fpx(
  bank TEXT, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_fpx
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, transaction_id
  )::stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_fpx;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_gropay
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtails_gropay(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_gropay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, bank_name, bic, verified_name
  )::stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_gropay;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_grbpay
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtails_grbpay(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_grbpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_grbpay;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_intrc_prsnt
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
  ADD ATTRIBUTE receipt stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt_rcpt;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt(
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
  receipt stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt_rcpt DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_intrc_prsnt
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
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_intrc_prsnt;
$$;

ALTER TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt_rcpt
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE application_cryptogram TEXT,
  ADD ATTRIBUTE application_preferred_name TEXT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE authorization_response_code TEXT,
  ADD ATTRIBUTE cardholder_verification_method TEXT,
  ADD ATTRIBUTE dedicated_file_name TEXT,
  ADD ATTRIBUTE terminal_verification_results TEXT,
  ADD ATTRIBUTE transaction_status_information TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt_rcpt(
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
RETURNS stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt_rcpt
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
  )::stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt_rcpt;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_kkao_py
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_kkao_py(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_kkao_py
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_kkao_py;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_klrna
  ADD ATTRIBUTE payer_details stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtil,
  ADD ATTRIBUTE payment_method_category TEXT,
  ADD ATTRIBUTE preferred_locale TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_klrna(
  payer_details stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtil DEFAULT NULL,
  payment_method_category TEXT DEFAULT NULL,
  preferred_locale TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_klrna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payer_details, payment_method_category, preferred_locale
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_klrna;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtil
  ADD ATTRIBUTE address stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl_addrss;

CREATE OR REPLACE FUNCTION stripe_invoices.m_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl(
  address stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl_addrss DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtil
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtil;
$$;

ALTER TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl_addrss
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_p_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl_addrss(
  country TEXT DEFAULT NULL
)
RETURNS stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl_addrss
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl_addrss;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_knbini
  ADD ATTRIBUTE store stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_knbini_stre;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtails_knbini(
  store stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_knbini_stre DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_knbini
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    store
  )::stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_knbini;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_knbini_stre
  ADD ATTRIBUTE chain TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_knbni_stre(
  chain TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_knbini_stre
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    chain
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_knbini_stre;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_kr_crd
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtails_kr_crd(
  brand TEXT DEFAULT NULL,
  buyer_id TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_kr_crd
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, buyer_id, last4, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_kr_crd;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_lnk
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_lnk(
  country TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_lnk
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_lnk;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_mbilepay
  ADD ATTRIBUTE card stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mblepay_crd;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mblepay(
  card stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mblepay_crd DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_mbilepay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_mbilepay;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mblepay_crd
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_mblpay_crd(
  brand TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mblepay_crd
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, country, exp_month, exp_year, last4
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mblepay_crd;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_mltibanco
  ADD ATTRIBUTE entity TEXT, ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mltbanco(
  entity TEXT DEFAULT NULL, reference TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_mltibanco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    entity, reference
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_mltibanco;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_nver_py
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_nver_py(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_nver_py
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_nver_py;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_nz_bnk_accnt
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE suffix TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_nz_bnk_accnt(
  bank_code TEXT,
  bank_name TEXT,
  branch_code TEXT,
  last4 TEXT,
  account_holder_name TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  suffix TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_nz_bnk_accnt
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
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_nz_bnk_accnt;
$$;

ALTER TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_oxxo
  ADD ATTRIBUTE number TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_oxxo(
  number TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_oxxo
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    number
  )::stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_oxxo;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_p24
  ADD ATTRIBUTE bank TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_p24(
  bank TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, reference, verified_name
  )::stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_p24;
$$;

ALTER TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyco
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_pyco(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyco;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pynow
  ADD ATTRIBUTE location TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_pynow(
  location TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pynow
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    location, reader, reference
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pynow;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pypal
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE payer_email TEXT,
  ADD ATTRIBUTE payer_id TEXT,
  ADD ATTRIBUTE payer_name TEXT,
  ADD ATTRIBUTE seller_protection stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_pypl_sllr_prtctn,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_pypal(
  country TEXT DEFAULT NULL,
  payer_email TEXT DEFAULT NULL,
  payer_id TEXT DEFAULT NULL,
  payer_name TEXT DEFAULT NULL,
  seller_protection stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_pypl_sllr_prtctn DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pypal
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
  )::stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pypal;
$$;

ALTER TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_pypl_sllr_prtctn
  ADD ATTRIBUTE status TEXT, ADD ATTRIBUTE dispute_categories TEXT[];

CREATE OR REPLACE FUNCTION stripe_invoices.m_p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_pypl_sllr_prtctn(
  status TEXT, dispute_categories TEXT[] DEFAULT NULL
)
RETURNS stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_pypl_sllr_prtctn
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status, dispute_categories
  )::stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_pypl_sllr_prtctn;
$$;

ALTER TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyto
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE pay_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_pyto(
  bsb_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  pay_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, last4, mandate, pay_id
  )::stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyto;
$$;

ALTER TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pix
  ADD ATTRIBUTE bank_transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_px(
  bank_transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pix
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_transaction_id
  )::stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pix;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_prmptpay
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_prmptpy(
  reference TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_prmptpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_prmptpay;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_rvolut_py
  ADD ATTRIBUTE funding stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_rvlut_py_fndng,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_rvlut_py(
  funding stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_rvlut_py_fndng DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_rvolut_py
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    funding, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_rvolut_py;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_rvlut_py_fndng
  ADD ATTRIBUTE card stripe.payment_method_details_passthrough_card,
  ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_rvlt_py_fndng(
  card stripe.payment_method_details_passthrough_card DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_rvlut_py_fndng
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card, type
  )::stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_rvlut_py_fndng;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_smsung_py
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_smsng_py(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_smsung_py
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_smsung_py;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_stispay
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_stispay(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_stispay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_stispay;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_spa_dbit
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_spa_dbt(
  bank_code TEXT DEFAULT NULL,
  branch_code TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_spa_dbit
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
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_spa_dbit;
$$;

ALTER TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_swsh
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE payment_reference TEXT,
  ADD ATTRIBUTE verified_phone_last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_swsh(
  fingerprint TEXT DEFAULT NULL,
  payment_reference TEXT DEFAULT NULL,
  verified_phone_last4 TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_swsh
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, payment_reference, verified_phone_last4
  )::stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_swsh;
$$;

ALTER TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_wchat_py
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE location TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_wcht_py(
  fingerprint TEXT DEFAULT NULL,
  location TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_wchat_py
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, location, reader, transaction_id
  )::stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_wchat_py;
$$;

ALTER TYPE stripe_invoices.sepa_debit_generated_from
  ADD ATTRIBUTE charge JSONB, ADD ATTRIBUTE setup_attempt JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_sepa_debit_generated_from(
  charge JSONB DEFAULT NULL, setup_attempt JSONB DEFAULT NULL
)
RETURNS stripe_invoices.sepa_debit_generated_from
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(charge, setup_attempt)::stripe_invoices.sepa_debit_generated_from;
$$;

ALTER TYPE stripe_invoices.shipping_rate_delivery_estimate_bound
  ADD ATTRIBUTE unit TEXT, ADD ATTRIBUTE value BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_shipping_rate_delivery_estimate_bound(
  unit TEXT, value BIGINT
)
RETURNS stripe_invoices.shipping_rate_delivery_estimate_bound
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    unit, value
  )::stripe_invoices.shipping_rate_delivery_estimate_bound;
$$;

ALTER TYPE stripe_invoices.tax_rate
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE active BOOLEAN,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE display_name TEXT,
  ADD ATTRIBUTE inclusive BOOLEAN,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE percentage DOUBLE PRECISION,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE effective_percentage DOUBLE PRECISION,
  ADD ATTRIBUTE flat_amount stripe_invoices.tax_rate_flat_amount,
  ADD ATTRIBUTE jurisdiction TEXT,
  ADD ATTRIBUTE jurisdiction_level TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE rate_type TEXT,
  ADD ATTRIBUTE state TEXT,
  ADD ATTRIBUTE tax_type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_tax_rate(
  id TEXT,
  active BOOLEAN,
  created BIGINT,
  display_name TEXT,
  inclusive BOOLEAN,
  livemode BOOLEAN,
  object TEXT,
  percentage DOUBLE PRECISION,
  country TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  effective_percentage DOUBLE PRECISION DEFAULT NULL,
  flat_amount stripe_invoices.tax_rate_flat_amount DEFAULT NULL,
  jurisdiction TEXT DEFAULT NULL,
  jurisdiction_level TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  rate_type TEXT DEFAULT NULL,
  state TEXT DEFAULT NULL,
  tax_type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.tax_rate
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    active,
    created,
    display_name,
    inclusive,
    livemode,
    object,
    percentage,
    country,
    description,
    effective_percentage,
    flat_amount,
    jurisdiction,
    jurisdiction_level,
    metadata,
    rate_type,
    state,
    tax_type
  )::stripe_invoices.tax_rate;
$$;

ALTER TYPE stripe_invoices.tax_rate_flat_amount
  ADD ATTRIBUTE amount BIGINT, ADD ATTRIBUTE currency TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_tax_rate_flat_amount(
  amount BIGINT, currency TEXT
)
RETURNS stripe_invoices.tax_rate_flat_amount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(amount, currency)::stripe_invoices.tax_rate_flat_amount;
$$;

ALTER TYPE stripe_invoices.create_params_automatic_tax
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE liability stripe_invoices.create_params_automatic_tax_create_params_liability;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_automatic_tax(
  enabled BOOLEAN,
  liability stripe_invoices.create_params_automatic_tax_create_params_liability DEFAULT NULL
)
RETURNS stripe_invoices.create_params_automatic_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled, liability)::stripe_invoices.create_params_automatic_tax;
$$;

ALTER TYPE stripe_invoices.create_params_automatic_tax_create_params_liability
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_automatic_tax_create_params_liability(
  type TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_invoices.create_params_automatic_tax_create_params_liability
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, account
  )::stripe_invoices.create_params_automatic_tax_create_params_liability;
$$;

ALTER TYPE stripe_invoices.create_params_from_invoice
  ADD ATTRIBUTE action TEXT, ADD ATTRIBUTE invoice TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_from_invoice(
  action TEXT, invoice TEXT
)
RETURNS stripe_invoices.create_params_from_invoice
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(action, invoice)::stripe_invoices.create_params_from_invoice;
$$;

ALTER TYPE stripe_invoices.create_params_issuer
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_issuer(
  type TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_invoices.create_params_issuer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(type, account)::stripe_invoices.create_params_issuer;
$$;

ALTER TYPE stripe_invoices.create_params_payment_setting
  ADD ATTRIBUTE default_mandate TEXT,
  ADD ATTRIBUTE payment_method_options stripe_invoices.crate_prams_payment_setting_create_params_payment_method_option,
  ADD ATTRIBUTE payment_method_types JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_payment_setting(
  default_mandate TEXT DEFAULT NULL,
  payment_method_options stripe_invoices.crate_prams_payment_setting_create_params_payment_method_option DEFAULT NULL,
  payment_method_types JSONB DEFAULT NULL
)
RETURNS stripe_invoices.create_params_payment_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_mandate, payment_method_options, payment_method_types
  )::stripe_invoices.create_params_payment_setting;
$$;

ALTER TYPE stripe_invoices.crate_prams_payment_setting_create_params_payment_method_option
  ADD ATTRIBUTE acss_debit JSONB,
  ADD ATTRIBUTE bancontact JSONB,
  ADD ATTRIBUTE card JSONB,
  ADD ATTRIBUTE customer_balance JSONB,
  ADD ATTRIBUTE konbini JSONB,
  ADD ATTRIBUTE payto JSONB,
  ADD ATTRIBUTE sepa_debit JSONB,
  ADD ATTRIBUTE us_bank_account JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_crate_prams_pyment_stting_crate_prams_payment_method_option(
  acss_debit JSONB DEFAULT NULL,
  bancontact JSONB DEFAULT NULL,
  card JSONB DEFAULT NULL,
  customer_balance JSONB DEFAULT NULL,
  konbini JSONB DEFAULT NULL,
  payto JSONB DEFAULT NULL,
  sepa_debit JSONB DEFAULT NULL,
  us_bank_account JSONB DEFAULT NULL
)
RETURNS stripe_invoices.crate_prams_payment_setting_create_params_payment_method_option
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
  )::stripe_invoices.crate_prams_payment_setting_create_params_payment_method_option;
$$;

ALTER TYPE stripe_invoices.create_params_rendering
  ADD ATTRIBUTE amount_tax_display TEXT,
  ADD ATTRIBUTE pdf stripe_invoices.create_params_rendering_create_params_pdf,
  ADD ATTRIBUTE template TEXT,
  ADD ATTRIBUTE template_version JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_rendering(
  amount_tax_display TEXT DEFAULT NULL,
  pdf stripe_invoices.create_params_rendering_create_params_pdf DEFAULT NULL,
  template TEXT DEFAULT NULL,
  template_version JSONB DEFAULT NULL
)
RETURNS stripe_invoices.create_params_rendering
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_tax_display, pdf, template, template_version
  )::stripe_invoices.create_params_rendering;
$$;

ALTER TYPE stripe_invoices.create_params_rendering_create_params_pdf
  ADD ATTRIBUTE page_size TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_rendering_create_params_pdf(
  page_size TEXT DEFAULT NULL
)
RETURNS stripe_invoices.create_params_rendering_create_params_pdf
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    page_size
  )::stripe_invoices.create_params_rendering_create_params_pdf;
$$;

ALTER TYPE stripe_invoices.create_params_shipping_cost
  ADD ATTRIBUTE shipping_rate TEXT,
  ADD ATTRIBUTE shipping_rate_data stripe_invoices.create_params_shipping_cost_create_params_shipping_rate_data;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_shipping_cost(
  shipping_rate TEXT DEFAULT NULL,
  shipping_rate_data stripe_invoices.create_params_shipping_cost_create_params_shipping_rate_data DEFAULT NULL
)
RETURNS stripe_invoices.create_params_shipping_cost
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    shipping_rate, shipping_rate_data
  )::stripe_invoices.create_params_shipping_cost;
$$;

ALTER TYPE stripe_invoices.create_params_shipping_cost_create_params_shipping_rate_data
  ADD ATTRIBUTE display_name TEXT,
  ADD ATTRIBUTE delivery_estimate stripe_invoices.c_p_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_dlvry_estmte,
  ADD ATTRIBUTE fixed_amount stripe_invoices.c_prms_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_fxd_amnt,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE tax_code TEXT,
  ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.mke_crate_params_shipping_cost_create_params_shipping_rate_data(
  display_name TEXT,
  delivery_estimate stripe_invoices.c_p_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_dlvry_estmte DEFAULT NULL,
  fixed_amount stripe_invoices.c_prms_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_fxd_amnt DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  type TEXT DEFAULT NULL
)
RETURNS stripe_invoices.create_params_shipping_cost_create_params_shipping_rate_data
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
    type
  )::stripe_invoices.create_params_shipping_cost_create_params_shipping_rate_data;
$$;

ALTER TYPE stripe_invoices.c_p_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_dlvry_estmte
  ADD ATTRIBUTE maximum stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mxmm,
  ADD ATTRIBUTE minimum stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mnmm;

CREATE OR REPLACE FUNCTION stripe_invoices.m_c_p_s_cst_crte_prms_shppng_rte_dta_crte_prms_dlvry_estmte(
  maximum stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mxmm DEFAULT NULL,
  minimum stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mnmm DEFAULT NULL
)
RETURNS stripe_invoices.c_p_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_dlvry_estmte
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    maximum, minimum
  )::stripe_invoices.c_p_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_dlvry_estmte;
$$;

ALTER TYPE stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mxmm
  ADD ATTRIBUTE unit TEXT, ADD ATTRIBUTE value BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mxmm(
  unit TEXT, value BIGINT
)
RETURNS stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mxmm
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    unit, value
  )::stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mxmm;
$$;

ALTER TYPE stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mnmm
  ADD ATTRIBUTE unit TEXT, ADD ATTRIBUTE value BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.m_c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mnmm(
  unit TEXT, value BIGINT
)
RETURNS stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mnmm
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    unit, value
  )::stripe_invoices.c_p_s_c_c_p_s_rte_dta_crte_prms_dlvry_estmte_crte_prms_mnmm;
$$;

ALTER TYPE stripe_invoices.c_prms_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_fxd_amnt
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE currency_options JSONB;

CREATE OR REPLACE FUNCTION stripe_invoices.m_c_prms_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_fxd_amnt(
  amount BIGINT, currency TEXT, currency_options JSONB DEFAULT NULL
)
RETURNS stripe_invoices.c_prms_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_fxd_amnt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, currency, currency_options
  )::stripe_invoices.c_prms_shppng_cst_crte_prms_shppng_rte_dta_crte_prms_fxd_amnt;
$$;

ALTER TYPE stripe_invoices.create_params_shipping_detail
  ADD ATTRIBUTE address stripe_invoices.create_params_shipping_detail_create_params_address,
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE phone TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_shipping_detail(
  address stripe_invoices.create_params_shipping_detail_create_params_address,
  name TEXT,
  phone TEXT DEFAULT NULL
)
RETURNS stripe_invoices.create_params_shipping_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, name, phone
  )::stripe_invoices.create_params_shipping_detail;
$$;

ALTER TYPE stripe_invoices.create_params_shipping_detail_create_params_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE state TEXT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_shipping_detail_create_params_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  state TEXT DEFAULT NULL
)
RETURNS stripe_invoices.create_params_shipping_detail_create_params_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, state
  )::stripe_invoices.create_params_shipping_detail_create_params_address;
$$;

ALTER TYPE stripe_invoices.create_params_transfer_data
  ADD ATTRIBUTE destination TEXT, ADD ATTRIBUTE amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_invoices.make_create_params_transfer_data(
  destination TEXT, amount BIGINT DEFAULT NULL
)
RETURNS stripe_invoices.create_params_transfer_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(destination, amount)::stripe_invoices.create_params_transfer_data;
$$;

CREATE OR REPLACE FUNCTION stripe_invoices._create(
  account_tax_ids JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  auto_advance BOOLEAN DEFAULT NULL,
  automatic_tax stripe_invoices.create_params_automatic_tax DEFAULT NULL,
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
  from_invoice stripe_invoices.create_params_from_invoice DEFAULT NULL,
  issuer stripe_invoices.create_params_issuer DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  number TEXT DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  payment_settings stripe_invoices.create_params_payment_setting DEFAULT NULL,
  pending_invoice_items_behavior TEXT DEFAULT NULL,
  rendering stripe_invoices.create_params_rendering DEFAULT NULL,
  shipping_cost stripe_invoices.create_params_shipping_cost DEFAULT NULL,
  shipping_details stripe_invoices.create_params_shipping_detail DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  subscription TEXT DEFAULT NULL,
  transfer_data stripe_invoices.create_params_transfer_data DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stainless_commons_stripe._types import not_given

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

CREATE OR REPLACE FUNCTION stripe_invoices.create(
  account_tax_ids JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  auto_advance BOOLEAN DEFAULT NULL,
  automatic_tax stripe_invoices.create_params_automatic_tax DEFAULT NULL,
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
  from_invoice stripe_invoices.create_params_from_invoice DEFAULT NULL,
  issuer stripe_invoices.create_params_issuer DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  number TEXT DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  payment_settings stripe_invoices.create_params_payment_setting DEFAULT NULL,
  pending_invoice_items_behavior TEXT DEFAULT NULL,
  rendering stripe_invoices.create_params_rendering DEFAULT NULL,
  shipping_cost stripe_invoices.create_params_shipping_cost DEFAULT NULL,
  shipping_details stripe_invoices.create_params_shipping_detail DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  subscription TEXT DEFAULT NULL,
  transfer_data stripe_invoices.create_params_transfer_data DEFAULT NULL
)
RETURNS stripe_invoices.invoice
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_invoices.invoice,
      stripe_invoices._create(
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
        number,
        on_behalf_of,
        payment_settings,
        pending_invoice_items_behavior,
        rendering,
        shipping_cost,
        shipping_details,
        statement_descriptor,
        subscription,
        transfer_data
      )
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_invoices._list_first_page_py(
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
  subscription TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe._types import not_given
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

-- A simpler wrapper around `stripe_invoices._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_invoices._list_first_page(
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
  subscription TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN stripe_invoices._list_first_page_py(
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
      subscription
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_invoices._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe.types import Invoice
  from stainless_commons_stripe.pagination import SyncMyCursorIDPage
  from stainless_commons_stripe._models import FinalRequestOptions
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

CREATE OR REPLACE FUNCTION stripe_invoices.list(
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
  subscription TEXT DEFAULT NULL
)
RETURNS SETOF stripe_invoices.invoice
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_invoices._list_first_page(
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
      subscription
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_invoices._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_invoices.invoice, data)).* FROM paginated;
$$;

CREATE OR REPLACE FUNCTION stripe_invoices._finalize(
  invoice TEXT, auto_advance BOOLEAN DEFAULT NULL, expand TEXT[] DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  from stainless_commons_stripe._types import not_given

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

CREATE OR REPLACE FUNCTION stripe_invoices.finalize(
  invoice TEXT, auto_advance BOOLEAN DEFAULT NULL, expand TEXT[] DEFAULT NULL
)
RETURNS stripe_invoices.invoice
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_invoices.invoice,
      stripe_invoices._finalize(invoice, auto_advance, expand)
    );
  END;
$$;