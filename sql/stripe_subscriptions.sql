ALTER TYPE stripe_subscriptions.automatic_tax_subscription
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE disabled_reason TEXT,
  ADD ATTRIBUTE liability JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_automatic_tax_subscription(
  enabled BOOLEAN,
  disabled_reason TEXT DEFAULT NULL,
  liability JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.automatic_tax_subscription
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, disabled_reason, liability
  )::stripe_subscriptions.automatic_tax_subscription;
$$;

ALTER TYPE stripe_subscriptions.default_settings
  ADD ATTRIBUTE billing_cycle_anchor TEXT,
  ADD ATTRIBUTE invoice_settings JSONB,
  ADD ATTRIBUTE application_fee_percent DOUBLE PRECISION,
  ADD ATTRIBUTE automatic_tax JSONB,
  ADD ATTRIBUTE billing_thresholds stripe_subscriptions.subscription_billing_thresholds,
  ADD ATTRIBUTE collection_method TEXT,
  ADD ATTRIBUTE default_payment_method JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE transfer_data JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_default_settings(
  billing_cycle_anchor TEXT,
  invoice_settings JSONB,
  application_fee_percent DOUBLE PRECISION DEFAULT NULL,
  automatic_tax JSONB DEFAULT NULL,
  billing_thresholds stripe_subscriptions.subscription_billing_thresholds DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  default_payment_method JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  transfer_data JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.default_settings
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_cycle_anchor,
    invoice_settings,
    application_fee_percent,
    automatic_tax,
    billing_thresholds,
    collection_method,
    default_payment_method,
    description,
    on_behalf_of,
    transfer_data
  )::stripe_subscriptions.default_settings;
$$;

ALTER TYPE stripe_subscriptions.default_settings_automatic_tax
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE disabled_reason TEXT,
  ADD ATTRIBUTE liability JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_default_settings_automatic_tax(
  enabled BOOLEAN,
  disabled_reason TEXT DEFAULT NULL,
  liability JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.default_settings_automatic_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, disabled_reason, liability
  )::stripe_subscriptions.default_settings_automatic_tax;
$$;

ALTER TYPE stripe_subscriptions.mandate
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE customer_acceptance stripe_subscriptions.mandate_customer_acceptance,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE payment_method JSONB,
  ADD ATTRIBUTE payment_method_details stripe_subscriptions.mandate_payment_method_detail,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE multi_use stripe_subscriptions.mandate_multi_use,
  ADD ATTRIBUTE on_behalf_of TEXT,
  ADD ATTRIBUTE single_use stripe_subscriptions.mandate_single_use;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate(
  "id" TEXT,
  customer_acceptance stripe_subscriptions.mandate_customer_acceptance,
  livemode BOOLEAN,
  "object" TEXT,
  payment_method JSONB,
  payment_method_details stripe_subscriptions.mandate_payment_method_detail,
  status TEXT,
  "type" TEXT,
  multi_use stripe_subscriptions.mandate_multi_use DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  single_use stripe_subscriptions.mandate_single_use DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    customer_acceptance,
    livemode,
    "object",
    payment_method,
    payment_method_details,
    status,
    "type",
    multi_use,
    on_behalf_of,
    single_use
  )::stripe_subscriptions.mandate;
$$;

ALTER TYPE stripe_subscriptions.mandate_customer_acceptance
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE accepted_at BIGINT,
  ADD ATTRIBUTE offline stripe_subscriptions.mandate_customer_acceptance_offline,
  ADD ATTRIBUTE online stripe_subscriptions.mandate_customer_acceptance_online;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_customer_acceptance(
  "type" TEXT,
  accepted_at BIGINT DEFAULT NULL,
  offline stripe_subscriptions.mandate_customer_acceptance_offline DEFAULT NULL,
  online stripe_subscriptions.mandate_customer_acceptance_online DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_customer_acceptance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", accepted_at, offline, online
  )::stripe_subscriptions.mandate_customer_acceptance;
$$;

ALTER TYPE stripe_subscriptions.mandate_customer_acceptance_online
  ADD ATTRIBUTE ip_address TEXT, ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_customer_acceptance_online(
  ip_address TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_customer_acceptance_online
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    ip_address, user_agent
  )::stripe_subscriptions.mandate_customer_acceptance_online;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE acss_debit stripe_subscriptions.mandate_payment_method_detail_acss_debit,
  ADD ATTRIBUTE amazon_pay stripe_subscriptions.mandate_payment_method_detail_amazon_pay,
  ADD ATTRIBUTE au_becs_debit stripe_subscriptions.mandate_payment_method_detail_au_becs_debit,
  ADD ATTRIBUTE bacs_debit stripe_subscriptions.mandate_payment_method_detail_bacs_debit,
  ADD ATTRIBUTE card stripe_subscriptions.mandate_payment_method_detail_card,
  ADD ATTRIBUTE cashapp stripe_subscriptions.mandate_payment_method_detail_cashapp,
  ADD ATTRIBUTE kakao_pay stripe_subscriptions.mandate_payment_method_detail_kakao_pay,
  ADD ATTRIBUTE klarna stripe_subscriptions.mandate_payment_method_detail_klarna,
  ADD ATTRIBUTE kr_card stripe_subscriptions.mandate_payment_method_detail_kr_card,
  ADD ATTRIBUTE "link" stripe_subscriptions.mandate_payment_method_detail_link,
  ADD ATTRIBUTE naver_pay stripe_subscriptions.mandate_payment_method_detail_naver_pay,
  ADD ATTRIBUTE nz_bank_account stripe_subscriptions.mandate_payment_method_detail_nz_bank_account,
  ADD ATTRIBUTE paypal stripe_subscriptions.mandate_payment_method_detail_paypal,
  ADD ATTRIBUTE payto stripe_subscriptions.mandate_payment_method_detail_payto,
  ADD ATTRIBUTE revolut_pay stripe_subscriptions.mandate_payment_method_detail_revolut_pay,
  ADD ATTRIBUTE sepa_debit stripe_subscriptions.mandate_payment_method_detail_sepa_debit,
  ADD ATTRIBUTE us_bank_account stripe_subscriptions.mandate_payment_method_detail_us_bank_account;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail(
  "type" TEXT,
  acss_debit stripe_subscriptions.mandate_payment_method_detail_acss_debit DEFAULT NULL,
  amazon_pay stripe_subscriptions.mandate_payment_method_detail_amazon_pay DEFAULT NULL,
  au_becs_debit stripe_subscriptions.mandate_payment_method_detail_au_becs_debit DEFAULT NULL,
  bacs_debit stripe_subscriptions.mandate_payment_method_detail_bacs_debit DEFAULT NULL,
  card stripe_subscriptions.mandate_payment_method_detail_card DEFAULT NULL,
  cashapp stripe_subscriptions.mandate_payment_method_detail_cashapp DEFAULT NULL,
  kakao_pay stripe_subscriptions.mandate_payment_method_detail_kakao_pay DEFAULT NULL,
  klarna stripe_subscriptions.mandate_payment_method_detail_klarna DEFAULT NULL,
  kr_card stripe_subscriptions.mandate_payment_method_detail_kr_card DEFAULT NULL,
  "link" stripe_subscriptions.mandate_payment_method_detail_link DEFAULT NULL,
  naver_pay stripe_subscriptions.mandate_payment_method_detail_naver_pay DEFAULT NULL,
  nz_bank_account stripe_subscriptions.mandate_payment_method_detail_nz_bank_account DEFAULT NULL,
  paypal stripe_subscriptions.mandate_payment_method_detail_paypal DEFAULT NULL,
  payto stripe_subscriptions.mandate_payment_method_detail_payto DEFAULT NULL,
  revolut_pay stripe_subscriptions.mandate_payment_method_detail_revolut_pay DEFAULT NULL,
  sepa_debit stripe_subscriptions.mandate_payment_method_detail_sepa_debit DEFAULT NULL,
  us_bank_account stripe_subscriptions.mandate_payment_method_detail_us_bank_account DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_payment_method_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    acss_debit,
    amazon_pay,
    au_becs_debit,
    bacs_debit,
    card,
    cashapp,
    kakao_pay,
    klarna,
    kr_card,
    "link",
    naver_pay,
    nz_bank_account,
    paypal,
    payto,
    revolut_pay,
    sepa_debit,
    us_bank_account
  )::stripe_subscriptions.mandate_payment_method_detail;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail_acss_debit
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE transaction_type TEXT,
  ADD ATTRIBUTE default_for TEXT[],
  ADD ATTRIBUTE interval_description TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail_acss_debit(
  payment_schedule TEXT,
  transaction_type TEXT,
  default_for TEXT[] DEFAULT NULL,
  interval_description TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_payment_method_detail_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_schedule, transaction_type, default_for, interval_description
  )::stripe_subscriptions.mandate_payment_method_detail_acss_debit;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail_au_becs_debit
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail_au_becs_debit(
  url TEXT
)
RETURNS stripe_subscriptions.mandate_payment_method_detail_au_becs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    url
  )::stripe_subscriptions.mandate_payment_method_detail_au_becs_debit;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail_bacs_debit
  ADD ATTRIBUTE network_status TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE url TEXT,
  ADD ATTRIBUTE revocation_reason TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail_bacs_debit(
  network_status TEXT,
  reference TEXT,
  url TEXT,
  revocation_reason TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_payment_method_detail_bacs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    network_status, reference, url, revocation_reason
  )::stripe_subscriptions.mandate_payment_method_detail_bacs_debit;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail_paypal
  ADD ATTRIBUTE billing_agreement_id TEXT, ADD ATTRIBUTE payer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail_paypal(
  billing_agreement_id TEXT DEFAULT NULL, payer_id TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_payment_method_detail_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_agreement_id, payer_id
  )::stripe_subscriptions.mandate_payment_method_detail_paypal;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail_payto
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT,
  ADD ATTRIBUTE start_date TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail_payto(
  amount_type TEXT,
  payment_schedule TEXT,
  amount BIGINT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL,
  start_date TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_payment_method_detail_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_type,
    payment_schedule,
    amount,
    end_date,
    payments_per_period,
    purpose,
    start_date
  )::stripe_subscriptions.mandate_payment_method_detail_payto;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail_sepa_debit
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail_sepa_debit(
  reference TEXT, url TEXT
)
RETURNS stripe_subscriptions.mandate_payment_method_detail_sepa_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, url
  )::stripe_subscriptions.mandate_payment_method_detail_sepa_debit;
$$;

ALTER TYPE stripe_subscriptions.mandate_payment_method_detail_us_bank_account
  ADD ATTRIBUTE collection_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_payment_method_detail_us_bank_account(
  collection_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.mandate_payment_method_detail_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    collection_method
  )::stripe_subscriptions.mandate_payment_method_detail_us_bank_account;
$$;

ALTER TYPE stripe_subscriptions.mandate_single_use
  ADD ATTRIBUTE amount BIGINT, ADD ATTRIBUTE currency TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_mandate_single_use(
  amount BIGINT, currency TEXT
)
RETURNS stripe_subscriptions.mandate_single_use
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(amount, currency)::stripe_subscriptions.mandate_single_use;
$$;

