ALTER TYPE stripe_disputes.application_fee
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE account JSONB,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_refunded BIGINT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE charge JSONB,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE refunded BOOLEAN,
  ADD ATTRIBUTE refunds stripe_disputes.application_fee_refund,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE fee_source stripe_disputes.application_fee_fee_source,
  ADD ATTRIBUTE originating_transaction JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.make_application_fee(
  "id" TEXT,
  account JSONB,
  amount BIGINT,
  amount_refunded BIGINT,
  application JSONB,
  charge JSONB,
  created BIGINT,
  currency TEXT,
  livemode BOOLEAN,
  "object" TEXT,
  refunded BOOLEAN,
  refunds stripe_disputes.application_fee_refund,
  balance_transaction JSONB DEFAULT NULL,
  fee_source stripe_disputes.application_fee_fee_source DEFAULT NULL,
  originating_transaction JSONB DEFAULT NULL
)
RETURNS stripe_disputes.application_fee
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    account,
    amount,
    amount_refunded,
    application,
    charge,
    created,
    currency,
    livemode,
    "object",
    refunded,
    refunds,
    balance_transaction,
    fee_source,
    originating_transaction
  )::stripe_disputes.application_fee;
$$;

ALTER TYPE stripe_disputes.application_fee_refund
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_application_fee_refund(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_disputes.application_fee_refund
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_disputes.application_fee_refund;
$$;

ALTER TYPE stripe_disputes.application_fee_fee_source
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE charge TEXT,
  ADD ATTRIBUTE payout TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_application_fee_fee_source(
  "type" TEXT, charge TEXT DEFAULT NULL, payout TEXT DEFAULT NULL
)
RETURNS stripe_disputes.application_fee_fee_source
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", charge, payout
  )::stripe_disputes.application_fee_fee_source;
$$;

ALTER TYPE stripe_disputes.balance_transaction
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE available_on BIGINT,
  ADD ATTRIBUTE balance_type TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE fee BIGINT,
  ADD ATTRIBUTE fee_details stripe_disputes.balance_transaction_fee_detail[],
  ADD ATTRIBUTE net BIGINT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE reporting_category TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE exchange_rate DOUBLE PRECISION,
  ADD ATTRIBUTE "source" JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.make_balance_transaction(
  "id" TEXT,
  amount BIGINT,
  available_on BIGINT,
  balance_type TEXT,
  created BIGINT,
  currency TEXT,
  fee BIGINT,
  fee_details stripe_disputes.balance_transaction_fee_detail[],
  net BIGINT,
  "object" TEXT,
  reporting_category TEXT,
  status TEXT,
  "type" TEXT,
  description TEXT DEFAULT NULL,
  exchange_rate DOUBLE PRECISION DEFAULT NULL,
  "source" JSONB DEFAULT NULL
)
RETURNS stripe_disputes.balance_transaction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    available_on,
    balance_type,
    created,
    currency,
    fee,
    fee_details,
    net,
    "object",
    reporting_category,
    status,
    "type",
    description,
    exchange_rate,
    "source"
  )::stripe_disputes.balance_transaction;
$$;

ALTER TYPE stripe_disputes.balance_transaction_fee_detail
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE application TEXT,
  ADD ATTRIBUTE description TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_balance_transaction_fee_detail(
  amount BIGINT,
  currency TEXT,
  "type" TEXT,
  application TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL
)
RETURNS stripe_disputes.balance_transaction_fee_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, currency, "type", application, description
  )::stripe_disputes.balance_transaction_fee_detail;
$$;

ALTER TYPE stripe_disputes.charge
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_captured BIGINT,
  ADD ATTRIBUTE amount_refunded BIGINT,
  ADD ATTRIBUTE billing_details stripe_disputes.charge_billing_detail,
  ADD ATTRIBUTE captured BOOLEAN,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE disputed BOOLEAN,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE paid BOOLEAN,
  ADD ATTRIBUTE refunded BOOLEAN,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE application_fee JSONB,
  ADD ATTRIBUTE application_fee_amount BIGINT,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE calculated_statement_descriptor TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE failure_balance_transaction JSONB,
  ADD ATTRIBUTE failure_code TEXT,
  ADD ATTRIBUTE failure_message TEXT,
  ADD ATTRIBUTE fraud_details stripe_disputes.charge_fraud_detail,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE outcome stripe_disputes.charge_outcome,
  ADD ATTRIBUTE payment_intent JSONB,
  ADD ATTRIBUTE payment_method TEXT,
  ADD ATTRIBUTE payment_method_details JSONB,
  ADD ATTRIBUTE presentment_details stripe.payment_flows_payment_intent_presentment_details,
  ADD ATTRIBUTE radar_options stripe_disputes.charge_radar_option,
  ADD ATTRIBUTE receipt_email TEXT,
  ADD ATTRIBUTE receipt_number TEXT,
  ADD ATTRIBUTE receipt_url TEXT,
  ADD ATTRIBUTE refunds stripe_disputes.charge_refund,
  ADD ATTRIBUTE review JSONB,
  ADD ATTRIBUTE shipping stripe.shipping,
  ADD ATTRIBUTE source_transfer JSONB,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE statement_descriptor_suffix TEXT,
  ADD ATTRIBUTE transfer JSONB,
  ADD ATTRIBUTE transfer_data JSONB,
  ADD ATTRIBUTE transfer_group TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_charge(
  "id" TEXT,
  amount BIGINT,
  amount_captured BIGINT,
  amount_refunded BIGINT,
  billing_details stripe_disputes.charge_billing_detail,
  captured BOOLEAN,
  created BIGINT,
  currency TEXT,
  disputed BOOLEAN,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  paid BOOLEAN,
  refunded BOOLEAN,
  status TEXT,
  application JSONB DEFAULT NULL,
  application_fee JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  balance_transaction JSONB DEFAULT NULL,
  calculated_statement_descriptor TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  failure_balance_transaction JSONB DEFAULT NULL,
  failure_code TEXT DEFAULT NULL,
  failure_message TEXT DEFAULT NULL,
  fraud_details stripe_disputes.charge_fraud_detail DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  outcome stripe_disputes.charge_outcome DEFAULT NULL,
  payment_intent JSONB DEFAULT NULL,
  payment_method TEXT DEFAULT NULL,
  payment_method_details JSONB DEFAULT NULL,
  presentment_details stripe.payment_flows_payment_intent_presentment_details DEFAULT NULL,
  radar_options stripe_disputes.charge_radar_option DEFAULT NULL,
  receipt_email TEXT DEFAULT NULL,
  receipt_number TEXT DEFAULT NULL,
  receipt_url TEXT DEFAULT NULL,
  refunds stripe_disputes.charge_refund DEFAULT NULL,
  review JSONB DEFAULT NULL,
  shipping stripe.shipping DEFAULT NULL,
  source_transfer JSONB DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  statement_descriptor_suffix TEXT DEFAULT NULL,
  transfer JSONB DEFAULT NULL,
  transfer_data JSONB DEFAULT NULL,
  transfer_group TEXT DEFAULT NULL
)
RETURNS stripe_disputes.charge
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    amount_captured,
    amount_refunded,
    billing_details,
    captured,
    created,
    currency,
    disputed,
    livemode,
    metadata,
    "object",
    paid,
    refunded,
    status,
    application,
    application_fee,
    application_fee_amount,
    balance_transaction,
    calculated_statement_descriptor,
    customer,
    description,
    failure_balance_transaction,
    failure_code,
    failure_message,
    fraud_details,
    on_behalf_of,
    outcome,
    payment_intent,
    payment_method,
    payment_method_details,
    presentment_details,
    radar_options,
    receipt_email,
    receipt_number,
    receipt_url,
    refunds,
    review,
    shipping,
    source_transfer,
    statement_descriptor,
    statement_descriptor_suffix,
    transfer,
    transfer_data,
    transfer_group
  )::stripe_disputes.charge;
$$;

ALTER TYPE stripe_disputes.charge_billing_detail
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_charge_billing_detail(
  address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  tax_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.charge_billing_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address, email, "name", phone, tax_id
  )::stripe_disputes.charge_billing_detail;
$$;

ALTER TYPE stripe_disputes.charge_fraud_detail
  ADD ATTRIBUTE stripe_report TEXT, ADD ATTRIBUTE user_report TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_charge_fraud_detail(
  stripe_report TEXT DEFAULT NULL, user_report TEXT DEFAULT NULL
)
RETURNS stripe_disputes.charge_fraud_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(stripe_report, user_report)::stripe_disputes.charge_fraud_detail;
$$;

ALTER TYPE stripe_disputes.charge_outcome
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE advice_code TEXT,
  ADD ATTRIBUTE network_advice_code TEXT,
  ADD ATTRIBUTE network_decline_code TEXT,
  ADD ATTRIBUTE network_status TEXT,
  ADD ATTRIBUTE reason TEXT,
  ADD ATTRIBUTE risk_level TEXT,
  ADD ATTRIBUTE risk_score BIGINT,
  ADD ATTRIBUTE "rule" JSONB,
  ADD ATTRIBUTE seller_message TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_charge_outcome(
  "type" TEXT,
  advice_code TEXT DEFAULT NULL,
  network_advice_code TEXT DEFAULT NULL,
  network_decline_code TEXT DEFAULT NULL,
  network_status TEXT DEFAULT NULL,
  reason TEXT DEFAULT NULL,
  risk_level TEXT DEFAULT NULL,
  risk_score BIGINT DEFAULT NULL,
  "rule" JSONB DEFAULT NULL,
  seller_message TEXT DEFAULT NULL
)
RETURNS stripe_disputes.charge_outcome
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    advice_code,
    network_advice_code,
    network_decline_code,
    network_status,
    reason,
    risk_level,
    risk_score,
    "rule",
    seller_message
  )::stripe_disputes.charge_outcome;
$$;

ALTER TYPE stripe_disputes.charge_radar_option
  ADD ATTRIBUTE "session" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_charge_radar_option(
  "session" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.charge_radar_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("session")::stripe_disputes.charge_radar_option;
$$;

ALTER TYPE stripe_disputes.charge_refund
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_charge_refund(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_disputes.charge_refund
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("data", has_more, "object", url)::stripe_disputes.charge_refund;
$$;

ALTER TYPE stripe_disputes.charge_transfer_data
  ADD ATTRIBUTE destination JSONB, ADD ATTRIBUTE amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_charge_transfer_data(
  destination JSONB, amount BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.charge_transfer_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(destination, amount)::stripe_disputes.charge_transfer_data;
$$;

ALTER TYPE stripe_disputes.connect_collection_transfer
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE destination JSONB,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_connect_collection_transfer(
  "id" TEXT,
  amount BIGINT,
  currency TEXT,
  destination JSONB,
  livemode BOOLEAN,
  "object" TEXT
)
RETURNS stripe_disputes.connect_collection_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id", amount, currency, destination, livemode, "object"
  )::stripe_disputes.connect_collection_transfer;
$$;

ALTER TYPE stripe_disputes.c_b_resource_cash_balance_transaction_adjusted_for_overdraft
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE linked_transaction JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_b_resource_cash_balance_transaction_adjusted_for_overdraft(
  balance_transaction JSONB, linked_transaction JSONB
)
RETURNS stripe_disputes.c_b_resource_cash_balance_transaction_adjusted_for_overdraft
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    balance_transaction, linked_transaction
  )::stripe_disputes.c_b_resource_cash_balance_transaction_adjusted_for_overdraft;
$$;

ALTER TYPE stripe_disputes.c_balance_resource_cash_balance_transaction_applied_to_payment
  ADD ATTRIBUTE payment_intent JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_b_resource_cash_balance_transaction_applied_to_payment(
  payment_intent JSONB
)
RETURNS stripe_disputes.c_balance_resource_cash_balance_transaction_applied_to_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_intent
  )::stripe_disputes.c_balance_resource_cash_balance_transaction_applied_to_payment;
$$;

ALTER TYPE stripe_disputes.c_b_resource_cash_balance_transaction_refunded_from_payment
  ADD ATTRIBUTE refund JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_b_resource_cash_balance_transaction_refunded_from_payment(
  refund JSONB
)
RETURNS stripe_disputes.c_b_resource_cash_balance_transaction_refunded_from_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    refund
  )::stripe_disputes.c_b_resource_cash_balance_transaction_refunded_from_payment;
$$;

ALTER TYPE stripe_disputes.c_b_resource_cash_balance_transaction_transferred_to_balance
  ADD ATTRIBUTE balance_transaction JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_b_resource_cash_balance_transaction_transferred_to_balance(
  balance_transaction JSONB
)
RETURNS stripe_disputes.c_b_resource_cash_balance_transaction_transferred_to_balance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    balance_transaction
  )::stripe_disputes.c_b_resource_cash_balance_transaction_transferred_to_balance;
$$;

ALTER TYPE stripe_disputes.c_b_resource_cash_balance_transaction_unapplied_from_payment
  ADD ATTRIBUTE payment_intent JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_b_resource_cash_balance_transaction_unapplied_from_payment(
  payment_intent JSONB
)
RETURNS stripe_disputes.c_b_resource_cash_balance_transaction_unapplied_from_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_intent
  )::stripe_disputes.c_b_resource_cash_balance_transaction_unapplied_from_payment;
$$;

ALTER TYPE stripe_disputes.customer_cash_balance_transaction
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE ending_balance BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE net_amount BIGINT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE adjusted_for_overdraft JSONB,
  ADD ATTRIBUTE applied_to_payment JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE funded stripe_disputes.customer_cash_balance_transaction_funded,
  ADD ATTRIBUTE refunded_from_payment JSONB,
  ADD ATTRIBUTE transferred_to_balance JSONB,
  ADD ATTRIBUTE unapplied_from_payment JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.make_customer_cash_balance_transaction(
  "id" TEXT,
  created BIGINT,
  currency TEXT,
  customer JSONB,
  ending_balance BIGINT,
  livemode BOOLEAN,
  net_amount BIGINT,
  "object" TEXT,
  "type" TEXT,
  adjusted_for_overdraft JSONB DEFAULT NULL,
  applied_to_payment JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  funded stripe_disputes.customer_cash_balance_transaction_funded DEFAULT NULL,
  refunded_from_payment JSONB DEFAULT NULL,
  transferred_to_balance JSONB DEFAULT NULL,
  unapplied_from_payment JSONB DEFAULT NULL
)
RETURNS stripe_disputes.customer_cash_balance_transaction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    currency,
    customer,
    ending_balance,
    livemode,
    net_amount,
    "object",
    "type",
    adjusted_for_overdraft,
    applied_to_payment,
    customer_account,
    funded,
    refunded_from_payment,
    transferred_to_balance,
    unapplied_from_payment
  )::stripe_disputes.customer_cash_balance_transaction;
$$;

ALTER TYPE stripe_disputes.customer_cash_balance_transaction_funded
  ADD ATTRIBUTE bank_transfer stripe_disputes.customer_cash_balance_transaction_funded_bank_transfer;

CREATE OR REPLACE FUNCTION stripe_disputes.make_customer_cash_balance_transaction_funded(
  bank_transfer stripe_disputes.customer_cash_balance_transaction_funded_bank_transfer
)
RETURNS stripe_disputes.customer_cash_balance_transaction_funded
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_transfer
  )::stripe_disputes.customer_cash_balance_transaction_funded;
$$;

ALTER TYPE stripe_disputes.customer_cash_balance_transaction_funded_bank_transfer
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE eu_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_eu_bank_transfer,
  ADD ATTRIBUTE gb_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_gb_bank_transfer,
  ADD ATTRIBUTE jp_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_jp_bank_transfer,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE us_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_us_bank_transfer;

CREATE OR REPLACE FUNCTION stripe_disputes.make_customer_cash_balance_transaction_funded_bank_transfer(
  "type" TEXT,
  eu_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_eu_bank_transfer DEFAULT NULL,
  gb_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_gb_bank_transfer DEFAULT NULL,
  jp_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_jp_bank_transfer DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  us_bank_transfer stripe_disputes.c_c_balance_transaction_funded_bank_transfer_us_bank_transfer DEFAULT NULL
)
RETURNS stripe_disputes.customer_cash_balance_transaction_funded_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    eu_bank_transfer,
    gb_bank_transfer,
    jp_bank_transfer,
    reference,
    us_bank_transfer
  )::stripe_disputes.customer_cash_balance_transaction_funded_bank_transfer;
$$;

