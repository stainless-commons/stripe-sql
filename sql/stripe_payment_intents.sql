ALTER TYPE stripe_payment_intents.payment_flows_installment_options
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE "plan" stripe.payment_method_details_card_installments_plan;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_flows_installment_options(
  enabled BOOLEAN,
  "plan" stripe.payment_method_details_card_installments_plan DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_flows_installment_options
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, "plan"
  )::stripe_payment_intents.payment_flows_installment_options;
$$;

ALTER TYPE stripe_payment_intents.payment_intent
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_capturable BIGINT,
  ADD ATTRIBUTE amount_details stripe_payment_intents.payment_intent_amount_detail,
  ADD ATTRIBUTE amount_received BIGINT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE application_fee_amount BIGINT,
  ADD ATTRIBUTE automatic_payment_methods stripe_payment_intents.payment_intent_automatic_payment_method,
  ADD ATTRIBUTE canceled_at BIGINT,
  ADD ATTRIBUTE cancellation_reason TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE client_secret TEXT,
  ADD ATTRIBUTE confirmation_method TEXT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE customer JSONB,
  ADD ATTRIBUTE customer_account TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE excluded_payment_method_types TEXT[],
  ADD ATTRIBUTE hooks stripe_payment_intents.payment_intent_hook,
  ADD ATTRIBUTE last_payment_error JSONB,
  ADD ATTRIBUTE latest_charge JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE next_action stripe_payment_intents.payment_intent_next_action,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE payment_details stripe_payment_intents.payment_intent_payment_detail,
  ADD ATTRIBUTE payment_method JSONB,
  ADD ATTRIBUTE payment_method_configuration_details stripe_payment_intents.payment_intent_payment_method_configuration_detail,
  ADD ATTRIBUTE payment_method_options stripe_payment_intents.payment_intent_payment_method_option,
  ADD ATTRIBUTE payment_method_types TEXT[],
  ADD ATTRIBUTE presentment_details stripe.payment_flows_payment_intent_presentment_details,
  ADD ATTRIBUTE processing stripe_payment_intents.payment_intent_processing,
  ADD ATTRIBUTE receipt_email TEXT,
  ADD ATTRIBUTE review JSONB,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE shipping stripe.shipping,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE statement_descriptor_suffix TEXT,
  ADD ATTRIBUTE transfer_data JSONB,
  ADD ATTRIBUTE transfer_group TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent(
  "id" TEXT,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  status TEXT,
  amount BIGINT DEFAULT NULL,
  amount_capturable BIGINT DEFAULT NULL,
  amount_details stripe_payment_intents.payment_intent_amount_detail DEFAULT NULL,
  amount_received BIGINT DEFAULT NULL,
  application JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  automatic_payment_methods stripe_payment_intents.payment_intent_automatic_payment_method DEFAULT NULL,
  canceled_at BIGINT DEFAULT NULL,
  cancellation_reason TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  client_secret TEXT DEFAULT NULL,
  confirmation_method TEXT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer JSONB DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  excluded_payment_method_types TEXT[] DEFAULT NULL,
  hooks stripe_payment_intents.payment_intent_hook DEFAULT NULL,
  last_payment_error JSONB DEFAULT NULL,
  latest_charge JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  next_action stripe_payment_intents.payment_intent_next_action DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  payment_details stripe_payment_intents.payment_intent_payment_detail DEFAULT NULL,
  payment_method JSONB DEFAULT NULL,
  payment_method_configuration_details stripe_payment_intents.payment_intent_payment_method_configuration_detail DEFAULT NULL,
  payment_method_options stripe_payment_intents.payment_intent_payment_method_option DEFAULT NULL,
  payment_method_types TEXT[] DEFAULT NULL,
  presentment_details stripe.payment_flows_payment_intent_presentment_details DEFAULT NULL,
  processing stripe_payment_intents.payment_intent_processing DEFAULT NULL,
  receipt_email TEXT DEFAULT NULL,
  review JSONB DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  shipping stripe.shipping DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  statement_descriptor_suffix TEXT DEFAULT NULL,
  transfer_data JSONB DEFAULT NULL,
  transfer_group TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    livemode,
    "object",
    status,
    amount,
    amount_capturable,
    amount_details,
    amount_received,
    application,
    application_fee_amount,
    automatic_payment_methods,
    canceled_at,
    cancellation_reason,
    capture_method,
    client_secret,
    confirmation_method,
    currency,
    customer,
    customer_account,
    description,
    excluded_payment_method_types,
    hooks,
    last_payment_error,
    latest_charge,
    metadata,
    next_action,
    on_behalf_of,
    payment_details,
    payment_method,
    payment_method_configuration_details,
    payment_method_options,
    payment_method_types,
    presentment_details,
    processing,
    receipt_email,
    review,
    setup_future_usage,
    shipping,
    statement_descriptor,
    statement_descriptor_suffix,
    transfer_data,
    transfer_group
  )::stripe_payment_intents.payment_intent;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail
  ADD ATTRIBUTE discount_amount BIGINT,
  ADD ATTRIBUTE "error" stripe_payment_intents.payment_intent_amount_detail_error,
  ADD ATTRIBUTE line_items stripe_payment_intents.payment_intent_amount_detail_line_item,
  ADD ATTRIBUTE shipping stripe_payment_intents.payment_intent_amount_detail_shipping,
  ADD ATTRIBUTE tax stripe_payment_intents.payment_intent_amount_detail_tax,
  ADD ATTRIBUTE tip stripe_payment_intents.payment_intent_amount_detail_tip;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail(
  discount_amount BIGINT DEFAULT NULL,
  "error" stripe_payment_intents.payment_intent_amount_detail_error DEFAULT NULL,
  line_items stripe_payment_intents.payment_intent_amount_detail_line_item DEFAULT NULL,
  shipping stripe_payment_intents.payment_intent_amount_detail_shipping DEFAULT NULL,
  tax stripe_payment_intents.payment_intent_amount_detail_tax DEFAULT NULL,
  tip stripe_payment_intents.payment_intent_amount_detail_tip DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_amount_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    discount_amount, "error", line_items, shipping, tax, tip
  )::stripe_payment_intents.payment_intent_amount_detail;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail_error
  ADD ATTRIBUTE code TEXT, ADD ATTRIBUTE message TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail_error(
  code TEXT DEFAULT NULL, message TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_amount_detail_error
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    code, message
  )::stripe_payment_intents.payment_intent_amount_detail_error;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail_line_item
  ADD ATTRIBUTE "data" stripe_payment_intents.payment_intent_amount_detail_line_item_data[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail_line_item(
  "data" stripe_payment_intents.payment_intent_amount_detail_line_item_data[],
  has_more BOOLEAN,
  "object" TEXT,
  url TEXT
)
RETURNS stripe_payment_intents.payment_intent_amount_detail_line_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_payment_intents.payment_intent_amount_detail_line_item;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail_line_item_data
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE product_name TEXT,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE unit_cost BIGINT,
  ADD ATTRIBUTE discount_amount BIGINT,
  ADD ATTRIBUTE payment_method_options stripe_payment_intents.p_intent_amount_detail_line_item_data_payment_method_option,
  ADD ATTRIBUTE product_code TEXT,
  ADD ATTRIBUTE tax stripe_payment_intents.payment_intent_amount_detail_line_item_data_tax,
  ADD ATTRIBUTE unit_of_measure TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail_line_item_data(
  "id" TEXT,
  "object" TEXT,
  product_name TEXT,
  quantity BIGINT,
  unit_cost BIGINT,
  discount_amount BIGINT DEFAULT NULL,
  payment_method_options stripe_payment_intents.p_intent_amount_detail_line_item_data_payment_method_option DEFAULT NULL,
  product_code TEXT DEFAULT NULL,
  tax stripe_payment_intents.payment_intent_amount_detail_line_item_data_tax DEFAULT NULL,
  unit_of_measure TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_amount_detail_line_item_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    "object",
    product_name,
    quantity,
    unit_cost,
    discount_amount,
    payment_method_options,
    product_code,
    tax,
    unit_of_measure
  )::stripe_payment_intents.payment_intent_amount_detail_line_item_data;
$$;

ALTER TYPE stripe_payment_intents.p_intent_amount_detail_line_item_data_payment_method_option
  ADD ATTRIBUTE card stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_card,
  ADD ATTRIBUTE card_present stripe_payment_intents.p_i_a_detail_line_item_data_payment_method_option_card_present,
  ADD ATTRIBUTE klarna stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_klarna,
  ADD ATTRIBUTE paypal stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_paypal;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_amount_detail_line_item_data_payment_method_option(
  card stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_card DEFAULT NULL,
  card_present stripe_payment_intents.p_i_a_detail_line_item_data_payment_method_option_card_present DEFAULT NULL,
  klarna stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_klarna DEFAULT NULL,
  paypal stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_paypal DEFAULT NULL
)
RETURNS stripe_payment_intents.p_intent_amount_detail_line_item_data_payment_method_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    card, card_present, klarna, paypal
  )::stripe_payment_intents.p_intent_amount_detail_line_item_data_payment_method_option;
