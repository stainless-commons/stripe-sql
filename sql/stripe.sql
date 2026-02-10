ALTER TYPE stripe.account_requirements_error
  ADD ATTRIBUTE code TEXT,
  ADD ATTRIBUTE reason TEXT,
  ADD ATTRIBUTE requirement TEXT;

CREATE OR REPLACE FUNCTION stripe.make_account_requirements_error(
  code TEXT, reason TEXT, requirement TEXT
)
RETURNS stripe.account_requirements_error
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(code, reason, requirement)::stripe.account_requirements_error;
$$;

ALTER TYPE stripe.address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL
)
RETURNS stripe.address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(city, country, line1, line2, postal_code, "state")::stripe.address;
$$;

ALTER TYPE stripe.application
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "name" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_application(
  "id" TEXT, "object" TEXT, "name" TEXT DEFAULT NULL
)
RETURNS stripe.application
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("id", "object", "name")::stripe.application;
$$;

ALTER TYPE stripe.billing_clocks_resource_status_details_advancing_status_details
  ADD ATTRIBUTE target_frozen_time BIGINT;

CREATE OR REPLACE FUNCTION stripe.m_b_clocks_resource_status_details_advancing_status_details(
  target_frozen_time BIGINT
)
RETURNS stripe.billing_clocks_resource_status_details_advancing_status_details
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    target_frozen_time
  )::stripe.billing_clocks_resource_status_details_advancing_status_details;
$$;

ALTER TYPE stripe.billing_clocks_resource_status_details_status_details
  ADD ATTRIBUTE advancing stripe.billing_clocks_resource_status_details_advancing_status_details;

CREATE OR REPLACE FUNCTION stripe.make_billing_clocks_resource_status_details_status_details(
  advancing stripe.billing_clocks_resource_status_details_advancing_status_details DEFAULT NULL
)
RETURNS stripe.billing_clocks_resource_status_details_status_details
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    advancing
  )::stripe.billing_clocks_resource_status_details_status_details;
$$;

ALTER TYPE stripe.deleted_application
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE deleted BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "name" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_deleted_application(
  "id" TEXT, deleted BOOLEAN, "object" TEXT, "name" TEXT DEFAULT NULL
)
RETURNS stripe.deleted_application
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("id", deleted, "object", "name")::stripe.deleted_application;
$$;

ALTER TYPE stripe.deleted_customer
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE deleted BOOLEAN,
  ADD ATTRIBUTE "object" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_deleted_customer(
  "id" TEXT, deleted BOOLEAN, "object" TEXT
)
RETURNS stripe.deleted_customer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("id", deleted, "object")::stripe.deleted_customer;
$$;

ALTER TYPE stripe.deleted_tax_id
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE deleted BOOLEAN,
  ADD ATTRIBUTE "object" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_deleted_tax_id(
  "id" TEXT, deleted BOOLEAN, "object" TEXT
)
RETURNS stripe.deleted_tax_id
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("id", deleted, "object")::stripe.deleted_tax_id;
$$;

ALTER TYPE stripe.invoice_setting_custom_field
  ADD ATTRIBUTE "name" TEXT, ADD ATTRIBUTE "value" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_invoice_setting_custom_field(
  "name" TEXT, "value" TEXT
)
RETURNS stripe.invoice_setting_custom_field
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("name", "value")::stripe.invoice_setting_custom_field;
$$;

ALTER TYPE stripe.payment_flows_payment_intent_presentment_details
  ADD ATTRIBUTE presentment_amount BIGINT,
  ADD ATTRIBUTE presentment_currency TEXT;

CREATE OR REPLACE FUNCTION stripe.make_payment_flows_payment_intent_presentment_details(
  presentment_amount BIGINT, presentment_currency TEXT
)
RETURNS stripe.payment_flows_payment_intent_presentment_details
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    presentment_amount, presentment_currency
  )::stripe.payment_flows_payment_intent_presentment_details;
$$;

ALTER TYPE stripe.p_flows_private_payment_methods_card_present_common_wallet
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe.m_p_flows_private_payment_methods_card_present_common_wallet(
  "type" TEXT
)
RETURNS stripe.p_flows_private_payment_methods_card_present_common_wallet
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type"
  )::stripe.p_flows_private_payment_methods_card_present_common_wallet;