ALTER TYPE stripe_subscriptions.payment_method_details_bancontact_setup_attempt
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE generated_sepa_debit JSONB,
  ADD ATTRIBUTE generated_sepa_debit_mandate JSONB,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_payment_method_details_bancontact_setup_attempt(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  generated_sepa_debit JSONB DEFAULT NULL,
  generated_sepa_debit_mandate JSONB DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  preferred_language TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.payment_method_details_bancontact_setup_attempt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    bank_name,
    bic,
    generated_sepa_debit,
    generated_sepa_debit_mandate,
    iban_last4,
    preferred_language,
    verified_name
  )::stripe_subscriptions.payment_method_details_bancontact_setup_attempt;
$$;

ALTER TYPE stripe_subscriptions.payment_method_details_ideal_setup_attempt
  ADD ATTRIBUTE bank TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE generated_sepa_debit JSONB,
  ADD ATTRIBUTE generated_sepa_debit_mandate JSONB,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_payment_method_details_ideal_setup_attempt(
  bank TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  generated_sepa_debit JSONB DEFAULT NULL,
  generated_sepa_debit_mandate JSONB DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.payment_method_details_ideal_setup_attempt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank,
    bic,
    generated_sepa_debit,
    generated_sepa_debit_mandate,
    iban_last4,
    verified_name
  )::stripe_subscriptions.payment_method_details_ideal_setup_attempt;
$$;

ALTER TYPE stripe_subscriptions.payment_method_details_sofort_setup_attempt
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE generated_sepa_debit JSONB,
  ADD ATTRIBUTE generated_sepa_debit_mandate JSONB,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_payment_method_details_sofort_setup_attempt(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  generated_sepa_debit JSONB DEFAULT NULL,
  generated_sepa_debit_mandate JSONB DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  preferred_language TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.payment_method_details_sofort_setup_attempt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    bank_name,
    bic,
    generated_sepa_debit,
    generated_sepa_debit_mandate,
    iban_last4,
    preferred_language,
    verified_name
  )::stripe_subscriptions.payment_method_details_sofort_setup_attempt;
$$;

ALTER TYPE stripe_subscriptions.pending_update
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE billing_cycle_anchor BIGINT,
  ADD ATTRIBUTE subscription_items JSONB[],
  ADD ATTRIBUTE trial_end BIGINT,
  ADD ATTRIBUTE trial_from_plan BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_pending_update(
  expires_at BIGINT,
  billing_cycle_anchor BIGINT DEFAULT NULL,
  subscription_items JSONB[] DEFAULT NULL,
  trial_end BIGINT DEFAULT NULL,
  trial_from_plan BOOLEAN DEFAULT NULL
)
RETURNS stripe_subscriptions.pending_update
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_at,
    billing_cycle_anchor,
    subscription_items,
    trial_end,
    trial_from_plan
  )::stripe_subscriptions.pending_update;
$$;

ALTER TYPE stripe_subscriptions.phase_automatic_tax
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE disabled_reason TEXT,
  ADD ATTRIBUTE liability JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_phase_automatic_tax(
  enabled BOOLEAN,
  disabled_reason TEXT DEFAULT NULL,
  liability JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.phase_automatic_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, disabled_reason, liability
  )::stripe_subscriptions.phase_automatic_tax;
$$;

ALTER TYPE stripe_subscriptions.schedule
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE billing_mode stripe_subscriptions.schedule_billing_mode,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE default_settings JSONB,
  ADD ATTRIBUTE end_behavior TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE phases JSONB[],
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE canceled_at BIGINT,
  ADD ATTRIBUTE completed_at BIGINT,
  ADD ATTRIBUTE current_phase stripe_subscriptions.schedule_current_phase,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE released_at BIGINT,
  ADD ATTRIBUTE released_subscription TEXT,
  ADD ATTRIBUTE "subscription" JSONB,
  ADD ATTRIBUTE test_clock JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule(
  "id" TEXT,
  billing_mode stripe_subscriptions.schedule_billing_mode,
  created BIGINT,
  customer JSONB,
  default_settings JSONB,
  end_behavior TEXT,
  livemode BOOLEAN,
  "object" TEXT,
  phases JSONB[],
  status TEXT,
  application JSONB DEFAULT NULL,
  canceled_at BIGINT DEFAULT NULL,
  completed_at BIGINT DEFAULT NULL,
  current_phase stripe_subscriptions.schedule_current_phase DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  released_at BIGINT DEFAULT NULL,
  released_subscription TEXT DEFAULT NULL,
  "subscription" JSONB DEFAULT NULL,
  test_clock JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    billing_mode,
    created,
    customer,
    default_settings,
    end_behavior,
    livemode,
    "object",
    phases,
    status,
    application,
    canceled_at,
    completed_at,
    current_phase,
    customer_account,
    metadata,
    released_at,
    released_subscription,
    "subscription",
    test_clock
  )::stripe_subscriptions.schedule;
$$;

ALTER TYPE stripe_subscriptions.schedule_billing_mode
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE flexible stripe_subscriptions.schedule_billing_mode_flexible,
  ADD ATTRIBUTE updated_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_billing_mode(
  "type" TEXT,
  flexible stripe_subscriptions.schedule_billing_mode_flexible DEFAULT NULL,
  updated_at BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_billing_mode
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", flexible, updated_at
  )::stripe_subscriptions.schedule_billing_mode;
$$;

ALTER TYPE stripe_subscriptions.schedule_billing_mode_flexible
  ADD ATTRIBUTE proration_discounts TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_billing_mode_flexible(
  proration_discounts TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_billing_mode_flexible
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    proration_discounts
  )::stripe_subscriptions.schedule_billing_mode_flexible;
$$;

ALTER TYPE stripe_subscriptions.schedule_current_phase
  ADD ATTRIBUTE end_date BIGINT, ADD ATTRIBUTE start_date BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_current_phase(
  end_date BIGINT, start_date BIGINT
)
RETURNS stripe_subscriptions.schedule_current_phase
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(end_date, start_date)::stripe_subscriptions.schedule_current_phase;
$$;

ALTER TYPE stripe_subscriptions.schedule_add_invoice_item
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE "period" stripe_subscriptions.schedule_add_invoice_item_period,
  ADD ATTRIBUTE price JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE tax_rates stripe_invoices.tax_rate[];

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_add_invoice_item(
  discounts JSONB[],
  "period" stripe_subscriptions.schedule_add_invoice_item_period,
  price JSONB,
  metadata JSONB DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  tax_rates stripe_invoices.tax_rate[] DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_add_invoice_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    discounts, "period", price, metadata, quantity, tax_rates
  )::stripe_subscriptions.schedule_add_invoice_item;
$$;

ALTER TYPE stripe_subscriptions.schedule_add_invoice_item_period
  ADD ATTRIBUTE "end" stripe_subscriptions.schedule_add_invoice_item_period_end,
  ADD ATTRIBUTE "start" stripe_subscriptions.schedule_add_invoice_item_period_start;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_add_invoice_item_period(
  "end" stripe_subscriptions.schedule_add_invoice_item_period_end,
  "start" stripe_subscriptions.schedule_add_invoice_item_period_start
)
RETURNS stripe_subscriptions.schedule_add_invoice_item_period
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "end", "start"
  )::stripe_subscriptions.schedule_add_invoice_item_period;
$$;

ALTER TYPE stripe_subscriptions.schedule_add_invoice_item_period_end
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE "timestamp" BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_add_invoice_item_period_end(
  "type" TEXT, "timestamp" BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_add_invoice_item_period_end
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", "timestamp"
  )::stripe_subscriptions.schedule_add_invoice_item_period_end;
$$;

ALTER TYPE stripe_subscriptions.schedule_add_invoice_item_period_start
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE "timestamp" BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_add_invoice_item_period_start(
  "type" TEXT, "timestamp" BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_add_invoice_item_period_start
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", "timestamp"
  )::stripe_subscriptions.schedule_add_invoice_item_period_start;
$$;

ALTER TYPE stripe_subscriptions.schedule_configuration_item
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE price JSONB,
  ADD ATTRIBUTE billing_thresholds stripe_subscriptions.schedule_configuration_item_billing_threshold,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE tax_rates stripe_invoices.tax_rate[];

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_configuration_item(
  discounts JSONB[],
  price JSONB,
  billing_thresholds stripe_subscriptions.schedule_configuration_item_billing_threshold DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  tax_rates stripe_invoices.tax_rate[] DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_configuration_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    discounts, price, billing_thresholds, metadata, quantity, tax_rates
  )::stripe_subscriptions.schedule_configuration_item;
$$;

ALTER TYPE stripe_subscriptions.schedule_configuration_item_billing_threshold
  ADD ATTRIBUTE usage_gte BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_configuration_item_billing_threshold(
  usage_gte BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_configuration_item_billing_threshold
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    usage_gte
  )::stripe_subscriptions.schedule_configuration_item_billing_threshold;
$$;

ALTER TYPE stripe_subscriptions.schedule_phase_configuration
  ADD ATTRIBUTE add_invoice_items JSONB[],
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE end_date BIGINT,
  ADD ATTRIBUTE items JSONB[],
  ADD ATTRIBUTE proration_behavior TEXT,
  ADD ATTRIBUTE start_date BIGINT,
  ADD ATTRIBUTE application_fee_percent DOUBLE PRECISION,
  ADD ATTRIBUTE automatic_tax JSONB,
  ADD ATTRIBUTE billing_cycle_anchor TEXT,
  ADD ATTRIBUTE billing_thresholds stripe_subscriptions.subscription_billing_thresholds,
  ADD ATTRIBUTE collection_method TEXT,
  ADD ATTRIBUTE default_payment_method JSONB,
  ADD ATTRIBUTE default_tax_rates stripe_invoices.tax_rate[],
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE invoice_settings JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE transfer_data JSONB,
  ADD ATTRIBUTE trial_end BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_phase_configuration(
  add_invoice_items JSONB[],
  currency TEXT,
  discounts JSONB[],
  end_date BIGINT,
  items JSONB[],
  proration_behavior TEXT,
  start_date BIGINT,
  application_fee_percent DOUBLE PRECISION DEFAULT NULL,
  automatic_tax JSONB DEFAULT NULL,
  billing_cycle_anchor TEXT DEFAULT NULL,
  billing_thresholds stripe_subscriptions.subscription_billing_thresholds DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  default_payment_method JSONB DEFAULT NULL,
  default_tax_rates stripe_invoices.tax_rate[] DEFAULT NULL,
  description TEXT DEFAULT NULL,
  invoice_settings JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  transfer_data JSONB DEFAULT NULL,
  trial_end BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_phase_configuration
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    add_invoice_items,
    currency,
    discounts,
    end_date,
    items,
    proration_behavior,
    start_date,
    application_fee_percent,
    automatic_tax,
    billing_cycle_anchor,
    billing_thresholds,
    collection_method,
    default_payment_method,
    default_tax_rates,
    description,
    invoice_settings,
    metadata,
    on_behalf_of,
    transfer_data,
    trial_end
  )::stripe_subscriptions.schedule_phase_configuration;
$$;

ALTER TYPE stripe_subscriptions.schedule_phase_setting
  ADD ATTRIBUTE account_tax_ids JSONB[],
  ADD ATTRIBUTE days_until_due BIGINT,
  ADD ATTRIBUTE issuer JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_phase_setting(
  account_tax_ids JSONB[] DEFAULT NULL,
  days_until_due BIGINT DEFAULT NULL,
  issuer JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_phase_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_tax_ids, days_until_due, issuer
  )::stripe_subscriptions.schedule_phase_setting;