$$;

ALTER TYPE stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_card
  ADD ATTRIBUTE commodity_code TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_amount_detail_line_item_data_payment_method_option_card(
  commodity_code TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    commodity_code
  )::stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_card;
$$;

ALTER TYPE stripe_payment_intents.p_i_a_detail_line_item_data_payment_method_option_card_present
  ADD ATTRIBUTE commodity_code TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_a_d_line_item_data_payment_method_option_card_present(
  commodity_code TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_a_detail_line_item_data_payment_method_option_card_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    commodity_code
  )::stripe_payment_intents.p_i_a_detail_line_item_data_payment_method_option_card_present;
$$;

ALTER TYPE stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_klarna
  ADD ATTRIBUTE image_url TEXT,
  ADD ATTRIBUTE product_url TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE subscription_reference TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_amount_detail_line_item_data_payment_method_option_klarna(
  image_url TEXT DEFAULT NULL,
  product_url TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  subscription_reference TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    image_url, product_url, reference, subscription_reference
  )::stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_klarna;
$$;

ALTER TYPE stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_paypal
  ADD ATTRIBUTE category TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE sold_by TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_amount_detail_line_item_data_payment_method_option_paypal(
  category TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  sold_by TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    category, description, sold_by
  )::stripe_payment_intents.p_i_amount_detail_line_item_data_payment_method_option_paypal;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail_line_item_data_tax
  ADD ATTRIBUTE total_tax_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail_line_item_data_tax(
  total_tax_amount BIGINT
)
RETURNS stripe_payment_intents.payment_intent_amount_detail_line_item_data_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    total_tax_amount
  )::stripe_payment_intents.payment_intent_amount_detail_line_item_data_tax;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail_shipping
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE from_postal_code TEXT,
  ADD ATTRIBUTE to_postal_code TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail_shipping(
  amount BIGINT DEFAULT NULL,
  from_postal_code TEXT DEFAULT NULL,
  to_postal_code TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_amount_detail_shipping
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, from_postal_code, to_postal_code
  )::stripe_payment_intents.payment_intent_amount_detail_shipping;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail_tax
  ADD ATTRIBUTE total_tax_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail_tax(
  total_tax_amount BIGINT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_amount_detail_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    total_tax_amount
  )::stripe_payment_intents.payment_intent_amount_detail_tax;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_amount_detail_tip
  ADD ATTRIBUTE amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_amount_detail_tip(
  amount BIGINT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_amount_detail_tip
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(amount)::stripe_payment_intents.payment_intent_amount_detail_tip;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_automatic_payment_method
  ADD ATTRIBUTE enabled BOOLEAN, ADD ATTRIBUTE allow_redirects TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_automatic_payment_method(
  enabled BOOLEAN, allow_redirects TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_automatic_payment_method
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, allow_redirects
  )::stripe_payment_intents.payment_intent_automatic_payment_method;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_hook
  ADD ATTRIBUTE inputs stripe_payment_intents.payment_intent_hook_input;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_hook(
  inputs stripe_payment_intents.payment_intent_hook_input DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_hook
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(inputs)::stripe_payment_intents.payment_intent_hook;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_hook_input
  ADD ATTRIBUTE tax stripe_payment_intents.payment_intent_hook_input_tax;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_hook_input(
  tax stripe_payment_intents.payment_intent_hook_input_tax DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_hook_input
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tax)::stripe_payment_intents.payment_intent_hook_input;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_hook_input_tax
  ADD ATTRIBUTE calculation TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_hook_input_tax(
  calculation TEXT
)
RETURNS stripe_payment_intents.payment_intent_hook_input_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(calculation)::stripe_payment_intents.payment_intent_hook_input_tax;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE alipay_handle_redirect stripe_payment_intents.payment_intent_next_action_alipay_handle_redirect,
  ADD ATTRIBUTE boleto_display_details stripe_payment_intents.payment_intent_next_action_boleto_display_detail,
  ADD ATTRIBUTE card_await_notification stripe_payment_intents.payment_intent_next_action_card_await_notification,
  ADD ATTRIBUTE cashapp_handle_redirect_or_display_qr_code stripe_payment_intents.p_intent_next_action_cashapp_handle_redirect_or_display_qr_code,
  ADD ATTRIBUTE display_bank_transfer_instructions stripe_payment_intents.payment_intent_next_action_display_bank_transfer_instruction,
  ADD ATTRIBUTE konbini_display_details stripe_payment_intents.payment_intent_next_action_konbini_display_detail,
  ADD ATTRIBUTE multibanco_display_details stripe_payment_intents.payment_intent_next_action_multibanco_display_detail,
  ADD ATTRIBUTE oxxo_display_details stripe_payment_intents.payment_intent_next_action_oxxo_display_detail,
  ADD ATTRIBUTE paynow_display_qr_code stripe_payment_intents.payment_intent_next_action_paynow_display_qr_code,
  ADD ATTRIBUTE pix_display_qr_code stripe_payment_intents.payment_intent_next_action_pix_display_qr_code,
  ADD ATTRIBUTE promptpay_display_qr_code stripe_payment_intents.payment_intent_next_action_promptpay_display_qr_code,
  ADD ATTRIBUTE redirect_to_url stripe_payment_intents.payment_intent_next_action_redirect_to_url,
  ADD ATTRIBUTE swish_handle_redirect_or_display_qr_code stripe_payment_intents.p_intent_next_action_swish_handle_redirect_or_display_qr_code,
  ADD ATTRIBUTE use_stripe_sdk JSONB,
  ADD ATTRIBUTE verify_with_microdeposits stripe_payment_intents.payment_intent_next_action_verify_with_microdeposit,
  ADD ATTRIBUTE wechat_pay_display_qr_code stripe_payment_intents.payment_intent_next_action_wechat_pay_display_qr_code,
  ADD ATTRIBUTE wechat_pay_redirect_to_android_app stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_android_app,
  ADD ATTRIBUTE wechat_pay_redirect_to_ios_app stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_ios_app;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action(
  "type" TEXT,
  alipay_handle_redirect stripe_payment_intents.payment_intent_next_action_alipay_handle_redirect DEFAULT NULL,
  boleto_display_details stripe_payment_intents.payment_intent_next_action_boleto_display_detail DEFAULT NULL,
  card_await_notification stripe_payment_intents.payment_intent_next_action_card_await_notification DEFAULT NULL,
  cashapp_handle_redirect_or_display_qr_code stripe_payment_intents.p_intent_next_action_cashapp_handle_redirect_or_display_qr_code DEFAULT NULL,
  display_bank_transfer_instructions stripe_payment_intents.payment_intent_next_action_display_bank_transfer_instruction DEFAULT NULL,
  konbini_display_details stripe_payment_intents.payment_intent_next_action_konbini_display_detail DEFAULT NULL,
  multibanco_display_details stripe_payment_intents.payment_intent_next_action_multibanco_display_detail DEFAULT NULL,
  oxxo_display_details stripe_payment_intents.payment_intent_next_action_oxxo_display_detail DEFAULT NULL,
  paynow_display_qr_code stripe_payment_intents.payment_intent_next_action_paynow_display_qr_code DEFAULT NULL,
  pix_display_qr_code stripe_payment_intents.payment_intent_next_action_pix_display_qr_code DEFAULT NULL,
  promptpay_display_qr_code stripe_payment_intents.payment_intent_next_action_promptpay_display_qr_code DEFAULT NULL,
  redirect_to_url stripe_payment_intents.payment_intent_next_action_redirect_to_url DEFAULT NULL,
  swish_handle_redirect_or_display_qr_code stripe_payment_intents.p_intent_next_action_swish_handle_redirect_or_display_qr_code DEFAULT NULL,
  use_stripe_sdk JSONB DEFAULT NULL,
  verify_with_microdeposits stripe_payment_intents.payment_intent_next_action_verify_with_microdeposit DEFAULT NULL,
  wechat_pay_display_qr_code stripe_payment_intents.payment_intent_next_action_wechat_pay_display_qr_code DEFAULT NULL,
  wechat_pay_redirect_to_android_app stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_android_app DEFAULT NULL,
  wechat_pay_redirect_to_ios_app stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_ios_app DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    alipay_handle_redirect,
    boleto_display_details,
    card_await_notification,
    cashapp_handle_redirect_or_display_qr_code,
    display_bank_transfer_instructions,
    konbini_display_details,
    multibanco_display_details,
    oxxo_display_details,
    paynow_display_qr_code,
    pix_display_qr_code,
    promptpay_display_qr_code,
    redirect_to_url,
    swish_handle_redirect_or_display_qr_code,
    use_stripe_sdk,
    verify_with_microdeposits,
    wechat_pay_display_qr_code,
    wechat_pay_redirect_to_android_app,
    wechat_pay_redirect_to_ios_app
  )::stripe_payment_intents.payment_intent_next_action;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_alipay_handle_redirect
  ADD ATTRIBUTE native_data TEXT,
  ADD ATTRIBUTE native_url TEXT,
  ADD ATTRIBUTE return_url TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_alipay_handle_redirect(
  native_data TEXT DEFAULT NULL,
  native_url TEXT DEFAULT NULL,
  return_url TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_alipay_handle_redirect
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    native_data, native_url, return_url, url
  )::stripe_payment_intents.payment_intent_next_action_alipay_handle_redirect;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_boleto_display_detail
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE hosted_voucher_url TEXT,
  ADD ATTRIBUTE "number" TEXT,
  ADD ATTRIBUTE pdf TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_boleto_display_detail(
  expires_at BIGINT DEFAULT NULL,
  hosted_voucher_url TEXT DEFAULT NULL,
  "number" TEXT DEFAULT NULL,
  pdf TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_boleto_display_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_at, hosted_voucher_url, "number", pdf
  )::stripe_payment_intents.payment_intent_next_action_boleto_display_detail;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_card_await_notification
  ADD ATTRIBUTE charge_attempt_at BIGINT,
  ADD ATTRIBUTE customer_approval_required BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_card_await_notification(
  charge_attempt_at BIGINT DEFAULT NULL,
  customer_approval_required BOOLEAN DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_card_await_notification
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    charge_attempt_at, customer_approval_required
  )::stripe_payment_intents.payment_intent_next_action_card_await_notification;
$$;

ALTER TYPE stripe_payment_intents.p_intent_next_action_cashapp_handle_redirect_or_display_qr_code
  ADD ATTRIBUTE hosted_instructions_url TEXT,
  ADD ATTRIBUTE mobile_auth_url TEXT,
  ADD ATTRIBUTE qr_code stripe_payment_intents.p_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_next_action_cashapp_handle_redirect_or_display_qr_code(
  hosted_instructions_url TEXT,
  mobile_auth_url TEXT,
  qr_code stripe_payment_intents.p_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code
)
RETURNS stripe_payment_intents.p_intent_next_action_cashapp_handle_redirect_or_display_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    hosted_instructions_url, mobile_auth_url, qr_code
  )::stripe_payment_intents.p_intent_next_action_cashapp_handle_redirect_or_display_qr_code;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE image_url_png TEXT,
  ADD ATTRIBUTE image_url_svg TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_cashapp_handle_redirect_or_display_qr_code_qr_code(
  expires_at BIGINT, image_url_png TEXT, image_url_svg TEXT
)
RETURNS stripe_payment_intents.p_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_at, image_url_png, image_url_svg
  )::stripe_payment_intents.p_i_n_action_cashapp_handle_redirect_or_display_qr_code_qr_code;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_display_bank_transfer_instruction
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE amount_remaining BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE financial_addresses stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address[],
  ADD ATTRIBUTE hosted_instructions_url TEXT,
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_payment_intent_next_action_display_bank_transfer_instruction(
  "type" TEXT,
  amount_remaining BIGINT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  financial_addresses stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address[] DEFAULT NULL,
  hosted_instructions_url TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_display_bank_transfer_instruction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    amount_remaining,
    currency,
    financial_addresses,
    hosted_instructions_url,
    reference
  )::stripe_payment_intents.payment_intent_next_action_display_bank_transfer_instruction;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE aba stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address_aba,
  ADD ATTRIBUTE iban stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_iban,
  ADD ATTRIBUTE sort_code stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_sort_code,
  ADD ATTRIBUTE spei stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_spei,
  ADD ATTRIBUTE supported_networks TEXT[],
  ADD ATTRIBUTE swift stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_swift,
  ADD ATTRIBUTE zengin stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_zengin;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_display_bank_transfer_instruction_financial_address(
  "type" TEXT,
  aba stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address_aba DEFAULT NULL,
  iban stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_iban DEFAULT NULL,
  sort_code stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_sort_code DEFAULT NULL,
  spei stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_spei DEFAULT NULL,
  supported_networks TEXT[] DEFAULT NULL,
  swift stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_swift DEFAULT NULL,
  zengin stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_zengin DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", aba, iban, sort_code, spei, supported_networks, swift, zengin
  )::stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address_aba
  ADD ATTRIBUTE account_holder_address stripe.address,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_address stripe.address,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE routing_number TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_d_bank_transfer_instruction_financial_address_aba(
  account_holder_address stripe.address,
  account_holder_name TEXT,
  account_number TEXT,
  account_type TEXT,
  bank_address stripe.address,
  bank_name TEXT,
  routing_number TEXT
)
RETURNS stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address_aba
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_address,
    account_holder_name,
    account_number,
    account_type,
    bank_address,
    bank_name,
    routing_number
  )::stripe_payment_intents.p_i_n_a_display_bank_transfer_instruction_financial_address_aba;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_iban
  ADD ATTRIBUTE account_holder_address stripe.address,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE bank_address stripe.address,
  ADD ATTRIBUTE bic TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE iban TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_d_bank_transfer_instruction_financial_address_iban(
  account_holder_address stripe.address,
  account_holder_name TEXT,
  bank_address stripe.address,
  bic TEXT,
  country TEXT,
  iban TEXT
)
RETURNS stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_iban
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_address,
    account_holder_name,
    bank_address,
    bic,
    country,
    iban
  )::stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_iban;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_sort_code
  ADD ATTRIBUTE account_holder_address stripe.address,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE bank_address stripe.address,
  ADD ATTRIBUTE sort_code TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_d_b_transfer_instruction_financial_address_sort_code(
  account_holder_address stripe.address,
  account_holder_name TEXT,
  account_number TEXT,
  bank_address stripe.address,
  sort_code TEXT
)
RETURNS stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_sort_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_address,
    account_holder_name,
    account_number,
    bank_address,
    sort_code
  )::stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_sort_code;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_spei
  ADD ATTRIBUTE account_holder_address stripe.address,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE bank_address stripe.address,
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE clabe TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_d_bank_transfer_instruction_financial_address_spei(
  account_holder_address stripe.address,
  account_holder_name TEXT,
  bank_address stripe.address,
  bank_code TEXT,
  bank_name TEXT,
  clabe TEXT
)
RETURNS stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_spei
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_address,
    account_holder_name,
    bank_address,
    bank_code,
    bank_name,
    clabe
  )::stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_spei;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_swift
  ADD ATTRIBUTE account_holder_address stripe.address,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_address stripe.address,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE swift_code TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_d_bank_transfer_instruction_financial_address_swift(
  account_holder_address stripe.address,
  account_holder_name TEXT,
  account_number TEXT,
  account_type TEXT,
  bank_address stripe.address,
  bank_name TEXT,
  swift_code TEXT
)
RETURNS stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_swift
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_address,
    account_holder_name,
    account_number,
    account_type,
    bank_address,
    bank_name,
    swift_code
  )::stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_swift;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_zengin
  ADD ATTRIBUTE account_holder_address stripe.address,
  ADD ATTRIBUTE bank_address stripe.address,
  ADD ATTRIBUTE account_holder_name TEXT,
  ADD ATTRIBUTE account_number TEXT,
  ADD ATTRIBUTE account_type TEXT,
  ADD ATTRIBUTE bank_code TEXT,
  ADD ATTRIBUTE bank_name TEXT,
  ADD ATTRIBUTE branch_code TEXT,
  ADD ATTRIBUTE branch_name TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_a_d_bank_transfer_instruction_financial_address_zengin(
  account_holder_address stripe.address,
  bank_address stripe.address,
  account_holder_name TEXT DEFAULT NULL,
  account_number TEXT DEFAULT NULL,
  account_type TEXT DEFAULT NULL,
  bank_code TEXT DEFAULT NULL,
  bank_name TEXT DEFAULT NULL,
  branch_code TEXT DEFAULT NULL,
  branch_name TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_zengin
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_holder_address,
    bank_address,
    account_holder_name,
    account_number,
    account_type,
    bank_code,
    bank_name,
    branch_code,
    branch_name
  )::stripe_payment_intents.p_i_n_a_d_bank_transfer_instruction_financial_address_zengin;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_konbini_display_detail
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE stores stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store,
  ADD ATTRIBUTE hosted_voucher_url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_konbini_display_detail(
  expires_at BIGINT,
  stores stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store,
  hosted_voucher_url TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_konbini_display_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_at, stores, hosted_voucher_url
  )::stripe_payment_intents.payment_intent_next_action_konbini_display_detail;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store
  ADD ATTRIBUTE familymart stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_familymart,
  ADD ATTRIBUTE lawson stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store_lawson,
  ADD ATTRIBUTE ministop stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_ministop,
  ADD ATTRIBUTE seicomart stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_seicomart;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_konbini_display_detail_store(
  familymart stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_familymart DEFAULT NULL,
  lawson stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store_lawson DEFAULT NULL,
  ministop stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_ministop DEFAULT NULL,
  seicomart stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_seicomart DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    familymart, lawson, ministop, seicomart
  )::stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store;