ALTER TYPE stripe_disputes.c_c_balance_transaction_funded_bank_transfer_eu_bank_transfer
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE sender_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_c_balance_transaction_funded_bank_transfer_eu_bank_transfer(
  bic TEXT DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  sender_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.c_c_balance_transaction_funded_bank_transfer_eu_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bic, iban_last4, sender_name
  )::stripe_disputes.c_c_balance_transaction_funded_bank_transfer_eu_bank_transfer;
$$;

ALTER TYPE stripe_disputes.c_c_balance_transaction_funded_bank_transfer_gb_bank_transfer
  ADD ATTRIBUTE account_number_last4 TEXT,
  ADD ATTRIBUTE sender_name TEXT,
  ADD ATTRIBUTE sort_code TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_c_balance_transaction_funded_bank_transfer_gb_bank_transfer(
  account_number_last4 TEXT DEFAULT NULL,
  sender_name TEXT DEFAULT NULL,
  sort_code TEXT DEFAULT NULL
)
RETURNS stripe_disputes.c_c_balance_transaction_funded_bank_transfer_gb_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_number_last4, sender_name, sort_code
  )::stripe_disputes.c_c_balance_transaction_funded_bank_transfer_gb_bank_transfer;
$$;

ALTER TYPE stripe_disputes.c_c_balance_transaction_funded_bank_transfer_jp_bank_transfer
  ADD ATTRIBUTE sender_bank TEXT,
  ADD ATTRIBUTE sender_branch TEXT,
  ADD ATTRIBUTE sender_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_c_balance_transaction_funded_bank_transfer_jp_bank_transfer(
  sender_bank TEXT DEFAULT NULL,
  sender_branch TEXT DEFAULT NULL,
  sender_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.c_c_balance_transaction_funded_bank_transfer_jp_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    sender_bank, sender_branch, sender_name
  )::stripe_disputes.c_c_balance_transaction_funded_bank_transfer_jp_bank_transfer;
$$;

ALTER TYPE stripe_disputes.c_c_balance_transaction_funded_bank_transfer_us_bank_transfer
  ADD ATTRIBUTE network TEXT, ADD ATTRIBUTE sender_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_c_c_balance_transaction_funded_bank_transfer_us_bank_transfer(
  network TEXT DEFAULT NULL, sender_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.c_c_balance_transaction_funded_bank_transfer_us_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    network, sender_name
  )::stripe_disputes.c_c_balance_transaction_funded_bank_transfer_us_bank_transfer;
$$;

ALTER TYPE stripe_disputes.dispute
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE balance_transactions JSONB[],
  ADD ATTRIBUTE charge JSONB,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE enhanced_eligibility_types TEXT[],
  ADD ATTRIBUTE evidence stripe_disputes.dispute_evidence,
  ADD ATTRIBUTE evidence_details stripe_disputes.dispute_evidence_detail,
  ADD ATTRIBUTE is_charge_refundable BOOLEAN,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE reason TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE payment_intent JSONB,
  ADD ATTRIBUTE payment_method_details stripe_disputes.dispute_payment_method_detail;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute(
  "id" TEXT,
  amount BIGINT,
  balance_transactions JSONB[],
  charge JSONB,
  created BIGINT,
  currency TEXT,
  enhanced_eligibility_types TEXT[],
  evidence stripe_disputes.dispute_evidence,
  evidence_details stripe_disputes.dispute_evidence_detail,
  is_charge_refundable BOOLEAN,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  reason TEXT,
  status TEXT,
  payment_intent JSONB DEFAULT NULL,
  payment_method_details stripe_disputes.dispute_payment_method_detail DEFAULT NULL
)
RETURNS stripe_disputes.dispute
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    balance_transactions,
    charge,
    created,
    currency,
    enhanced_eligibility_types,
    evidence,
    evidence_details,
    is_charge_refundable,
    livemode,
    metadata,
    "object",
    reason,
    status,
    payment_intent,
    payment_method_details
  )::stripe_disputes.dispute;
$$;

ALTER TYPE stripe_disputes.dispute_evidence
  ADD ATTRIBUTE enhanced_evidence stripe_disputes.dispute_evidence_enhanced_evidence,
  ADD ATTRIBUTE access_activity_log TEXT,
  ADD ATTRIBUTE billing_address TEXT,
  ADD ATTRIBUTE cancellation_policy JSONB,
  ADD ATTRIBUTE cancellation_policy_disclosure TEXT,
  ADD ATTRIBUTE cancellation_rebuttal TEXT,
  ADD ATTRIBUTE customer_communication JSONB,
  ADD ATTRIBUTE customer_email_address TEXT,
  ADD ATTRIBUTE customer_name TEXT,
  ADD ATTRIBUTE customer_purchase_ip TEXT,
  ADD ATTRIBUTE customer_signature JSONB,
  ADD ATTRIBUTE duplicate_charge_documentation JSONB,
  ADD ATTRIBUTE duplicate_charge_explanation TEXT,
  ADD ATTRIBUTE duplicate_charge_id TEXT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE receipt JSONB,
  ADD ATTRIBUTE refund_policy JSONB,
  ADD ATTRIBUTE refund_policy_disclosure TEXT,
  ADD ATTRIBUTE refund_refusal_explanation TEXT,
  ADD ATTRIBUTE service_date TEXT,
  ADD ATTRIBUTE service_documentation JSONB,
  ADD ATTRIBUTE shipping_address TEXT,
  ADD ATTRIBUTE shipping_carrier TEXT,
  ADD ATTRIBUTE shipping_date TEXT,
  ADD ATTRIBUTE shipping_documentation JSONB,
  ADD ATTRIBUTE shipping_tracking_number TEXT,
  ADD ATTRIBUTE uncategorized_file JSONB,
  ADD ATTRIBUTE uncategorized_text TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_evidence(
  enhanced_evidence stripe_disputes.dispute_evidence_enhanced_evidence,
  access_activity_log TEXT DEFAULT NULL,
  billing_address TEXT DEFAULT NULL,
  cancellation_policy JSONB DEFAULT NULL,
  cancellation_policy_disclosure TEXT DEFAULT NULL,
  cancellation_rebuttal TEXT DEFAULT NULL,
  customer_communication JSONB DEFAULT NULL,
  customer_email_address TEXT DEFAULT NULL,
  customer_name TEXT DEFAULT NULL,
  customer_purchase_ip TEXT DEFAULT NULL,
  customer_signature JSONB DEFAULT NULL,
  duplicate_charge_documentation JSONB DEFAULT NULL,
  duplicate_charge_explanation TEXT DEFAULT NULL,
  duplicate_charge_id TEXT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  receipt JSONB DEFAULT NULL,
  refund_policy JSONB DEFAULT NULL,
  refund_policy_disclosure TEXT DEFAULT NULL,
  refund_refusal_explanation TEXT DEFAULT NULL,
  service_date TEXT DEFAULT NULL,
  service_documentation JSONB DEFAULT NULL,
  shipping_address TEXT DEFAULT NULL,
  shipping_carrier TEXT DEFAULT NULL,
  shipping_date TEXT DEFAULT NULL,
  shipping_documentation JSONB DEFAULT NULL,
  shipping_tracking_number TEXT DEFAULT NULL,
  uncategorized_file JSONB DEFAULT NULL,
  uncategorized_text TEXT DEFAULT NULL
)
RETURNS stripe_disputes.dispute_evidence
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enhanced_evidence,
    access_activity_log,
    billing_address,
    cancellation_policy,
    cancellation_policy_disclosure,
    cancellation_rebuttal,
    customer_communication,
    customer_email_address,
    customer_name,
    customer_purchase_ip,
    customer_signature,
    duplicate_charge_documentation,
    duplicate_charge_explanation,
    duplicate_charge_id,
    product_description,
    receipt,
    refund_policy,
    refund_policy_disclosure,
    refund_refusal_explanation,
    service_date,
    service_documentation,
    shipping_address,
    shipping_carrier,
    shipping_date,
    shipping_documentation,
    shipping_tracking_number,
    uncategorized_file,
    uncategorized_text
  )::stripe_disputes.dispute_evidence;
$$;

ALTER TYPE stripe_disputes.dispute_evidence_enhanced_evidence
  ADD ATTRIBUTE visa_compelling_evidence_3 stripe_disputes.dispute_evidence_enhanced_evidence_visa_compelling_evidence_3,
  ADD ATTRIBUTE visa_compliance stripe_disputes.dispute_evidence_enhanced_evidence_visa_compliance;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_evidence_enhanced_evidence(
  visa_compelling_evidence_3 stripe_disputes.dispute_evidence_enhanced_evidence_visa_compelling_evidence_3 DEFAULT NULL,
  visa_compliance stripe_disputes.dispute_evidence_enhanced_evidence_visa_compliance DEFAULT NULL
)
RETURNS stripe_disputes.dispute_evidence_enhanced_evidence
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    visa_compelling_evidence_3, visa_compliance
  )::stripe_disputes.dispute_evidence_enhanced_evidence;
$$;

ALTER TYPE stripe_disputes.dispute_evidence_enhanced_evidence_visa_compelling_evidence_3
  ADD ATTRIBUTE prior_undisputed_transactions stripe_disputes.d_e_e_e_visa_compelling_evidence_3_prior_undisputed_transaction[],
  ADD ATTRIBUTE disputed_transaction stripe_disputes.d_e_e_evidence_visa_compelling_evidence_3_disputed_transaction;

CREATE OR REPLACE FUNCTION stripe_disputes.m_dispute_evidence_enhanced_evidence_visa_compelling_evidence_3(
  prior_undisputed_transactions stripe_disputes.d_e_e_e_visa_compelling_evidence_3_prior_undisputed_transaction[],
  disputed_transaction stripe_disputes.d_e_e_evidence_visa_compelling_evidence_3_disputed_transaction DEFAULT NULL
)
RETURNS stripe_disputes.dispute_evidence_enhanced_evidence_visa_compelling_evidence_3
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    prior_undisputed_transactions, disputed_transaction
  )::stripe_disputes.dispute_evidence_enhanced_evidence_visa_compelling_evidence_3;
$$;

ALTER TYPE stripe_disputes.d_e_e_e_visa_compelling_evidence_3_prior_undisputed_transaction
  ADD ATTRIBUTE charge TEXT,
  ADD ATTRIBUTE customer_account_id TEXT,
  ADD ATTRIBUTE customer_device_fingerprint TEXT,
  ADD ATTRIBUTE customer_device_id TEXT,
  ADD ATTRIBUTE customer_email_address TEXT,
  ADD ATTRIBUTE customer_purchase_ip TEXT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE shipping_address stripe_disputes.d_e_e_e_v_c_e_3_prior_undisputed_transaction_shipping_address;

CREATE OR REPLACE FUNCTION stripe_disputes.m_d_e_e_e_v_compelling_evidence_3_prior_undisputed_transaction(
  charge TEXT,
  customer_account_id TEXT DEFAULT NULL,
  customer_device_fingerprint TEXT DEFAULT NULL,
  customer_device_id TEXT DEFAULT NULL,
  customer_email_address TEXT DEFAULT NULL,
  customer_purchase_ip TEXT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  shipping_address stripe_disputes.d_e_e_e_v_c_e_3_prior_undisputed_transaction_shipping_address DEFAULT NULL
)
RETURNS stripe_disputes.d_e_e_e_visa_compelling_evidence_3_prior_undisputed_transaction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    charge,
    customer_account_id,
    customer_device_fingerprint,
    customer_device_id,
    customer_email_address,
    customer_purchase_ip,
    product_description,
    shipping_address
  )::stripe_disputes.d_e_e_e_visa_compelling_evidence_3_prior_undisputed_transaction;
$$;

ALTER TYPE stripe_disputes.d_e_e_e_v_c_e_3_prior_undisputed_transaction_shipping_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_d_e_e_e_v_c_e_3_prior_undisputed_transaction_shipping_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.d_e_e_e_v_c_e_3_prior_undisputed_transaction_shipping_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, "state"
  )::stripe_disputes.d_e_e_e_v_c_e_3_prior_undisputed_transaction_shipping_address;
$$;

ALTER TYPE stripe_disputes.d_e_e_evidence_visa_compelling_evidence_3_disputed_transaction
  ADD ATTRIBUTE customer_account_id TEXT,
  ADD ATTRIBUTE customer_device_fingerprint TEXT,
  ADD ATTRIBUTE customer_device_id TEXT,
  ADD ATTRIBUTE customer_email_address TEXT,
  ADD ATTRIBUTE customer_purchase_ip TEXT,
  ADD ATTRIBUTE merchandise_or_services TEXT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE shipping_address stripe_disputes.d_e_e_e_v_c_evidence_3_disputed_transaction_shipping_address;

CREATE OR REPLACE FUNCTION stripe_disputes.m_d_e_e_e_visa_compelling_evidence_3_disputed_transaction(
  customer_account_id TEXT DEFAULT NULL,
  customer_device_fingerprint TEXT DEFAULT NULL,
  customer_device_id TEXT DEFAULT NULL,
  customer_email_address TEXT DEFAULT NULL,
  customer_purchase_ip TEXT DEFAULT NULL,
  merchandise_or_services TEXT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  shipping_address stripe_disputes.d_e_e_e_v_c_evidence_3_disputed_transaction_shipping_address DEFAULT NULL
)
RETURNS stripe_disputes.d_e_e_evidence_visa_compelling_evidence_3_disputed_transaction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    customer_account_id,
    customer_device_fingerprint,
    customer_device_id,
    customer_email_address,
    customer_purchase_ip,
    merchandise_or_services,
    product_description,
    shipping_address
  )::stripe_disputes.d_e_e_evidence_visa_compelling_evidence_3_disputed_transaction;
$$;

ALTER TYPE stripe_disputes.d_e_e_e_v_c_evidence_3_disputed_transaction_shipping_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_d_e_e_e_v_c_evidence_3_disputed_transaction_shipping_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.d_e_e_e_v_c_evidence_3_disputed_transaction_shipping_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, "state"
  )::stripe_disputes.d_e_e_e_v_c_evidence_3_disputed_transaction_shipping_address;
$$;

ALTER TYPE stripe_disputes.dispute_evidence_enhanced_evidence_visa_compliance
  ADD ATTRIBUTE fee_acknowledged BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_evidence_enhanced_evidence_visa_compliance(
  fee_acknowledged BOOLEAN
)
RETURNS stripe_disputes.dispute_evidence_enhanced_evidence_visa_compliance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fee_acknowledged
  )::stripe_disputes.dispute_evidence_enhanced_evidence_visa_compliance;
$$;

ALTER TYPE stripe_disputes.dispute_evidence_detail
  ADD ATTRIBUTE enhanced_eligibility stripe_disputes.dispute_evidence_detail_enhanced_eligibility,
  ADD ATTRIBUTE has_evidence BOOLEAN,
  ADD ATTRIBUTE past_due BOOLEAN,
  ADD ATTRIBUTE submission_count BIGINT,
  ADD ATTRIBUTE due_by BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_evidence_detail(
  enhanced_eligibility stripe_disputes.dispute_evidence_detail_enhanced_eligibility,
  has_evidence BOOLEAN,
  past_due BOOLEAN,
  submission_count BIGINT,
  due_by BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.dispute_evidence_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enhanced_eligibility, has_evidence, past_due, submission_count, due_by
  )::stripe_disputes.dispute_evidence_detail;
$$;

ALTER TYPE stripe_disputes.dispute_evidence_detail_enhanced_eligibility
  ADD ATTRIBUTE visa_compelling_evidence_3 stripe_disputes.d_e_detail_enhanced_eligibility_visa_compelling_evidence_3,
  ADD ATTRIBUTE visa_compliance stripe_disputes.dispute_evidence_detail_enhanced_eligibility_visa_compliance;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_evidence_detail_enhanced_eligibility(
  visa_compelling_evidence_3 stripe_disputes.d_e_detail_enhanced_eligibility_visa_compelling_evidence_3 DEFAULT NULL,
  visa_compliance stripe_disputes.dispute_evidence_detail_enhanced_eligibility_visa_compliance DEFAULT NULL
)
RETURNS stripe_disputes.dispute_evidence_detail_enhanced_eligibility
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    visa_compelling_evidence_3, visa_compliance
  )::stripe_disputes.dispute_evidence_detail_enhanced_eligibility;
$$;