$$;

ALTER TYPE stripe.payment_method_details_card_installments_plan
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE "count" BIGINT,
  ADD ATTRIBUTE "interval" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_payment_method_details_card_installments_plan(
  "type" TEXT, "count" BIGINT DEFAULT NULL, "interval" TEXT DEFAULT NULL
)
RETURNS stripe.payment_method_details_card_installments_plan
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", "count", "interval"
  )::stripe.payment_method_details_card_installments_plan;
$$;

ALTER TYPE stripe.payment_method_details_card_present
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE incremental_authorization_supported BOOLEAN,
  ADD ATTRIBUTE overcapture_supported BOOLEAN,
  ADD ATTRIBUTE amount_authorized BIGINT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE brand_product TEXT,
  ADD ATTRIBUTE capture_before BIGINT,
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
  ADD ATTRIBUTE offline stripe.payment_method_details_card_present_offline,
  ADD ATTRIBUTE preferred_locales TEXT[],
  ADD ATTRIBUTE read_method TEXT,
  ADD ATTRIBUTE receipt stripe.payment_method_details_card_present_receipt,
  ADD ATTRIBUTE wallet stripe.p_flows_private_payment_methods_card_present_common_wallet;

CREATE OR REPLACE FUNCTION stripe.make_payment_method_details_card_present(
  exp_month BIGINT,
  exp_year BIGINT,
  incremental_authorization_supported BOOLEAN,
  overcapture_supported BOOLEAN,
  amount_authorized BIGINT DEFAULT NULL,
  brand TEXT DEFAULT NULL,
  brand_product TEXT DEFAULT NULL,
  capture_before BIGINT DEFAULT NULL,
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
  offline stripe.payment_method_details_card_present_offline DEFAULT NULL,
  preferred_locales TEXT[] DEFAULT NULL,
  read_method TEXT DEFAULT NULL,
  receipt stripe.payment_method_details_card_present_receipt DEFAULT NULL,
  wallet stripe.p_flows_private_payment_methods_card_present_common_wallet DEFAULT NULL
)
RETURNS stripe.payment_method_details_card_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    exp_month,
    exp_year,
    incremental_authorization_supported,
    overcapture_supported,
    amount_authorized,
    brand,
    brand_product,
    capture_before,
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
    offline,
    preferred_locales,
    read_method,
    receipt,
    wallet
  )::stripe.payment_method_details_card_present;
$$;

ALTER TYPE stripe.payment_method_details_card_present_offline
  ADD ATTRIBUTE stored_at BIGINT, ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_payment_method_details_card_present_offline(
  stored_at BIGINT DEFAULT NULL, "type" TEXT DEFAULT NULL
)
RETURNS stripe.payment_method_details_card_present_offline
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    stored_at, "type"
  )::stripe.payment_method_details_card_present_offline;
$$;

ALTER TYPE stripe.payment_method_details_card_present_receipt
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE application_cryptogram TEXT,
  ADD ATTRIBUTE application_preferred_name TEXT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE authorization_response_code TEXT,
  ADD ATTRIBUTE cardholder_verification_method TEXT,
  ADD ATTRIBUTE dedicated_file_name TEXT,
  ADD ATTRIBUTE terminal_verification_results TEXT,
  ADD ATTRIBUTE transaction_status_information TEXT;

CREATE OR REPLACE FUNCTION stripe.make_payment_method_details_card_present_receipt(
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
RETURNS stripe.payment_method_details_card_present_receipt
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
  )::stripe.payment_method_details_card_present_receipt;
$$;

ALTER TYPE stripe.payment_method_details_passthrough_card
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe.make_payment_method_details_passthrough_card(
  brand TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe.payment_method_details_passthrough_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    brand, country, exp_month, exp_year, funding, last4
  )::stripe.payment_method_details_passthrough_card;
$$;

ALTER TYPE stripe.shipping
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE carrier TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE tracking_number TEXT;