$$;

ALTER TYPE stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_familymart
  ADD ATTRIBUTE payment_code TEXT, ADD ATTRIBUTE confirmation_number TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_next_action_konbini_display_detail_store_familymart(
  payment_code TEXT, confirmation_number TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_familymart
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_code, confirmation_number
  )::stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_familymart;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store_lawson
  ADD ATTRIBUTE payment_code TEXT, ADD ATTRIBUTE confirmation_number TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_next_action_konbini_display_detail_store_lawson(
  payment_code TEXT, confirmation_number TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store_lawson
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_code, confirmation_number
  )::stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store_lawson;
$$;

ALTER TYPE stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_ministop
  ADD ATTRIBUTE payment_code TEXT, ADD ATTRIBUTE confirmation_number TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_next_action_konbini_display_detail_store_ministop(
  payment_code TEXT, confirmation_number TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_ministop
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_code, confirmation_number
  )::stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_ministop;
$$;

ALTER TYPE stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_seicomart
  ADD ATTRIBUTE payment_code TEXT, ADD ATTRIBUTE confirmation_number TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_next_action_konbini_display_detail_store_seicomart(
  payment_code TEXT, confirmation_number TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_seicomart
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_code, confirmation_number
  )::stripe_payment_intents.p_intent_next_action_konbini_display_detail_store_seicomart;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_multibanco_display_detail
  ADD ATTRIBUTE entity TEXT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE hosted_voucher_url TEXT,
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_multibanco_display_detail(
  entity TEXT DEFAULT NULL,
  expires_at BIGINT DEFAULT NULL,
  hosted_voucher_url TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_multibanco_display_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    entity, expires_at, hosted_voucher_url, reference
  )::stripe_payment_intents.payment_intent_next_action_multibanco_display_detail;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_oxxo_display_detail
  ADD ATTRIBUTE expires_after BIGINT,
  ADD ATTRIBUTE hosted_voucher_url TEXT,
  ADD ATTRIBUTE "number" TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_oxxo_display_detail(
  expires_after BIGINT DEFAULT NULL,
  hosted_voucher_url TEXT DEFAULT NULL,
  "number" TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_oxxo_display_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_after, hosted_voucher_url, "number"
  )::stripe_payment_intents.payment_intent_next_action_oxxo_display_detail;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_paynow_display_qr_code
  ADD ATTRIBUTE "data" TEXT,
  ADD ATTRIBUTE image_url_png TEXT,
  ADD ATTRIBUTE image_url_svg TEXT,
  ADD ATTRIBUTE hosted_instructions_url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_paynow_display_qr_code(
  "data" TEXT,
  image_url_png TEXT,
  image_url_svg TEXT,
  hosted_instructions_url TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_paynow_display_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", image_url_png, image_url_svg, hosted_instructions_url
  )::stripe_payment_intents.payment_intent_next_action_paynow_display_qr_code;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_pix_display_qr_code
  ADD ATTRIBUTE "data" TEXT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE hosted_instructions_url TEXT,
  ADD ATTRIBUTE image_url_png TEXT,
  ADD ATTRIBUTE image_url_svg TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_pix_display_qr_code(
  "data" TEXT DEFAULT NULL,
  expires_at BIGINT DEFAULT NULL,
  hosted_instructions_url TEXT DEFAULT NULL,
  image_url_png TEXT DEFAULT NULL,
  image_url_svg TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_pix_display_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", expires_at, hosted_instructions_url, image_url_png, image_url_svg
  )::stripe_payment_intents.payment_intent_next_action_pix_display_qr_code;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_promptpay_display_qr_code
  ADD ATTRIBUTE "data" TEXT,
  ADD ATTRIBUTE hosted_instructions_url TEXT,
  ADD ATTRIBUTE image_url_png TEXT,
  ADD ATTRIBUTE image_url_svg TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_promptpay_display_qr_code(
  "data" TEXT,
  hosted_instructions_url TEXT,
  image_url_png TEXT,
  image_url_svg TEXT
)
RETURNS stripe_payment_intents.payment_intent_next_action_promptpay_display_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", hosted_instructions_url, image_url_png, image_url_svg
  )::stripe_payment_intents.payment_intent_next_action_promptpay_display_qr_code;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_redirect_to_url
  ADD ATTRIBUTE return_url TEXT, ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_redirect_to_url(
  return_url TEXT DEFAULT NULL, url TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_redirect_to_url
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    return_url, url
  )::stripe_payment_intents.payment_intent_next_action_redirect_to_url;