ALTER TYPE stripe_disputes.d_e_detail_enhanced_eligibility_visa_compelling_evidence_3
  ADD ATTRIBUTE required_actions TEXT[], ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_d_e_detail_enhanced_eligibility_visa_compelling_evidence_3(
  required_actions TEXT[], status TEXT
)
RETURNS stripe_disputes.d_e_detail_enhanced_eligibility_visa_compelling_evidence_3
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    required_actions, status
  )::stripe_disputes.d_e_detail_enhanced_eligibility_visa_compelling_evidence_3;
$$;

ALTER TYPE stripe_disputes.dispute_evidence_detail_enhanced_eligibility_visa_compliance
  ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_dispute_evidence_detail_enhanced_eligibility_visa_compliance(
  status TEXT
)
RETURNS stripe_disputes.dispute_evidence_detail_enhanced_eligibility_visa_compliance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status
  )::stripe_disputes.dispute_evidence_detail_enhanced_eligibility_visa_compliance;
$$;

ALTER TYPE stripe_disputes.dispute_payment_method_detail
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE amazon_pay stripe_disputes.dispute_payment_method_detail_amazon_pay,
  ADD ATTRIBUTE card stripe_disputes.dispute_payment_method_detail_card,
  ADD ATTRIBUTE klarna stripe_disputes.dispute_payment_method_detail_klarna,
  ADD ATTRIBUTE paypal stripe_disputes.dispute_payment_method_detail_paypal;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_payment_method_detail(
  "type" TEXT,
  amazon_pay stripe_disputes.dispute_payment_method_detail_amazon_pay DEFAULT NULL,
  card stripe_disputes.dispute_payment_method_detail_card DEFAULT NULL,
  klarna stripe_disputes.dispute_payment_method_detail_klarna DEFAULT NULL,
  paypal stripe_disputes.dispute_payment_method_detail_paypal DEFAULT NULL
)
RETURNS stripe_disputes.dispute_payment_method_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", amazon_pay, card, klarna, paypal
  )::stripe_disputes.dispute_payment_method_detail;
$$;

ALTER TYPE stripe_disputes.dispute_payment_method_detail_amazon_pay
  ADD ATTRIBUTE dispute_type TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_payment_method_detail_amazon_pay(
  dispute_type TEXT DEFAULT NULL
)
RETURNS stripe_disputes.dispute_payment_method_detail_amazon_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    dispute_type
  )::stripe_disputes.dispute_payment_method_detail_amazon_pay;
$$;

ALTER TYPE stripe_disputes.dispute_payment_method_detail_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE case_type TEXT,
  ADD ATTRIBUTE network_reason_code TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_payment_method_detail_card(
  brand TEXT, case_type TEXT, network_reason_code TEXT DEFAULT NULL
)
RETURNS stripe_disputes.dispute_payment_method_detail_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, case_type, network_reason_code
  )::stripe_disputes.dispute_payment_method_detail_card;
$$;

ALTER TYPE stripe_disputes.dispute_payment_method_detail_klarna
  ADD ATTRIBUTE chargeback_loss_reason_code TEXT,
  ADD ATTRIBUTE reason_code TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_payment_method_detail_klarna(
  chargeback_loss_reason_code TEXT DEFAULT NULL, reason_code TEXT DEFAULT NULL
)
RETURNS stripe_disputes.dispute_payment_method_detail_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    chargeback_loss_reason_code, reason_code
  )::stripe_disputes.dispute_payment_method_detail_klarna;
$$;

ALTER TYPE stripe_disputes.dispute_payment_method_detail_paypal
  ADD ATTRIBUTE case_id TEXT, ADD ATTRIBUTE reason_code TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_dispute_payment_method_detail_paypal(
  case_id TEXT DEFAULT NULL, reason_code TEXT DEFAULT NULL
)
RETURNS stripe_disputes.dispute_payment_method_detail_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    case_id, reason_code
  )::stripe_disputes.dispute_payment_method_detail_paypal;
$$;

ALTER TYPE stripe_disputes.fee_refund
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE fee JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE metadata JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.make_fee_refund(
  "id" TEXT,
  amount BIGINT,
  created BIGINT,
  currency TEXT,
  fee JSONB,
  "object" TEXT,
  balance_transaction JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL
)
RETURNS stripe_disputes.fee_refund
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    created,
    currency,
    fee,
    "object",
    balance_transaction,
    metadata
  )::stripe_disputes.fee_refund;
$$;

ALTER TYPE stripe_disputes.file
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE purpose TEXT,
  ADD ATTRIBUTE "size" BIGINT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE filename TEXT,
  ADD ATTRIBUTE links stripe_disputes.file_link,
  ADD ATTRIBUTE title TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_file(
  "id" TEXT,
  created BIGINT,
  "object" TEXT,
  purpose TEXT,
  "size" BIGINT,
  expires_at BIGINT DEFAULT NULL,
  filename TEXT DEFAULT NULL,
  links stripe_disputes.file_link DEFAULT NULL,
  title TEXT DEFAULT NULL,
  "type" TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_disputes.file
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    "object",
    purpose,
    "size",
    expires_at,
    filename,
    links,
    title,
    "type",
    url
  )::stripe_disputes.file;
$$;

ALTER TYPE stripe_disputes.file_link
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_file_link(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_disputes.file_link
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("data", has_more, "object", url)::stripe_disputes.file_link;
$$;

ALTER TYPE stripe_disputes.file_link1
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE expired BOOLEAN,
  ADD ATTRIBUTE "file" JSONB,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_file_link1(
  "id" TEXT,
  created BIGINT,
  expired BOOLEAN,
  "file" JSONB,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  expires_at BIGINT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_disputes.file_link1
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    expired,
    "file",
    livemode,
    metadata,
    "object",
    expires_at,
    url
  )::stripe_disputes.file_link1;
$$;

ALTER TYPE stripe_disputes.issuing_authorization
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE approved BOOLEAN,
  ADD ATTRIBUTE authorization_method TEXT,
  ADD ATTRIBUTE balance_transactions JSONB[],
  ADD ATTRIBUTE card stripe_disputes.issuing_card,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE merchant_amount BIGINT,
  ADD ATTRIBUTE merchant_currency TEXT,
  ADD ATTRIBUTE merchant_data stripe_disputes.issuing_authorization_merchant_data,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE request_history stripe_disputes.issuing_authorization_request_history[],
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE transactions JSONB[],
  ADD ATTRIBUTE verification_data stripe_disputes.issuing_authorization_verification_data,
  ADD ATTRIBUTE "token" JSONB,
  ADD ATTRIBUTE amount_details stripe_disputes.issuing_authorization_amount_details,
  ADD ATTRIBUTE cardholder JSONB,
  ADD ATTRIBUTE fleet stripe_disputes.issuing_authorization_fleet,
  ADD ATTRIBUTE fraud_challenges stripe_disputes.issuing_authorization_fraud_challenge[],
  ADD ATTRIBUTE fuel stripe_disputes.issuing_authorization_fuel,
  ADD ATTRIBUTE network_data stripe_disputes.issuing_authorization_network_data,
  ADD ATTRIBUTE pending_request stripe_disputes.issuing_authorization_pending_request,
  ADD ATTRIBUTE treasury stripe_disputes.issuing_authorization_treasury,
  ADD ATTRIBUTE verified_by_fraud_challenge BOOLEAN,
  ADD ATTRIBUTE wallet TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization(
  "id" TEXT,
  amount BIGINT,
  approved BOOLEAN,
  authorization_method TEXT,
  balance_transactions JSONB[],
  card stripe_disputes.issuing_card,
  created BIGINT,
  currency TEXT,
  livemode BOOLEAN,
  merchant_amount BIGINT,
  merchant_currency TEXT,
  merchant_data stripe_disputes.issuing_authorization_merchant_data,
  metadata JSONB,
  "object" TEXT,
  request_history stripe_disputes.issuing_authorization_request_history[],
  status TEXT,
  transactions JSONB[],
  verification_data stripe_disputes.issuing_authorization_verification_data,
  "token" JSONB DEFAULT NULL,
  amount_details stripe_disputes.issuing_authorization_amount_details DEFAULT NULL,
  cardholder JSONB DEFAULT NULL,
  fleet stripe_disputes.issuing_authorization_fleet DEFAULT NULL,
  fraud_challenges stripe_disputes.issuing_authorization_fraud_challenge[] DEFAULT NULL,
  fuel stripe_disputes.issuing_authorization_fuel DEFAULT NULL,
  network_data stripe_disputes.issuing_authorization_network_data DEFAULT NULL,
  pending_request stripe_disputes.issuing_authorization_pending_request DEFAULT NULL,
  treasury stripe_disputes.issuing_authorization_treasury DEFAULT NULL,
  verified_by_fraud_challenge BOOLEAN DEFAULT NULL,
  wallet TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    approved,
    authorization_method,
    balance_transactions,
    card,
    created,
    currency,
    livemode,
    merchant_amount,
    merchant_currency,
    merchant_data,
    metadata,
    "object",
    request_history,
    status,
    transactions,
    verification_data,
    "token",
    amount_details,
    cardholder,
    fleet,
    fraud_challenges,
    fuel,
    network_data,
    pending_request,
    treasury,
    verified_by_fraud_challenge,
    wallet
  )::stripe_disputes.issuing_authorization;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_merchant_data
  ADD ATTRIBUTE category TEXT,
  ADD ATTRIBUTE category_code TEXT,
  ADD ATTRIBUTE network_id TEXT,
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT,
  ADD ATTRIBUTE tax_id TEXT,
  ADD ATTRIBUTE terminal_id TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_merchant_data(
  category TEXT,
  category_code TEXT,
  network_id TEXT,
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL,
  tax_id TEXT DEFAULT NULL,
  terminal_id TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_merchant_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    category,
    category_code,
    network_id,
    city,
    country,
    "name",
    postal_code,
    "state",
    tax_id,
    terminal_id,
    url
  )::stripe_disputes.issuing_authorization_merchant_data;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_request_history
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE approved BOOLEAN,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE merchant_amount BIGINT,
  ADD ATTRIBUTE merchant_currency TEXT,
  ADD ATTRIBUTE reason TEXT,
  ADD ATTRIBUTE amount_details stripe_disputes.issuing_authorization_amount_details,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE network_risk_score BIGINT,
  ADD ATTRIBUTE reason_message TEXT,
  ADD ATTRIBUTE requested_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_request_history(
  amount BIGINT,
  approved BOOLEAN,
  created BIGINT,
  currency TEXT,
  merchant_amount BIGINT,
  merchant_currency TEXT,
  reason TEXT,
  amount_details stripe_disputes.issuing_authorization_amount_details DEFAULT NULL,
  authorization_code TEXT DEFAULT NULL,
  network_risk_score BIGINT DEFAULT NULL,
  reason_message TEXT DEFAULT NULL,
  requested_at BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_request_history
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    approved,
    created,
    currency,
    merchant_amount,
    merchant_currency,
    reason,
    amount_details,
    authorization_code,
    network_risk_score,
    reason_message,
    requested_at
  )::stripe_disputes.issuing_authorization_request_history;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_verification_data
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_postal_code_check TEXT,
  ADD ATTRIBUTE cvc_check TEXT,
  ADD ATTRIBUTE expiry_check TEXT,
  ADD ATTRIBUTE authentication_exemption stripe_disputes.i_authorization_verification_data_authentication_exemption,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE three_d_secure stripe_disputes.issuing_authorization_verification_data_three_d_secure;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_verification_data(
  address_line1_check TEXT,
  address_postal_code_check TEXT,
  cvc_check TEXT,
  expiry_check TEXT,
  authentication_exemption stripe_disputes.i_authorization_verification_data_authentication_exemption DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  three_d_secure stripe_disputes.issuing_authorization_verification_data_three_d_secure DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_verification_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check,
    address_postal_code_check,
    cvc_check,
    expiry_check,
    authentication_exemption,
    postal_code,
    three_d_secure
  )::stripe_disputes.issuing_authorization_verification_data;
$$;

ALTER TYPE stripe_disputes.i_authorization_verification_data_authentication_exemption
  ADD ATTRIBUTE claimed_by TEXT, ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_i_authorization_verification_data_authentication_exemption(
  claimed_by TEXT, "type" TEXT
)
RETURNS stripe_disputes.i_authorization_verification_data_authentication_exemption
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    claimed_by, "type"
  )::stripe_disputes.i_authorization_verification_data_authentication_exemption;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_verification_data_three_d_secure
  ADD ATTRIBUTE "result" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_verification_data_three_d_secure(
  "result" TEXT
)
RETURNS stripe_disputes.issuing_authorization_verification_data_three_d_secure
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "result"
  )::stripe_disputes.issuing_authorization_verification_data_three_d_secure;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fleet
  ADD ATTRIBUTE cardholder_prompt_data stripe_disputes.issuing_authorization_fleet_cardholder_prompt_data,
  ADD ATTRIBUTE purchase_type TEXT,
  ADD ATTRIBUTE reported_breakdown stripe_disputes.issuing_authorization_fleet_reported_breakdown,
  ADD ATTRIBUTE service_type TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fleet(
  cardholder_prompt_data stripe_disputes.issuing_authorization_fleet_cardholder_prompt_data DEFAULT NULL,
  purchase_type TEXT DEFAULT NULL,
  reported_breakdown stripe_disputes.issuing_authorization_fleet_reported_breakdown DEFAULT NULL,
  service_type TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fleet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    cardholder_prompt_data, purchase_type, reported_breakdown, service_type
  )::stripe_disputes.issuing_authorization_fleet;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fleet_cardholder_prompt_data
  ADD ATTRIBUTE alphanumeric_id TEXT,
  ADD ATTRIBUTE driver_id TEXT,
  ADD ATTRIBUTE odometer BIGINT,
  ADD ATTRIBUTE unspecified_id TEXT,
  ADD ATTRIBUTE user_id TEXT,
  ADD ATTRIBUTE vehicle_number TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fleet_cardholder_prompt_data(
  alphanumeric_id TEXT DEFAULT NULL,
  driver_id TEXT DEFAULT NULL,
  odometer BIGINT DEFAULT NULL,
  unspecified_id TEXT DEFAULT NULL,
  user_id TEXT DEFAULT NULL,
  vehicle_number TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fleet_cardholder_prompt_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    alphanumeric_id,
    driver_id,
    odometer,
    unspecified_id,
    user_id,
    vehicle_number
  )::stripe_disputes.issuing_authorization_fleet_cardholder_prompt_data;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown
  ADD ATTRIBUTE fuel stripe_disputes.issuing_authorization_fleet_reported_breakdown_fuel,
  ADD ATTRIBUTE non_fuel stripe_disputes.issuing_authorization_fleet_reported_breakdown_non_fuel,
  ADD ATTRIBUTE tax stripe_disputes.issuing_authorization_fleet_reported_breakdown_tax;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fleet_reported_breakdown(
  fuel stripe_disputes.issuing_authorization_fleet_reported_breakdown_fuel DEFAULT NULL,
  non_fuel stripe_disputes.issuing_authorization_fleet_reported_breakdown_non_fuel DEFAULT NULL,
  tax stripe_disputes.issuing_authorization_fleet_reported_breakdown_tax DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fleet_reported_breakdown
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fuel, non_fuel, tax
  )::stripe_disputes.issuing_authorization_fleet_reported_breakdown;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown_fuel
  ADD ATTRIBUTE gross_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fleet_reported_breakdown_fuel(
  gross_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fleet_reported_breakdown_fuel
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    gross_amount_decimal
  )::stripe_disputes.issuing_authorization_fleet_reported_breakdown_fuel;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown_non_fuel
  ADD ATTRIBUTE gross_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fleet_reported_breakdown_non_fuel(
  gross_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fleet_reported_breakdown_non_fuel
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    gross_amount_decimal
  )::stripe_disputes.issuing_authorization_fleet_reported_breakdown_non_fuel;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown_tax
  ADD ATTRIBUTE local_amount_decimal TEXT,
  ADD ATTRIBUTE national_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fleet_reported_breakdown_tax(
  local_amount_decimal TEXT DEFAULT NULL,
  national_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fleet_reported_breakdown_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    local_amount_decimal, national_amount_decimal
  )::stripe_disputes.issuing_authorization_fleet_reported_breakdown_tax;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fraud_challenge
  ADD ATTRIBUTE channel TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE undeliverable_reason TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fraud_challenge(
  channel TEXT, status TEXT, undeliverable_reason TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fraud_challenge
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    channel, status, undeliverable_reason
  )::stripe_disputes.issuing_authorization_fraud_challenge;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_fuel
  ADD ATTRIBUTE industry_product_code TEXT,
  ADD ATTRIBUTE quantity_decimal TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE unit TEXT,
  ADD ATTRIBUTE unit_cost_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_fuel(
  industry_product_code TEXT DEFAULT NULL,
  quantity_decimal TEXT DEFAULT NULL,
  "type" TEXT DEFAULT NULL,
  unit TEXT DEFAULT NULL,
  unit_cost_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_fuel
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    industry_product_code, quantity_decimal, "type", unit, unit_cost_decimal
  )::stripe_disputes.issuing_authorization_fuel;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_network_data
  ADD ATTRIBUTE acquiring_institution_id TEXT,
  ADD ATTRIBUTE system_trace_audit_number TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_network_data(
  acquiring_institution_id TEXT DEFAULT NULL,
  system_trace_audit_number TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_network_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    acquiring_institution_id, system_trace_audit_number, transaction_id
  )::stripe_disputes.issuing_authorization_network_data;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_pending_request
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE is_amount_controllable BOOLEAN,
  ADD ATTRIBUTE merchant_amount BIGINT,
  ADD ATTRIBUTE merchant_currency TEXT,
  ADD ATTRIBUTE amount_details stripe_disputes.issuing_authorization_amount_details,
  ADD ATTRIBUTE network_risk_score BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_pending_request(
  amount BIGINT,
  currency TEXT,
  is_amount_controllable BOOLEAN,
  merchant_amount BIGINT,
  merchant_currency TEXT,
  amount_details stripe_disputes.issuing_authorization_amount_details DEFAULT NULL,
  network_risk_score BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_pending_request
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    currency,
    is_amount_controllable,
    merchant_amount,
    merchant_currency,
    amount_details,
    network_risk_score
  )::stripe_disputes.issuing_authorization_pending_request;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_treasury
  ADD ATTRIBUTE received_credits TEXT[],
  ADD ATTRIBUTE received_debits TEXT[],
  ADD ATTRIBUTE "transaction" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_treasury(
  received_credits TEXT[],
  received_debits TEXT[],
  "transaction" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_treasury
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    received_credits, received_debits, "transaction"
  )::stripe_disputes.issuing_authorization_treasury;