CREATE OR REPLACE FUNCTION stripe.make_shipping(
  address stripe.address DEFAULT NULL,
  carrier TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  tracking_number TEXT DEFAULT NULL
)
RETURNS stripe.shipping
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(address, carrier, "name", phone, tracking_number)::stripe.shipping;
$$;

ALTER TYPE stripe.source
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE client_secret TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE flow TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE ach_credit_transfer stripe.source_type_ach_credit_transfer,
  ADD ATTRIBUTE ach_debit stripe.source_type_ach_debit,
  ADD ATTRIBUTE acss_debit stripe.source_type_acss_debit,
  ADD ATTRIBUTE alipay stripe.source_type_alipay,
  ADD ATTRIBUTE allow_redisplay TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE au_becs_debit stripe.source_type_au_becs_debit,
  ADD ATTRIBUTE bancontact stripe.source_type_bancontact,
  ADD ATTRIBUTE card stripe.source_type_card,
  ADD ATTRIBUTE card_present stripe.source_type_card_present,
  ADD ATTRIBUTE code_verification stripe.source_code_verification_flow,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer TEXT,
  ADD ATTRIBUTE eps stripe.source_type_eps,
  ADD ATTRIBUTE giropay stripe.source_type_giropay,
  ADD ATTRIBUTE ideal stripe.source_type_ideal,
  ADD ATTRIBUTE klarna stripe.source_type_klarna,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE multibanco stripe.source_type_multibanco,
  ADD ATTRIBUTE "owner" stripe.source_owner,
  ADD ATTRIBUTE p24 stripe.source_type_p24,
  ADD ATTRIBUTE receiver stripe.source_receiver_flow,
  ADD ATTRIBUTE redirect stripe.source_redirect_flow,
  ADD ATTRIBUTE sepa_debit stripe.source_type_sepa_debit,
  ADD ATTRIBUTE sofort stripe.source_type_sofort,
  ADD ATTRIBUTE source_order stripe.source_order,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE three_d_secure stripe.source_type_three_d_secure,
  ADD ATTRIBUTE "usage" TEXT,
  ADD ATTRIBUTE wechat stripe.source_type_wechat;

CREATE OR REPLACE FUNCTION stripe.make_source(
  "id" TEXT,
  client_secret TEXT,
  created BIGINT,
  flow TEXT,
  livemode BOOLEAN,
  "object" TEXT,
  status TEXT,
  "type" TEXT,
  ach_credit_transfer stripe.source_type_ach_credit_transfer DEFAULT NULL,
  ach_debit stripe.source_type_ach_debit DEFAULT NULL,
  acss_debit stripe.source_type_acss_debit DEFAULT NULL,
  alipay stripe.source_type_alipay DEFAULT NULL,
  allow_redisplay TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  au_becs_debit stripe.source_type_au_becs_debit DEFAULT NULL,
  bancontact stripe.source_type_bancontact DEFAULT NULL,
  card stripe.source_type_card DEFAULT NULL,
  card_present stripe.source_type_card_present DEFAULT NULL,
  code_verification stripe.source_code_verification_flow DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  eps stripe.source_type_eps DEFAULT NULL,
  giropay stripe.source_type_giropay DEFAULT NULL,
  ideal stripe.source_type_ideal DEFAULT NULL,
  klarna stripe.source_type_klarna DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  multibanco stripe.source_type_multibanco DEFAULT NULL,
  "owner" stripe.source_owner DEFAULT NULL,
  p24 stripe.source_type_p24 DEFAULT NULL,
  receiver stripe.source_receiver_flow DEFAULT NULL,
  redirect stripe.source_redirect_flow DEFAULT NULL,
  sepa_debit stripe.source_type_sepa_debit DEFAULT NULL,
  sofort stripe.source_type_sofort DEFAULT NULL,
  source_order stripe.source_order DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  three_d_secure stripe.source_type_three_d_secure DEFAULT NULL,
  "usage" TEXT DEFAULT NULL,
  wechat stripe.source_type_wechat DEFAULT NULL
)
RETURNS stripe.source
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    client_secret,
    created,
    flow,
    livemode,
    "object",
    status,
    "type",
    ach_credit_transfer,
    ach_debit,
    acss_debit,
    alipay,
    allow_redisplay,
    amount,
    au_becs_debit,
    bancontact,
    card,
    card_present,
    code_verification,
    currency,
    customer,
    eps,
    giropay,
    ideal,
    klarna,
    metadata,
    multibanco,
    "owner",
    p24,
    receiver,
    redirect,
    sepa_debit,
    sofort,
    source_order,
    statement_descriptor,
    three_d_secure,
    "usage",
    wechat
  )::stripe.source;