$$;

ALTER TYPE stripe_subscriptions.schedule_setting
  ADD ATTRIBUTE issuer JSONB,
  ADD ATTRIBUTE account_tax_ids JSONB[],
  ADD ATTRIBUTE days_until_due BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_schedule_setting(
  issuer JSONB,
  account_tax_ids JSONB[] DEFAULT NULL,
  days_until_due BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.schedule_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    issuer, account_tax_ids, days_until_due
  )::stripe_subscriptions.schedule_setting;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE payment_method JSONB,
  ADD ATTRIBUTE payment_method_details JSONB,
  ADD ATTRIBUTE setup_intent JSONB,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "usage" TEXT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE attach_to_self BOOLEAN,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE flow_directions TEXT[],
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE setup_error JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt(
  "id" TEXT,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  payment_method JSONB,
  payment_method_details JSONB,
  setup_intent JSONB,
  status TEXT,
  "usage" TEXT,
  application JSONB DEFAULT NULL,
  attach_to_self BOOLEAN DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  flow_directions TEXT[] DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  setup_error JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    livemode,
    "object",
    payment_method,
    payment_method_details,
    setup_intent,
    status,
    "usage",
    application,
    attach_to_self,
    customer,
    customer_account,
    flow_directions,
    on_behalf_of,
    setup_error
  )::stripe_subscriptions.setup_attempt;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt_payment_method_details
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE acss_debit stripe_subscriptions.setup_attempt_payment_method_details_acss_debit,
  ADD ATTRIBUTE amazon_pay stripe_subscriptions.setup_attempt_payment_method_details_amazon_pay,
  ADD ATTRIBUTE au_becs_debit stripe_subscriptions.setup_attempt_payment_method_details_au_becs_debit,
  ADD ATTRIBUTE bacs_debit stripe_subscriptions.setup_attempt_payment_method_details_bacs_debit,
  ADD ATTRIBUTE bancontact JSONB,
  ADD ATTRIBUTE boleto stripe_subscriptions.setup_attempt_payment_method_details_boleto,
  ADD ATTRIBUTE card stripe_subscriptions.setup_attempt_payment_method_details_card,
  ADD ATTRIBUTE card_present JSONB,
  ADD ATTRIBUTE cashapp stripe_subscriptions.setup_attempt_payment_method_details_cashapp,
  ADD ATTRIBUTE ideal JSONB,
  ADD ATTRIBUTE kakao_pay stripe_subscriptions.setup_attempt_payment_method_details_kakao_pay,
  ADD ATTRIBUTE klarna stripe_subscriptions.setup_attempt_payment_method_details_klarna,
  ADD ATTRIBUTE kr_card stripe_subscriptions.setup_attempt_payment_method_details_kr_card,
  ADD ATTRIBUTE "link" stripe_subscriptions.setup_attempt_payment_method_details_link,
  ADD ATTRIBUTE naver_pay stripe_subscriptions.setup_attempt_payment_method_details_naver_pay,
  ADD ATTRIBUTE nz_bank_account stripe_subscriptions.setup_attempt_payment_method_details_nz_bank_account,
  ADD ATTRIBUTE paypal stripe_subscriptions.setup_attempt_payment_method_details_paypal,
  ADD ATTRIBUTE payto stripe_subscriptions.setup_attempt_payment_method_details_payto,
  ADD ATTRIBUTE revolut_pay stripe_subscriptions.setup_attempt_payment_method_details_revolut_pay,
  ADD ATTRIBUTE sepa_debit stripe_subscriptions.setup_attempt_payment_method_details_sepa_debit,
  ADD ATTRIBUTE sofort JSONB,
  ADD ATTRIBUTE us_bank_account stripe_subscriptions.setup_attempt_payment_method_details_us_bank_account;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt_payment_method_details(
  "type" TEXT,
  acss_debit stripe_subscriptions.setup_attempt_payment_method_details_acss_debit DEFAULT NULL,
  amazon_pay stripe_subscriptions.setup_attempt_payment_method_details_amazon_pay DEFAULT NULL,
  au_becs_debit stripe_subscriptions.setup_attempt_payment_method_details_au_becs_debit DEFAULT NULL,
  bacs_debit stripe_subscriptions.setup_attempt_payment_method_details_bacs_debit DEFAULT NULL,
  bancontact JSONB DEFAULT NULL,
  boleto stripe_subscriptions.setup_attempt_payment_method_details_boleto DEFAULT NULL,
  card stripe_subscriptions.setup_attempt_payment_method_details_card DEFAULT NULL,
  card_present JSONB DEFAULT NULL,
  cashapp stripe_subscriptions.setup_attempt_payment_method_details_cashapp DEFAULT NULL,
  ideal JSONB DEFAULT NULL,
  kakao_pay stripe_subscriptions.setup_attempt_payment_method_details_kakao_pay DEFAULT NULL,
  klarna stripe_subscriptions.setup_attempt_payment_method_details_klarna DEFAULT NULL,
  kr_card stripe_subscriptions.setup_attempt_payment_method_details_kr_card DEFAULT NULL,
  "link" stripe_subscriptions.setup_attempt_payment_method_details_link DEFAULT NULL,
  naver_pay stripe_subscriptions.setup_attempt_payment_method_details_naver_pay DEFAULT NULL,
  nz_bank_account stripe_subscriptions.setup_attempt_payment_method_details_nz_bank_account DEFAULT NULL,
  paypal stripe_subscriptions.setup_attempt_payment_method_details_paypal DEFAULT NULL,
  payto stripe_subscriptions.setup_attempt_payment_method_details_payto DEFAULT NULL,
  revolut_pay stripe_subscriptions.setup_attempt_payment_method_details_revolut_pay DEFAULT NULL,
  sepa_debit stripe_subscriptions.setup_attempt_payment_method_details_sepa_debit DEFAULT NULL,
  sofort JSONB DEFAULT NULL,
  us_bank_account stripe_subscriptions.setup_attempt_payment_method_details_us_bank_account DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt_payment_method_details
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    acss_debit,
    amazon_pay,
    au_becs_debit,
    bacs_debit,
    bancontact,
    boleto,
    card,
    card_present,
    cashapp,
    ideal,
    kakao_pay,
    klarna,
    kr_card,
    "link",
    naver_pay,
    nz_bank_account,
    paypal,
    payto,
    revolut_pay,
    sepa_debit,
    sofort,
    us_bank_account
  )::stripe_subscriptions.setup_attempt_payment_method_details;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt_payment_method_details_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE checks stripe_subscriptions.setup_attempt_payment_method_details_card_check,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE three_d_secure stripe_subscriptions.setup_attempt_payment_method_details_card_three_d_secure,
  ADD ATTRIBUTE wallet stripe_subscriptions.setup_attempt_payment_method_details_card_wallet;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt_payment_method_details_card(
  brand TEXT DEFAULT NULL,
  checks stripe_subscriptions.setup_attempt_payment_method_details_card_check DEFAULT NULL,
  country TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  network TEXT DEFAULT NULL,
  three_d_secure stripe_subscriptions.setup_attempt_payment_method_details_card_three_d_secure DEFAULT NULL,
  wallet stripe_subscriptions.setup_attempt_payment_method_details_card_wallet DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt_payment_method_details_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand,
    checks,
    country,
    exp_month,
    exp_year,
    fingerprint,
    funding,
    last4,
    network,
    three_d_secure,
    wallet
  )::stripe_subscriptions.setup_attempt_payment_method_details_card;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_check
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_postal_code_check TEXT,
  ADD ATTRIBUTE cvc_check TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt_payment_method_details_card_check(
  address_line1_check TEXT DEFAULT NULL,
  address_postal_code_check TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt_payment_method_details_card_check
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check, address_postal_code_check, cvc_check
  )::stripe_subscriptions.setup_attempt_payment_method_details_card_check;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_three_d_secure
  ADD ATTRIBUTE authentication_flow TEXT,
  ADD ATTRIBUTE electronic_commerce_indicator TEXT,
  ADD ATTRIBUTE "result" TEXT,
  ADD ATTRIBUTE result_reason TEXT,
  ADD ATTRIBUTE transaction_id TEXT,
  ADD ATTRIBUTE "version" TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt_payment_method_details_card_three_d_secure(
  authentication_flow TEXT DEFAULT NULL,
  electronic_commerce_indicator TEXT DEFAULT NULL,
  "result" TEXT DEFAULT NULL,
  result_reason TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL,
  "version" TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt_payment_method_details_card_three_d_secure
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    authentication_flow,
    electronic_commerce_indicator,
    "result",
    result_reason,
    transaction_id,
    "version"
  )::stripe_subscriptions.setup_attempt_payment_method_details_card_three_d_secure;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_wallet
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE apple_pay stripe_subscriptions.setup_attempt_payment_method_details_card_wallet_apple_pay,
  ADD ATTRIBUTE google_pay stripe_subscriptions.setup_attempt_payment_method_details_card_wallet_google_pay;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt_payment_method_details_card_wallet(
  "type" TEXT,
  apple_pay stripe_subscriptions.setup_attempt_payment_method_details_card_wallet_apple_pay DEFAULT NULL,
  google_pay stripe_subscriptions.setup_attempt_payment_method_details_card_wallet_google_pay DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt_payment_method_details_card_wallet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", apple_pay, google_pay
  )::stripe_subscriptions.setup_attempt_payment_method_details_card_wallet;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt_payment_method_details_naver_pay
  ADD ATTRIBUTE buyer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt_payment_method_details_naver_pay(
  buyer_id TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt_payment_method_details_naver_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id
  )::stripe_subscriptions.setup_attempt_payment_method_details_naver_pay;
$$;

ALTER TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_present
  ADD ATTRIBUTE generated_card JSONB,
  ADD ATTRIBUTE offline stripe.payment_method_details_card_present_offline;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_attempt_payment_method_details_card_present(
  generated_card JSONB DEFAULT NULL,
  offline stripe.payment_method_details_card_present_offline DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_attempt_payment_method_details_card_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    generated_card, offline
  )::stripe_subscriptions.setup_attempt_payment_method_details_card_present;
$$;