$$;

ALTER TYPE stripe_disputes.issuing_authorization_amount_details
  ADD ATTRIBUTE atm_fee BIGINT, ADD ATTRIBUTE cashback_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_authorization_amount_details(
  atm_fee BIGINT DEFAULT NULL, cashback_amount BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_authorization_amount_details
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    atm_fee, cashback_amount
  )::stripe_disputes.issuing_authorization_amount_details;
$$;

ALTER TYPE stripe_disputes.issuing_card
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE cardholder stripe_disputes.issuing_cardholder,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE spending_controls stripe_disputes.issuing_card_spending_control,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE cancellation_reason TEXT,
  ADD ATTRIBUTE cvc TEXT,
  ADD ATTRIBUTE financial_account TEXT,
  ADD ATTRIBUTE latest_fraud_warning stripe_disputes.issuing_card_latest_fraud_warning,
  ADD ATTRIBUTE "number" TEXT,
  ADD ATTRIBUTE personalization_design JSONB,
  ADD ATTRIBUTE replaced_by JSONB,
  ADD ATTRIBUTE replacement_for JSONB,
  ADD ATTRIBUTE replacement_reason TEXT,
  ADD ATTRIBUTE second_line TEXT,
  ADD ATTRIBUTE shipping stripe_disputes.issuing_card_shipping,
  ADD ATTRIBUTE wallets stripe_disputes.issuing_card_wallet;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card(
  "id" TEXT,
  brand TEXT,
  cardholder stripe_disputes.issuing_cardholder,
  created BIGINT,
  currency TEXT,
  exp_month BIGINT,
  exp_year BIGINT,
  last4 TEXT,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  spending_controls stripe_disputes.issuing_card_spending_control,
  status TEXT,
  "type" TEXT,
  cancellation_reason TEXT DEFAULT NULL,
  cvc TEXT DEFAULT NULL,
  financial_account TEXT DEFAULT NULL,
  latest_fraud_warning stripe_disputes.issuing_card_latest_fraud_warning DEFAULT NULL,
  "number" TEXT DEFAULT NULL,
  personalization_design JSONB DEFAULT NULL,
  replaced_by JSONB DEFAULT NULL,
  replacement_for JSONB DEFAULT NULL,
  replacement_reason TEXT DEFAULT NULL,
  second_line TEXT DEFAULT NULL,
  shipping stripe_disputes.issuing_card_shipping DEFAULT NULL,
  wallets stripe_disputes.issuing_card_wallet DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    brand,
    cardholder,
    created,
    currency,
    exp_month,
    exp_year,
    last4,
    livemode,
    metadata,
    "object",
    spending_controls,
    status,
    "type",
    cancellation_reason,
    cvc,
    financial_account,
    latest_fraud_warning,
    "number",
    personalization_design,
    replaced_by,
    replacement_for,
    replacement_reason,
    second_line,
    shipping,
    wallets
  )::stripe_disputes.issuing_card;
$$;

ALTER TYPE stripe_disputes.issuing_card_spending_control
  ADD ATTRIBUTE allowed_categories TEXT[],
  ADD ATTRIBUTE allowed_merchant_countries TEXT[],
  ADD ATTRIBUTE blocked_categories TEXT[],
  ADD ATTRIBUTE blocked_merchant_countries TEXT[],
  ADD ATTRIBUTE spending_limits stripe_disputes.issuing_card_spending_control_spending_limit[],
  ADD ATTRIBUTE spending_limits_currency TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_spending_control(
  allowed_categories TEXT[] DEFAULT NULL,
  allowed_merchant_countries TEXT[] DEFAULT NULL,
  blocked_categories TEXT[] DEFAULT NULL,
  blocked_merchant_countries TEXT[] DEFAULT NULL,
  spending_limits stripe_disputes.issuing_card_spending_control_spending_limit[] DEFAULT NULL,
  spending_limits_currency TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_spending_control
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    allowed_categories,
    allowed_merchant_countries,
    blocked_categories,
    blocked_merchant_countries,
    spending_limits,
    spending_limits_currency
  )::stripe_disputes.issuing_card_spending_control;
$$;

ALTER TYPE stripe_disputes.issuing_card_spending_control_spending_limit
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE categories TEXT[];

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_spending_control_spending_limit(
  amount BIGINT, "interval" TEXT, categories TEXT[] DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_spending_control_spending_limit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, "interval", categories
  )::stripe_disputes.issuing_card_spending_control_spending_limit;
$$;

ALTER TYPE stripe_disputes.issuing_card_latest_fraud_warning
  ADD ATTRIBUTE started_at BIGINT, ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_latest_fraud_warning(
  started_at BIGINT DEFAULT NULL, "type" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_latest_fraud_warning
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    started_at, "type"
  )::stripe_disputes.issuing_card_latest_fraud_warning;
$$;

ALTER TYPE stripe_disputes.issuing_card_shipping
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE service TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE address_validation stripe_disputes.issuing_card_shipping_address_validation,
  ADD ATTRIBUTE carrier TEXT,
  ADD ATTRIBUTE customs stripe_disputes.issuing_card_shipping_custom,
  ADD ATTRIBUTE eta BIGINT,
  ADD ATTRIBUTE phone_number TEXT,
  ADD ATTRIBUTE require_signature BOOLEAN,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE tracking_number TEXT,
  ADD ATTRIBUTE tracking_url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_shipping(
  address stripe.address,
  "name" TEXT,
  service TEXT,
  "type" TEXT,
  address_validation stripe_disputes.issuing_card_shipping_address_validation DEFAULT NULL,
  carrier TEXT DEFAULT NULL,
  customs stripe_disputes.issuing_card_shipping_custom DEFAULT NULL,
  eta BIGINT DEFAULT NULL,
  phone_number TEXT DEFAULT NULL,
  require_signature BOOLEAN DEFAULT NULL,
  status TEXT DEFAULT NULL,
  tracking_number TEXT DEFAULT NULL,
  tracking_url TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_shipping
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address,
    "name",
    service,
    "type",
    address_validation,
    carrier,
    customs,
    eta,
    phone_number,
    require_signature,
    status,
    tracking_number,
    tracking_url
  )::stripe_disputes.issuing_card_shipping;
$$;

ALTER TYPE stripe_disputes.issuing_card_shipping_address_validation
  ADD ATTRIBUTE "mode" TEXT,
  ADD ATTRIBUTE normalized_address stripe.address,
  ADD ATTRIBUTE "result" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_shipping_address_validation(
  "mode" TEXT,
  normalized_address stripe.address DEFAULT NULL,
  "result" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_shipping_address_validation
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "mode", normalized_address, "result"
  )::stripe_disputes.issuing_card_shipping_address_validation;
$$;