$$;

ALTER TYPE stripe.source_code_verification_flow
  ADD ATTRIBUTE attempts_remaining BIGINT, ADD ATTRIBUTE status TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_code_verification_flow(
  attempts_remaining BIGINT, status TEXT
)
RETURNS stripe.source_code_verification_flow
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(attempts_remaining, status)::stripe.source_code_verification_flow;
$$;

ALTER TYPE stripe.source_order
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE items stripe.source_order_item[],
  ADD ATTRIBUTE shipping stripe.shipping;

CREATE OR REPLACE FUNCTION stripe.make_source_order(
  amount BIGINT,
  currency TEXT,
  email TEXT DEFAULT NULL,
  items stripe.source_order_item[] DEFAULT NULL,
  shipping stripe.shipping DEFAULT NULL
)
RETURNS stripe.source_order
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(amount, currency, email, items, shipping)::stripe.source_order;
$$;

ALTER TYPE stripe.source_order_item
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE parent TEXT,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_order_item(
  amount BIGINT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  parent TEXT DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe.source_order_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, currency, description, parent, quantity, "type"
  )::stripe.source_order_item;
$$;

ALTER TYPE stripe.source_owner
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE verified_address stripe.address,
  ADD ATTRIBUTE verified_email TEXT,
  ADD ATTRIBUTE verified_name TEXT,
  ADD ATTRIBUTE verified_phone TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_owner(
  address stripe.address DEFAULT NULL,
  email TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  verified_address stripe.address DEFAULT NULL,
  verified_email TEXT DEFAULT NULL,
  verified_name TEXT DEFAULT NULL,
  verified_phone TEXT DEFAULT NULL
)
RETURNS stripe.source_owner
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address,
    email,
    "name",
    phone,
    verified_address,
    verified_email,
    verified_name,
    verified_phone
  )::stripe.source_owner;
$$;

ALTER TYPE stripe.source_receiver_flow
  ADD ATTRIBUTE amount_charged BIGINT,
  ADD ATTRIBUTE amount_received BIGINT,
  ADD ATTRIBUTE amount_returned BIGINT,
  ADD ATTRIBUTE refund_attributes_method TEXT,
  ADD ATTRIBUTE refund_attributes_status TEXT,
  ADD ATTRIBUTE address TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_receiver_flow(
  amount_charged BIGINT,
  amount_received BIGINT,
  amount_returned BIGINT,
  refund_attributes_method TEXT,
  refund_attributes_status TEXT,
  address TEXT DEFAULT NULL
)
RETURNS stripe.source_receiver_flow
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_charged,
    amount_received,
    amount_returned,
    refund_attributes_method,
    refund_attributes_status,
    address
  )::stripe.source_receiver_flow;
$$;

ALTER TYPE stripe.source_redirect_flow
  ADD ATTRIBUTE return_url TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE url TEXT,
  ADD ATTRIBUTE failure_reason TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_redirect_flow(
  return_url TEXT, status TEXT, url TEXT, failure_reason TEXT DEFAULT NULL
)
RETURNS stripe.source_redirect_flow
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    return_url, status, url, failure_reason
  )::stripe.source_redirect_flow;
$$;

ALTER TYPE stripe.source_type_ach_credit_transfer
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE refund_account_holder_name TEXT,
  ADD ATTRIBUTE refund_account_holder_type TEXT,
  ADD ATTRIBUTE refund_routing_number TEXT,
  ADD ATTRIBUTE routing_number TEXT,
  ADD ATTRIBUTE swift_code TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_ach_credit_transfer(
  account_number TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  refund_account_holder_name TEXT DEFAULT NULL,
  refund_account_holder_type TEXT DEFAULT NULL,
  refund_routing_number TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL,
  swift_code TEXT DEFAULT NULL
)
RETURNS stripe.source_type_ach_credit_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_number,
    bank_name,
    fingerprint,
    refund_account_holder_name,
    refund_account_holder_type,
    refund_routing_number,
    routing_number,
    swift_code
  )::stripe.source_type_ach_credit_transfer;