ALTER TYPE stripe_subscriptions.setup_intent
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE payment_method_types TEXT[],
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "usage" TEXT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE attach_to_self BOOLEAN,
  ADD ATTRIBUTE automatic_payment_methods stripe_subscriptions.setup_intent_automatic_payment_method,
  ADD ATTRIBUTE cancellation_reason TEXT,
  ADD ATTRIBUTE client_secret TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE excluded_payment_method_types TEXT[],
  ADD ATTRIBUTE flow_directions TEXT[],
  ADD ATTRIBUTE last_setup_error JSONB,
  ADD ATTRIBUTE latest_attempt JSONB,
  ADD ATTRIBUTE mandate JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE next_action stripe_subscriptions.setup_intent_next_action,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE payment_method JSONB,
  ADD ATTRIBUTE payment_method_configuration_details stripe_subscriptions.setup_intent_payment_method_configuration_detail,
  ADD ATTRIBUTE payment_method_options stripe_subscriptions.setup_intent_payment_method_option,
  ADD ATTRIBUTE single_use_mandate JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent(
  "id" TEXT,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  payment_method_types TEXT[],
  status TEXT,
  "usage" TEXT,
  application JSONB DEFAULT NULL,
  attach_to_self BOOLEAN DEFAULT NULL,
  automatic_payment_methods stripe_subscriptions.setup_intent_automatic_payment_method DEFAULT NULL,
  cancellation_reason TEXT DEFAULT NULL,
  client_secret TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  excluded_payment_method_types TEXT[] DEFAULT NULL,
  flow_directions TEXT[] DEFAULT NULL,
  last_setup_error JSONB DEFAULT NULL,
  latest_attempt JSONB DEFAULT NULL,
  mandate JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  next_action stripe_subscriptions.setup_intent_next_action DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  payment_method JSONB DEFAULT NULL,
  payment_method_configuration_details stripe_subscriptions.setup_intent_payment_method_configuration_detail DEFAULT NULL,
  payment_method_options stripe_subscriptions.setup_intent_payment_method_option DEFAULT NULL,
  single_use_mandate JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    livemode,
    "object",
    payment_method_types,
    status,
    "usage",
    application,
    attach_to_self,
    automatic_payment_methods,
    cancellation_reason,
    client_secret,
    customer,
    customer_account,
    description,
    excluded_payment_method_types,
    flow_directions,
    last_setup_error,
    latest_attempt,
    mandate,
    metadata,
    next_action,
    on_behalf_of,
    payment_method,
    payment_method_configuration_details,
    payment_method_options,
    single_use_mandate
  )::stripe_subscriptions.setup_intent;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_automatic_payment_method
  ADD ATTRIBUTE allow_redirects TEXT, ADD ATTRIBUTE enabled BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_automatic_payment_method(
  allow_redirects TEXT DEFAULT NULL, enabled BOOLEAN DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_automatic_payment_method
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    allow_redirects, enabled
  )::stripe_subscriptions.setup_intent_automatic_payment_method;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_next_action
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE cashapp_handle_redirect_or_display_qr_code stripe_subscriptions.s_intent_next_action_cashapp_handle_redirect_or_display_qr_code,
  ADD ATTRIBUTE redirect_to_url stripe_subscriptions.setup_intent_next_action_redirect_to_url,
  ADD ATTRIBUTE use_stripe_sdk JSONB,
  ADD ATTRIBUTE verify_with_microdeposits stripe_subscriptions.setup_intent_next_action_verify_with_microdeposit;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_next_action(
  "type" TEXT,
  cashapp_handle_redirect_or_display_qr_code stripe_subscriptions.s_intent_next_action_cashapp_handle_redirect_or_display_qr_code DEFAULT NULL,
  redirect_to_url stripe_subscriptions.setup_intent_next_action_redirect_to_url DEFAULT NULL,
  use_stripe_sdk JSONB DEFAULT NULL,
  verify_with_microdeposits stripe_subscriptions.setup_intent_next_action_verify_with_microdeposit DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_next_action
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    cashapp_handle_redirect_or_display_qr_code,
    redirect_to_url,
    use_stripe_sdk,
    verify_with_microdeposits
  )::stripe_subscriptions.setup_intent_next_action;
$$;

ALTER TYPE stripe_subscriptions.s_intent_next_action_cashapp_handle_redirect_or_display_qr_code
  ADD ATTRIBUTE hosted_instructions_url TEXT,
  ADD ATTRIBUTE mobile_auth_url TEXT,
  ADD ATTRIBUTE qr_code stripe_subscriptions.s_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_i_next_action_cashapp_handle_redirect_or_display_qr_code(
  hosted_instructions_url TEXT,
  mobile_auth_url TEXT,
  qr_code stripe_subscriptions.s_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code
)
RETURNS stripe_subscriptions.s_intent_next_action_cashapp_handle_redirect_or_display_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    hosted_instructions_url, mobile_auth_url, qr_code
  )::stripe_subscriptions.s_intent_next_action_cashapp_handle_redirect_or_display_qr_code;
$$;