ALTER TYPE stripe_disputes.issuing_card_shipping_custom
  ADD ATTRIBUTE eori_number TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_shipping_custom(
  eori_number TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_shipping_custom
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(eori_number)::stripe_disputes.issuing_card_shipping_custom;
$$;

ALTER TYPE stripe_disputes.issuing_card_wallet
  ADD ATTRIBUTE apple_pay stripe_disputes.issuing_card_wallet_apple_pay,
  ADD ATTRIBUTE google_pay stripe_disputes.issuing_card_wallet_google_pay,
  ADD ATTRIBUTE primary_account_identifier TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_wallet(
  apple_pay stripe_disputes.issuing_card_wallet_apple_pay,
  google_pay stripe_disputes.issuing_card_wallet_google_pay,
  primary_account_identifier TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_wallet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    apple_pay, google_pay, primary_account_identifier
  )::stripe_disputes.issuing_card_wallet;
$$;

ALTER TYPE stripe_disputes.issuing_card_wallet_apple_pay
  ADD ATTRIBUTE eligible BOOLEAN, ADD ATTRIBUTE ineligible_reason TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_wallet_apple_pay(
  eligible BOOLEAN, ineligible_reason TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_wallet_apple_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    eligible, ineligible_reason
  )::stripe_disputes.issuing_card_wallet_apple_pay;
$$;

ALTER TYPE stripe_disputes.issuing_card_wallet_google_pay
  ADD ATTRIBUTE eligible BOOLEAN, ADD ATTRIBUTE ineligible_reason TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_card_wallet_google_pay(
  eligible BOOLEAN, ineligible_reason TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_card_wallet_google_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    eligible, ineligible_reason
  )::stripe_disputes.issuing_card_wallet_google_pay;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE billing stripe_disputes.issuing_cardholder_address,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE requirements stripe_disputes.issuing_cardholder_requirements,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE company stripe_disputes.issuing_cardholder_company,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE individual stripe_disputes.issuing_cardholder_individual,
  ADD ATTRIBUTE phone_number TEXT,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE spending_controls stripe_disputes.issuing_cardholder_authorization_controls;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder(
  "id" TEXT,
  billing stripe_disputes.issuing_cardholder_address,
  created BIGINT,
  livemode BOOLEAN,
  metadata JSONB,
  "name" TEXT,
  "object" TEXT,
  requirements stripe_disputes.issuing_cardholder_requirements,
  status TEXT,
  "type" TEXT,
  company stripe_disputes.issuing_cardholder_company DEFAULT NULL,
  email TEXT DEFAULT NULL,
  individual stripe_disputes.issuing_cardholder_individual DEFAULT NULL,
  phone_number TEXT DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  spending_controls stripe_disputes.issuing_cardholder_authorization_controls DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    billing,
    created,
    livemode,
    metadata,
    "name",
    "object",
    requirements,
    status,
    "type",
    company,
    email,
    individual,
    phone_number,
    preferred_locales,
    spending_controls
  )::stripe_disputes.issuing_cardholder;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_address
  ADD ATTRIBUTE address stripe.address;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_address(
  address stripe.address
)
RETURNS stripe_disputes.issuing_cardholder_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(address)::stripe_disputes.issuing_cardholder_address;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_authorization_controls
  ADD ATTRIBUTE allowed_categories TEXT[],
  ADD ATTRIBUTE allowed_merchant_countries TEXT[],
  ADD ATTRIBUTE blocked_categories TEXT[],
  ADD ATTRIBUTE blocked_merchant_countries TEXT[],
  ADD ATTRIBUTE spending_limits stripe_disputes.issuing_cardholder_spending_limit[],
  ADD ATTRIBUTE spending_limits_currency TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_authorization_controls(
  allowed_categories TEXT[] DEFAULT NULL,
  allowed_merchant_countries TEXT[] DEFAULT NULL,
  blocked_categories TEXT[] DEFAULT NULL,
  blocked_merchant_countries TEXT[] DEFAULT NULL,
  spending_limits stripe_disputes.issuing_cardholder_spending_limit[] DEFAULT NULL,
  spending_limits_currency TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_authorization_controls
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    allowed_categories,
    allowed_merchant_countries,
    blocked_categories,
    blocked_merchant_countries,
    spending_limits,
    spending_limits_currency
  )::stripe_disputes.issuing_cardholder_authorization_controls;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_card_issuing
  ADD ATTRIBUTE user_terms_acceptance stripe_disputes.issuing_cardholder_user_terms_acceptance;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_card_issuing(
  user_terms_acceptance stripe_disputes.issuing_cardholder_user_terms_acceptance DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_card_issuing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    user_terms_acceptance
  )::stripe_disputes.issuing_cardholder_card_issuing;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_company
  ADD ATTRIBUTE tax_id_provided BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_company(
  tax_id_provided BOOLEAN
)
RETURNS stripe_disputes.issuing_cardholder_company
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_id_provided)::stripe_disputes.issuing_cardholder_company;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_id_document
  ADD ATTRIBUTE back JSONB, ADD ATTRIBUTE front JSONB;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_id_document(
  back JSONB DEFAULT NULL, front JSONB DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_id_document
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(back, front)::stripe_disputes.issuing_cardholder_id_document;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_individual
  ADD ATTRIBUTE card_issuing stripe_disputes.issuing_cardholder_card_issuing,
  ADD ATTRIBUTE dob stripe_disputes.issuing_cardholder_individual_dob,
  ADD ATTRIBUTE first_name TEXT,
  ADD ATTRIBUTE last_name TEXT,
  ADD ATTRIBUTE verification stripe_disputes.issuing_cardholder_verification;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_individual(
  card_issuing stripe_disputes.issuing_cardholder_card_issuing DEFAULT NULL,
  dob stripe_disputes.issuing_cardholder_individual_dob DEFAULT NULL,
  first_name TEXT DEFAULT NULL,
  last_name TEXT DEFAULT NULL,
  verification stripe_disputes.issuing_cardholder_verification DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_individual
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card_issuing, dob, first_name, last_name, verification
  )::stripe_disputes.issuing_cardholder_individual;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_individual_dob
  ADD ATTRIBUTE "day" BIGINT,
  ADD ATTRIBUTE "month" BIGINT,
  ADD ATTRIBUTE "year" BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_individual_dob(
  "day" BIGINT DEFAULT NULL,
  "month" BIGINT DEFAULT NULL,
  "year" BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_individual_dob
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "day", "month", "year"
  )::stripe_disputes.issuing_cardholder_individual_dob;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_requirements
  ADD ATTRIBUTE disabled_reason TEXT, ADD ATTRIBUTE past_due TEXT[];

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_requirements(
  disabled_reason TEXT DEFAULT NULL, past_due TEXT[] DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_requirements
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    disabled_reason, past_due
  )::stripe_disputes.issuing_cardholder_requirements;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_spending_limit
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE categories TEXT[];

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_spending_limit(
  amount BIGINT, "interval" TEXT, categories TEXT[] DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_spending_limit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, "interval", categories
  )::stripe_disputes.issuing_cardholder_spending_limit;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_user_terms_acceptance
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_user_terms_acceptance(
  "date" BIGINT DEFAULT NULL, ip TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_user_terms_acceptance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, user_agent
  )::stripe_disputes.issuing_cardholder_user_terms_acceptance;
$$;

ALTER TYPE stripe_disputes.issuing_cardholder_verification
  ADD ATTRIBUTE "document" stripe_disputes.issuing_cardholder_id_document;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_cardholder_verification(
  "document" stripe_disputes.issuing_cardholder_id_document DEFAULT NULL
)
RETURNS stripe_disputes.issuing_cardholder_verification
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("document")::stripe_disputes.issuing_cardholder_verification;
$$;

ALTER TYPE stripe_disputes.issuing_dispute
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE evidence stripe_disputes.issuing_dispute_evidence,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "transaction" JSONB,
  ADD ATTRIBUTE balance_transactions JSONB[],
  ADD ATTRIBUTE loss_reason TEXT,
  ADD ATTRIBUTE treasury stripe_disputes.issuing_dispute_treasury;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute(
  "id" TEXT,
  amount BIGINT,
  created BIGINT,
  currency TEXT,
  evidence stripe_disputes.issuing_dispute_evidence,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  status TEXT,
  "transaction" JSONB,
  balance_transactions JSONB[] DEFAULT NULL,
  loss_reason TEXT DEFAULT NULL,
  treasury stripe_disputes.issuing_dispute_treasury DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    created,
    currency,
    evidence,
    livemode,
    metadata,
    "object",
    status,
    "transaction",
    balance_transactions,
    loss_reason,
    treasury
  )::stripe_disputes.issuing_dispute;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence
  ADD ATTRIBUTE reason TEXT,
  ADD ATTRIBUTE canceled stripe_disputes.issuing_dispute_evidence_canceled,
  ADD ATTRIBUTE duplicate stripe_disputes.issuing_dispute_evidence_duplicate,
  ADD ATTRIBUTE fraudulent stripe_disputes.issuing_dispute_evidence_fraudulent,
  ADD ATTRIBUTE merchandise_not_as_described stripe_disputes.issuing_dispute_evidence_merchandise_not_as_described,
  ADD ATTRIBUTE no_valid_authorization stripe_disputes.issuing_dispute_evidence_no_valid_authorization,
  ADD ATTRIBUTE not_received stripe_disputes.issuing_dispute_evidence_not_received,
  ADD ATTRIBUTE other stripe_disputes.issuing_dispute_evidence_other,
  ADD ATTRIBUTE service_not_as_described stripe_disputes.issuing_dispute_evidence_service_not_as_described;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence(
  reason TEXT,
  canceled stripe_disputes.issuing_dispute_evidence_canceled DEFAULT NULL,
  duplicate stripe_disputes.issuing_dispute_evidence_duplicate DEFAULT NULL,
  fraudulent stripe_disputes.issuing_dispute_evidence_fraudulent DEFAULT NULL,
  merchandise_not_as_described stripe_disputes.issuing_dispute_evidence_merchandise_not_as_described DEFAULT NULL,
  no_valid_authorization stripe_disputes.issuing_dispute_evidence_no_valid_authorization DEFAULT NULL,
  not_received stripe_disputes.issuing_dispute_evidence_not_received DEFAULT NULL,
  other stripe_disputes.issuing_dispute_evidence_other DEFAULT NULL,
  service_not_as_described stripe_disputes.issuing_dispute_evidence_service_not_as_described DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reason,
    canceled,
    duplicate,
    fraudulent,
    merchandise_not_as_described,
    no_valid_authorization,
    not_received,
    other,
    service_not_as_described
  )::stripe_disputes.issuing_dispute_evidence;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_canceled
  ADD ATTRIBUTE additional_documentation JSONB,
  ADD ATTRIBUTE canceled_at BIGINT,
  ADD ATTRIBUTE cancellation_policy_provided BOOLEAN,
  ADD ATTRIBUTE cancellation_reason TEXT,
  ADD ATTRIBUTE expected_at BIGINT,
  ADD ATTRIBUTE explanation TEXT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE product_type TEXT,
  ADD ATTRIBUTE return_status TEXT,
  ADD ATTRIBUTE returned_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_canceled(
  additional_documentation JSONB DEFAULT NULL,
  canceled_at BIGINT DEFAULT NULL,
  cancellation_policy_provided BOOLEAN DEFAULT NULL,
  cancellation_reason TEXT DEFAULT NULL,
  expected_at BIGINT DEFAULT NULL,
  explanation TEXT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  product_type TEXT DEFAULT NULL,
  return_status TEXT DEFAULT NULL,
  returned_at BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_canceled
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation,
    canceled_at,
    cancellation_policy_provided,
    cancellation_reason,
    expected_at,
    explanation,
    product_description,
    product_type,
    return_status,
    returned_at
  )::stripe_disputes.issuing_dispute_evidence_canceled;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_duplicate
  ADD ATTRIBUTE additional_documentation JSONB,
  ADD ATTRIBUTE card_statement JSONB,
  ADD ATTRIBUTE cash_receipt JSONB,
  ADD ATTRIBUTE check_image JSONB,
  ADD ATTRIBUTE explanation TEXT,
  ADD ATTRIBUTE original_transaction TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_duplicate(
  additional_documentation JSONB DEFAULT NULL,
  card_statement JSONB DEFAULT NULL,
  cash_receipt JSONB DEFAULT NULL,
  check_image JSONB DEFAULT NULL,
  explanation TEXT DEFAULT NULL,
  original_transaction TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_duplicate
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation,
    card_statement,
    cash_receipt,
    check_image,
    explanation,
    original_transaction
  )::stripe_disputes.issuing_dispute_evidence_duplicate;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_fraudulent
  ADD ATTRIBUTE additional_documentation JSONB, ADD ATTRIBUTE explanation TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_fraudulent(
  additional_documentation JSONB DEFAULT NULL, explanation TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_fraudulent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation, explanation
  )::stripe_disputes.issuing_dispute_evidence_fraudulent;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_merchandise_not_as_described
  ADD ATTRIBUTE additional_documentation JSONB,
  ADD ATTRIBUTE explanation TEXT,
  ADD ATTRIBUTE received_at BIGINT,
  ADD ATTRIBUTE return_description TEXT,
  ADD ATTRIBUTE return_status TEXT,
  ADD ATTRIBUTE returned_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_merchandise_not_as_described(
  additional_documentation JSONB DEFAULT NULL,
  explanation TEXT DEFAULT NULL,
  received_at BIGINT DEFAULT NULL,
  return_description TEXT DEFAULT NULL,
  return_status TEXT DEFAULT NULL,
  returned_at BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_merchandise_not_as_described
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation,
    explanation,
    received_at,
    return_description,
    return_status,
    returned_at
  )::stripe_disputes.issuing_dispute_evidence_merchandise_not_as_described;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_no_valid_authorization
  ADD ATTRIBUTE additional_documentation JSONB, ADD ATTRIBUTE explanation TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_no_valid_authorization(
  additional_documentation JSONB DEFAULT NULL, explanation TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_no_valid_authorization
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation, explanation
  )::stripe_disputes.issuing_dispute_evidence_no_valid_authorization;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_not_received
  ADD ATTRIBUTE additional_documentation JSONB,
  ADD ATTRIBUTE expected_at BIGINT,
  ADD ATTRIBUTE explanation TEXT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE product_type TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_not_received(
  additional_documentation JSONB DEFAULT NULL,
  expected_at BIGINT DEFAULT NULL,
  explanation TEXT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  product_type TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_not_received
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation,
    expected_at,
    explanation,
    product_description,
    product_type
  )::stripe_disputes.issuing_dispute_evidence_not_received;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_other
  ADD ATTRIBUTE additional_documentation JSONB,
  ADD ATTRIBUTE explanation TEXT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE product_type TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_other(
  additional_documentation JSONB DEFAULT NULL,
  explanation TEXT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  product_type TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_other
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation, explanation, product_description, product_type
  )::stripe_disputes.issuing_dispute_evidence_other;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_evidence_service_not_as_described
  ADD ATTRIBUTE additional_documentation JSONB,
  ADD ATTRIBUTE canceled_at BIGINT,
  ADD ATTRIBUTE cancellation_reason TEXT,
  ADD ATTRIBUTE explanation TEXT,
  ADD ATTRIBUTE received_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_evidence_service_not_as_described(
  additional_documentation JSONB DEFAULT NULL,
  canceled_at BIGINT DEFAULT NULL,
  cancellation_reason TEXT DEFAULT NULL,
  explanation TEXT DEFAULT NULL,
  received_at BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_evidence_service_not_as_described
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    additional_documentation,
    canceled_at,
    cancellation_reason,
    explanation,
    received_at
  )::stripe_disputes.issuing_dispute_evidence_service_not_as_described;
$$;

ALTER TYPE stripe_disputes.issuing_dispute_treasury
  ADD ATTRIBUTE received_debit TEXT, ADD ATTRIBUTE debit_reversal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_dispute_treasury(
  received_debit TEXT, debit_reversal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_dispute_treasury
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    received_debit, debit_reversal
  )::stripe_disputes.issuing_dispute_treasury;
$$;

ALTER TYPE stripe_disputes.issuing_transaction
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE card JSONB,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE merchant_amount BIGINT,
  ADD ATTRIBUTE merchant_currency TEXT,
  ADD ATTRIBUTE merchant_data stripe_disputes.issuing_transaction_merchant_data,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE "token" JSONB,
  ADD ATTRIBUTE amount_details stripe_disputes.issuing_transaction_amount_detail,
  ADD ATTRIBUTE "authorization" JSONB,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE cardholder JSONB,
  ADD ATTRIBUTE dispute JSONB,
  ADD ATTRIBUTE network_data stripe_disputes.issuing_transaction_network_data,
  ADD ATTRIBUTE purchase_details stripe_disputes.issuing_transaction_purchase_detail,
  ADD ATTRIBUTE treasury stripe_disputes.issuing_transaction_treasury,
  ADD ATTRIBUTE wallet TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction(
  "id" TEXT,
  amount BIGINT,
  card JSONB,
  created BIGINT,
  currency TEXT,
  livemode BOOLEAN,
  merchant_amount BIGINT,
  merchant_currency TEXT,
  merchant_data stripe_disputes.issuing_transaction_merchant_data,
  metadata JSONB,
  "object" TEXT,
  "type" TEXT,
  "token" JSONB DEFAULT NULL,
  amount_details stripe_disputes.issuing_transaction_amount_detail DEFAULT NULL,
  "authorization" JSONB DEFAULT NULL,
  balance_transaction JSONB DEFAULT NULL,
  cardholder JSONB DEFAULT NULL,
  dispute JSONB DEFAULT NULL,
  network_data stripe_disputes.issuing_transaction_network_data DEFAULT NULL,
  purchase_details stripe_disputes.issuing_transaction_purchase_detail DEFAULT NULL,
  treasury stripe_disputes.issuing_transaction_treasury DEFAULT NULL,
  wallet TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    card,
    created,
    currency,
    livemode,
    merchant_amount,
    merchant_currency,
    merchant_data,
    metadata,
    "object",
    "type",
    "token",
    amount_details,
    "authorization",
    balance_transaction,
    cardholder,
    dispute,
    network_data,
    purchase_details,
    treasury,
    wallet
  )::stripe_disputes.issuing_transaction;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_merchant_data
  ADD ATTRIBUTE category TEXT,
  ADD ATTRIBUTE category_code TEXT,
  ADD ATTRIBUTE network_id TEXT,
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT,
  ADD ATTRIBUTE tax_id TEXT,
  ADD ATTRIBUTE terminal_id TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_merchant_data(
  category TEXT,
  category_code TEXT,
  network_id TEXT,
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL,
  tax_id TEXT DEFAULT NULL,
  terminal_id TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_merchant_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    category,
    category_code,
    network_id,
    city,
    country,
    "name",
    postal_code,
    "state",
    tax_id,
    terminal_id,
    url
  )::stripe_disputes.issuing_transaction_merchant_data;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_amount_detail
  ADD ATTRIBUTE atm_fee BIGINT, ADD ATTRIBUTE cashback_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_amount_detail(
  atm_fee BIGINT DEFAULT NULL, cashback_amount BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_amount_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    atm_fee, cashback_amount
  )::stripe_disputes.issuing_transaction_amount_detail;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_network_data
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE processing_date TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_network_data(
  authorization_code TEXT DEFAULT NULL,
  processing_date TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_network_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    authorization_code, processing_date, transaction_id
  )::stripe_disputes.issuing_transaction_network_data;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail
  ADD ATTRIBUTE fleet stripe_disputes.issuing_transaction_purchase_detail_fleet,
  ADD ATTRIBUTE flight stripe_disputes.issuing_transaction_purchase_detail_flight,
  ADD ATTRIBUTE fuel stripe_disputes.issuing_transaction_purchase_detail_fuel,
  ADD ATTRIBUTE lodging stripe_disputes.issuing_transaction_purchase_detail_lodging,
  ADD ATTRIBUTE receipt stripe_disputes.issuing_transaction_purchase_detail_receipt[],
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_purchase_detail(
  fleet stripe_disputes.issuing_transaction_purchase_detail_fleet DEFAULT NULL,
  flight stripe_disputes.issuing_transaction_purchase_detail_flight DEFAULT NULL,
  fuel stripe_disputes.issuing_transaction_purchase_detail_fuel DEFAULT NULL,
  lodging stripe_disputes.issuing_transaction_purchase_detail_lodging DEFAULT NULL,
  receipt stripe_disputes.issuing_transaction_purchase_detail_receipt[] DEFAULT NULL,
  reference TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fleet, flight, fuel, lodging, receipt, reference
  )::stripe_disputes.issuing_transaction_purchase_detail;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail_fleet
  ADD ATTRIBUTE cardholder_prompt_data stripe_disputes.i_transaction_purchase_detail_fleet_cardholder_prompt_data,
  ADD ATTRIBUTE purchase_type TEXT,
  ADD ATTRIBUTE reported_breakdown stripe_disputes.issuing_transaction_purchase_detail_fleet_reported_breakdown,
  ADD ATTRIBUTE service_type TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_purchase_detail_fleet(
  cardholder_prompt_data stripe_disputes.i_transaction_purchase_detail_fleet_cardholder_prompt_data DEFAULT NULL,
  purchase_type TEXT DEFAULT NULL,
  reported_breakdown stripe_disputes.issuing_transaction_purchase_detail_fleet_reported_breakdown DEFAULT NULL,
  service_type TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail_fleet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    cardholder_prompt_data, purchase_type, reported_breakdown, service_type
  )::stripe_disputes.issuing_transaction_purchase_detail_fleet;
$$;

ALTER TYPE stripe_disputes.i_transaction_purchase_detail_fleet_cardholder_prompt_data
  ADD ATTRIBUTE driver_id TEXT,
  ADD ATTRIBUTE odometer BIGINT,
  ADD ATTRIBUTE unspecified_id TEXT,
  ADD ATTRIBUTE user_id TEXT,
  ADD ATTRIBUTE vehicle_number TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_i_transaction_purchase_detail_fleet_cardholder_prompt_data(
  driver_id TEXT DEFAULT NULL,
  odometer BIGINT DEFAULT NULL,
  unspecified_id TEXT DEFAULT NULL,
  user_id TEXT DEFAULT NULL,
  vehicle_number TEXT DEFAULT NULL
)
RETURNS stripe_disputes.i_transaction_purchase_detail_fleet_cardholder_prompt_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    driver_id, odometer, unspecified_id, user_id, vehicle_number
  )::stripe_disputes.i_transaction_purchase_detail_fleet_cardholder_prompt_data;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail_fleet_reported_breakdown
  ADD ATTRIBUTE fuel stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_fuel,
  ADD ATTRIBUTE non_fuel stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_non_fuel,
  ADD ATTRIBUTE tax stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_tax;

CREATE OR REPLACE FUNCTION stripe_disputes.m_issuing_transaction_purchase_detail_fleet_reported_breakdown(
  fuel stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_fuel DEFAULT NULL,
  non_fuel stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_non_fuel DEFAULT NULL,
  tax stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_tax DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail_fleet_reported_breakdown
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fuel, non_fuel, tax
  )::stripe_disputes.issuing_transaction_purchase_detail_fleet_reported_breakdown;
$$;

ALTER TYPE stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_fuel
  ADD ATTRIBUTE gross_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_i_transaction_purchase_detail_fleet_reported_breakdown_fuel(
  gross_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_fuel
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    gross_amount_decimal
  )::stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_fuel;
$$;

ALTER TYPE stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_non_fuel
  ADD ATTRIBUTE gross_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_i_t_purchase_detail_fleet_reported_breakdown_non_fuel(
  gross_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_non_fuel
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    gross_amount_decimal
  )::stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_non_fuel;
$$;