$$;

ALTER TYPE stripe_payment_intents.p_intent_next_action_swish_handle_redirect_or_display_qr_code
  ADD ATTRIBUTE hosted_instructions_url TEXT,
  ADD ATTRIBUTE qr_code stripe_payment_intents.p_i_n_action_swish_handle_redirect_or_display_qr_code_qr_code;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_next_action_swish_handle_redirect_or_display_qr_code(
  hosted_instructions_url TEXT,
  qr_code stripe_payment_intents.p_i_n_action_swish_handle_redirect_or_display_qr_code_qr_code
)
RETURNS stripe_payment_intents.p_intent_next_action_swish_handle_redirect_or_display_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    hosted_instructions_url, qr_code
  )::stripe_payment_intents.p_intent_next_action_swish_handle_redirect_or_display_qr_code;
$$;

ALTER TYPE stripe_payment_intents.p_i_n_action_swish_handle_redirect_or_display_qr_code_qr_code
  ADD ATTRIBUTE "data" TEXT,
  ADD ATTRIBUTE image_url_png TEXT,
  ADD ATTRIBUTE image_url_svg TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_n_action_swish_handle_redirect_or_display_qr_code_qr_code(
  "data" TEXT, image_url_png TEXT, image_url_svg TEXT
)
RETURNS stripe_payment_intents.p_i_n_action_swish_handle_redirect_or_display_qr_code_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", image_url_png, image_url_svg
  )::stripe_payment_intents.p_i_n_action_swish_handle_redirect_or_display_qr_code_qr_code;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_verify_with_microdeposit
  ADD ATTRIBUTE arrival_date BIGINT,
  ADD ATTRIBUTE hosted_verification_url TEXT,
  ADD ATTRIBUTE microdeposit_type TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_verify_with_microdeposit(
  arrival_date BIGINT,
  hosted_verification_url TEXT,
  microdeposit_type TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_next_action_verify_with_microdeposit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    arrival_date, hosted_verification_url, microdeposit_type
  )::stripe_payment_intents.payment_intent_next_action_verify_with_microdeposit;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_wechat_pay_display_qr_code
  ADD ATTRIBUTE "data" TEXT,
  ADD ATTRIBUTE hosted_instructions_url TEXT,
  ADD ATTRIBUTE image_data_url TEXT,
  ADD ATTRIBUTE image_url_png TEXT,
  ADD ATTRIBUTE image_url_svg TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_wechat_pay_display_qr_code(
  "data" TEXT,
  hosted_instructions_url TEXT,
  image_data_url TEXT,
  image_url_png TEXT,
  image_url_svg TEXT
)
RETURNS stripe_payment_intents.payment_intent_next_action_wechat_pay_display_qr_code
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data",
    hosted_instructions_url,
    image_data_url,
    image_url_png,
    image_url_svg
  )::stripe_payment_intents.payment_intent_next_action_wechat_pay_display_qr_code;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_android_app
  ADD ATTRIBUTE app_id TEXT,
  ADD ATTRIBUTE nonce_str TEXT,
  ADD ATTRIBUTE package TEXT,
  ADD ATTRIBUTE partner_id TEXT,
  ADD ATTRIBUTE prepay_id TEXT,
  ADD ATTRIBUTE sign TEXT,
  ADD ATTRIBUTE "timestamp" TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_payment_intent_next_action_wechat_pay_redirect_to_android_app(
  app_id TEXT,
  nonce_str TEXT,
  package TEXT,
  partner_id TEXT,
  prepay_id TEXT,
  sign TEXT,
  "timestamp" TEXT
)
RETURNS stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_android_app
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    app_id, nonce_str, package, partner_id, prepay_id, sign, "timestamp"
  )::stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_android_app;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_ios_app
  ADD ATTRIBUTE native_url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_next_action_wechat_pay_redirect_to_ios_app(
  native_url TEXT
)
RETURNS stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_ios_app
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    native_url
  )::stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_ios_app;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_detail
  ADD ATTRIBUTE customer_reference TEXT, ADD ATTRIBUTE order_reference TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_detail(
  customer_reference TEXT DEFAULT NULL, order_reference TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    customer_reference, order_reference
  )::stripe_payment_intents.payment_intent_payment_detail;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_configuration_detail
  ADD ATTRIBUTE "id" TEXT, ADD ATTRIBUTE parent TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_configuration_detail(
  "id" TEXT, parent TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_configuration_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id", parent
  )::stripe_payment_intents.payment_intent_payment_method_configuration_detail;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option
  ADD ATTRIBUTE acss_debit stripe_payment_intents.payment_intent_payment_method_option_acss_debit,
  ADD ATTRIBUTE affirm stripe_payment_intents.payment_intent_payment_method_option_affirm,
  ADD ATTRIBUTE afterpay_clearpay stripe_payment_intents.payment_intent_payment_method_option_afterpay_clearpay,
  ADD ATTRIBUTE alipay stripe_payment_intents.payment_intent_payment_method_option_alipay,
  ADD ATTRIBUTE alma stripe_payment_intents.payment_intent_payment_method_option_alma,
  ADD ATTRIBUTE amazon_pay stripe_payment_intents.payment_intent_payment_method_option_amazon_pay,
  ADD ATTRIBUTE au_becs_debit stripe_payment_intents.payment_intent_payment_method_option_au_becs_debit,
  ADD ATTRIBUTE bacs_debit stripe_payment_intents.payment_intent_payment_method_option_bacs_debit,
  ADD ATTRIBUTE bancontact stripe_payment_intents.payment_intent_payment_method_option_bancontact,
  ADD ATTRIBUTE billie stripe_payment_intents.payment_intent_payment_method_option_billie,
  ADD ATTRIBUTE blik stripe_payment_intents.payment_intent_payment_method_option_blik,
  ADD ATTRIBUTE boleto stripe_payment_intents.payment_intent_payment_method_option_boleto,
  ADD ATTRIBUTE card stripe_payment_intents.payment_intent_payment_method_option_card,
  ADD ATTRIBUTE card_present stripe_payment_intents.payment_intent_payment_method_option_card_present,
  ADD ATTRIBUTE cashapp stripe_payment_intents.payment_intent_payment_method_option_cashapp,
  ADD ATTRIBUTE crypto stripe_payment_intents.payment_intent_payment_method_option_crypto,
  ADD ATTRIBUTE customer_balance stripe_payment_intents.payment_intent_payment_method_option_customer_balance,
  ADD ATTRIBUTE eps stripe_payment_intents.payment_intent_payment_method_option_ep,
  ADD ATTRIBUTE fpx stripe_payment_intents.payment_intent_payment_method_option_fpx,
  ADD ATTRIBUTE giropay stripe_payment_intents.payment_intent_payment_method_option_giropay,
  ADD ATTRIBUTE grabpay stripe_payment_intents.payment_intent_payment_method_option_grabpay,
  ADD ATTRIBUTE ideal stripe_payment_intents.payment_intent_payment_method_option_ideal,
  ADD ATTRIBUTE interac_present stripe_payment_intents.payment_intent_payment_method_option_interac_present,
  ADD ATTRIBUTE kakao_pay stripe_payment_intents.payment_intent_payment_method_option_kakao_pay,
  ADD ATTRIBUTE klarna stripe_payment_intents.payment_intent_payment_method_option_klarna,
  ADD ATTRIBUTE konbini stripe_payment_intents.payment_intent_payment_method_option_konbini,
  ADD ATTRIBUTE kr_card stripe_payment_intents.payment_intent_payment_method_option_kr_card,
  ADD ATTRIBUTE "link" stripe_payment_intents.payment_intent_payment_method_option_link,
  ADD ATTRIBUTE mb_way stripe_payment_intents.payment_intent_payment_method_option_mb_way,
  ADD ATTRIBUTE mobilepay stripe_payment_intents.payment_intent_payment_method_option_mobilepay,
  ADD ATTRIBUTE multibanco stripe_payment_intents.payment_intent_payment_method_option_multibanco,
  ADD ATTRIBUTE naver_pay stripe_payment_intents.payment_intent_payment_method_option_naver_pay,
  ADD ATTRIBUTE nz_bank_account stripe_payment_intents.payment_intent_payment_method_option_nz_bank_account,
  ADD ATTRIBUTE oxxo stripe_payment_intents.payment_intent_payment_method_option_oxxo,
  ADD ATTRIBUTE p24 stripe_payment_intents.payment_intent_payment_method_option_p24,
  ADD ATTRIBUTE pay_by_bank stripe_payment_intents.payment_intent_payment_method_option_pay_by_bank,
  ADD ATTRIBUTE payco stripe_payment_intents.payment_intent_payment_method_option_payco,
  ADD ATTRIBUTE paynow stripe_payment_intents.payment_intent_payment_method_option_paynow,
  ADD ATTRIBUTE paypal stripe_payment_intents.payment_intent_payment_method_option_paypal,
  ADD ATTRIBUTE payto stripe_payment_intents.payment_intent_payment_method_option_payto,
  ADD ATTRIBUTE pix stripe_payment_intents.payment_intent_payment_method_option_pix,
  ADD ATTRIBUTE promptpay stripe_payment_intents.payment_intent_payment_method_option_promptpay,
  ADD ATTRIBUTE revolut_pay stripe_payment_intents.payment_intent_payment_method_option_revolut_pay,
  ADD ATTRIBUTE samsung_pay stripe_payment_intents.payment_intent_payment_method_option_samsung_pay,
  ADD ATTRIBUTE satispay stripe_payment_intents.payment_intent_payment_method_option_satispay,
  ADD ATTRIBUTE sepa_debit stripe_payment_intents.payment_intent_payment_method_option_sepa_debit,
  ADD ATTRIBUTE sofort stripe_payment_intents.payment_intent_payment_method_option_sofort,
  ADD ATTRIBUTE swish stripe_payment_intents.payment_intent_payment_method_option_swish,
  ADD ATTRIBUTE twint stripe_payment_intents.payment_intent_payment_method_option_twint,
  ADD ATTRIBUTE us_bank_account stripe_payment_intents.payment_intent_payment_method_option_us_bank_account,
  ADD ATTRIBUTE wechat_pay stripe_payment_intents.payment_intent_payment_method_option_wechat_pay,
  ADD ATTRIBUTE zip stripe_payment_intents.payment_intent_payment_method_option_zip;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option(
  acss_debit stripe_payment_intents.payment_intent_payment_method_option_acss_debit DEFAULT NULL,
  affirm stripe_payment_intents.payment_intent_payment_method_option_affirm DEFAULT NULL,
  afterpay_clearpay stripe_payment_intents.payment_intent_payment_method_option_afterpay_clearpay DEFAULT NULL,
  alipay stripe_payment_intents.payment_intent_payment_method_option_alipay DEFAULT NULL,
  alma stripe_payment_intents.payment_intent_payment_method_option_alma DEFAULT NULL,
  amazon_pay stripe_payment_intents.payment_intent_payment_method_option_amazon_pay DEFAULT NULL,
  au_becs_debit stripe_payment_intents.payment_intent_payment_method_option_au_becs_debit DEFAULT NULL,
  bacs_debit stripe_payment_intents.payment_intent_payment_method_option_bacs_debit DEFAULT NULL,
  bancontact stripe_payment_intents.payment_intent_payment_method_option_bancontact DEFAULT NULL,
  billie stripe_payment_intents.payment_intent_payment_method_option_billie DEFAULT NULL,
  blik stripe_payment_intents.payment_intent_payment_method_option_blik DEFAULT NULL,
  boleto stripe_payment_intents.payment_intent_payment_method_option_boleto DEFAULT NULL,
  card stripe_payment_intents.payment_intent_payment_method_option_card DEFAULT NULL,
  card_present stripe_payment_intents.payment_intent_payment_method_option_card_present DEFAULT NULL,
  cashapp stripe_payment_intents.payment_intent_payment_method_option_cashapp DEFAULT NULL,
  crypto stripe_payment_intents.payment_intent_payment_method_option_crypto DEFAULT NULL,
  customer_balance stripe_payment_intents.payment_intent_payment_method_option_customer_balance DEFAULT NULL,
  eps stripe_payment_intents.payment_intent_payment_method_option_ep DEFAULT NULL,
  fpx stripe_payment_intents.payment_intent_payment_method_option_fpx DEFAULT NULL,
  giropay stripe_payment_intents.payment_intent_payment_method_option_giropay DEFAULT NULL,
  grabpay stripe_payment_intents.payment_intent_payment_method_option_grabpay DEFAULT NULL,
  ideal stripe_payment_intents.payment_intent_payment_method_option_ideal DEFAULT NULL,
  interac_present stripe_payment_intents.payment_intent_payment_method_option_interac_present DEFAULT NULL,
  kakao_pay stripe_payment_intents.payment_intent_payment_method_option_kakao_pay DEFAULT NULL,
  klarna stripe_payment_intents.payment_intent_payment_method_option_klarna DEFAULT NULL,
  konbini stripe_payment_intents.payment_intent_payment_method_option_konbini DEFAULT NULL,
  kr_card stripe_payment_intents.payment_intent_payment_method_option_kr_card DEFAULT NULL,
  "link" stripe_payment_intents.payment_intent_payment_method_option_link DEFAULT NULL,
  mb_way stripe_payment_intents.payment_intent_payment_method_option_mb_way DEFAULT NULL,
  mobilepay stripe_payment_intents.payment_intent_payment_method_option_mobilepay DEFAULT NULL,
  multibanco stripe_payment_intents.payment_intent_payment_method_option_multibanco DEFAULT NULL,
  naver_pay stripe_payment_intents.payment_intent_payment_method_option_naver_pay DEFAULT NULL,
  nz_bank_account stripe_payment_intents.payment_intent_payment_method_option_nz_bank_account DEFAULT NULL,
  oxxo stripe_payment_intents.payment_intent_payment_method_option_oxxo DEFAULT NULL,
  p24 stripe_payment_intents.payment_intent_payment_method_option_p24 DEFAULT NULL,
  pay_by_bank stripe_payment_intents.payment_intent_payment_method_option_pay_by_bank DEFAULT NULL,
  payco stripe_payment_intents.payment_intent_payment_method_option_payco DEFAULT NULL,
  paynow stripe_payment_intents.payment_intent_payment_method_option_paynow DEFAULT NULL,
  paypal stripe_payment_intents.payment_intent_payment_method_option_paypal DEFAULT NULL,
  payto stripe_payment_intents.payment_intent_payment_method_option_payto DEFAULT NULL,
  pix stripe_payment_intents.payment_intent_payment_method_option_pix DEFAULT NULL,
  promptpay stripe_payment_intents.payment_intent_payment_method_option_promptpay DEFAULT NULL,
  revolut_pay stripe_payment_intents.payment_intent_payment_method_option_revolut_pay DEFAULT NULL,
  samsung_pay stripe_payment_intents.payment_intent_payment_method_option_samsung_pay DEFAULT NULL,
  satispay stripe_payment_intents.payment_intent_payment_method_option_satispay DEFAULT NULL,
  sepa_debit stripe_payment_intents.payment_intent_payment_method_option_sepa_debit DEFAULT NULL,
  sofort stripe_payment_intents.payment_intent_payment_method_option_sofort DEFAULT NULL,
  swish stripe_payment_intents.payment_intent_payment_method_option_swish DEFAULT NULL,
  twint stripe_payment_intents.payment_intent_payment_method_option_twint DEFAULT NULL,
  us_bank_account stripe_payment_intents.payment_intent_payment_method_option_us_bank_account DEFAULT NULL,
  wechat_pay stripe_payment_intents.payment_intent_payment_method_option_wechat_pay DEFAULT NULL,
  zip stripe_payment_intents.payment_intent_payment_method_option_zip DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
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
    swish,
    twint,
    us_bank_account,
    wechat_pay,
    zip
  )::stripe_payment_intents.payment_intent_payment_method_option;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_acss_debit
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_option_acss_debit_mandate_option,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE target_date TEXT,
  ADD ATTRIBUTE verification_method TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_acss_debit(
  mandate_options stripe_payment_intents.payment_intent_payment_method_option_acss_debit_mandate_option DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  target_date TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_acss_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options,
    setup_future_usage,
    target_date,
    verification_method,
    capture_method,
    installments,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing
  )::stripe_payment_intents.payment_intent_payment_method_option_acss_debit;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_acss_debit_mandate_option
  ADD ATTRIBUTE custom_mandate_url TEXT,
  ADD ATTRIBUTE interval_description TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE transaction_type TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_payment_method_option_acss_debit_mandate_option(
  custom_mandate_url TEXT DEFAULT NULL,
  interval_description TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  transaction_type TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_acss_debit_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    custom_mandate_url,
    interval_description,
    payment_schedule,
    transaction_type,
    amount,
    amount_type,
    end_date,
    payments_per_period,
    purpose
  )::stripe_payment_intents.payment_intent_payment_method_option_acss_debit_mandate_option;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_affirm
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE preferred_locale TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_affirm(
  capture_method TEXT DEFAULT NULL,
  preferred_locale TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_affirm
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    preferred_locale,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_affirm;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_afterpay_clearpay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_afterpay_clearpay(
  capture_method TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_afterpay_clearpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    reference,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_afterpay_clearpay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_alipay
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_alipay(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_alipay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_alipay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_alma
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_alma(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_alma
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_alma;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_amazon_pay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_amazon_pay(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_amazon_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_amazon_pay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_au_becs_debit
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE target_date TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_au_becs_debit(
  setup_future_usage TEXT DEFAULT NULL,
  target_date TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_au_becs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    target_date,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_au_becs_debit;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_bacs_debit
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_option_bacs_debit_mandate_option,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE target_date TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_bacs_debit(
  mandate_options stripe_payment_intents.payment_intent_payment_method_option_bacs_debit_mandate_option DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  target_date TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_bacs_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options,
    setup_future_usage,
    target_date,
    capture_method,
    installments,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_bacs_debit;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_bacs_debit_mandate_option
  ADD ATTRIBUTE reference_prefix TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_payment_method_option_bacs_debit_mandate_option(
  reference_prefix TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_bacs_debit_mandate_option
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
    purpose
  )::stripe_payment_intents.payment_intent_payment_method_option_bacs_debit_mandate_option;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_bancontact
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_bancontact(
  preferred_language TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_bancontact
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    preferred_language,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_bancontact;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_billie
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_billie(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_billie
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_billie;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_blik
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_blik(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_blik
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_blik;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_boleto
  ADD ATTRIBUTE expires_after_days BIGINT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_boleto(
  expires_after_days BIGINT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_boleto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_after_days,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_boleto;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_card
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_intent_payment_method_option_card_installment,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_option_card_mandate_option,
  ADD ATTRIBUTE network TEXT,
  ADD ATTRIBUTE request_extended_authorization TEXT,
  ADD ATTRIBUTE request_incremental_authorization TEXT,
  ADD ATTRIBUTE request_multicapture TEXT,
  ADD ATTRIBUTE request_overcapture TEXT,
  ADD ATTRIBUTE request_three_d_secure TEXT,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE statement_descriptor_suffix_kana TEXT,
  ADD ATTRIBUTE statement_descriptor_suffix_kanji TEXT,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_card(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_intent_payment_method_option_card_installment DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_option_card_mandate_option DEFAULT NULL,
  network TEXT DEFAULT NULL,
  request_extended_authorization TEXT DEFAULT NULL,
  request_incremental_authorization TEXT DEFAULT NULL,
  request_multicapture TEXT DEFAULT NULL,
  request_overcapture TEXT DEFAULT NULL,
  request_three_d_secure TEXT DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  statement_descriptor_suffix_kana TEXT DEFAULT NULL,
  statement_descriptor_suffix_kanji TEXT DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    network,
    request_extended_authorization,
    request_incremental_authorization,
    request_multicapture,
    request_overcapture,
    request_three_d_secure,
    require_cvc_recollection,
    setup_future_usage,
    statement_descriptor_suffix_kana,
    statement_descriptor_suffix_kanji,
    request_incremental_authorization_support,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_card;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_card_installment
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE available_plans stripe.payment_method_details_card_installments_plan[],
  ADD ATTRIBUTE "plan" stripe.payment_method_details_card_installments_plan;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_card_installment(
  enabled BOOLEAN,
  available_plans stripe.payment_method_details_card_installments_plan[] DEFAULT NULL,
  "plan" stripe.payment_method_details_card_installments_plan DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_card_installment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, available_plans, "plan"
  )::stripe_payment_intents.payment_intent_payment_method_option_card_installment;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_card_mandate_option
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE start_date BIGINT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE end_date JSONB,
  ADD ATTRIBUTE interval_count BIGINT,
  ADD ATTRIBUTE supported_types TEXT[],
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_card_mandate_option(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  "interval" TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  start_date BIGINT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  end_date JSONB DEFAULT NULL,
  interval_count BIGINT DEFAULT NULL,
  supported_types TEXT[] DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_card_mandate_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    amount_type,
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
  )::stripe_payment_intents.payment_intent_payment_method_option_card_mandate_option;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_card_present
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE request_extended_authorization BOOLEAN,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_card_present(
  capture_method TEXT DEFAULT NULL,
  request_extended_authorization BOOLEAN DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_card_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    request_extended_authorization,
    request_incremental_authorization_support,
    routing,
    installments,
    mandate_options,
    require_cvc_recollection,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_card_present;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_cashapp
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_cashapp(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_cashapp
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_cashapp;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_crypto
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_crypto(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_crypto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_crypto;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_customer_balance
  ADD ATTRIBUTE bank_transfer stripe_payment_intents.p_intent_payment_method_option_customer_balance_bank_transfer,
  ADD ATTRIBUTE funding_type TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_customer_balance(
  bank_transfer stripe_payment_intents.p_intent_payment_method_option_customer_balance_bank_transfer DEFAULT NULL,
  funding_type TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_customer_balance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    bank_transfer,
    funding_type,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_customer_balance;
$$;

ALTER TYPE stripe_payment_intents.p_intent_payment_method_option_customer_balance_bank_transfer
  ADD ATTRIBUTE eu_bank_transfer stripe_payment_intents.p_i_p_m_option_customer_balance_bank_transfer_eu_bank_transfer,
  ADD ATTRIBUTE requested_address_types TEXT[],
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_payment_method_option_customer_balance_bank_transfer(
  eu_bank_transfer stripe_payment_intents.p_i_p_m_option_customer_balance_bank_transfer_eu_bank_transfer DEFAULT NULL,
  requested_address_types TEXT[] DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_intent_payment_method_option_customer_balance_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    eu_bank_transfer, requested_address_types, "type"
  )::stripe_payment_intents.p_intent_payment_method_option_customer_balance_bank_transfer;
$$;

ALTER TYPE stripe_payment_intents.p_i_p_m_option_customer_balance_bank_transfer_eu_bank_transfer
  ADD ATTRIBUTE country TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_p_m_o_customer_balance_bank_transfer_eu_bank_transfer(
  country TEXT
)
RETURNS stripe_payment_intents.p_i_p_m_option_customer_balance_bank_transfer_eu_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    country
  )::stripe_payment_intents.p_i_p_m_option_customer_balance_bank_transfer_eu_bank_transfer;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_ep
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_ep(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_ep
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_ep;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_fpx
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_fpx(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_fpx
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_fpx;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_giropay
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_giropay(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_giropay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_giropay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_grabpay
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_grabpay(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_grabpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_grabpay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_ideal
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_ideal(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_ideal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_ideal;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_interac_present
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_interac_present(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_interac_present
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_interac_present;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_kakao_pay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_kakao_pay(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_kakao_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_kakao_pay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_klarna
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE preferred_locale TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_klarna(
  capture_method TEXT DEFAULT NULL,
  preferred_locale TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_klarna
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    preferred_locale,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_klarna;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_konbini
  ADD ATTRIBUTE confirmation_number TEXT,
  ADD ATTRIBUTE expires_after_days BIGINT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_konbini(
  confirmation_number TEXT DEFAULT NULL,
  expires_after_days BIGINT DEFAULT NULL,
  expires_at BIGINT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_konbini
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    confirmation_number,
    expires_after_days,
    expires_at,
    product_description,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_konbini;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_kr_card
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_kr_card(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_kr_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_kr_card;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_link
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_link(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_link
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_link;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_mb_way
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_mb_way(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_mb_way
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_mb_way;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_mobilepay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_mobilepay(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_mobilepay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_mobilepay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_multibanco
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_multibanco(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_multibanco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_multibanco;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_naver_pay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_naver_pay(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_naver_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_naver_pay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_nz_bank_account
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE target_date TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_nz_bank_account(
  setup_future_usage TEXT DEFAULT NULL,
  target_date TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_nz_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    target_date,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_nz_bank_account;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_oxxo
  ADD ATTRIBUTE expires_after_days BIGINT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_oxxo(
  expires_after_days BIGINT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_oxxo
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    expires_after_days,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_oxxo;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_p24
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_p24(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_p24;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_pay_by_bank
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_pay_by_bank(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_pay_by_bank
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_pay_by_bank;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_payco
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_payco(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_payco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_payco;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_paynow
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_paynow(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_paynow
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_paynow;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_paypal
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE preferred_locale TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_paypal(
  capture_method TEXT DEFAULT NULL,
  preferred_locale TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    preferred_locale,
    reference,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_paypal;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_payto
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_payto(
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options,
    setup_future_usage,
    capture_method,
    installments,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_payto;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_pix
  ADD ATTRIBUTE amount_includes_iof TEXT,
  ADD ATTRIBUTE expires_after_seconds BIGINT,
  ADD ATTRIBUTE expires_at BIGINT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_pix(
  amount_includes_iof TEXT DEFAULT NULL,
  expires_after_seconds BIGINT DEFAULT NULL,
  expires_at BIGINT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_pix
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_includes_iof,
    expires_after_seconds,
    expires_at,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_pix;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_promptpay
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_promptpay(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_promptpay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_promptpay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_revolut_pay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_revolut_pay(
  capture_method TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_revolut_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    setup_future_usage,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_revolut_pay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_samsung_pay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_samsung_pay(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_samsung_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_samsung_pay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_satispay
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_satispay(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_satispay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_satispay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_sepa_debit
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_option_sepa_debit_mandate_option,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE target_date TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_sepa_debit(
  mandate_options stripe_payment_intents.payment_intent_payment_method_option_sepa_debit_mandate_option DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  target_date TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_sepa_debit
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    mandate_options,
    setup_future_usage,
    target_date,
    capture_method,
    installments,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_sepa_debit;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_sepa_debit_mandate_option
  ADD ATTRIBUTE reference_prefix TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_payment_method_option_sepa_debit_mandate_option(
  reference_prefix TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_sepa_debit_mandate_option
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
    purpose
  )::stripe_payment_intents.payment_intent_payment_method_option_sepa_debit_mandate_option;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_sofort
  ADD ATTRIBUTE preferred_language TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_sofort(
  preferred_language TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_sofort
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    preferred_language,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_sofort;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_swish
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_swish(
  reference TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_swish
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_swish;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_twint
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_twint(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_twint
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_twint;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_us_bank_account
  ADD ATTRIBUTE financial_connections stripe_payment_intents.p_i_payment_method_option_us_bank_account_financial_connection,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.p_intent_payment_method_option_us_bank_account_mandate_option,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE target_date TEXT,
  ADD ATTRIBUTE verification_method TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_us_bank_account(
  financial_connections stripe_payment_intents.p_i_payment_method_option_us_bank_account_financial_connection DEFAULT NULL,
  mandate_options stripe_payment_intents.p_intent_payment_method_option_us_bank_account_mandate_option DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  target_date TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_us_bank_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    financial_connections,
    mandate_options,
    setup_future_usage,
    target_date,
    verification_method,
    capture_method,
    installments,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing
  )::stripe_payment_intents.payment_intent_payment_method_option_us_bank_account;
$$;

ALTER TYPE stripe_payment_intents.p_i_payment_method_option_us_bank_account_financial_connection
  ADD ATTRIBUTE filters stripe_payment_intents.p_i_p_method_option_us_bank_account_financial_connection_filter,
  ADD ATTRIBUTE permissions TEXT[],
  ADD ATTRIBUTE prefetch TEXT[],
  ADD ATTRIBUTE return_url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_p_method_option_us_bank_account_financial_connection(
  filters stripe_payment_intents.p_i_p_method_option_us_bank_account_financial_connection_filter DEFAULT NULL,
  permissions TEXT[] DEFAULT NULL,
  prefetch TEXT[] DEFAULT NULL,
  return_url TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_payment_method_option_us_bank_account_financial_connection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    filters, permissions, prefetch, return_url
  )::stripe_payment_intents.p_i_payment_method_option_us_bank_account_financial_connection;
$$;

ALTER TYPE stripe_payment_intents.p_i_p_method_option_us_bank_account_financial_connection_filter
  ADD ATTRIBUTE account_subcategories TEXT[];

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_i_p_m_option_us_bank_account_financial_connection_filter(
  account_subcategories TEXT[] DEFAULT NULL
)
RETURNS stripe_payment_intents.p_i_p_method_option_us_bank_account_financial_connection_filter
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_subcategories
  )::stripe_payment_intents.p_i_p_method_option_us_bank_account_financial_connection_filter;
$$;

ALTER TYPE stripe_payment_intents.p_intent_payment_method_option_us_bank_account_mandate_option
  ADD ATTRIBUTE collection_method TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_p_intent_payment_method_option_us_bank_account_mandate_option(
  collection_method TEXT DEFAULT NULL,
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.p_intent_payment_method_option_us_bank_account_mandate_option
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
    purpose
  )::stripe_payment_intents.p_intent_payment_method_option_us_bank_account_mandate_option;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_wechat_pay
  ADD ATTRIBUTE app_id TEXT,
  ADD ATTRIBUTE client TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_wechat_pay(
  app_id TEXT DEFAULT NULL,
  client TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_wechat_pay
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    app_id,
    client,
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_wechat_pay;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_option_zip
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_payment_method_option_zip(
  setup_future_usage TEXT DEFAULT NULL,
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_option_zip
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    setup_future_usage,
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    verification_method
  )::stripe_payment_intents.payment_intent_payment_method_option_zip;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_processing
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE card stripe_payment_intents.payment_intent_processing_card;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_processing(
  "type" TEXT,
  card stripe_payment_intents.payment_intent_processing_card DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_processing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", card)::stripe_payment_intents.payment_intent_processing;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_processing_card
  ADD ATTRIBUTE customer_notification stripe_payment_intents.payment_intent_processing_card_customer_notification;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_processing_card(
  customer_notification stripe_payment_intents.payment_intent_processing_card_customer_notification DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_processing_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    customer_notification
  )::stripe_payment_intents.payment_intent_processing_card;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_processing_card_customer_notification
  ADD ATTRIBUTE approval_requested BOOLEAN, ADD ATTRIBUTE completes_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_processing_card_customer_notification(
  approval_requested BOOLEAN DEFAULT NULL, completes_at BIGINT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_processing_card_customer_notification
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    approval_requested, completes_at
  )::stripe_payment_intents.payment_intent_processing_card_customer_notification;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE amount_type TEXT,
  ADD ATTRIBUTE end_date TEXT,
  ADD ATTRIBUTE payment_schedule TEXT,
  ADD ATTRIBUTE payments_per_period BIGINT,
  ADD ATTRIBUTE purpose TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.m_payment_intent_payment_method_options_mandate_options_payto(
  amount BIGINT DEFAULT NULL,
  amount_type TEXT DEFAULT NULL,
  end_date TEXT DEFAULT NULL,
  payment_schedule TEXT DEFAULT NULL,
  payments_per_period BIGINT DEFAULT NULL,
  purpose TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount,
    amount_type,
    end_date,
    payment_schedule,
    payments_per_period,
    purpose
  )::stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto;
$$;

ALTER TYPE stripe_payment_intents.payment_intent_type_specific_payment_method_options_client
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE installments stripe_payment_intents.payment_flows_installment_options,
  ADD ATTRIBUTE mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto,
  ADD ATTRIBUTE request_incremental_authorization_support BOOLEAN,
  ADD ATTRIBUTE require_cvc_recollection BOOLEAN,
  ADD ATTRIBUTE routing stripe_payment_intents.payment_method_options_card_present_routing,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE verification_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_intent_type_specific_payment_method_options_client(
  capture_method TEXT DEFAULT NULL,
  installments stripe_payment_intents.payment_flows_installment_options DEFAULT NULL,
  mandate_options stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto DEFAULT NULL,
  request_incremental_authorization_support BOOLEAN DEFAULT NULL,
  require_cvc_recollection BOOLEAN DEFAULT NULL,
  routing stripe_payment_intents.payment_method_options_card_present_routing DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  verification_method TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_intent_type_specific_payment_method_options_client
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    installments,
    mandate_options,
    request_incremental_authorization_support,
    require_cvc_recollection,
    routing,
    setup_future_usage,
    verification_method
  )::stripe_payment_intents.payment_intent_type_specific_payment_method_options_client;
$$;

ALTER TYPE stripe_payment_intents.payment_method_options_card_present_routing
  ADD ATTRIBUTE requested_priority TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_method_options_card_present_routing(
  requested_priority TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_method_options_card_present_routing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    requested_priority
  )::stripe_payment_intents.payment_method_options_card_present_routing;
$$;

ALTER TYPE stripe_payment_intents.payment_transfer_data
  ADD ATTRIBUTE destination JSONB, ADD ATTRIBUTE amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_payment_transfer_data(
  destination JSONB, amount BIGINT DEFAULT NULL
)
RETURNS stripe_payment_intents.payment_transfer_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(destination, amount)::stripe_payment_intents.payment_transfer_data;
$$;

ALTER TYPE stripe_payment_intents.review
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE "open" BOOLEAN,
  ADD ATTRIBUTE opened_reason TEXT,
  ADD ATTRIBUTE reason TEXT,
  ADD ATTRIBUTE billing_zip TEXT,
  ADD ATTRIBUTE charge JSONB,
  ADD ATTRIBUTE closed_reason TEXT,
  ADD ATTRIBUTE ip_address TEXT,
  ADD ATTRIBUTE ip_address_location stripe_payment_intents.review_ip_address_location,
  ADD ATTRIBUTE payment_intent JSONB,
  ADD ATTRIBUTE "session" stripe_payment_intents.review_session;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_review(
  "id" TEXT,
  created BIGINT,
  livemode BOOLEAN,
  "object" TEXT,
  "open" BOOLEAN,
  opened_reason TEXT,
  reason TEXT,
  billing_zip TEXT DEFAULT NULL,
  charge JSONB DEFAULT NULL,
  closed_reason TEXT DEFAULT NULL,
  ip_address TEXT DEFAULT NULL,
  ip_address_location stripe_payment_intents.review_ip_address_location DEFAULT NULL,
  payment_intent JSONB DEFAULT NULL,
  "session" stripe_payment_intents.review_session DEFAULT NULL
)
RETURNS stripe_payment_intents.review
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    created,
    livemode,
    "object",
    "open",
    opened_reason,
    reason,
    billing_zip,
    charge,
    closed_reason,
    ip_address,
    ip_address_location,
    payment_intent,
    "session"
  )::stripe_payment_intents.review;
$$;

ALTER TYPE stripe_payment_intents.review_ip_address_location
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE latitude DOUBLE PRECISION,
  ADD ATTRIBUTE longitude DOUBLE PRECISION,
  ADD ATTRIBUTE region TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_review_ip_address_location(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  latitude DOUBLE PRECISION DEFAULT NULL,
  longitude DOUBLE PRECISION DEFAULT NULL,
  region TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.review_ip_address_location
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, latitude, longitude, region
  )::stripe_payment_intents.review_ip_address_location;
$$;

ALTER TYPE stripe_payment_intents.review_session
  ADD ATTRIBUTE browser TEXT,
  ADD ATTRIBUTE device TEXT,
  ADD ATTRIBUTE platform TEXT,
  ADD ATTRIBUTE "version" TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_intents.make_review_session(
  browser TEXT DEFAULT NULL,
  device TEXT DEFAULT NULL,
  platform TEXT DEFAULT NULL,
  "version" TEXT DEFAULT NULL
)
RETURNS stripe_payment_intents.review_session
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    browser, device, platform, "version"
  )::stripe_payment_intents.review_session;
$$;

CREATE OR REPLACE FUNCTION stripe_payment_intents._list_first_page_py(
  created JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
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

  page = GD["__stripe_context__"].client.payment_intents.list(
      created=not_given if created is None else json.loads(created),
      customer=not_given if customer is None else customer,
      customer_account=not_given if customer_account is None else customer_account,
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

-- A simpler wrapper around `stripe_payment_intents._list_first_page` that ensures the global client is initialized.
CREATE OR REPLACE FUNCTION stripe_payment_intents._list_first_page(
  created JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
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
    RETURN stripe_payment_intents._list_first_page_py(
      created,
      customer,
      customer_account,
      ending_before,
      expand,
      "limit",
      starting_after
    );
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_payment_intents._list_next_page(request_options JSONB)
RETURNS stripe_internal.page
LANGUAGE plpython3u
STABLE
AS $$
  import json
  from stripe_minimal.types import PaymentIntent
  from stripe_minimal.pagination import SyncMyCursorIDPage
  from stripe_minimal._models import FinalRequestOptions
  from pydantic import TypeAdapter
  from typing import Any

  page = GD["__stripe_context__"].client._request_api_list(
    model=PaymentIntent,
    page=SyncMyCursorIDPage[PaymentIntent],
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

CREATE OR REPLACE FUNCTION stripe_payment_intents.list(
  created JSONB DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  customer_account TEXT DEFAULT NULL,
  ending_before TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  "limit" BIGINT DEFAULT NULL,
  starting_after TEXT DEFAULT NULL
)
RETURNS SETOF stripe_payment_intents.payment_intent
LANGUAGE SQL
STABLE
AS $$
  WITH RECURSIVE paginated AS (
    SELECT page.*
    FROM stripe_payment_intents._list_first_page(
      created,
      customer,
      customer_account,
      ending_before,
      expand,
      "limit",
      starting_after
    ) AS page

    UNION ALL

    SELECT page.*
    FROM paginated
    CROSS JOIN stripe_payment_intents._list_next_page(paginated.next_request_options) AS page
    WHERE paginated.next_request_options IS NOT NULL
  )
  SELECT (jsonb_populate_recordset(NULL::stripe_payment_intents.payment_intent, "data")).* FROM paginated;
$$;