$$;

ALTER TYPE stripe.source_type_ach_debit
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE routing_number TEXT,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_ach_debit(
  bank_name TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe.source_type_ach_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_name, country, fingerprint, last4, routing_number, "type"
  )::stripe.source_type_ach_debit;
$$;

ALTER TYPE stripe.source_type_acss_debit
  ADD ATTRIBUTE bank_address_city TEXT,
  ADD ATTRIBUTE bank_address_line_1 TEXT,
  ADD ATTRIBUTE bank_address_line_2 TEXT,
  ADD ATTRIBUTE bank_address_postal_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE category TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_acss_debit(
  bank_address_city TEXT DEFAULT NULL,
  bank_address_line_1 TEXT DEFAULT NULL,
  bank_address_line_2 TEXT DEFAULT NULL,
  bank_address_postal_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  category TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  routing_number TEXT DEFAULT NULL
)
RETURNS stripe.source_type_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_address_city,
    bank_address_line_1,
    bank_address_line_2,
    bank_address_postal_code,
    bank_name,
    category,
    country,
    fingerprint,
    last4,
    routing_number
  )::stripe.source_type_acss_debit;
$$;

ALTER TYPE stripe.source_type_alipay
  ADD ATTRIBUTE data_string TEXT,
  ADD ATTRIBUTE native_url TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_alipay(
  data_string TEXT DEFAULT NULL,
  native_url TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe.source_type_alipay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    data_string, native_url, statement_descriptor
  )::stripe.source_type_alipay;
$$;

ALTER TYPE stripe.source_type_au_becs_debit
  ADD ATTRIBUTE bsb_number TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_au_becs_debit(
  bsb_number TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL
)
RETURNS stripe.source_type_au_becs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(bsb_number, fingerprint, last4)::stripe.source_type_au_becs_debit;
$$;

ALTER TYPE stripe.source_type_bancontact
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_bancontact(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  preferred_language TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe.source_type_bancontact
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    bank_name,
    bic,
    iban_last4,
    preferred_language,
    statement_descriptor
  )::stripe.source_type_bancontact;
$$;

ALTER TYPE stripe.source_type_card
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_zip_check TEXT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE cvc_check TEXT,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE three_d_secure TEXT,
  ADD ATTRIBUTE tokenization_method TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_card(
  address_line1_check TEXT DEFAULT NULL,
  address_zip_check TEXT DEFAULT NULL,
  brand TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  three_d_secure TEXT DEFAULT NULL,
  tokenization_method TEXT DEFAULT NULL
)
RETURNS stripe.source_type_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check,
    address_zip_check,
    brand,
    country,
    cvc_check,
    dynamic_last4,
    exp_month,
    exp_year,
    fingerprint,
    funding,
    last4,
    "name",
    three_d_secure,
    tokenization_method
  )::stripe.source_type_card;
$$;