ALTER TYPE stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_tax
  ADD ATTRIBUTE local_amount_decimal TEXT,
  ADD ATTRIBUTE national_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.m_i_transaction_purchase_detail_fleet_reported_breakdown_tax(
  local_amount_decimal TEXT DEFAULT NULL,
  national_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    local_amount_decimal, national_amount_decimal
  )::stripe_disputes.i_transaction_purchase_detail_fleet_reported_breakdown_tax;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail_flight
  ADD ATTRIBUTE departure_at BIGINT,
  ADD ATTRIBUTE passenger_name TEXT,
  ADD ATTRIBUTE refundable BOOLEAN,
  ADD ATTRIBUTE segments stripe_disputes.issuing_transaction_purchase_detail_flight_segment[],
  ADD ATTRIBUTE travel_agency TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_purchase_detail_flight(
  departure_at BIGINT DEFAULT NULL,
  passenger_name TEXT DEFAULT NULL,
  refundable BOOLEAN DEFAULT NULL,
  segments stripe_disputes.issuing_transaction_purchase_detail_flight_segment[] DEFAULT NULL,
  travel_agency TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail_flight
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    departure_at, passenger_name, refundable, segments, travel_agency
  )::stripe_disputes.issuing_transaction_purchase_detail_flight;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail_flight_segment
  ADD ATTRIBUTE arrival_airport_code TEXT,
  ADD ATTRIBUTE carrier TEXT,
  ADD ATTRIBUTE departure_airport_code TEXT,
  ADD ATTRIBUTE flight_number TEXT,
  ADD ATTRIBUTE service_class TEXT,
  ADD ATTRIBUTE stopover_allowed BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_purchase_detail_flight_segment(
  arrival_airport_code TEXT DEFAULT NULL,
  carrier TEXT DEFAULT NULL,
  departure_airport_code TEXT DEFAULT NULL,
  flight_number TEXT DEFAULT NULL,
  service_class TEXT DEFAULT NULL,
  stopover_allowed BOOLEAN DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail_flight_segment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    arrival_airport_code,
    carrier,
    departure_airport_code,
    flight_number,
    service_class,
    stopover_allowed
  )::stripe_disputes.issuing_transaction_purchase_detail_flight_segment;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail_fuel
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE unit TEXT,
  ADD ATTRIBUTE unit_cost_decimal TEXT,
  ADD ATTRIBUTE industry_product_code TEXT,
  ADD ATTRIBUTE quantity_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_purchase_detail_fuel(
  "type" TEXT,
  unit TEXT,
  unit_cost_decimal TEXT,
  industry_product_code TEXT DEFAULT NULL,
  quantity_decimal TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail_fuel
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", unit, unit_cost_decimal, industry_product_code, quantity_decimal
  )::stripe_disputes.issuing_transaction_purchase_detail_fuel;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail_lodging
  ADD ATTRIBUTE check_in_at BIGINT, ADD ATTRIBUTE nights BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_purchase_detail_lodging(
  check_in_at BIGINT DEFAULT NULL, nights BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail_lodging
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    check_in_at, nights
  )::stripe_disputes.issuing_transaction_purchase_detail_lodging;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_purchase_detail_receipt
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE quantity DOUBLE PRECISION,
  ADD ATTRIBUTE total BIGINT,
  ADD ATTRIBUTE unit_cost BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_purchase_detail_receipt(
  description TEXT DEFAULT NULL,
  quantity DOUBLE PRECISION DEFAULT NULL,
  total BIGINT DEFAULT NULL,
  unit_cost BIGINT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_purchase_detail_receipt
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    description, quantity, total, unit_cost
  )::stripe_disputes.issuing_transaction_purchase_detail_receipt;
$$;

ALTER TYPE stripe_disputes.issuing_transaction_treasury
  ADD ATTRIBUTE received_credit TEXT, ADD ATTRIBUTE received_debit TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_issuing_transaction_treasury(
  received_credit TEXT DEFAULT NULL, received_debit TEXT DEFAULT NULL
)
RETURNS stripe_disputes.issuing_transaction_treasury
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    received_credit, received_debit
  )::stripe_disputes.issuing_transaction_treasury;
$$;

ALTER TYPE stripe_disputes.payment_method_details
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE ach_credit_transfer stripe_disputes.payment_method_details_ach_credit_transfer,
  ADD ATTRIBUTE ach_debit stripe_disputes.payment_method_details_ach_debit,
  ADD ATTRIBUTE acss_debit stripe_disputes.payment_method_details_acss_debit,
  ADD ATTRIBUTE affirm stripe_disputes.payment_method_details_affirm,
  ADD ATTRIBUTE afterpay_clearpay stripe_disputes.payment_method_details_afterpay_clearpay,
  ADD ATTRIBUTE alipay stripe_disputes.payment_method_details_alipay,
  ADD ATTRIBUTE alma stripe_disputes.payment_method_details_alma,
  ADD ATTRIBUTE amazon_pay stripe_disputes.payment_method_details_amazon_pay,
  ADD ATTRIBUTE au_becs_debit stripe_disputes.payment_method_details_au_becs_debit,
  ADD ATTRIBUTE bacs_debit stripe_disputes.payment_method_details_bacs_debit,
  ADD ATTRIBUTE bancontact JSONB,
  ADD ATTRIBUTE billie stripe_disputes.payment_method_details_billie,
  ADD ATTRIBUTE blik stripe_disputes.payment_method_details_blik,
  ADD ATTRIBUTE boleto stripe_disputes.payment_method_details_boleto,
  ADD ATTRIBUTE card stripe_disputes.payment_method_details_card,
  ADD ATTRIBUTE card_present stripe.payment_method_details_card_present,
  ADD ATTRIBUTE cashapp stripe_disputes.payment_method_details_cashapp,
  ADD ATTRIBUTE crypto stripe_disputes.payment_method_details_crypto,
  ADD ATTRIBUTE customer_balance stripe_disputes.payment_method_details_customer_balance,
  ADD ATTRIBUTE eps stripe_disputes.payment_method_details_ep,
  ADD ATTRIBUTE fpx stripe_disputes.payment_method_details_fpx,
  ADD ATTRIBUTE giropay stripe_disputes.payment_method_details_giropay,
  ADD ATTRIBUTE grabpay stripe_disputes.payment_method_details_grabpay,
  ADD ATTRIBUTE ideal JSONB,
  ADD ATTRIBUTE interac_present stripe_disputes.payment_method_details_interac_present,
  ADD ATTRIBUTE kakao_pay stripe_disputes.payment_method_details_kakao_pay,
  ADD ATTRIBUTE klarna stripe_disputes.payment_method_details_klarna,
  ADD ATTRIBUTE konbini stripe_disputes.payment_method_details_konbini,
  ADD ATTRIBUTE kr_card stripe_disputes.payment_method_details_kr_card,
  ADD ATTRIBUTE "link" stripe_disputes.payment_method_details_link,
  ADD ATTRIBUTE mb_way stripe_disputes.payment_method_details_mb_way,
  ADD ATTRIBUTE mobilepay stripe_disputes.payment_method_details_mobilepay,
  ADD ATTRIBUTE multibanco stripe_disputes.payment_method_details_multibanco,
  ADD ATTRIBUTE naver_pay stripe_disputes.payment_method_details_naver_pay,
  ADD ATTRIBUTE nz_bank_account stripe_disputes.payment_method_details_nz_bank_account,
  ADD ATTRIBUTE oxxo stripe_disputes.payment_method_details_oxxo,
  ADD ATTRIBUTE p24 stripe_disputes.payment_method_details_p24,
  ADD ATTRIBUTE pay_by_bank stripe_disputes.payment_method_details_pay_by_bank,
  ADD ATTRIBUTE payco stripe_disputes.payment_method_details_payco,
  ADD ATTRIBUTE paynow stripe_disputes.payment_method_details_paynow,
  ADD ATTRIBUTE paypal stripe_disputes.payment_method_details_paypal,
  ADD ATTRIBUTE payto stripe_disputes.payment_method_details_payto,
  ADD ATTRIBUTE pix stripe_disputes.payment_method_details_pix,
  ADD ATTRIBUTE promptpay stripe_disputes.payment_method_details_promptpay,
  ADD ATTRIBUTE revolut_pay stripe_disputes.payment_method_details_revolut_pay,
  ADD ATTRIBUTE samsung_pay stripe_disputes.payment_method_details_samsung_pay,
  ADD ATTRIBUTE satispay stripe_disputes.payment_method_details_satispay,
  ADD ATTRIBUTE sepa_debit stripe_disputes.payment_method_details_sepa_debit,
  ADD ATTRIBUTE sofort JSONB,
  ADD ATTRIBUTE stripe_account stripe_disputes.payment_method_details_stripe_account,
  ADD ATTRIBUTE swish stripe_disputes.payment_method_details_swish,
  ADD ATTRIBUTE twint stripe_disputes.payment_method_details_twint,
  ADD ATTRIBUTE us_bank_account JSONB,
  ADD ATTRIBUTE wechat stripe_disputes.payment_method_details_wechat,
  ADD ATTRIBUTE wechat_pay stripe_disputes.payment_method_details_wechat_pay,
  ADD ATTRIBUTE zip stripe_disputes.payment_method_details_zip;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details(
  "type" TEXT,
  ach_credit_transfer stripe_disputes.payment_method_details_ach_credit_transfer DEFAULT NULL,
  ach_debit stripe_disputes.payment_method_details_ach_debit DEFAULT NULL,
  acss_debit stripe_disputes.payment_method_details_acss_debit DEFAULT NULL,
  affirm stripe_disputes.payment_method_details_affirm DEFAULT NULL,
  afterpay_clearpay stripe_disputes.payment_method_details_afterpay_clearpay DEFAULT NULL,
  alipay stripe_disputes.payment_method_details_alipay DEFAULT NULL,
  alma stripe_disputes.payment_method_details_alma DEFAULT NULL,
  amazon_pay stripe_disputes.payment_method_details_amazon_pay DEFAULT NULL,
  au_becs_debit stripe_disputes.payment_method_details_au_becs_debit DEFAULT NULL,
  bacs_debit stripe_disputes.payment_method_details_bacs_debit DEFAULT NULL,
  bancontact JSONB DEFAULT NULL,
  billie stripe_disputes.payment_method_details_billie DEFAULT NULL,
  blik stripe_disputes.payment_method_details_blik DEFAULT NULL,
  boleto stripe_disputes.payment_method_details_boleto DEFAULT NULL,
  card stripe_disputes.payment_method_details_card DEFAULT NULL,
  card_present stripe.payment_method_details_card_present DEFAULT NULL,
  cashapp stripe_disputes.payment_method_details_cashapp DEFAULT NULL,
  crypto stripe_disputes.payment_method_details_crypto DEFAULT NULL,
  customer_balance stripe_disputes.payment_method_details_customer_balance DEFAULT NULL,
  eps stripe_disputes.payment_method_details_ep DEFAULT NULL,
  fpx stripe_disputes.payment_method_details_fpx DEFAULT NULL,
  giropay stripe_disputes.payment_method_details_giropay DEFAULT NULL,
  grabpay stripe_disputes.payment_method_details_grabpay DEFAULT NULL,
  ideal JSONB DEFAULT NULL,
  interac_present stripe_disputes.payment_method_details_interac_present DEFAULT NULL,
  kakao_pay stripe_disputes.payment_method_details_kakao_pay DEFAULT NULL,
  klarna stripe_disputes.payment_method_details_klarna DEFAULT NULL,
  konbini stripe_disputes.payment_method_details_konbini DEFAULT NULL,
  kr_card stripe_disputes.payment_method_details_kr_card DEFAULT NULL,
  "link" stripe_disputes.payment_method_details_link DEFAULT NULL,
  mb_way stripe_disputes.payment_method_details_mb_way DEFAULT NULL,
  mobilepay stripe_disputes.payment_method_details_mobilepay DEFAULT NULL,
  multibanco stripe_disputes.payment_method_details_multibanco DEFAULT NULL,
  naver_pay stripe_disputes.payment_method_details_naver_pay DEFAULT NULL,
  nz_bank_account stripe_disputes.payment_method_details_nz_bank_account DEFAULT NULL,
  oxxo stripe_disputes.payment_method_details_oxxo DEFAULT NULL,
  p24 stripe_disputes.payment_method_details_p24 DEFAULT NULL,
  pay_by_bank stripe_disputes.payment_method_details_pay_by_bank DEFAULT NULL,
  payco stripe_disputes.payment_method_details_payco DEFAULT NULL,
  paynow stripe_disputes.payment_method_details_paynow DEFAULT NULL,
  paypal stripe_disputes.payment_method_details_paypal DEFAULT NULL,
  payto stripe_disputes.payment_method_details_payto DEFAULT NULL,
  pix stripe_disputes.payment_method_details_pix DEFAULT NULL,
  promptpay stripe_disputes.payment_method_details_promptpay DEFAULT NULL,
  revolut_pay stripe_disputes.payment_method_details_revolut_pay DEFAULT NULL,
  samsung_pay stripe_disputes.payment_method_details_samsung_pay DEFAULT NULL,
  satispay stripe_disputes.payment_method_details_satispay DEFAULT NULL,
  sepa_debit stripe_disputes.payment_method_details_sepa_debit DEFAULT NULL,
  sofort JSONB DEFAULT NULL,
  stripe_account stripe_disputes.payment_method_details_stripe_account DEFAULT NULL,
  swish stripe_disputes.payment_method_details_swish DEFAULT NULL,
  twint stripe_disputes.payment_method_details_twint DEFAULT NULL,
  us_bank_account JSONB DEFAULT NULL,
  wechat stripe_disputes.payment_method_details_wechat DEFAULT NULL,
  wechat_pay stripe_disputes.payment_method_details_wechat_pay DEFAULT NULL,
  zip stripe_disputes.payment_method_details_zip DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details
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
    blik,
    boleto,
    card,
    card_present,
    cashapp,
    crypto,
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
  )::stripe_disputes.payment_method_details;
$$;

ALTER TYPE stripe_disputes.payment_method_details_ach_credit_transfer
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE routing_number TEXT,
  ADD ATTRIBUTE swift_code TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_ach_credit_transfer(
  account_number TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL,
  swift_code TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_ach_credit_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_number, bank_name, routing_number, swift_code
  )::stripe_disputes.payment_method_details_ach_credit_transfer;
$$;

ALTER TYPE stripe_disputes.payment_method_details_ach_debit
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_ach_debit(
  account_holder_type TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_ach_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_type, bank_name, country, fingerprint, last4, routing_number
  )::stripe_disputes.payment_method_details_ach_debit;
$$;

ALTER TYPE stripe_disputes.payment_method_details_acss_debit
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE institution_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE transit_number TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_acss_debit(
  bank_name TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  institution_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  transit_number TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_acss_debit
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
  )::stripe_disputes.payment_method_details_acss_debit;
$$;

ALTER TYPE stripe_disputes.payment_method_details_affirm
  ADD ATTRIBUTE "location" TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_affirm(
  "location" TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_affirm
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "location", reader, transaction_id
  )::stripe_disputes.payment_method_details_affirm;
$$;

ALTER TYPE stripe_disputes.payment_method_details_afterpay_clearpay
  ADD ATTRIBUTE order_id TEXT, ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_afterpay_clearpay(
  order_id TEXT DEFAULT NULL, reference TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_afterpay_clearpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    order_id, reference
  )::stripe_disputes.payment_method_details_afterpay_clearpay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_alipay
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_alipay(
  buyer_id TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_alipay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, fingerprint, transaction_id
  )::stripe_disputes.payment_method_details_alipay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_alma
  ADD ATTRIBUTE installments stripe_disputes.payment_method_details_alma_installment,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_alma(
  installments stripe_disputes.payment_method_details_alma_installment DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_alma
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    installments, transaction_id
  )::stripe_disputes.payment_method_details_alma;
$$;

ALTER TYPE stripe_disputes.payment_method_details_alma_installment
  ADD ATTRIBUTE "count" BIGINT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_alma_installment(
  "count" BIGINT
)
RETURNS stripe_disputes.payment_method_details_alma_installment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("count")::stripe_disputes.payment_method_details_alma_installment;
$$;

ALTER TYPE stripe_disputes.payment_method_details_amazon_pay
  ADD ATTRIBUTE funding stripe_disputes.payment_method_details_amazon_pay_funding,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_amazon_pay(
  funding stripe_disputes.payment_method_details_amazon_pay_funding DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_amazon_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    funding, transaction_id
  )::stripe_disputes.payment_method_details_amazon_pay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_amazon_pay_funding
  ADD ATTRIBUTE card stripe.payment_method_details_passthrough_card,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_amazon_pay_funding(
  card stripe.payment_method_details_passthrough_card DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_amazon_pay_funding
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card, "type"
  )::stripe_disputes.payment_method_details_amazon_pay_funding;
$$;