ALTER TYPE stripe_subscriptions.s_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE image_url_png TEXT,
  ADD ATTRIBUTE image_url_svg TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_i_n_a_cashapp_handle_redirect_or_display_qr_code_qr_code(
  expires_at BIGINT, image_url_png TEXT, image_url_svg TEXT
)
RETURNS stripe_subscriptions.s_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_at, image_url_png, image_url_svg
  )::stripe_subscriptions.s_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_next_action_redirect_to_url
  ADD ATTRIBUTE return_url TEXT, ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_next_action_redirect_to_url(
  return_url TEXT DEFAULT NULL, url TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_next_action_redirect_to_url
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    return_url, url
  )::stripe_subscriptions.setup_intent_next_action_redirect_to_url;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_next_action_verify_with_microdeposit
  ADD ATTRIBUTE arrival_date BIGINT,
  ADD ATTRIBUTE hosted_verification_url TEXT,
  ADD ATTRIBUTE microdeposit_type TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_next_action_verify_with_microdeposit(
  arrival_date BIGINT,
  hosted_verification_url TEXT,
  microdeposit_type TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_next_action_verify_with_microdeposit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    arrival_date, hosted_verification_url, microdeposit_type
  )::stripe_subscriptions.setup_intent_next_action_verify_with_microdeposit;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_configuration_detail
  ADD ATTRIBUTE "id" TEXT, ADD ATTRIBUTE parent TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_configuration_detail(
  "id" TEXT, parent TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_configuration_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id", parent
  )::stripe_subscriptions.setup_intent_payment_method_configuration_detail;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option
  ADD ATTRIBUTE acss_debit stripe_subscriptions.setup_intent_payment_method_option_acss_debit,
  ADD ATTRIBUTE amazon_pay stripe_subscriptions.setup_intent_payment_method_option_amazon_pay,
  ADD ATTRIBUTE bacs_debit stripe_subscriptions.setup_intent_payment_method_option_bacs_debit,
  ADD ATTRIBUTE card stripe_subscriptions.setup_intent_payment_method_option_card,
  ADD ATTRIBUTE card_present stripe_subscriptions.setup_intent_payment_method_option_card_present,
  ADD ATTRIBUTE klarna stripe_subscriptions.setup_intent_payment_method_option_klarna,
  ADD ATTRIBUTE "link" stripe_subscriptions.setup_intent_payment_method_option_link,
  ADD ATTRIBUTE paypal stripe_subscriptions.setup_intent_payment_method_option_paypal,
  ADD ATTRIBUTE payto stripe_subscriptions.setup_intent_payment_method_option_payto,
  ADD ATTRIBUTE sepa_debit stripe_subscriptions.setup_intent_payment_method_option_sepa_debit,
  ADD ATTRIBUTE us_bank_account stripe_subscriptions.setup_intent_payment_method_option_us_bank_account;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option(
  acss_debit stripe_subscriptions.setup_intent_payment_method_option_acss_debit DEFAULT NULL,
  amazon_pay stripe_subscriptions.setup_intent_payment_method_option_amazon_pay DEFAULT NULL,
  bacs_debit stripe_subscriptions.setup_intent_payment_method_option_bacs_debit DEFAULT NULL,
  card stripe_subscriptions.setup_intent_payment_method_option_card DEFAULT NULL,
  card_present stripe_subscriptions.setup_intent_payment_method_option_card_present DEFAULT NULL,
  klarna stripe_subscriptions.setup_intent_payment_method_option_klarna DEFAULT NULL,
  "link" stripe_subscriptions.setup_intent_payment_method_option_link DEFAULT NULL,
  paypal stripe_subscriptions.setup_intent_payment_method_option_paypal DEFAULT NULL,
  payto stripe_subscriptions.setup_intent_payment_method_option_payto DEFAULT NULL,
  sepa_debit stripe_subscriptions.setup_intent_payment_method_option_sepa_debit DEFAULT NULL,
  us_bank_account stripe_subscriptions.setup_intent_payment_method_option_us_bank_account DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    acss_debit,
    amazon_pay,
    bacs_debit,
    card,
    card_present,
    klarna,
    "link",
    paypal,
    payto,
    sepa_debit,
    us_bank_account
  )::stripe_subscriptions.setup_intent_payment_method_option;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_acss_debit
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_option_acss_debit_mandate_option,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_acss_debit(
  currency TEXT DEFAULT NULL,
  mandate_options stripe_subscriptions.setup_intent_payment_method_option_acss_debit_mandate_option DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_acss_debit;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_acss_debit_mandate_option
  ADD ATTRIBUTE custom_mandate_url TEXT,
  ADD ATTRIBUTE default_for TEXT[],
  ADD ATTRIBUTE interval_description TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE transaction_type TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT,
  ADD ATTRIBUTE start_date TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_setup_intent_payment_method_option_acss_debit_mandate_option(
  custom_mandate_url TEXT DEFAULT NULL,
  default_for TEXT[] DEFAULT NULL,
  interval_description TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  transaction_type TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL,
  start_date TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_acss_debit_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    custom_mandate_url,
    default_for,
    interval_description,
    payment_schedule,
    transaction_type,
    amount,
    amount_type,
    end_date,
    payments_per_period,
    purpose,
    start_date
  )::stripe_subscriptions.setup_intent_payment_method_option_acss_debit_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_amazon_pay
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_amazon_pay(
  mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_amazon_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_amazon_pay;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_bacs_debit
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_option_bacs_debit_mandate_option,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_bacs_debit(
  mandate_options stripe_subscriptions.setup_intent_payment_method_option_bacs_debit_mandate_option DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_bacs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_bacs_debit;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_bacs_debit_mandate_option
  ADD ATTRIBUTE reference_prefix TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT,
  ADD ATTRIBUTE start_date TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_setup_intent_payment_method_option_bacs_debit_mandate_option(
  reference_prefix TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL,
  start_date TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_bacs_debit_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference_prefix,
    amount,
    amount_type,
    end_date,
    payment_schedule,
    payments_per_period,
    purpose,
    start_date
  )::stripe_subscriptions.setup_intent_payment_method_option_bacs_debit_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_card
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_option_card_mandate_option,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE request_three_d_secure TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_card(
  mandate_options stripe_subscriptions.setup_intent_payment_method_option_card_mandate_option DEFAULT NULL,
  network TEXT DEFAULT NULL,
  request_three_d_secure TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, network, request_three_d_secure, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_card;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_card_mandate_option
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE start_date JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE end_date JSONB,
  ADD ATTRIBUTE interval_count BIGINT,
  ADD ATTRIBUTE supported_types TEXT[],
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_card_mandate_option(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  "interval" TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  start_date JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  end_date JSONB DEFAULT NULL,
  interval_count BIGINT DEFAULT NULL,
  supported_types TEXT[] DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_card_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    amount_type,
    currency,
    "interval",
    reference,
    start_date,
    description,
    end_date,
    interval_count,
    supported_types,
    payment_schedule,
    payments_per_period,
    purpose
  )::stripe_subscriptions.setup_intent_payment_method_option_card_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_card_present
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_card_present(
  mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_card_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_card_present;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_klarna
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE preferred_locale TEXT,
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_klarna(
  currency TEXT DEFAULT NULL,
  preferred_locale TEXT DEFAULT NULL,
  mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, preferred_locale, mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_klarna;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_link
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_link(
  mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_link
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_link;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_paypal
  ADD ATTRIBUTE billing_agreement_id TEXT,
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_paypal(
  billing_agreement_id TEXT DEFAULT NULL,
  mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_agreement_id, mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_paypal;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_payto
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_payto(
  mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_payto;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_sepa_debit
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_option_sepa_debit_mandate_option,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_sepa_debit(
  mandate_options stripe_subscriptions.setup_intent_payment_method_option_sepa_debit_mandate_option DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_sepa_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_sepa_debit;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_sepa_debit_mandate_option
  ADD ATTRIBUTE reference_prefix TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT,
  ADD ATTRIBUTE start_date TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_setup_intent_payment_method_option_sepa_debit_mandate_option(
  reference_prefix TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL,
  start_date TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_sepa_debit_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference_prefix,
    amount,
    amount_type,
    end_date,
    payment_schedule,
    payments_per_period,
    purpose,
    start_date
  )::stripe_subscriptions.setup_intent_payment_method_option_sepa_debit_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_option_us_bank_account
  ADD ATTRIBUTE financial_connections stripe_subscriptions.s_i_payment_method_option_us_bank_account_financial_connection,
  ADD ATTRIBUTE mandate_options stripe_subscriptions.s_intent_payment_method_option_us_bank_account_mandate_option,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_option_us_bank_account(
  financial_connections stripe_subscriptions.s_i_payment_method_option_us_bank_account_financial_connection DEFAULT NULL,
  mandate_options stripe_subscriptions.s_intent_payment_method_option_us_bank_account_mandate_option DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_option_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    financial_connections, mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_payment_method_option_us_bank_account;
$$;

ALTER TYPE stripe_subscriptions.s_i_payment_method_option_us_bank_account_financial_connection
  ADD ATTRIBUTE filters stripe_subscriptions.s_i_p_method_option_us_bank_account_financial_connection_filter,
  ADD ATTRIBUTE permissions TEXT[],
  ADD ATTRIBUTE prefetch TEXT[],
  ADD ATTRIBUTE return_url TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_i_p_method_option_us_bank_account_financial_connection(
  filters stripe_subscriptions.s_i_p_method_option_us_bank_account_financial_connection_filter DEFAULT NULL,
  permissions TEXT[] DEFAULT NULL,
  prefetch TEXT[] DEFAULT NULL,
  return_url TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_i_payment_method_option_us_bank_account_financial_connection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    filters, permissions, prefetch, return_url
  )::stripe_subscriptions.s_i_payment_method_option_us_bank_account_financial_connection;
$$;

ALTER TYPE stripe_subscriptions.s_i_p_method_option_us_bank_account_financial_connection_filter
  ADD ATTRIBUTE account_subcategories TEXT[];

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_i_p_m_option_us_bank_account_financial_connection_filter(
  account_subcategories TEXT[] DEFAULT NULL
)
RETURNS stripe_subscriptions.s_i_p_method_option_us_bank_account_financial_connection_filter
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_subcategories
  )::stripe_subscriptions.s_i_p_method_option_us_bank_account_financial_connection_filter;
$$;

ALTER TYPE stripe_subscriptions.s_intent_payment_method_option_us_bank_account_mandate_option
  ADD ATTRIBUTE collection_method TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT,
  ADD ATTRIBUTE start_date TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_intent_payment_method_option_us_bank_account_mandate_option(
  collection_method TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL,
  start_date TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_intent_payment_method_option_us_bank_account_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    collection_method,
    amount,
    amount_type,
    end_date,
    payment_schedule,
    payments_per_period,
    purpose,
    start_date
  )::stripe_subscriptions.s_intent_payment_method_option_us_bank_account_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT,
  ADD ATTRIBUTE start_date TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_payment_method_options_mandate_options_payto(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL,
  start_date TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    amount_type,
    end_date,
    payment_schedule,
    payments_per_period,
    purpose,
    start_date
  )::stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto;
$$;

ALTER TYPE stripe_subscriptions.setup_intent_type_specific_payment_method_options_client
  ADD ATTRIBUTE mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_setup_intent_type_specific_payment_method_options_client(
  mandate_options stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.setup_intent_type_specific_payment_method_options_client
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.setup_intent_type_specific_payment_method_options_client;
$$;

ALTER TYPE stripe_subscriptions.stackable_discount
  ADD ATTRIBUTE coupon JSONB,
  ADD ATTRIBUTE discount JSONB,
  ADD ATTRIBUTE promotion_code JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_stackable_discount(
  coupon JSONB DEFAULT NULL,
  discount JSONB DEFAULT NULL,
  promotion_code JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.stackable_discount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    coupon, discount, promotion_code
  )::stripe_subscriptions.stackable_discount;
$$;

ALTER TYPE stripe_subscriptions.subscription
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE automatic_tax JSONB,
  ADD ATTRIBUTE billing_cycle_anchor BIGINT,
  ADD ATTRIBUTE billing_mode stripe_subscriptions.subscription_billing_mode,
  ADD ATTRIBUTE cancel_at_period_end BOOLEAN,
  ADD ATTRIBUTE collection_method TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE invoice_settings JSONB,
  ADD ATTRIBUTE items stripe_subscriptions.subscription_item,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE start_date BIGINT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE application_fee_percent DOUBLE PRECISION,
  ADD ATTRIBUTE billing_cycle_anchor_config stripe_subscriptions.subscription_billing_cycle_anchor_config,
  ADD ATTRIBUTE billing_thresholds stripe_subscriptions.subscription_billing_thresholds,
  ADD ATTRIBUTE cancel_at BIGINT,
  ADD ATTRIBUTE canceled_at BIGINT,
  ADD ATTRIBUTE cancellation_details stripe_subscriptions.subscription_cancellation_detail,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE days_until_due BIGINT,
  ADD ATTRIBUTE default_payment_method JSONB,
  ADD ATTRIBUTE default_source JSONB,
  ADD ATTRIBUTE default_tax_rates stripe_invoices.tax_rate[],
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE ended_at BIGINT,
  ADD ATTRIBUTE latest_invoice JSONB,
  ADD ATTRIBUTE next_pending_invoice_item_invoice BIGINT,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE pause_collection stripe_subscriptions.subscription_pause_collection,
  ADD ATTRIBUTE payment_settings stripe_subscriptions.subscription_payment_setting,
  ADD ATTRIBUTE pending_invoice_item_interval stripe_subscriptions.subscription_pending_invoice_item_interval,
  ADD ATTRIBUTE pending_setup_intent JSONB,
  ADD ATTRIBUTE pending_update JSONB,
  ADD ATTRIBUTE schedule JSONB,
  ADD ATTRIBUTE test_clock JSONB,
  ADD ATTRIBUTE transfer_data JSONB,
  ADD ATTRIBUTE trial_end BIGINT,
  ADD ATTRIBUTE trial_settings stripe_subscriptions.subscription_trial_setting,
  ADD ATTRIBUTE trial_start BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription(
  "id" TEXT,
  automatic_tax JSONB,
  billing_cycle_anchor BIGINT,
  billing_mode stripe_subscriptions.subscription_billing_mode,
  cancel_at_period_end BOOLEAN,
  collection_method TEXT,
  created BIGINT,
  currency TEXT,
  customer JSONB,
  discounts JSONB[],
  invoice_settings JSONB,
  items stripe_subscriptions.subscription_item,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  start_date BIGINT,
  status TEXT,
  application JSONB DEFAULT NULL,
  application_fee_percent DOUBLE PRECISION DEFAULT NULL,
  billing_cycle_anchor_config stripe_subscriptions.subscription_billing_cycle_anchor_config DEFAULT NULL,
  billing_thresholds stripe_subscriptions.subscription_billing_thresholds DEFAULT NULL,
  cancel_at BIGINT DEFAULT NULL,
  canceled_at BIGINT DEFAULT NULL,
  cancellation_details stripe_subscriptions.subscription_cancellation_detail DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  days_until_due BIGINT DEFAULT NULL,
  default_payment_method JSONB DEFAULT NULL,
  default_source JSONB DEFAULT NULL,
  default_tax_rates stripe_invoices.tax_rate[] DEFAULT NULL,
  description TEXT DEFAULT NULL,
  ended_at BIGINT DEFAULT NULL,
  latest_invoice JSONB DEFAULT NULL,
  next_pending_invoice_item_invoice BIGINT DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  pause_collection stripe_subscriptions.subscription_pause_collection DEFAULT NULL,
  payment_settings stripe_subscriptions.subscription_payment_setting DEFAULT NULL,
  pending_invoice_item_interval stripe_subscriptions.subscription_pending_invoice_item_interval DEFAULT NULL,
  pending_setup_intent JSONB DEFAULT NULL,
  pending_update JSONB DEFAULT NULL,
  schedule JSONB DEFAULT NULL,
  test_clock JSONB DEFAULT NULL,
  transfer_data JSONB DEFAULT NULL,
  trial_end BIGINT DEFAULT NULL,
  trial_settings stripe_subscriptions.subscription_trial_setting DEFAULT NULL,
  trial_start BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    automatic_tax,
    billing_cycle_anchor,
    billing_mode,
    cancel_at_period_end,
    collection_method,
    created,
    currency,
    customer,
    discounts,
    invoice_settings,
    items,
    livemode,
    metadata,
    "object",
    start_date,
    status,
    application,
    application_fee_percent,
    billing_cycle_anchor_config,
    billing_thresholds,
    cancel_at,
    canceled_at,
    cancellation_details,
    customer_account,
    days_until_due,
    default_payment_method,
    default_source,
    default_tax_rates,
    description,
    ended_at,
    latest_invoice,
    next_pending_invoice_item_invoice,
    on_behalf_of,
    pause_collection,
    payment_settings,
    pending_invoice_item_interval,
    pending_setup_intent,
    pending_update,
    schedule,
    test_clock,
    transfer_data,
    trial_end,
    trial_settings,
    trial_start
  )::stripe_subscriptions.subscription;
$$;

ALTER TYPE stripe_subscriptions.subscription_billing_mode
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE flexible stripe_subscriptions.subscription_billing_mode_flexible,
  ADD ATTRIBUTE updated_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_billing_mode(
  "type" TEXT,
  flexible stripe_subscriptions.subscription_billing_mode_flexible DEFAULT NULL,
  updated_at BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_billing_mode
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", flexible, updated_at
  )::stripe_subscriptions.subscription_billing_mode;
$$;

ALTER TYPE stripe_subscriptions.subscription_billing_mode_flexible
  ADD ATTRIBUTE proration_discounts TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_billing_mode_flexible(
  proration_discounts TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_billing_mode_flexible
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    proration_discounts
  )::stripe_subscriptions.subscription_billing_mode_flexible;
$$;

ALTER TYPE stripe_subscriptions.subscription_item
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_item(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_subscriptions.subscription_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_subscriptions.subscription_item;
$$;

ALTER TYPE stripe_subscriptions.subscription_billing_cycle_anchor_config
  ADD ATTRIBUTE day_of_month BIGINT,
  ADD ATTRIBUTE "hour" BIGINT,
  ADD ATTRIBUTE "minute" BIGINT,
  ADD ATTRIBUTE "month" BIGINT,
  ADD ATTRIBUTE "second" BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_billing_cycle_anchor_config(
  day_of_month BIGINT,
  "hour" BIGINT DEFAULT NULL,
  "minute" BIGINT DEFAULT NULL,
  "month" BIGINT DEFAULT NULL,
  "second" BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_billing_cycle_anchor_config
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    day_of_month, "hour", "minute", "month", "second"
  )::stripe_subscriptions.subscription_billing_cycle_anchor_config;
$$;

ALTER TYPE stripe_subscriptions.subscription_cancellation_detail
  ADD ATTRIBUTE "comment" TEXT,
  ADD ATTRIBUTE feedback TEXT,
  ADD ATTRIBUTE reason TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_cancellation_detail(
  "comment" TEXT DEFAULT NULL,
  feedback TEXT DEFAULT NULL,
  reason TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_cancellation_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "comment", feedback, reason
  )::stripe_subscriptions.subscription_cancellation_detail;
$$;

ALTER TYPE stripe_subscriptions.subscription_pause_collection
  ADD ATTRIBUTE behavior TEXT, ADD ATTRIBUTE resumes_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_pause_collection(
  behavior TEXT, resumes_at BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_pause_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    behavior, resumes_at
  )::stripe_subscriptions.subscription_pause_collection;
$$;

ALTER TYPE stripe_subscriptions.subscription_payment_setting
  ADD ATTRIBUTE payment_method_options stripe_subscriptions.subscription_payment_setting_payment_method_option,
  ADD ATTRIBUTE payment_method_types TEXT[],
  ADD ATTRIBUTE save_default_payment_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_payment_setting(
  payment_method_options stripe_subscriptions.subscription_payment_setting_payment_method_option DEFAULT NULL,
  payment_method_types TEXT[] DEFAULT NULL,
  save_default_payment_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_payment_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_method_options, payment_method_types, save_default_payment_method
  )::stripe_subscriptions.subscription_payment_setting;
$$;

ALTER TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option
  ADD ATTRIBUTE acss_debit stripe_subscriptions.subscription_payment_setting_payment_method_option_acss_debit,
  ADD ATTRIBUTE bancontact stripe_subscriptions.subscription_payment_setting_payment_method_option_bancontact,
  ADD ATTRIBUTE card stripe_subscriptions.subscription_payment_setting_payment_method_option_card,
  ADD ATTRIBUTE customer_balance stripe_subscriptions.s_payment_setting_payment_method_option_customer_balance,
  ADD ATTRIBUTE konbini stripe_subscriptions.subscription_payment_setting_payment_method_option_konbini,
  ADD ATTRIBUTE payto stripe_subscriptions.subscription_payment_setting_payment_method_option_payto,
  ADD ATTRIBUTE sepa_debit stripe_subscriptions.subscription_payment_setting_payment_method_option_sepa_debit,
  ADD ATTRIBUTE us_bank_account stripe_subscriptions.s_payment_setting_payment_method_option_us_bank_account;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_payment_setting_payment_method_option(
  acss_debit stripe_subscriptions.subscription_payment_setting_payment_method_option_acss_debit DEFAULT NULL,
  bancontact stripe_subscriptions.subscription_payment_setting_payment_method_option_bancontact DEFAULT NULL,
  card stripe_subscriptions.subscription_payment_setting_payment_method_option_card DEFAULT NULL,
  customer_balance stripe_subscriptions.s_payment_setting_payment_method_option_customer_balance DEFAULT NULL,
  konbini stripe_subscriptions.subscription_payment_setting_payment_method_option_konbini DEFAULT NULL,
  payto stripe_subscriptions.subscription_payment_setting_payment_method_option_payto DEFAULT NULL,
  sepa_debit stripe_subscriptions.subscription_payment_setting_payment_method_option_sepa_debit DEFAULT NULL,
  us_bank_account stripe_subscriptions.s_payment_setting_payment_method_option_us_bank_account DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_payment_setting_payment_method_option
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
  )::stripe_subscriptions.subscription_payment_setting_payment_method_option;
$$;

ALTER TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_acss_debit
  ADD ATTRIBUTE mandate_options stripe_subscriptions.s_p_setting_payment_method_option_acss_debit_mandate_option,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_subscription_payment_setting_payment_method_option_acss_debit(
  mandate_options stripe_subscriptions.s_p_setting_payment_method_option_acss_debit_mandate_option DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_payment_setting_payment_method_option_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, verification_method
  )::stripe_subscriptions.subscription_payment_setting_payment_method_option_acss_debit;
$$;

ALTER TYPE stripe_subscriptions.s_p_setting_payment_method_option_acss_debit_mandate_option
  ADD ATTRIBUTE transaction_type TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_p_setting_payment_method_option_acss_debit_mandate_option(
  transaction_type TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_p_setting_payment_method_option_acss_debit_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    transaction_type
  )::stripe_subscriptions.s_p_setting_payment_method_option_acss_debit_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_bancontact
  ADD ATTRIBUTE preferred_language TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_subscription_payment_setting_payment_method_option_bancontact(
  preferred_language TEXT
)
RETURNS stripe_subscriptions.subscription_payment_setting_payment_method_option_bancontact
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    preferred_language
  )::stripe_subscriptions.subscription_payment_setting_payment_method_option_bancontact;
$$;

ALTER TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_card
  ADD ATTRIBUTE mandate_options stripe_subscriptions.s_payment_setting_payment_method_option_card_mandate_option,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE request_three_d_secure TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_payment_setting_payment_method_option_card(
  mandate_options stripe_subscriptions.s_payment_setting_payment_method_option_card_mandate_option DEFAULT NULL,
  network TEXT DEFAULT NULL,
  request_three_d_secure TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_payment_setting_payment_method_option_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options, network, request_three_d_secure
  )::stripe_subscriptions.subscription_payment_setting_payment_method_option_card;
$$;

ALTER TYPE stripe_subscriptions.s_payment_setting_payment_method_option_card_mandate_option
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE description TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_payment_setting_payment_method_option_card_mandate_option(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_payment_setting_payment_method_option_card_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, amount_type, description
  )::stripe_subscriptions.s_payment_setting_payment_method_option_card_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.s_payment_setting_payment_method_option_customer_balance
  ADD ATTRIBUTE bank_transfer stripe_subscriptions.s_p_s_payment_method_option_customer_balance_bank_transfer,
  ADD ATTRIBUTE funding_type TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_payment_setting_payment_method_option_customer_balance(
  bank_transfer stripe_subscriptions.s_p_s_payment_method_option_customer_balance_bank_transfer DEFAULT NULL,
  funding_type TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_payment_setting_payment_method_option_customer_balance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_transfer, funding_type
  )::stripe_subscriptions.s_payment_setting_payment_method_option_customer_balance;
$$;

ALTER TYPE stripe_subscriptions.s_p_s_payment_method_option_customer_balance_bank_transfer
  ADD ATTRIBUTE eu_bank_transfer stripe_subscriptions.s_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_p_s_payment_method_option_customer_balance_bank_transfer(
  eu_bank_transfer stripe_subscriptions.s_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_p_s_payment_method_option_customer_balance_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    eu_bank_transfer, "type"
  )::stripe_subscriptions.s_p_s_payment_method_option_customer_balance_bank_transfer;
$$;

ALTER TYPE stripe_subscriptions.s_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer(
  country TEXT
)
RETURNS stripe_subscriptions.s_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_subscriptions.s_p_s_p_m_o_customer_balance_bank_transfer_eu_bank_transfer;
$$;

ALTER TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_payto
  ADD ATTRIBUTE mandate_options stripe_subscriptions.s_payment_setting_payment_method_option_payto_mandate_option;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_payment_setting_payment_method_option_payto(
  mandate_options stripe_subscriptions.s_payment_setting_payment_method_option_payto_mandate_option DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_payment_setting_payment_method_option_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options
  )::stripe_subscriptions.subscription_payment_setting_payment_method_option_payto;
$$;

ALTER TYPE stripe_subscriptions.s_payment_setting_payment_method_option_payto_mandate_option
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_payment_setting_payment_method_option_payto_mandate_option(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_payment_setting_payment_method_option_payto_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, amount_type, purpose
  )::stripe_subscriptions.s_payment_setting_payment_method_option_payto_mandate_option;
$$;

ALTER TYPE stripe_subscriptions.s_payment_setting_payment_method_option_us_bank_account
  ADD ATTRIBUTE financial_connections stripe_subscriptions.s_p_s_p_method_option_us_bank_account_financial_connection,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_payment_setting_payment_method_option_us_bank_account(
  financial_connections stripe_subscriptions.s_p_s_p_method_option_us_bank_account_financial_connection DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.s_payment_setting_payment_method_option_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    financial_connections, verification_method
  )::stripe_subscriptions.s_payment_setting_payment_method_option_us_bank_account;
$$;

ALTER TYPE stripe_subscriptions.s_p_s_p_method_option_us_bank_account_financial_connection
  ADD ATTRIBUTE filters stripe_subscriptions.s_p_s_p_m_option_us_bank_account_financial_connection_filter,
  ADD ATTRIBUTE permissions TEXT[],
  ADD ATTRIBUTE prefetch TEXT[];

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_p_s_p_method_option_us_bank_account_financial_connection(
  filters stripe_subscriptions.s_p_s_p_m_option_us_bank_account_financial_connection_filter DEFAULT NULL,
  permissions TEXT[] DEFAULT NULL,
  prefetch TEXT[] DEFAULT NULL
)
RETURNS stripe_subscriptions.s_p_s_p_method_option_us_bank_account_financial_connection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    filters, permissions, prefetch
  )::stripe_subscriptions.s_p_s_p_method_option_us_bank_account_financial_connection;
$$;

ALTER TYPE stripe_subscriptions.s_p_s_p_m_option_us_bank_account_financial_connection_filter
  ADD ATTRIBUTE account_subcategories TEXT[];

CREATE OR REPLACE FUNCTION stripe_subscriptions.m_s_p_s_p_m_option_us_bank_account_financial_connection_filter(
  account_subcategories TEXT[] DEFAULT NULL
)
RETURNS stripe_subscriptions.s_p_s_p_m_option_us_bank_account_financial_connection_filter
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_subcategories
  )::stripe_subscriptions.s_p_s_p_m_option_us_bank_account_financial_connection_filter;
$$;

ALTER TYPE stripe_subscriptions.subscription_pending_invoice_item_interval
  ADD ATTRIBUTE "interval" TEXT, ADD ATTRIBUTE interval_count BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_pending_invoice_item_interval(
  "interval" TEXT, interval_count BIGINT
)
RETURNS stripe_subscriptions.subscription_pending_invoice_item_interval
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "interval", interval_count
  )::stripe_subscriptions.subscription_pending_invoice_item_interval;
$$;

ALTER TYPE stripe_subscriptions.subscription_trial_setting
  ADD ATTRIBUTE end_behavior stripe_subscriptions.subscription_trial_setting_end_behavior;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_trial_setting(
  end_behavior stripe_subscriptions.subscription_trial_setting_end_behavior
)
RETURNS stripe_subscriptions.subscription_trial_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(end_behavior)::stripe_subscriptions.subscription_trial_setting;
$$;

ALTER TYPE stripe_subscriptions.subscription_trial_setting_end_behavior
  ADD ATTRIBUTE missing_payment_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_trial_setting_end_behavior(
  missing_payment_method TEXT
)
RETURNS stripe_subscriptions.subscription_trial_setting_end_behavior
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    missing_payment_method
  )::stripe_subscriptions.subscription_trial_setting_end_behavior;
$$;

ALTER TYPE stripe_subscriptions.subscription_billing_thresholds
  ADD ATTRIBUTE amount_gte BIGINT,
  ADD ATTRIBUTE reset_billing_cycle_anchor BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_billing_thresholds(
  amount_gte BIGINT DEFAULT NULL,
  reset_billing_cycle_anchor BOOLEAN DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_billing_thresholds
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_gte, reset_billing_cycle_anchor
  )::stripe_subscriptions.subscription_billing_thresholds;
$$;

ALTER TYPE stripe_subscriptions.subscription_invoice_settings
  ADD ATTRIBUTE issuer JSONB, ADD ATTRIBUTE account_tax_ids JSONB[];

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_invoice_settings(
  issuer JSONB, account_tax_ids JSONB[] DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_invoice_settings
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    issuer, account_tax_ids
  )::stripe_subscriptions.subscription_invoice_settings;
$$;

ALTER TYPE stripe_subscriptions.subscription_item1
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE current_period_end BIGINT,
  ADD ATTRIBUTE current_period_start BIGINT,
  ADD ATTRIBUTE discounts JSONB[],
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE price stripe_prices.price,
  ADD ATTRIBUTE "subscription" TEXT,
  ADD ATTRIBUTE billing_thresholds stripe_subscriptions.subscription_item_billing_threshold,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE tax_rates stripe_invoices.tax_rate[];

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_item1(
  "id" TEXT,
  created BIGINT,
  current_period_end BIGINT,
  current_period_start BIGINT,
  discounts JSONB[],
  metadata JSONB,
  "object" TEXT,
  price stripe_prices.price,
  "subscription" TEXT,
  billing_thresholds stripe_subscriptions.subscription_item_billing_threshold DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  tax_rates stripe_invoices.tax_rate[] DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_item1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    current_period_end,
    current_period_start,
    discounts,
    metadata,
    "object",
    price,
    "subscription",
    billing_thresholds,
    quantity,
    tax_rates
  )::stripe_subscriptions.subscription_item1;
$$;

ALTER TYPE stripe_subscriptions.subscription_item_billing_threshold
  ADD ATTRIBUTE usage_gte BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_item_billing_threshold(
  usage_gte BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_item_billing_threshold
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    usage_gte
  )::stripe_subscriptions.subscription_item_billing_threshold;
$$;

ALTER TYPE stripe_subscriptions.subscription_transfer_data
  ADD ATTRIBUTE destination JSONB,
  ADD ATTRIBUTE amount_percent DOUBLE PRECISION;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_subscription_transfer_data(
  destination JSONB, amount_percent DOUBLE PRECISION DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription_transfer_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    destination, amount_percent
  )::stripe_subscriptions.subscription_transfer_data;
$$;

ALTER TYPE stripe_subscriptions.add_invoice_item
  ADD ATTRIBUTE discounts stripe_subscriptions.add_invoice_item_discount[],
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "period" stripe_subscriptions.add_invoice_item_period,
  ADD ATTRIBUTE price TEXT,
  ADD ATTRIBUTE price_data stripe_subscriptions.add_invoice_item_price_data,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE tax_rates JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_add_invoice_item(
  discounts stripe_subscriptions.add_invoice_item_discount[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  "period" stripe_subscriptions.add_invoice_item_period DEFAULT NULL,
  price TEXT DEFAULT NULL,
  price_data stripe_subscriptions.add_invoice_item_price_data DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  tax_rates JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.add_invoice_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    discounts, metadata, "period", price, price_data, quantity, tax_rates
  )::stripe_subscriptions.add_invoice_item;
$$;

ALTER TYPE stripe_subscriptions.add_invoice_item_discount
  ADD ATTRIBUTE coupon TEXT,
  ADD ATTRIBUTE discount TEXT,
  ADD ATTRIBUTE promotion_code TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_add_invoice_item_discount(
  coupon TEXT DEFAULT NULL,
  discount TEXT DEFAULT NULL,
  promotion_code TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.add_invoice_item_discount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    coupon, discount, promotion_code
  )::stripe_subscriptions.add_invoice_item_discount;
$$;

ALTER TYPE stripe_subscriptions.add_invoice_item_period
  ADD ATTRIBUTE "end" stripe_subscriptions.add_invoice_item_period_end,
  ADD ATTRIBUTE "start" stripe_subscriptions.add_invoice_item_period_start;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_add_invoice_item_period(
  "end" stripe_subscriptions.add_invoice_item_period_end,
  "start" stripe_subscriptions.add_invoice_item_period_start
)
RETURNS stripe_subscriptions.add_invoice_item_period
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("end", "start")::stripe_subscriptions.add_invoice_item_period;
$$;

ALTER TYPE stripe_subscriptions.add_invoice_item_period_end
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE "timestamp" BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_add_invoice_item_period_end(
  "type" TEXT, "timestamp" BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.add_invoice_item_period_end
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", "timestamp"
  )::stripe_subscriptions.add_invoice_item_period_end;
$$;

ALTER TYPE stripe_subscriptions.add_invoice_item_period_start
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE "timestamp" BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_add_invoice_item_period_start(
  "type" TEXT, "timestamp" BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.add_invoice_item_period_start
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", "timestamp"
  )::stripe_subscriptions.add_invoice_item_period_start;
$$;

ALTER TYPE stripe_subscriptions.add_invoice_item_price_data
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE product TEXT,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_add_invoice_item_price_data(
  currency TEXT,
  product TEXT,
  tax_behavior TEXT DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.add_invoice_item_price_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, product, tax_behavior, unit_amount, unit_amount_decimal
  )::stripe_subscriptions.add_invoice_item_price_data;
$$;

ALTER TYPE stripe_subscriptions.automatic_tax
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE liability stripe_subscriptions.automatic_tax_liability;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_automatic_tax(
  enabled BOOLEAN,
  liability stripe_subscriptions.automatic_tax_liability DEFAULT NULL
)
RETURNS stripe_subscriptions.automatic_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled, liability)::stripe_subscriptions.automatic_tax;
$$;

ALTER TYPE stripe_subscriptions.automatic_tax_liability
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_automatic_tax_liability(
  "type" TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.automatic_tax_liability
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", account)::stripe_subscriptions.automatic_tax_liability;
$$;

ALTER TYPE stripe_subscriptions.cancellation_detail
  ADD ATTRIBUTE "comment" TEXT, ADD ATTRIBUTE feedback TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_cancellation_detail(
  "comment" TEXT DEFAULT NULL, feedback TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.cancellation_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("comment", feedback)::stripe_subscriptions.cancellation_detail;
$$;

ALTER TYPE stripe_subscriptions.invoice_setting
  ADD ATTRIBUTE account_tax_ids JSONB,
  ADD ATTRIBUTE issuer stripe_subscriptions.invoice_setting_issuer;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_invoice_setting(
  account_tax_ids JSONB DEFAULT NULL,
  issuer stripe_subscriptions.invoice_setting_issuer DEFAULT NULL
)
RETURNS stripe_subscriptions.invoice_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(account_tax_ids, issuer)::stripe_subscriptions.invoice_setting;
$$;

ALTER TYPE stripe_subscriptions.invoice_setting_issuer
  ADD ATTRIBUTE "type" TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_invoice_setting_issuer(
  "type" TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.invoice_setting_issuer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", account)::stripe_subscriptions.invoice_setting_issuer;
$$;

ALTER TYPE stripe_subscriptions.item
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE billing_thresholds JSONB,
  ADD ATTRIBUTE clear_usage BOOLEAN,
  ADD ATTRIBUTE deleted BOOLEAN,
  ADD ATTRIBUTE discounts JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE price TEXT,
  ADD ATTRIBUTE price_data stripe_subscriptions.item_price_data,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE tax_rates JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_item(
  "id" TEXT DEFAULT NULL,
  billing_thresholds JSONB DEFAULT NULL,
  clear_usage BOOLEAN DEFAULT NULL,
  deleted BOOLEAN DEFAULT NULL,
  discounts JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  price TEXT DEFAULT NULL,
  price_data stripe_subscriptions.item_price_data DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  tax_rates JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    billing_thresholds,
    clear_usage,
    deleted,
    discounts,
    metadata,
    price,
    price_data,
    quantity,
    tax_rates
  )::stripe_subscriptions.item;
$$;

ALTER TYPE stripe_subscriptions.item_price_data
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE product TEXT,
  ADD ATTRIBUTE recurring stripe_subscriptions.item_price_data_recurring,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_item_price_data(
  currency TEXT,
  product TEXT,
  recurring stripe_subscriptions.item_price_data_recurring,
  tax_behavior TEXT DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.item_price_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency, product, recurring, tax_behavior, unit_amount, unit_amount_decimal
  )::stripe_subscriptions.item_price_data;
$$;

ALTER TYPE stripe_subscriptions.item_price_data_recurring
  ADD ATTRIBUTE "interval" TEXT, ADD ATTRIBUTE interval_count BIGINT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_item_price_data_recurring(
  "interval" TEXT, interval_count BIGINT DEFAULT NULL
)
RETURNS stripe_subscriptions.item_price_data_recurring
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "interval", interval_count
  )::stripe_subscriptions.item_price_data_recurring;
$$;

ALTER TYPE stripe_subscriptions.payment_setting
  ADD ATTRIBUTE payment_method_options stripe_subscriptions.payment_setting_payment_method_option,
  ADD ATTRIBUTE payment_method_types JSONB,
  ADD ATTRIBUTE save_default_payment_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_payment_setting(
  payment_method_options stripe_subscriptions.payment_setting_payment_method_option DEFAULT NULL,
  payment_method_types JSONB DEFAULT NULL,
  save_default_payment_method TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.payment_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_method_options, payment_method_types, save_default_payment_method
  )::stripe_subscriptions.payment_setting;
$$;

ALTER TYPE stripe_subscriptions.payment_setting_payment_method_option
  ADD ATTRIBUTE acss_debit JSONB,
  ADD ATTRIBUTE bancontact JSONB,
  ADD ATTRIBUTE card JSONB,
  ADD ATTRIBUTE customer_balance JSONB,
  ADD ATTRIBUTE konbini JSONB,
  ADD ATTRIBUTE payto JSONB,
  ADD ATTRIBUTE sepa_debit JSONB,
  ADD ATTRIBUTE us_bank_account JSONB;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_payment_setting_payment_method_option(
  acss_debit JSONB DEFAULT NULL,
  bancontact JSONB DEFAULT NULL,
  card JSONB DEFAULT NULL,
  customer_balance JSONB DEFAULT NULL,
  konbini JSONB DEFAULT NULL,
  payto JSONB DEFAULT NULL,
  sepa_debit JSONB DEFAULT NULL,
  us_bank_account JSONB DEFAULT NULL
)
RETURNS stripe_subscriptions.payment_setting_payment_method_option
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
  )::stripe_subscriptions.payment_setting_payment_method_option;
$$;

ALTER TYPE stripe_subscriptions.trial_setting
  ADD ATTRIBUTE end_behavior stripe_subscriptions.trial_setting_end_behavior;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_trial_setting(
  end_behavior stripe_subscriptions.trial_setting_end_behavior
)
RETURNS stripe_subscriptions.trial_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(end_behavior)::stripe_subscriptions.trial_setting;
$$;

ALTER TYPE stripe_subscriptions.trial_setting_end_behavior
  ADD ATTRIBUTE missing_payment_method TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_trial_setting_end_behavior(
  missing_payment_method TEXT
)
RETURNS stripe_subscriptions.trial_setting_end_behavior
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    missing_payment_method
  )::stripe_subscriptions.trial_setting_end_behavior;
$$;

ALTER TYPE stripe_subscriptions.automatic_tax1
  ADD ATTRIBUTE enabled BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_automatic_tax1(
  enabled BOOLEAN
)
RETURNS stripe_subscriptions.automatic_tax1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled)::stripe_subscriptions.automatic_tax1;
$$;

ALTER TYPE stripe_subscriptions.cancellation_detail1
  ADD ATTRIBUTE "comment" TEXT, ADD ATTRIBUTE feedback TEXT;

CREATE OR REPLACE FUNCTION stripe_subscriptions.make_cancellation_detail1(
  "comment" TEXT DEFAULT NULL, feedback TEXT DEFAULT NULL
)
RETURNS stripe_subscriptions.cancellation_detail1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("comment", feedback)::stripe_subscriptions.cancellation_detail1;
$$;

CREATE OR REPLACE FUNCTION stripe_subscriptions._update(
  subscription_exposed_id TEXT,
  add_invoice_items stripe_subscriptions.add_invoice_item[] DEFAULT NULL,
  application_fee_percent JSONB DEFAULT NULL,
  automatic_tax stripe_subscriptions.automatic_tax DEFAULT NULL,
  billing_cycle_anchor TEXT DEFAULT NULL,
  billing_thresholds JSONB DEFAULT NULL,
  cancel_at JSONB DEFAULT NULL,
  cancel_at_period_end BOOLEAN DEFAULT NULL,
  cancellation_details stripe_subscriptions.cancellation_detail DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  days_until_due BIGINT DEFAULT NULL,
  default_payment_method TEXT DEFAULT NULL,
  default_source TEXT DEFAULT NULL,
  default_tax_rates JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discounts JSONB DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  invoice_settings stripe_subscriptions.invoice_setting DEFAULT NULL,
  items stripe_subscriptions.item[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  off_session BOOLEAN DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  pause_collection JSONB DEFAULT NULL,
  payment_behavior TEXT DEFAULT NULL,
  payment_settings stripe_subscriptions.payment_setting DEFAULT NULL,
  pending_invoice_item_interval JSONB DEFAULT NULL,
  proration_behavior TEXT DEFAULT NULL,
  proration_date BIGINT DEFAULT NULL,
  transfer_data JSONB DEFAULT NULL,
  trial_end JSONB DEFAULT NULL,
  trial_from_plan BOOLEAN DEFAULT NULL,
  trial_settings stripe_subscriptions.trial_setting DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stainless_commons_stripe._types import not_given

  response = GD["__stripe_context__"].client.subscriptions.with_raw_response.update(
      subscription_exposed_id=subscription_exposed_id,
      add_invoice_items=not_given if add_invoice_items is None else GD["__stripe_context__"].strip_none(add_invoice_items),
      application_fee_percent=not_given if application_fee_percent is None else json.loads(application_fee_percent),
      automatic_tax=not_given if automatic_tax is None else GD["__stripe_context__"].strip_none(automatic_tax),
      billing_cycle_anchor=not_given if billing_cycle_anchor is None else billing_cycle_anchor,
      billing_thresholds=not_given if billing_thresholds is None else json.loads(billing_thresholds),
      cancel_at=not_given if cancel_at is None else json.loads(cancel_at),
      cancel_at_period_end=not_given if cancel_at_period_end is None else cancel_at_period_end,
      cancellation_details=not_given if cancellation_details is None else GD["__stripe_context__"].strip_none(cancellation_details),
      collection_method=not_given if collection_method is None else collection_method,
      days_until_due=not_given if days_until_due is None else days_until_due,
      default_payment_method=not_given if default_payment_method is None else default_payment_method,
      default_source=not_given if default_source is None else default_source,
      default_tax_rates=not_given if default_tax_rates is None else json.loads(default_tax_rates),
      description=not_given if description is None else description,
      discounts=not_given if discounts is None else json.loads(discounts),
      expand=not_given if expand is None else expand,
      invoice_settings=not_given if invoice_settings is None else GD["__stripe_context__"].strip_none(invoice_settings),
      items=not_given if items is None else GD["__stripe_context__"].strip_none(items),
      metadata=not_given if metadata is None else json.loads(metadata),
      off_session=not_given if off_session is None else off_session,
      on_behalf_of=not_given if on_behalf_of is None else on_behalf_of,
      pause_collection=not_given if pause_collection is None else json.loads(pause_collection),
      payment_behavior=not_given if payment_behavior is None else payment_behavior,
      payment_settings=not_given if payment_settings is None else GD["__stripe_context__"].strip_none(payment_settings),
      pending_invoice_item_interval=not_given if pending_invoice_item_interval is None else json.loads(pending_invoice_item_interval),
      proration_behavior=not_given if proration_behavior is None else proration_behavior,
      proration_date=not_given if proration_date is None else proration_date,
      transfer_data=not_given if transfer_data is None else json.loads(transfer_data),
      trial_end=not_given if trial_end is None else json.loads(trial_end),
      trial_from_plan=not_given if trial_from_plan is None else trial_from_plan,
      trial_settings=not_given if trial_settings is None else GD["__stripe_context__"].strip_none(trial_settings),
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_subscriptions.update(
  subscription_exposed_id TEXT,
  add_invoice_items stripe_subscriptions.add_invoice_item[] DEFAULT NULL,
  application_fee_percent JSONB DEFAULT NULL,
  automatic_tax stripe_subscriptions.automatic_tax DEFAULT NULL,
  billing_cycle_anchor TEXT DEFAULT NULL,
  billing_thresholds JSONB DEFAULT NULL,
  cancel_at JSONB DEFAULT NULL,
  cancel_at_period_end BOOLEAN DEFAULT NULL,
  cancellation_details stripe_subscriptions.cancellation_detail DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  days_until_due BIGINT DEFAULT NULL,
  default_payment_method TEXT DEFAULT NULL,
  default_source TEXT DEFAULT NULL,
  default_tax_rates JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discounts JSONB DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  invoice_settings stripe_subscriptions.invoice_setting DEFAULT NULL,
  items stripe_subscriptions.item[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  off_session BOOLEAN DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  pause_collection JSONB DEFAULT NULL,
  payment_behavior TEXT DEFAULT NULL,
  payment_settings stripe_subscriptions.payment_setting DEFAULT NULL,
  pending_invoice_item_interval JSONB DEFAULT NULL,
  proration_behavior TEXT DEFAULT NULL,
  proration_date BIGINT DEFAULT NULL,
  transfer_data JSONB DEFAULT NULL,
  trial_end JSONB DEFAULT NULL,
  trial_from_plan BOOLEAN DEFAULT NULL,
  trial_settings stripe_subscriptions.trial_setting DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_subscriptions.subscription,
      stripe_subscriptions._update(
        subscription_exposed_id,
        add_invoice_items,
        application_fee_percent,
        automatic_tax,
        billing_cycle_anchor,
        billing_thresholds,
        cancel_at,
        cancel_at_period_end,
        cancellation_details,
        collection_method,
        days_until_due,
        default_payment_method,
        default_source,
        default_tax_rates,
        description,
        discounts,
        expand,
        invoice_settings,
        items,
        metadata,
        off_session,
        on_behalf_of,
        pause_collection,
        payment_behavior,
        payment_settings,
        pending_invoice_item_interval,
        proration_behavior,
        proration_date,
        transfer_data,
        trial_end,
        trial_from_plan,
        trial_settings
      )
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_subscriptions._list_first_page_py(
  automatic_tax stripe_subscriptions.automatic_tax1 DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  current_period_end JSONB DEFAULT NULL,
  current_period_start JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  price TEXT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe._types import not_given
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client.subscriptions.list(
      automatic_tax=not_given if automatic_tax is None else GD["__stripe_context__"].strip_none(automatic_tax),
      collection_method=not_given if collection_method is None else collection_method,
      created=not_given if created is None else json.loads(created),
      current_period_end=not_given if current_period_end is None else json.loads(current_period_end),
      current_period_start=not_given if current_period_start is None else json.loads(current_period_start),
      customer=not_given if customer is None else customer,
      customer_account=not_given if customer_account is None else customer_account,
      ending_before=not_given if ending_before is None else ending_before,
      expand=not_given if expand is None else expand,
      limit=not_given if limit is None else limit,
      price=not_given if price is None else price,
      starting_after=not_given if starting_after is None else starting_after,
      status=not_given if status is None else status,
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

-- A simpler wrapper around `stripe_subscriptions._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_subscriptions._list_first_page(
  automatic_tax stripe_subscriptions.automatic_tax1 DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  current_period_end JSONB DEFAULT NULL,
  current_period_start JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  price TEXT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN stripe_subscriptions._list_first_page_py(
      automatic_tax,
      collection_method,
      created,
      current_period_end,
      current_period_start,
      customer,
      customer_account,
      ending_before,
      expand,
      "limit",
      price,
      starting_after,
      status,
      test_clock
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_subscriptions._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stainless_commons_stripe.types import Subscription
  from stainless_commons_stripe.pagination import SyncMyCursorIDPage
  from stainless_commons_stripe._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client._request_api_list(
    model=Subscription,
    page=SyncMyCursorIDPage[Subscription],
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

CREATE OR REPLACE FUNCTION stripe_subscriptions.list(
  automatic_tax stripe_subscriptions.automatic_tax1 DEFAULT NULL,
  collection_method TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  current_period_end JSONB DEFAULT NULL,
  current_period_start JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  price TEXT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL,
  status TEXT DEFAULT NULL,
  test_clock TEXT DEFAULT NULL
)
RETURNS SETOF stripe_subscriptions.subscription
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_subscriptions._list_first_page(
      automatic_tax,
      collection_method,
      created,
      current_period_end,
      current_period_start,
      customer,
      customer_account,
      ending_before,
      expand,
      "limit",
      price,
      starting_after,
      status,
      test_clock
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_subscriptions._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_subscriptions.subscription, "data")).* FROM paginated;
$$;

CREATE OR REPLACE FUNCTION stripe_subscriptions._cancel(
  subscription_exposed_id TEXT,
  cancellation_details stripe_subscriptions.cancellation_detail1 DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  invoice_now BOOLEAN DEFAULT NULL,
  prorate BOOLEAN DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  from stainless_commons_stripe._types import not_given

  response = GD["__stripe_context__"].client.subscriptions.with_raw_response.cancel(
      subscription_exposed_id=subscription_exposed_id,
      cancellation_details=not_given if cancellation_details is None else GD["__stripe_context__"].strip_none(cancellation_details),
      expand=not_given if expand is None else expand,
      invoice_now=not_given if invoice_now is None else invoice_now,
      prorate=not_given if prorate is None else prorate,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_subscriptions.cancel(
  subscription_exposed_id TEXT,
  cancellation_details stripe_subscriptions.cancellation_detail1 DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  invoice_now BOOLEAN DEFAULT NULL,
  prorate BOOLEAN DEFAULT NULL
)
RETURNS stripe_subscriptions.subscription
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_subscriptions.subscription,
      stripe_subscriptions._cancel(
        subscription_exposed_id,
        cancellation_details,
        expand,
        invoice_now,
        prorate
      )
    );
  END;
$$;