ALTER TYPE stripe.source_type_card_present
  ADD ATTRIBUTE application_cryptogram TEXT,
  ADD ATTRIBUTE application_preferred_name TEXT,
  ADD ATTRIBUTE authorization_code TEXT,
  ADD ATTRIBUTE authorization_response_code TEXT,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE cvm_type TEXT,
  ADD ATTRIBUTE data_type TEXT,
  ADD ATTRIBUTE dedicated_file_name TEXT,
  ADD ATTRIBUTE emv_auth_data TEXT,
  ADD ATTRIBUTE evidence_customer_signature TEXT,
  ADD ATTRIBUTE evidence_transaction_certificate TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE pos_device_id TEXT,
  ADD ATTRIBUTE pos_entry_mode TEXT,
  ADD ATTRIBUTE read_method TEXT,
  ADD ATTRIBUTE reader TEXT,
  ADD ATTRIBUTE terminal_verification_results TEXT,
  ADD ATTRIBUTE transaction_status_information TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_card_present(
  application_cryptogram TEXT DEFAULT NULL,
  application_preferred_name TEXT DEFAULT NULL,
  authorization_code TEXT DEFAULT NULL,
  authorization_response_code TEXT DEFAULT NULL,
  brand TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  cvm_type TEXT DEFAULT NULL,
  data_type TEXT DEFAULT NULL,
  dedicated_file_name TEXT DEFAULT NULL,
  emv_auth_data TEXT DEFAULT NULL,
  evidence_customer_signature TEXT DEFAULT NULL,
  evidence_transaction_certificate TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  pos_device_id TEXT DEFAULT NULL,
  pos_entry_mode TEXT DEFAULT NULL,
  read_method TEXT DEFAULT NULL,
  reader TEXT DEFAULT NULL,
  terminal_verification_results TEXT DEFAULT NULL,
  transaction_status_information TEXT DEFAULT NULL
)
RETURNS stripe.source_type_card_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    application_cryptogram,
    application_preferred_name,
    authorization_code,
    authorization_response_code,
    brand,
    country,
    cvm_type,
    data_type,
    dedicated_file_name,
    emv_auth_data,
    evidence_customer_signature,
    evidence_transaction_certificate,
    exp_month,
    exp_year,
    fingerprint,
    funding,
    last4,
    pos_device_id,
    pos_entry_mode,
    read_method,
    reader,
    terminal_verification_results,
    transaction_status_information
  )::stripe.source_type_card_present;
$$;

ALTER TYPE stripe.source_type_eps
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_eps(
  reference TEXT DEFAULT NULL, statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe.source_type_eps
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(reference, statement_descriptor)::stripe.source_type_eps;
$$;

ALTER TYPE stripe.source_type_giropay
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_giropay(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe.source_type_giropay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code, bank_name, bic, statement_descriptor
  )::stripe.source_type_giropay;
$$;

ALTER TYPE stripe.source_type_ideal
  ADD ATTRIBUTE bank TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_ideal(
  bank TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe.source_type_ideal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank, bic, iban_last4, statement_descriptor
  )::stripe.source_type_ideal;
$$;

ALTER TYPE stripe.source_type_klarna
  ADD ATTRIBUTE background_image_url TEXT,
  ADD ATTRIBUTE client_token TEXT,
  ADD ATTRIBUTE first_name TEXT,
  ADD ATTRIBUTE last_name TEXT,
  ADD ATTRIBUTE locale TEXT,
  ADD ATTRIBUTE logo_url TEXT,
  ADD ATTRIBUTE page_title TEXT,
  ADD ATTRIBUTE pay_later_asset_urls_descriptive TEXT,
  ADD ATTRIBUTE pay_later_asset_urls_standard TEXT,
  ADD ATTRIBUTE pay_later_name TEXT,
  ADD ATTRIBUTE pay_later_redirect_url TEXT,
  ADD ATTRIBUTE pay_now_asset_urls_descriptive TEXT,
  ADD ATTRIBUTE pay_now_asset_urls_standard TEXT,
  ADD ATTRIBUTE pay_now_name TEXT,
  ADD ATTRIBUTE pay_now_redirect_url TEXT,
  ADD ATTRIBUTE pay_over_time_asset_urls_descriptive TEXT,
  ADD ATTRIBUTE pay_over_time_asset_urls_standard TEXT,
  ADD ATTRIBUTE pay_over_time_name TEXT,
  ADD ATTRIBUTE pay_over_time_redirect_url TEXT,
  ADD ATTRIBUTE payment_method_categories TEXT,
  ADD ATTRIBUTE purchase_country TEXT,
  ADD ATTRIBUTE purchase_type TEXT,
  ADD ATTRIBUTE redirect_url TEXT,
  ADD ATTRIBUTE shipping_delay BIGINT,
  ADD ATTRIBUTE shipping_first_name TEXT,
  ADD ATTRIBUTE shipping_last_name TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_klarna(
  background_image_url TEXT DEFAULT NULL,
  client_token TEXT DEFAULT NULL,
  first_name TEXT DEFAULT NULL,
  last_name TEXT DEFAULT NULL,
  locale TEXT DEFAULT NULL,
  logo_url TEXT DEFAULT NULL,
  page_title TEXT DEFAULT NULL,
  pay_later_asset_urls_descriptive TEXT DEFAULT NULL,
  pay_later_asset_urls_standard TEXT DEFAULT NULL,
  pay_later_name TEXT DEFAULT NULL,
  pay_later_redirect_url TEXT DEFAULT NULL,
  pay_now_asset_urls_descriptive TEXT DEFAULT NULL,
  pay_now_asset_urls_standard TEXT DEFAULT NULL,
  pay_now_name TEXT DEFAULT NULL,
  pay_now_redirect_url TEXT DEFAULT NULL,
  pay_over_time_asset_urls_descriptive TEXT DEFAULT NULL,
  pay_over_time_asset_urls_standard TEXT DEFAULT NULL,
  pay_over_time_name TEXT DEFAULT NULL,
  pay_over_time_redirect_url TEXT DEFAULT NULL,
  payment_method_categories TEXT DEFAULT NULL,
  purchase_country TEXT DEFAULT NULL,
  purchase_type TEXT DEFAULT NULL,
  redirect_url TEXT DEFAULT NULL,
  shipping_delay BIGINT DEFAULT NULL,
  shipping_first_name TEXT DEFAULT NULL,
  shipping_last_name TEXT DEFAULT NULL
)
RETURNS stripe.source_type_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    background_image_url,
    client_token,
    first_name,
    last_name,
    locale,
    logo_url,
    page_title,
    pay_later_asset_urls_descriptive,
    pay_later_asset_urls_standard,
    pay_later_name,
    pay_later_redirect_url,
    pay_now_asset_urls_descriptive,
    pay_now_asset_urls_standard,
    pay_now_name,
    pay_now_redirect_url,
    pay_over_time_asset_urls_descriptive,
    pay_over_time_asset_urls_standard,
    pay_over_time_name,
    pay_over_time_redirect_url,
    payment_method_categories,
    purchase_country,
    purchase_type,
    redirect_url,
    shipping_delay,
    shipping_first_name,
    shipping_last_name
  )::stripe.source_type_klarna;