ALTER TYPE stripe_disputes.payment_method_details_au_becs_debit
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_au_becs_debit(
  bsb_number TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_au_becs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, expected_debit_date, fingerprint, last4, mandate
  )::stripe_disputes.payment_method_details_au_becs_debit;
$$;

ALTER TYPE stripe_disputes.payment_method_details_bacs_debit
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE sort_code TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_bacs_debit(
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  sort_code TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_bacs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expected_debit_date, fingerprint, last4, mandate, sort_code
  )::stripe_disputes.payment_method_details_bacs_debit;
$$;

ALTER TYPE stripe_disputes.payment_method_details_billie
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_billie(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_billie
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(transaction_id)::stripe_disputes.payment_method_details_billie;
$$;

ALTER TYPE stripe_disputes.payment_method_details_blik
  ADD ATTRIBUTE buyer_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_blik(
  buyer_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_blik
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(buyer_id)::stripe_disputes.payment_method_details_blik;
$$;

ALTER TYPE stripe_disputes.payment_method_details_boleto
  ADD ATTRIBUTE tax_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_boleto(
  tax_id TEXT
)
RETURNS stripe_disputes.payment_method_details_boleto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax_id)::stripe_disputes.payment_method_details_boleto;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE amount_authorized BIGINT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE capture_before BIGINT,
  ADD ATTRIBUTE checks stripe_disputes.payment_method_details_card_check,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE extended_authorization stripe_disputes.payment_method_details_card_extended_authorization,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE incremental_authorization stripe_disputes.payment_method_details_card_incremental_authorization,
  ADD ATTRIBUTE installments stripe_disputes.payment_method_details_card_installment,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE multicapture stripe_disputes.payment_method_details_card_multicapture,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE network_token stripe_disputes.payment_method_details_card_network_token,
  ADD ATTRIBUTE network_transaction_id TEXT,
  ADD ATTRIBUTE overcapture stripe_disputes.payment_method_details_card_overcapture,
  ADD ATTRIBUTE regulated_status TEXT,
  ADD ATTRIBUTE three_d_secure stripe_disputes.payment_method_details_card_three_d_secure,
  ADD ATTRIBUTE wallet stripe_disputes.payment_method_details_card_wallet;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card(
  exp_month BIGINT,
  exp_year BIGINT,
  amount_authorized BIGINT DEFAULT NULL,
  authorization_code TEXT DEFAULT NULL,
  brand TEXT DEFAULT NULL,
  capture_before BIGINT DEFAULT NULL,
  checks stripe_disputes.payment_method_details_card_check DEFAULT NULL,
  country TEXT DEFAULT NULL,
  extended_authorization stripe_disputes.payment_method_details_card_extended_authorization DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  incremental_authorization stripe_disputes.payment_method_details_card_incremental_authorization DEFAULT NULL,
  installments stripe_disputes.payment_method_details_card_installment DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  multicapture stripe_disputes.payment_method_details_card_multicapture DEFAULT NULL,
  network TEXT DEFAULT NULL,
  network_token stripe_disputes.payment_method_details_card_network_token DEFAULT NULL,
  network_transaction_id TEXT DEFAULT NULL,
  overcapture stripe_disputes.payment_method_details_card_overcapture DEFAULT NULL,
  regulated_status TEXT DEFAULT NULL,
  three_d_secure stripe_disputes.payment_method_details_card_three_d_secure DEFAULT NULL,
  wallet stripe_disputes.payment_method_details_card_wallet DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    exp_month,
    exp_year,
    amount_authorized,
    authorization_code,
    brand,
    capture_before,
    checks,
    country,
    extended_authorization,
    fingerprint,
    funding,
    incremental_authorization,
    installments,
    last4,
    mandate,
    multicapture,
    network,
    network_token,
    network_transaction_id,
    overcapture,
    regulated_status,
    three_d_secure,
    wallet
  )::stripe_disputes.payment_method_details_card;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_check
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_postal_code_check TEXT,
  ADD ATTRIBUTE cvc_check TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_check(
  address_line1_check TEXT DEFAULT NULL,
  address_postal_code_check TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_card_check
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check, address_postal_code_check, cvc_check
  )::stripe_disputes.payment_method_details_card_check;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_extended_authorization
  ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_extended_authorization(
  status TEXT
)
RETURNS stripe_disputes.payment_method_details_card_extended_authorization
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status
  )::stripe_disputes.payment_method_details_card_extended_authorization;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_incremental_authorization
  ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_incremental_authorization(
  status TEXT
)
RETURNS stripe_disputes.payment_method_details_card_incremental_authorization
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status
  )::stripe_disputes.payment_method_details_card_incremental_authorization;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_installment
  ADD ATTRIBUTE "plan" stripe.payment_method_details_card_installments_plan;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_installment(
  "plan" stripe.payment_method_details_card_installments_plan DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_card_installment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("plan")::stripe_disputes.payment_method_details_card_installment;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_multicapture
  ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_multicapture(
  status TEXT
)
RETURNS stripe_disputes.payment_method_details_card_multicapture
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(status)::stripe_disputes.payment_method_details_card_multicapture;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_network_token
  ADD ATTRIBUTE used BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_network_token(
  used BOOLEAN
)
RETURNS stripe_disputes.payment_method_details_card_network_token
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(used)::stripe_disputes.payment_method_details_card_network_token;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_overcapture
  ADD ATTRIBUTE maximum_amount_capturable BIGINT, ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_overcapture(
  maximum_amount_capturable BIGINT, status TEXT
)
RETURNS stripe_disputes.payment_method_details_card_overcapture
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    maximum_amount_capturable, status
  )::stripe_disputes.payment_method_details_card_overcapture;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_three_d_secure
  ADD ATTRIBUTE authentication_flow TEXT,
  ADD ATTRIBUTE electronic_commerce_indicator TEXT,
  ADD ATTRIBUTE exemption_indicator TEXT,
  ADD ATTRIBUTE exemption_indicator_applied BOOLEAN,
  ADD ATTRIBUTE "result" TEXT,
  ADD ATTRIBUTE result_reason TEXT,
  ADD ATTRIBUTE transaction_id TEXT,
  ADD ATTRIBUTE "version" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_three_d_secure(
  authentication_flow TEXT DEFAULT NULL,
  electronic_commerce_indicator TEXT DEFAULT NULL,
  exemption_indicator TEXT DEFAULT NULL,
  exemption_indicator_applied BOOLEAN DEFAULT NULL,
  "result" TEXT DEFAULT NULL,
  result_reason TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL,
  "version" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_card_three_d_secure
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    authentication_flow,
    electronic_commerce_indicator,
    exemption_indicator,
    exemption_indicator_applied,
    "result",
    result_reason,
    transaction_id,
    "version"
  )::stripe_disputes.payment_method_details_card_three_d_secure;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_wallet
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE amex_express_checkout stripe_disputes.payment_method_details_card_wallet_amex_express_checkout,
  ADD ATTRIBUTE apple_pay stripe_disputes.payment_method_details_card_wallet_apple_pay,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE google_pay stripe_disputes.payment_method_details_card_wallet_google_pay,
  ADD ATTRIBUTE "link" stripe_disputes.payment_method_details_card_wallet_link,
  ADD ATTRIBUTE masterpass stripe_disputes.payment_method_details_card_wallet_masterpass,
  ADD ATTRIBUTE samsung_pay stripe_disputes.payment_method_details_card_wallet_samsung_pay,
  ADD ATTRIBUTE visa_checkout stripe_disputes.payment_method_details_card_wallet_visa_checkout;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_wallet(
  "type" TEXT,
  amex_express_checkout stripe_disputes.payment_method_details_card_wallet_amex_express_checkout DEFAULT NULL,
  apple_pay stripe_disputes.payment_method_details_card_wallet_apple_pay DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  google_pay stripe_disputes.payment_method_details_card_wallet_google_pay DEFAULT NULL,
  "link" stripe_disputes.payment_method_details_card_wallet_link DEFAULT NULL,
  masterpass stripe_disputes.payment_method_details_card_wallet_masterpass DEFAULT NULL,
  samsung_pay stripe_disputes.payment_method_details_card_wallet_samsung_pay DEFAULT NULL,
  visa_checkout stripe_disputes.payment_method_details_card_wallet_visa_checkout DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_card_wallet
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
  )::stripe_disputes.payment_method_details_card_wallet;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_wallet_masterpass
  ADD ATTRIBUTE billing_address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE shipping_address stripe.address;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_wallet_masterpass(
  billing_address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  shipping_address stripe.address DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_card_wallet_masterpass
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_address, email, "name", shipping_address
  )::stripe_disputes.payment_method_details_card_wallet_masterpass;
$$;

ALTER TYPE stripe_disputes.payment_method_details_card_wallet_visa_checkout
  ADD ATTRIBUTE billing_address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE shipping_address stripe.address;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_card_wallet_visa_checkout(
  billing_address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  shipping_address stripe.address DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_card_wallet_visa_checkout
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    billing_address, email, "name", shipping_address
  )::stripe_disputes.payment_method_details_card_wallet_visa_checkout;
$$;

ALTER TYPE stripe_disputes.payment_method_details_cashapp
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE cashtag TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_cashapp(
  buyer_id TEXT DEFAULT NULL,
  cashtag TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_cashapp
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, cashtag, transaction_id
  )::stripe_disputes.payment_method_details_cashapp;
$$;

ALTER TYPE stripe_disputes.payment_method_details_crypto
  ADD ATTRIBUTE buyer_address TEXT,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE token_currency TEXT,
  ADD ATTRIBUTE transaction_hash TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_crypto(
  buyer_address TEXT DEFAULT NULL,
  network TEXT DEFAULT NULL,
  token_currency TEXT DEFAULT NULL,
  transaction_hash TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_crypto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_address, network, token_currency, transaction_hash
  )::stripe_disputes.payment_method_details_crypto;
$$;

ALTER TYPE stripe_disputes.payment_method_details_ep
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_ep(
  bank TEXT DEFAULT NULL, verified_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_ep
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank, verified_name)::stripe_disputes.payment_method_details_ep;
$$;

ALTER TYPE stripe_disputes.payment_method_details_fpx
  ADD ATTRIBUTE bank TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_fpx(
  bank TEXT, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_fpx
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank, transaction_id)::stripe_disputes.payment_method_details_fpx;
$$;

ALTER TYPE stripe_disputes.payment_method_details_giropay
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_giropay(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_giropay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, bank_name, bic, verified_name
  )::stripe_disputes.payment_method_details_giropay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_grabpay
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_grabpay(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_grabpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(transaction_id)::stripe_disputes.payment_method_details_grabpay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_interac_present
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
  ADD ATTRIBUTE receipt stripe_disputes.payment_method_details_interac_present_receipt;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_interac_present(
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
  receipt stripe_disputes.payment_method_details_interac_present_receipt DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_interac_present
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
  )::stripe_disputes.payment_method_details_interac_present;
$$;

ALTER TYPE stripe_disputes.payment_method_details_interac_present_receipt
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE application_cryptogram TEXT,
  ADD ATTRIBUTE application_preferred_name TEXT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE authorization_response_code TEXT,
  ADD ATTRIBUTE cardholder_verification_method TEXT,
  ADD ATTRIBUTE dedicated_file_name TEXT,
  ADD ATTRIBUTE terminal_verification_results TEXT,
  ADD ATTRIBUTE transaction_status_information TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_interac_present_receipt(
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
RETURNS stripe_disputes.payment_method_details_interac_present_receipt
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
  )::stripe_disputes.payment_method_details_interac_present_receipt;
$$;

ALTER TYPE stripe_disputes.payment_method_details_kakao_pay
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_kakao_pay(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_kakao_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_disputes.payment_method_details_kakao_pay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_klarna
  ADD ATTRIBUTE payer_details stripe_disputes.payment_method_details_klarna_payer_detail,
  ADD ATTRIBUTE payment_method_category TEXT,
  ADD ATTRIBUTE preferred_locale TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_klarna(
  payer_details stripe_disputes.payment_method_details_klarna_payer_detail DEFAULT NULL,
  payment_method_category TEXT DEFAULT NULL,
  preferred_locale TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payer_details, payment_method_category, preferred_locale
  )::stripe_disputes.payment_method_details_klarna;
$$;

ALTER TYPE stripe_disputes.payment_method_details_klarna_payer_detail
  ADD ATTRIBUTE address stripe_disputes.payment_method_details_klarna_payer_detail_address;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_klarna_payer_detail(
  address stripe_disputes.payment_method_details_klarna_payer_detail_address DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_klarna_payer_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address
  )::stripe_disputes.payment_method_details_klarna_payer_detail;
$$;

ALTER TYPE stripe_disputes.payment_method_details_klarna_payer_detail_address
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_klarna_payer_detail_address(
  country TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_klarna_payer_detail_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_disputes.payment_method_details_klarna_payer_detail_address;
$$;

ALTER TYPE stripe_disputes.payment_method_details_konbini
  ADD ATTRIBUTE store stripe_disputes.payment_method_details_konbini_store;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_konbini(
  store stripe_disputes.payment_method_details_konbini_store DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_konbini
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(store)::stripe_disputes.payment_method_details_konbini;
$$;

ALTER TYPE stripe_disputes.payment_method_details_konbini_store
  ADD ATTRIBUTE "chain" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_konbini_store(
  "chain" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_konbini_store
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("chain")::stripe_disputes.payment_method_details_konbini_store;
$$;

ALTER TYPE stripe_disputes.payment_method_details_kr_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE buyer_id TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_kr_card(
  brand TEXT DEFAULT NULL,
  buyer_id TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_kr_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, buyer_id, last4, transaction_id
  )::stripe_disputes.payment_method_details_kr_card;
$$;

ALTER TYPE stripe_disputes.payment_method_details_link
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_link(
  country TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_link
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(country)::stripe_disputes.payment_method_details_link;
$$;

ALTER TYPE stripe_disputes.payment_method_details_mobilepay
  ADD ATTRIBUTE card stripe_disputes.payment_method_details_mobilepay_card;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_mobilepay(
  card stripe_disputes.payment_method_details_mobilepay_card DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_mobilepay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(card)::stripe_disputes.payment_method_details_mobilepay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_mobilepay_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_mobilepay_card(
  brand TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_mobilepay_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, country, exp_month, exp_year, last4
  )::stripe_disputes.payment_method_details_mobilepay_card;
$$;

ALTER TYPE stripe_disputes.payment_method_details_multibanco
  ADD ATTRIBUTE entity TEXT, ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_multibanco(
  entity TEXT DEFAULT NULL, reference TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_multibanco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    entity, reference
  )::stripe_disputes.payment_method_details_multibanco;
$$;

ALTER TYPE stripe_disputes.payment_method_details_naver_pay
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_naver_pay(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_naver_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_disputes.payment_method_details_naver_pay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_nz_bank_account
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE suffix TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_nz_bank_account(
  bank_code TEXT,
  bank_name TEXT,
  branch_code TEXT,
  last4 TEXT,
  account_holder_name TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  suffix TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_nz_bank_account
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
  )::stripe_disputes.payment_method_details_nz_bank_account;
$$;

ALTER TYPE stripe_disputes.payment_method_details_oxxo
  ADD ATTRIBUTE "number" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_oxxo(
  "number" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_oxxo
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("number")::stripe_disputes.payment_method_details_oxxo;
$$;

ALTER TYPE stripe_disputes.payment_method_details_p24
  ADD ATTRIBUTE bank TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_p24(
  bank TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, reference, verified_name
  )::stripe_disputes.payment_method_details_p24;
$$;

ALTER TYPE stripe_disputes.payment_method_details_payco
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_payco(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_payco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_disputes.payment_method_details_payco;
$$;

ALTER TYPE stripe_disputes.payment_method_details_paynow
  ADD ATTRIBUTE "location" TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_paynow(
  "location" TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_paynow
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "location", reader, reference
  )::stripe_disputes.payment_method_details_paynow;
$$;

ALTER TYPE stripe_disputes.payment_method_details_paypal
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE payer_email TEXT,
  ADD ATTRIBUTE payer_id TEXT,
  ADD ATTRIBUTE payer_name TEXT,
  ADD ATTRIBUTE seller_protection stripe_disputes.payment_method_details_paypal_seller_protection,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_paypal(
  country TEXT DEFAULT NULL,
  payer_email TEXT DEFAULT NULL,
  payer_id TEXT DEFAULT NULL,
  payer_name TEXT DEFAULT NULL,
  seller_protection stripe_disputes.payment_method_details_paypal_seller_protection DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_paypal
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
  )::stripe_disputes.payment_method_details_paypal;
$$;

ALTER TYPE stripe_disputes.payment_method_details_paypal_seller_protection
  ADD ATTRIBUTE status TEXT, ADD ATTRIBUTE dispute_categories TEXT[];

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_paypal_seller_protection(
  status TEXT, dispute_categories TEXT[] DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_paypal_seller_protection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status, dispute_categories
  )::stripe_disputes.payment_method_details_paypal_seller_protection;
$$;

ALTER TYPE stripe_disputes.payment_method_details_payto
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT,
  ADD ATTRIBUTE pay_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_payto(
  bsb_number TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL,
  pay_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bsb_number, last4, mandate, pay_id
  )::stripe_disputes.payment_method_details_payto;
$$;

ALTER TYPE stripe_disputes.payment_method_details_pix
  ADD ATTRIBUTE bank_transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_pix(
  bank_transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_pix
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bank_transaction_id)::stripe_disputes.payment_method_details_pix;
$$;

ALTER TYPE stripe_disputes.payment_method_details_promptpay
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_promptpay(
  reference TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_promptpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(reference)::stripe_disputes.payment_method_details_promptpay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_revolut_pay
  ADD ATTRIBUTE funding stripe_disputes.payment_method_details_revolut_pay_funding,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_revolut_pay(
  funding stripe_disputes.payment_method_details_revolut_pay_funding DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_revolut_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    funding, transaction_id
  )::stripe_disputes.payment_method_details_revolut_pay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_revolut_pay_funding
  ADD ATTRIBUTE card stripe.payment_method_details_passthrough_card,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_revolut_pay_funding(
  card stripe.payment_method_details_passthrough_card DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_revolut_pay_funding
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card, "type"
  )::stripe_disputes.payment_method_details_revolut_pay_funding;
$$;

ALTER TYPE stripe_disputes.payment_method_details_samsung_pay
  ADD ATTRIBUTE buyer_id TEXT, ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_samsung_pay(
  buyer_id TEXT DEFAULT NULL, transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_samsung_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    buyer_id, transaction_id
  )::stripe_disputes.payment_method_details_samsung_pay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_satispay
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_satispay(
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_satispay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(transaction_id)::stripe_disputes.payment_method_details_satispay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_sepa_debit
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_sepa_debit(
  bank_code TEXT DEFAULT NULL,
  branch_code TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  expected_debit_date TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_sepa_debit
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
  )::stripe_disputes.payment_method_details_sepa_debit;
$$;

ALTER TYPE stripe_disputes.payment_method_details_swish
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE payment_reference TEXT,
  ADD ATTRIBUTE verified_phone_last4 TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_swish(
  fingerprint TEXT DEFAULT NULL,
  payment_reference TEXT DEFAULT NULL,
  verified_phone_last4 TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_swish
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, payment_reference, verified_phone_last4
  )::stripe_disputes.payment_method_details_swish;
$$;

ALTER TYPE stripe_disputes.payment_method_details_wechat_pay
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE "location" TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE transaction_id TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_wechat_pay(
  fingerprint TEXT DEFAULT NULL,
  "location" TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_wechat_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    fingerprint, "location", reader, transaction_id
  )::stripe_disputes.payment_method_details_wechat_pay;
$$;

ALTER TYPE stripe_disputes.payment_method_details_bancontact_dispute
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE generated_sepa_debit JSONB,
  ADD ATTRIBUTE generated_sepa_debit_mandate JSONB,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_bancontact_dispute(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  generated_sepa_debit JSONB DEFAULT NULL,
  generated_sepa_debit_mandate JSONB DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  preferred_language TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_bancontact_dispute
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
  )::stripe_disputes.payment_method_details_bancontact_dispute;
$$;

ALTER TYPE stripe_disputes.payment_method_details_ideal_dispute
  ADD ATTRIBUTE bank TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE generated_sepa_debit JSONB,
  ADD ATTRIBUTE generated_sepa_debit_mandate JSONB,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE transaction_id TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_ideal_dispute(
  bank TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  generated_sepa_debit JSONB DEFAULT NULL,
  generated_sepa_debit_mandate JSONB DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  transaction_id TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_ideal_dispute
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank,
    bic,
    generated_sepa_debit,
    generated_sepa_debit_mandate,
    iban_last4,
    transaction_id,
    verified_name
  )::stripe_disputes.payment_method_details_ideal_dispute;
$$;

ALTER TYPE stripe_disputes.payment_method_details_sofort_dispute
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE generated_sepa_debit JSONB,
  ADD ATTRIBUTE generated_sepa_debit_mandate JSONB,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE verified_name TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_sofort_dispute(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  generated_sepa_debit JSONB DEFAULT NULL,
  generated_sepa_debit_mandate JSONB DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  preferred_language TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payment_method_details_sofort_dispute
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    bank_name,
    bic,
    country,
    generated_sepa_debit,
    generated_sepa_debit_mandate,
    iban_last4,
    preferred_language,
    verified_name
  )::stripe_disputes.payment_method_details_sofort_dispute;
$$;

ALTER TYPE stripe_disputes.payment_method_details_us_bank_account
  ADD ATTRIBUTE account_holder_type TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE expected_debit_date TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate JSONB,
  ADD ATTRIBUTE payment_reference TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payment_method_details_us_bank_account(
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
RETURNS stripe_disputes.payment_method_details_us_bank_account
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
  )::stripe_disputes.payment_method_details_us_bank_account;
$$;

ALTER TYPE stripe_disputes.payout
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE arrival_date BIGINT,
  ADD ATTRIBUTE automatic BOOLEAN,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "method" TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE reconciliation_status TEXT,
  ADD ATTRIBUTE source_type TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE application_fee JSONB,
  ADD ATTRIBUTE application_fee_amount BIGINT,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE destination JSONB,
  ADD ATTRIBUTE failure_balance_transaction JSONB,
  ADD ATTRIBUTE failure_code TEXT,
  ADD ATTRIBUTE failure_message TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE original_payout JSONB,
  ADD ATTRIBUTE payout_method TEXT,
  ADD ATTRIBUTE reversed_by JSONB,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE trace_id stripe_disputes.payout_trace_id;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payout(
  "id" TEXT,
  amount BIGINT,
  arrival_date BIGINT,
  automatic BOOLEAN,
  created BIGINT,
  currency TEXT,
  livemode BOOLEAN,
  "method" TEXT,
  "object" TEXT,
  reconciliation_status TEXT,
  source_type TEXT,
  status TEXT,
  "type" TEXT,
  application_fee JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  balance_transaction JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  destination JSONB DEFAULT NULL,
  failure_balance_transaction JSONB DEFAULT NULL,
  failure_code TEXT DEFAULT NULL,
  failure_message TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  original_payout JSONB DEFAULT NULL,
  payout_method TEXT DEFAULT NULL,
  reversed_by JSONB DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  trace_id stripe_disputes.payout_trace_id DEFAULT NULL
)
RETURNS stripe_disputes.payout
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    arrival_date,
    automatic,
    created,
    currency,
    livemode,
    "method",
    "object",
    reconciliation_status,
    source_type,
    status,
    "type",
    application_fee,
    application_fee_amount,
    balance_transaction,
    description,
    destination,
    failure_balance_transaction,
    failure_code,
    failure_message,
    metadata,
    original_payout,
    payout_method,
    reversed_by,
    statement_descriptor,
    trace_id
  )::stripe_disputes.payout;
$$;

ALTER TYPE stripe_disputes.payout_trace_id
  ADD ATTRIBUTE status TEXT, ADD ATTRIBUTE "value" TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_payout_trace_id(
  status TEXT, "value" TEXT DEFAULT NULL
)
RETURNS stripe_disputes.payout_trace_id
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(status, "value")::stripe_disputes.payout_trace_id;
$$;

ALTER TYPE stripe_disputes.topup
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE expected_availability_date BIGINT,
  ADD ATTRIBUTE failure_code TEXT,
  ADD ATTRIBUTE failure_message TEXT,
  ADD ATTRIBUTE "source" stripe.source,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE transfer_group TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_topup(
  "id" TEXT,
  amount BIGINT,
  created BIGINT,
  currency TEXT,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  status TEXT,
  balance_transaction JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  expected_availability_date BIGINT DEFAULT NULL,
  failure_code TEXT DEFAULT NULL,
  failure_message TEXT DEFAULT NULL,
  "source" stripe.source DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  transfer_group TEXT DEFAULT NULL
)
RETURNS stripe_disputes.topup
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    created,
    currency,
    livemode,
    metadata,
    "object",
    status,
    balance_transaction,
    description,
    expected_availability_date,
    failure_code,
    failure_message,
    "source",
    statement_descriptor,
    transfer_group
  )::stripe_disputes.topup;
$$;

ALTER TYPE stripe_disputes.transfer
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_reversed BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE reversals stripe_disputes.transfer_reversal,
  ADD ATTRIBUTE reversed BOOLEAN,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE destination JSONB,
  ADD ATTRIBUTE destination_payment JSONB,
  ADD ATTRIBUTE source_transaction JSONB,
  ADD ATTRIBUTE source_type TEXT,
  ADD ATTRIBUTE transfer_group TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_transfer(
  "id" TEXT,
  amount BIGINT,
  amount_reversed BIGINT,
  created BIGINT,
  currency TEXT,
  livemode BOOLEAN,
  metadata JSONB,
  "object" TEXT,
  reversals stripe_disputes.transfer_reversal,
  reversed BOOLEAN,
  balance_transaction JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  destination JSONB DEFAULT NULL,
  destination_payment JSONB DEFAULT NULL,
  source_transaction JSONB DEFAULT NULL,
  source_type TEXT DEFAULT NULL,
  transfer_group TEXT DEFAULT NULL
)
RETURNS stripe_disputes.transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    amount_reversed,
    created,
    currency,
    livemode,
    metadata,
    "object",
    reversals,
    reversed,
    balance_transaction,
    description,
    destination,
    destination_payment,
    source_transaction,
    source_type,
    transfer_group
  )::stripe_disputes.transfer;
$$;

ALTER TYPE stripe_disputes.transfer_reversal
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_transfer_reversal(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_disputes.transfer_reversal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_disputes.transfer_reversal;
$$;

ALTER TYPE stripe_disputes.evidence
  ADD ATTRIBUTE access_activity_log TEXT,
  ADD ATTRIBUTE billing_address TEXT,
  ADD ATTRIBUTE cancellation_policy TEXT,
  ADD ATTRIBUTE cancellation_policy_disclosure TEXT,
  ADD ATTRIBUTE cancellation_rebuttal TEXT,
  ADD ATTRIBUTE customer_communication TEXT,
  ADD ATTRIBUTE customer_email_address TEXT,
  ADD ATTRIBUTE customer_name TEXT,
  ADD ATTRIBUTE customer_purchase_ip TEXT,
  ADD ATTRIBUTE customer_signature TEXT,
  ADD ATTRIBUTE duplicate_charge_documentation TEXT,
  ADD ATTRIBUTE duplicate_charge_explanation TEXT,
  ADD ATTRIBUTE duplicate_charge_id TEXT,
  ADD ATTRIBUTE enhanced_evidence JSONB,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE receipt TEXT,
  ADD ATTRIBUTE refund_policy TEXT,
  ADD ATTRIBUTE refund_policy_disclosure TEXT,
  ADD ATTRIBUTE refund_refusal_explanation TEXT,
  ADD ATTRIBUTE service_date TEXT,
  ADD ATTRIBUTE service_documentation TEXT,
  ADD ATTRIBUTE shipping_address TEXT,
  ADD ATTRIBUTE shipping_carrier TEXT,
  ADD ATTRIBUTE shipping_date TEXT,
  ADD ATTRIBUTE shipping_documentation TEXT,
  ADD ATTRIBUTE shipping_tracking_number TEXT,
  ADD ATTRIBUTE uncategorized_file TEXT,
  ADD ATTRIBUTE uncategorized_text TEXT;

CREATE OR REPLACE FUNCTION stripe_disputes.make_evidence(
  access_activity_log TEXT DEFAULT NULL,
  billing_address TEXT DEFAULT NULL,
  cancellation_policy TEXT DEFAULT NULL,
  cancellation_policy_disclosure TEXT DEFAULT NULL,
  cancellation_rebuttal TEXT DEFAULT NULL,
  customer_communication TEXT DEFAULT NULL,
  customer_email_address TEXT DEFAULT NULL,
  customer_name TEXT DEFAULT NULL,
  customer_purchase_ip TEXT DEFAULT NULL,
  customer_signature TEXT DEFAULT NULL,
  duplicate_charge_documentation TEXT DEFAULT NULL,
  duplicate_charge_explanation TEXT DEFAULT NULL,
  duplicate_charge_id TEXT DEFAULT NULL,
  enhanced_evidence JSONB DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  receipt TEXT DEFAULT NULL,
  refund_policy TEXT DEFAULT NULL,
  refund_policy_disclosure TEXT DEFAULT NULL,
  refund_refusal_explanation TEXT DEFAULT NULL,
  service_date TEXT DEFAULT NULL,
  service_documentation TEXT DEFAULT NULL,
  shipping_address TEXT DEFAULT NULL,
  shipping_carrier TEXT DEFAULT NULL,
  shipping_date TEXT DEFAULT NULL,
  shipping_documentation TEXT DEFAULT NULL,
  shipping_tracking_number TEXT DEFAULT NULL,
  uncategorized_file TEXT DEFAULT NULL,
  uncategorized_text TEXT DEFAULT NULL
)
RETURNS stripe_disputes.evidence
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    access_activity_log,
    billing_address,
    cancellation_policy,
    cancellation_policy_disclosure,
    cancellation_rebuttal,
    customer_communication,
    customer_email_address,
    customer_name,
    customer_purchase_ip,
    customer_signature,
    duplicate_charge_documentation,
    duplicate_charge_explanation,
    duplicate_charge_id,
    enhanced_evidence,
    product_description,
    receipt,
    refund_policy,
    refund_policy_disclosure,
    refund_refusal_explanation,
    service_date,
    service_documentation,
    shipping_address,
    shipping_carrier,
    shipping_date,
    shipping_documentation,
    shipping_tracking_number,
    uncategorized_file,
    uncategorized_text
  )::stripe_disputes.evidence;
$$;

CREATE OR REPLACE FUNCTION stripe_disputes._update(
  dispute TEXT,
  evidence stripe_disputes.evidence DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  submit BOOLEAN DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stripe_minimal._types import not_given

  response = GD["__stripe_context__"].client.disputes.with_raw_response.update(
      dispute=dispute,
      evidence=not_given if evidence is None else GD["__stripe_context__"].strip_none(evidence),
      expand=not_given if expand is None else expand,
      metadata=not_given if metadata is None else json.loads(metadata),
      submit=not_given if submit is None else submit,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_disputes.update(
  dispute TEXT,
  evidence stripe_disputes.evidence DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  submit BOOLEAN DEFAULT NULL
)
RETURNS stripe_disputes.dispute
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_disputes.dispute,
      stripe_disputes._update(dispute, evidence, expand, metadata, submit)
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_disputes._list_first_page_py(
  charge TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  payment_intent TEXT DEFAULT NULL,
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

  page = GD["__stripe_context__"].client.disputes.list(
      charge=not_given if charge is None else charge,
      created=not_given if created is None else json.loads(created),
      ending_before=not_given if ending_before is None else ending_before,
      expand=not_given if expand is None else expand,
      limit=not_given if limit is None else limit,
      payment_intent=not_given if payment_intent is None else payment_intent,
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

-- A simpler wrapper around `stripe_disputes._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_disputes._list_first_page(
  charge TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  payment_intent TEXT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL
)
RETURNS stripe_internal.page
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN stripe_disputes._list_first_page_py(
      charge,
      created,
      ending_before,
      expand,
      "limit",
      payment_intent,
      starting_after
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_disputes._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal.types import Dispute
  from stripe_minimal.pagination import SyncMyCursorIDPage
  from stripe_minimal._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client._request_api_list(
    model=Dispute,
    page=SyncMyCursorIDPage[Dispute],
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

CREATE OR REPLACE FUNCTION stripe_disputes.list(
  charge TEXT DEFAULT NULL,
  created JSONB DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  payment_intent TEXT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL
)
RETURNS SETOF stripe_disputes.dispute
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_disputes._list_first_page(
      charge,
      created,
      ending_before,
      expand,
      "limit",
      payment_intent,
      starting_after
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_disputes._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_disputes.dispute, "data")).* FROM paginated;
$$;