$$;

ALTER TYPE stripe.source_type_multibanco
  ADD ATTRIBUTE entity TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE refund_account_holder_address_city TEXT,
  ADD ATTRIBUTE refund_account_holder_address_country TEXT,
  ADD ATTRIBUTE refund_account_holder_address_line1 TEXT,
  ADD ATTRIBUTE refund_account_holder_address_line2 TEXT,
  ADD ATTRIBUTE refund_account_holder_address_postal_code TEXT,
  ADD ATTRIBUTE refund_account_holder_address_state TEXT,
  ADD ATTRIBUTE refund_account_holder_name TEXT,
  ADD ATTRIBUTE refund_iban TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_multibanco(
  entity TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  refund_account_holder_address_city TEXT DEFAULT NULL,
  refund_account_holder_address_country TEXT DEFAULT NULL,
  refund_account_holder_address_line1 TEXT DEFAULT NULL,
  refund_account_holder_address_line2 TEXT DEFAULT NULL,
  refund_account_holder_address_postal_code TEXT DEFAULT NULL,
  refund_account_holder_address_state TEXT DEFAULT NULL,
  refund_account_holder_name TEXT DEFAULT NULL,
  refund_iban TEXT DEFAULT NULL
)
RETURNS stripe.source_type_multibanco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    entity,
    reference,
    refund_account_holder_address_city,
    refund_account_holder_address_country,
    refund_account_holder_address_line1,
    refund_account_holder_address_line2,
    refund_account_holder_address_postal_code,
    refund_account_holder_address_state,
    refund_account_holder_name,
    refund_iban
  )::stripe.source_type_multibanco;
$$;

ALTER TYPE stripe.source_type_p24
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_p24(
  reference TEXT DEFAULT NULL
)
RETURNS stripe.source_type_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(reference)::stripe.source_type_p24;
$$;

ALTER TYPE stripe.source_type_sepa_debit
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE mandate_reference TEXT,
  ADD ATTRIBUTE mandate_url TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_sepa_debit(
  bank_code TEXT DEFAULT NULL,
  branch_code TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  mandate_reference TEXT DEFAULT NULL,
  mandate_url TEXT DEFAULT NULL
)
RETURNS stripe.source_type_sepa_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    branch_code,
    country,
    fingerprint,
    last4,
    mandate_reference,
    mandate_url
  )::stripe.source_type_sepa_debit;
$$;

ALTER TYPE stripe.source_type_sofort
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE iban_last4 TEXT,
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_sofort(
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  bic TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  iban_last4 TEXT DEFAULT NULL,
  preferred_language TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe.source_type_sofort
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_code,
    bank_name,
    bic,
    country,
    iban_last4,
    preferred_language,
    statement_descriptor
  )::stripe.source_type_sofort;
$$;

ALTER TYPE stripe.source_type_three_d_secure
  ADD ATTRIBUTE address_line1_check TEXT,
  ADD ATTRIBUTE address_zip_check TEXT,
  ADD ATTRIBUTE authenticated BOOLEAN,
  ADD ATTRIBUTE brand TEXT,
  ADD ATTRIBUTE card TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE customer TEXT,
  ADD ATTRIBUTE cvc_check TEXT,
  ADD ATTRIBUTE dynamic_last4 TEXT,
  ADD ATTRIBUTE exp_month BIGINT,
  ADD ATTRIBUTE exp_year BIGINT,
  ADD ATTRIBUTE fingerprint TEXT,
  ADD ATTRIBUTE funding TEXT,
  ADD ATTRIBUTE last4 TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE three_d_secure TEXT,
  ADD ATTRIBUTE tokenization_method TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_three_d_secure(
  address_line1_check TEXT DEFAULT NULL,
  address_zip_check TEXT DEFAULT NULL,
  authenticated BOOLEAN DEFAULT NULL,
  brand TEXT DEFAULT NULL,
  card TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  cvc_check TEXT DEFAULT NULL,
  dynamic_last4 TEXT DEFAULT NULL,
  exp_month BIGINT DEFAULT NULL,
  exp_year BIGINT DEFAULT NULL,
  fingerprint TEXT DEFAULT NULL,
  funding TEXT DEFAULT NULL,
  last4 TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  three_d_secure TEXT DEFAULT NULL,
  tokenization_method TEXT DEFAULT NULL
)
RETURNS stripe.source_type_three_d_secure
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address_line1_check,
    address_zip_check,
    authenticated,
    brand,
    card,
    country,
    customer,
    cvc_check,
    dynamic_last4,
    exp_month,
    exp_year,
    fingerprint,
    funding,
    last4,
    "name",
    three_d_secure,
    tokenization_method
  )::stripe.source_type_three_d_secure;
$$;

ALTER TYPE stripe.source_type_wechat
  ADD ATTRIBUTE prepay_id TEXT,
  ADD ATTRIBUTE qr_code_url TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe.make_source_type_wechat(
  prepay_id TEXT DEFAULT NULL,
  qr_code_url TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe.source_type_wechat
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    prepay_id, qr_code_url, statement_descriptor
  )::stripe.source_type_wechat;
$$;

ALTER TYPE stripe.tax_code
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE "object" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_tax_code(
  "id" TEXT, description TEXT, "name" TEXT, "object" TEXT
)
RETURNS stripe.tax_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("id", description, "name", "object")::stripe.tax_code;
$$;

ALTER TYPE stripe.test_helpers_test_clock
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE deletes_after BIGINT,
  ADD ATTRIBUTE frozen_time BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE status_details stripe.billing_clocks_resource_status_details_status_details,
  ADD ATTRIBUTE "name" TEXT;

CREATE OR REPLACE FUNCTION stripe.make_test_helpers_test_clock(
  "id" TEXT,
  created BIGINT,
  deletes_after BIGINT,
  frozen_time BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  status TEXT,
  status_details stripe.billing_clocks_resource_status_details_status_details,
  "name" TEXT DEFAULT NULL
)
RETURNS stripe.test_helpers_test_clock
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    deletes_after,
    frozen_time,
    livemode,
    "object",
    status,
    status_details,
    "name"
  )::stripe.test_helpers_test_clock;
$$;