ALTER TYPE stripe_payment_links.custom_text_position
  ADD ATTRIBUTE message TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_text_position(
  message TEXT
)
RETURNS stripe_payment_links.custom_text_position
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(message)::stripe_payment_links.custom_text_position;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE active BOOLEAN,
  ADD ATTRIBUTE after_completion stripe_payment_links.payment_link_create_response_after_completion,
  ADD ATTRIBUTE allow_promotion_codes BOOLEAN,
  ADD ATTRIBUTE automatic_tax stripe_payment_links.payment_link_create_response_automatic_tax,
  ADD ATTRIBUTE billing_address_collection TEXT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE custom_fields stripe_payment_links.payment_link_create_response_custom_field[],
  ADD ATTRIBUTE custom_text stripe_payment_links.payment_link_create_response_custom_text,
  ADD ATTRIBUTE customer_creation TEXT,
  ADD ATTRIBUTE livemode BOOLEAN,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE payment_method_collection TEXT,
  ADD ATTRIBUTE phone_number_collection stripe_payment_links.payment_link_create_response_phone_number_collection,
  ADD ATTRIBUTE shipping_options stripe_payment_links.payment_link_create_response_shipping_option[],
  ADD ATTRIBUTE submit_type TEXT,
  ADD ATTRIBUTE tax_id_collection stripe_payment_links.payment_link_create_response_tax_id_collection,
  ADD ATTRIBUTE url TEXT,
  ADD ATTRIBUTE application JSONB,
  ADD ATTRIBUTE application_fee_amount BIGINT,
  ADD ATTRIBUTE application_fee_percent DOUBLE PRECISION,
  ADD ATTRIBUTE consent_collection stripe_payment_links.payment_link_create_response_consent_collection,
  ADD ATTRIBUTE inactive_message TEXT,
  ADD ATTRIBUTE invoice_creation stripe_payment_links.payment_link_create_response_invoice_creation,
  ADD ATTRIBUTE line_items stripe_payment_links.payment_link_create_response_line_item,
  ADD ATTRIBUTE name_collection stripe_payment_links.payment_link_create_response_name_collection,
  ADD ATTRIBUTE on_behalf_of JSONB,
  ADD ATTRIBUTE optional_items stripe_payment_links.payment_link_create_response_optional_item[],
  ADD ATTRIBUTE payment_intent_data stripe_payment_links.payment_link_create_response_payment_intent_data,
  ADD ATTRIBUTE payment_method_types TEXT[],
  ADD ATTRIBUTE restrictions stripe_payment_links.payment_link_create_response_restriction,
  ADD ATTRIBUTE shipping_address_collection stripe_payment_links.payment_link_create_response_shipping_address_collection,
  ADD ATTRIBUTE subscription_data stripe_payment_links.payment_link_create_response_subscription_data,
  ADD ATTRIBUTE transfer_data stripe_payment_links.payment_link_create_response_transfer_data;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response(
  id TEXT,
  active BOOLEAN,
  after_completion stripe_payment_links.payment_link_create_response_after_completion,
  allow_promotion_codes BOOLEAN,
  automatic_tax stripe_payment_links.payment_link_create_response_automatic_tax,
  billing_address_collection TEXT,
  currency TEXT,
  custom_fields stripe_payment_links.payment_link_create_response_custom_field[],
  custom_text stripe_payment_links.payment_link_create_response_custom_text,
  customer_creation TEXT,
  livemode BOOLEAN,
  metadata JSONB,
  object TEXT,
  payment_method_collection TEXT,
  phone_number_collection stripe_payment_links.payment_link_create_response_phone_number_collection,
  shipping_options stripe_payment_links.payment_link_create_response_shipping_option[],
  submit_type TEXT,
  tax_id_collection stripe_payment_links.payment_link_create_response_tax_id_collection,
  url TEXT,
  application JSONB DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  application_fee_percent DOUBLE PRECISION DEFAULT NULL,
  consent_collection stripe_payment_links.payment_link_create_response_consent_collection DEFAULT NULL,
  inactive_message TEXT DEFAULT NULL,
  invoice_creation stripe_payment_links.payment_link_create_response_invoice_creation DEFAULT NULL,
  line_items stripe_payment_links.payment_link_create_response_line_item DEFAULT NULL,
  name_collection stripe_payment_links.payment_link_create_response_name_collection DEFAULT NULL,
  on_behalf_of JSONB DEFAULT NULL,
  optional_items stripe_payment_links.payment_link_create_response_optional_item[] DEFAULT NULL,
  payment_intent_data stripe_payment_links.payment_link_create_response_payment_intent_data DEFAULT NULL,
  payment_method_types TEXT[] DEFAULT NULL,
  restrictions stripe_payment_links.payment_link_create_response_restriction DEFAULT NULL,
  shipping_address_collection stripe_payment_links.payment_link_create_response_shipping_address_collection DEFAULT NULL,
  subscription_data stripe_payment_links.payment_link_create_response_subscription_data DEFAULT NULL,
  transfer_data stripe_payment_links.payment_link_create_response_transfer_data DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    active,
    after_completion,
    allow_promotion_codes,
    automatic_tax,
    billing_address_collection,
    currency,
    custom_fields,
    custom_text,
    customer_creation,
    livemode,
    metadata,
    object,
    payment_method_collection,
    phone_number_collection,
    shipping_options,
    submit_type,
    tax_id_collection,
    url,
    application,
    application_fee_amount,
    application_fee_percent,
    consent_collection,
    inactive_message,
    invoice_creation,
    line_items,
    name_collection,
    on_behalf_of,
    optional_items,
    payment_intent_data,
    payment_method_types,
    restrictions,
    shipping_address_collection,
    subscription_data,
    transfer_data
  )::stripe_payment_links.payment_link_create_response;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_after_completion
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE hosted_confirmation stripe_payment_links.p_link_create_response_after_completion_hosted_confirmation,
  ADD ATTRIBUTE redirect stripe_payment_links.payment_link_create_response_after_completion_redirect;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_after_completion(
  type TEXT,
  hosted_confirmation stripe_payment_links.p_link_create_response_after_completion_hosted_confirmation DEFAULT NULL,
  redirect stripe_payment_links.payment_link_create_response_after_completion_redirect DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_after_completion
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, hosted_confirmation, redirect
  )::stripe_payment_links.payment_link_create_response_after_completion;
$$;

ALTER TYPE stripe_payment_links.p_link_create_response_after_completion_hosted_confirmation
  ADD ATTRIBUTE custom_message TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_p_link_create_response_after_completion_hosted_confirmation(
  custom_message TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.p_link_create_response_after_completion_hosted_confirmation
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    custom_message
  )::stripe_payment_links.p_link_create_response_after_completion_hosted_confirmation;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_after_completion_redirect
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_after_completion_redirect(
  url TEXT
)
RETURNS stripe_payment_links.payment_link_create_response_after_completion_redirect
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    url
  )::stripe_payment_links.payment_link_create_response_after_completion_redirect;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_automatic_tax
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE liability stripe_invoices.connect_account_reference;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_automatic_tax(
  enabled BOOLEAN,
  liability stripe_invoices.connect_account_reference DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_automatic_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, liability
  )::stripe_payment_links.payment_link_create_response_automatic_tax;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_custom_field
  ADD ATTRIBUTE key TEXT,
  ADD ATTRIBUTE label stripe_payment_links.payment_link_create_response_custom_field_label,
  ADD ATTRIBUTE optional BOOLEAN,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE dropdown stripe_payment_links.payment_link_create_response_custom_field_dropdown,
  ADD ATTRIBUTE "numeric" stripe_payment_links.payment_link_create_response_custom_field_numeric,
  ADD ATTRIBUTE text stripe_payment_links.payment_link_create_response_custom_field_text;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_custom_field(
  key TEXT,
  label stripe_payment_links.payment_link_create_response_custom_field_label,
  optional BOOLEAN,
  type TEXT,
  dropdown stripe_payment_links.payment_link_create_response_custom_field_dropdown DEFAULT NULL,
  "numeric" stripe_payment_links.payment_link_create_response_custom_field_numeric DEFAULT NULL,
  text stripe_payment_links.payment_link_create_response_custom_field_text DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_custom_field
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    key, label, optional, type, dropdown, "numeric", text
  )::stripe_payment_links.payment_link_create_response_custom_field;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_custom_field_label
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE custom TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_custom_field_label(
  type TEXT, custom TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_custom_field_label
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, custom
  )::stripe_payment_links.payment_link_create_response_custom_field_label;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_custom_field_dropdown
  ADD ATTRIBUTE options stripe_payment_links.payment_link_create_response_custom_field_dropdown_option[],
  ADD ATTRIBUTE default_value TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_custom_field_dropdown(
  options stripe_payment_links.payment_link_create_response_custom_field_dropdown_option[],
  default_value TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_custom_field_dropdown
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    options, default_value
  )::stripe_payment_links.payment_link_create_response_custom_field_dropdown;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_custom_field_dropdown_option
  ADD ATTRIBUTE label TEXT, ADD ATTRIBUTE value TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_custom_field_dropdown_option(
  label TEXT, value TEXT
)
RETURNS stripe_payment_links.payment_link_create_response_custom_field_dropdown_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    label, value
  )::stripe_payment_links.payment_link_create_response_custom_field_dropdown_option;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_custom_field_numeric
  ADD ATTRIBUTE default_value TEXT,
  ADD ATTRIBUTE maximum_length BIGINT,
  ADD ATTRIBUTE minimum_length BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_custom_field_numeric(
  default_value TEXT DEFAULT NULL,
  maximum_length BIGINT DEFAULT NULL,
  minimum_length BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_custom_field_numeric
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_value, maximum_length, minimum_length
  )::stripe_payment_links.payment_link_create_response_custom_field_numeric;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_custom_field_text
  ADD ATTRIBUTE default_value TEXT,
  ADD ATTRIBUTE maximum_length BIGINT,
  ADD ATTRIBUTE minimum_length BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_custom_field_text(
  default_value TEXT DEFAULT NULL,
  maximum_length BIGINT DEFAULT NULL,
  minimum_length BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_custom_field_text
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_value, maximum_length, minimum_length
  )::stripe_payment_links.payment_link_create_response_custom_field_text;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_custom_text
  ADD ATTRIBUTE after_submit stripe_payment_links.custom_text_position,
  ADD ATTRIBUTE shipping_address stripe_payment_links.custom_text_position,
  ADD ATTRIBUTE submit stripe_payment_links.custom_text_position,
  ADD ATTRIBUTE terms_of_service_acceptance stripe_payment_links.custom_text_position;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_custom_text(
  after_submit stripe_payment_links.custom_text_position DEFAULT NULL,
  shipping_address stripe_payment_links.custom_text_position DEFAULT NULL,
  submit stripe_payment_links.custom_text_position DEFAULT NULL,
  terms_of_service_acceptance stripe_payment_links.custom_text_position DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_custom_text
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    after_submit, shipping_address, submit, terms_of_service_acceptance
  )::stripe_payment_links.payment_link_create_response_custom_text;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_phone_number_collection
  ADD ATTRIBUTE enabled BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_phone_number_collection(
  enabled BOOLEAN
)
RETURNS stripe_payment_links.payment_link_create_response_phone_number_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled
  )::stripe_payment_links.payment_link_create_response_phone_number_collection;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_shipping_option
  ADD ATTRIBUTE shipping_amount BIGINT, ADD ATTRIBUTE shipping_rate JSONB;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_shipping_option(
  shipping_amount BIGINT, shipping_rate JSONB
)
RETURNS stripe_payment_links.payment_link_create_response_shipping_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    shipping_amount, shipping_rate
  )::stripe_payment_links.payment_link_create_response_shipping_option;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_tax_id_collection
  ADD ATTRIBUTE enabled BOOLEAN, ADD ATTRIBUTE required TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_tax_id_collection(
  enabled BOOLEAN, required TEXT
)
RETURNS stripe_payment_links.payment_link_create_response_tax_id_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, required
  )::stripe_payment_links.payment_link_create_response_tax_id_collection;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_consent_collection
  ADD ATTRIBUTE payment_method_reuse_agreement stripe_payment_links.p_l_c_r_consent_collection_payment_method_reuse_agreement,
  ADD ATTRIBUTE promotions TEXT,
  ADD ATTRIBUTE terms_of_service TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_consent_collection(
  payment_method_reuse_agreement stripe_payment_links.p_l_c_r_consent_collection_payment_method_reuse_agreement DEFAULT NULL,
  promotions TEXT DEFAULT NULL,
  terms_of_service TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_consent_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_method_reuse_agreement, promotions, terms_of_service
  )::stripe_payment_links.payment_link_create_response_consent_collection;
$$;

ALTER TYPE stripe_payment_links.p_l_c_r_consent_collection_payment_method_reuse_agreement
  ADD ATTRIBUTE "position" TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_p_l_c_r_consent_collection_payment_method_reuse_agreement(
  "position" TEXT
)
RETURNS stripe_payment_links.p_l_c_r_consent_collection_payment_method_reuse_agreement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "position"
  )::stripe_payment_links.p_l_c_r_consent_collection_payment_method_reuse_agreement;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_invoice_creation
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE invoice_data stripe_payment_links.payment_link_create_response_invoice_creation_invoice_data;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_invoice_creation(
  enabled BOOLEAN,
  invoice_data stripe_payment_links.payment_link_create_response_invoice_creation_invoice_data DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_invoice_creation
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, invoice_data
  )::stripe_payment_links.payment_link_create_response_invoice_creation;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_invoice_creation_invoice_data
  ADD ATTRIBUTE account_tax_ids JSONB[],
  ADD ATTRIBUTE custom_fields stripe.invoice_setting_custom_field[],
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE footer TEXT,
  ADD ATTRIBUTE issuer stripe_invoices.connect_account_reference,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE rendering_options stripe_payment_links.p_l_c_response_invoice_creation_invoice_data_rendering_option;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_invoice_creation_invoice_data(
  account_tax_ids JSONB[] DEFAULT NULL,
  custom_fields stripe.invoice_setting_custom_field[] DEFAULT NULL,
  description TEXT DEFAULT NULL,
  footer TEXT DEFAULT NULL,
  issuer stripe_invoices.connect_account_reference DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  rendering_options stripe_payment_links.p_l_c_response_invoice_creation_invoice_data_rendering_option DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_invoice_creation_invoice_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_tax_ids,
    custom_fields,
    description,
    footer,
    issuer,
    metadata,
    rendering_options
  )::stripe_payment_links.payment_link_create_response_invoice_creation_invoice_data;
$$;

ALTER TYPE stripe_payment_links.p_l_c_response_invoice_creation_invoice_data_rendering_option
  ADD ATTRIBUTE amount_tax_display TEXT, ADD ATTRIBUTE template TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_p_l_c_response_invoice_creation_invoice_data_rendering_option(
  amount_tax_display TEXT DEFAULT NULL, template TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.p_l_c_response_invoice_creation_invoice_data_rendering_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount_tax_display, template
  )::stripe_payment_links.p_l_c_response_invoice_creation_invoice_data_rendering_option;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_line_item
  ADD ATTRIBUTE data stripe_payment_links.payment_link_create_response_line_item_data[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_line_item(
  data stripe_payment_links.payment_link_create_response_line_item_data[],
  has_more BOOLEAN,
  object TEXT,
  url TEXT
)
RETURNS stripe_payment_links.payment_link_create_response_line_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    data, has_more, object, url
  )::stripe_payment_links.payment_link_create_response_line_item;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_line_item_data
  ADD ATTRIBUTE id TEXT,
  ADD ATTRIBUTE amount_discount BIGINT,
  ADD ATTRIBUTE amount_subtotal BIGINT,
  ADD ATTRIBUTE amount_tax BIGINT,
  ADD ATTRIBUTE amount_total BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE object TEXT,
  ADD ATTRIBUTE adjustable_quantity stripe_payment_links.payment_link_create_response_line_item_data_adjustable_quantity,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE discounts stripe_payment_links.payment_link_create_response_line_item_data_discount[],
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE price stripe_prices.price,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE taxes stripe_payment_links.payment_link_create_response_line_item_data_tax[];

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_line_item_data(
  id TEXT,
  amount_discount BIGINT,
  amount_subtotal BIGINT,
  amount_tax BIGINT,
  amount_total BIGINT,
  currency TEXT,
  object TEXT,
  adjustable_quantity stripe_payment_links.payment_link_create_response_line_item_data_adjustable_quantity DEFAULT NULL,
  description TEXT DEFAULT NULL,
  discounts stripe_payment_links.payment_link_create_response_line_item_data_discount[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  price stripe_prices.price DEFAULT NULL,
  quantity BIGINT DEFAULT NULL,
  taxes stripe_payment_links.payment_link_create_response_line_item_data_tax[] DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_line_item_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    id,
    amount_discount,
    amount_subtotal,
    amount_tax,
    amount_total,
    currency,
    object,
    adjustable_quantity,
    description,
    discounts,
    metadata,
    price,
    quantity,
    taxes
  )::stripe_payment_links.payment_link_create_response_line_item_data;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_line_item_data_adjustable_quantity
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE maximum BIGINT,
  ADD ATTRIBUTE minimum BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_p_link_create_response_line_item_data_adjustable_quantity(
  enabled BOOLEAN, maximum BIGINT DEFAULT NULL, minimum BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_line_item_data_adjustable_quantity
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, maximum, minimum
  )::stripe_payment_links.payment_link_create_response_line_item_data_adjustable_quantity;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_line_item_data_discount
  ADD ATTRIBUTE amount BIGINT, ADD ATTRIBUTE discount stripe_customers.discount;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_line_item_data_discount(
  amount BIGINT, discount stripe_customers.discount
)
RETURNS stripe_payment_links.payment_link_create_response_line_item_data_discount
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, discount
  )::stripe_payment_links.payment_link_create_response_line_item_data_discount;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_line_item_data_tax
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE rate stripe_invoices.tax_rate,
  ADD ATTRIBUTE taxability_reason TEXT,
  ADD ATTRIBUTE taxable_amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_line_item_data_tax(
  amount BIGINT,
  rate stripe_invoices.tax_rate,
  taxability_reason TEXT DEFAULT NULL,
  taxable_amount BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_line_item_data_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, rate, taxability_reason, taxable_amount
  )::stripe_payment_links.payment_link_create_response_line_item_data_tax;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_name_collection
  ADD ATTRIBUTE business stripe_payment_links.payment_link_create_response_name_collection_business,
  ADD ATTRIBUTE individual stripe_payment_links.payment_link_create_response_name_collection_individual;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_name_collection(
  business stripe_payment_links.payment_link_create_response_name_collection_business DEFAULT NULL,
  individual stripe_payment_links.payment_link_create_response_name_collection_individual DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_name_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    business, individual
  )::stripe_payment_links.payment_link_create_response_name_collection;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_name_collection_business
  ADD ATTRIBUTE enabled BOOLEAN, ADD ATTRIBUTE optional BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_name_collection_business(
  enabled BOOLEAN, optional BOOLEAN
)
RETURNS stripe_payment_links.payment_link_create_response_name_collection_business
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, optional
  )::stripe_payment_links.payment_link_create_response_name_collection_business;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_name_collection_individual
  ADD ATTRIBUTE enabled BOOLEAN, ADD ATTRIBUTE optional BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_name_collection_individual(
  enabled BOOLEAN, optional BOOLEAN
)
RETURNS stripe_payment_links.payment_link_create_response_name_collection_individual
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, optional
  )::stripe_payment_links.payment_link_create_response_name_collection_individual;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_optional_item
  ADD ATTRIBUTE price TEXT,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE adjustable_quantity stripe_payment_links.payment_link_create_response_optional_item_adjustable_quantity;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_optional_item(
  price TEXT,
  quantity BIGINT,
  adjustable_quantity stripe_payment_links.payment_link_create_response_optional_item_adjustable_quantity DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_optional_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    price, quantity, adjustable_quantity
  )::stripe_payment_links.payment_link_create_response_optional_item;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_optional_item_adjustable_quantity
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE maximum BIGINT,
  ADD ATTRIBUTE minimum BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_p_link_create_response_optional_item_adjustable_quantity(
  enabled BOOLEAN, maximum BIGINT DEFAULT NULL, minimum BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_optional_item_adjustable_quantity
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, maximum, minimum
  )::stripe_payment_links.payment_link_create_response_optional_item_adjustable_quantity;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_payment_intent_data
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE statement_descriptor_suffix TEXT,
  ADD ATTRIBUTE transfer_group TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_payment_intent_data(
  metadata JSONB,
  capture_method TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  statement_descriptor_suffix TEXT DEFAULT NULL,
  transfer_group TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_payment_intent_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    metadata,
    capture_method,
    description,
    setup_future_usage,
    statement_descriptor,
    statement_descriptor_suffix,
    transfer_group
  )::stripe_payment_links.payment_link_create_response_payment_intent_data;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_restriction
  ADD ATTRIBUTE completed_sessions stripe_payment_links.payment_link_create_response_restriction_completed_session;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_restriction(
  completed_sessions stripe_payment_links.payment_link_create_response_restriction_completed_session
)
RETURNS stripe_payment_links.payment_link_create_response_restriction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    completed_sessions
  )::stripe_payment_links.payment_link_create_response_restriction;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_restriction_completed_session
  ADD ATTRIBUTE count BIGINT, ADD ATTRIBUTE "limit" BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_restriction_completed_session(
  count BIGINT, "limit" BIGINT
)
RETURNS stripe_payment_links.payment_link_create_response_restriction_completed_session
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    count, "limit"
  )::stripe_payment_links.payment_link_create_response_restriction_completed_session;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_shipping_address_collection
  ADD ATTRIBUTE allowed_countries TEXT[];

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_shipping_address_collection(
  allowed_countries TEXT[]
)
RETURNS stripe_payment_links.payment_link_create_response_shipping_address_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    allowed_countries
  )::stripe_payment_links.payment_link_create_response_shipping_address_collection;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_subscription_data
  ADD ATTRIBUTE invoice_settings stripe_payment_links.payment_link_create_response_subscription_data_invoice_setting,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE trial_period_days BIGINT,
  ADD ATTRIBUTE trial_settings stripe_payment_links.payment_link_create_response_subscription_data_trial_setting;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_subscription_data(
  invoice_settings stripe_payment_links.payment_link_create_response_subscription_data_invoice_setting,
  metadata JSONB,
  description TEXT DEFAULT NULL,
  trial_period_days BIGINT DEFAULT NULL,
  trial_settings stripe_payment_links.payment_link_create_response_subscription_data_trial_setting DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_subscription_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    invoice_settings, metadata, description, trial_period_days, trial_settings
  )::stripe_payment_links.payment_link_create_response_subscription_data;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_subscription_data_invoice_setting
  ADD ATTRIBUTE issuer stripe_invoices.connect_account_reference;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_p_link_create_response_subscription_data_invoice_setting(
  issuer stripe_invoices.connect_account_reference
)
RETURNS stripe_payment_links.payment_link_create_response_subscription_data_invoice_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    issuer
  )::stripe_payment_links.payment_link_create_response_subscription_data_invoice_setting;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_subscription_data_trial_setting
  ADD ATTRIBUTE end_behavior stripe_payment_links.p_l_c_response_subscription_data_trial_setting_end_behavior;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_payment_link_create_response_subscription_data_trial_setting(
  end_behavior stripe_payment_links.p_l_c_response_subscription_data_trial_setting_end_behavior
)
RETURNS stripe_payment_links.payment_link_create_response_subscription_data_trial_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    end_behavior
  )::stripe_payment_links.payment_link_create_response_subscription_data_trial_setting;
$$;

ALTER TYPE stripe_payment_links.p_l_c_response_subscription_data_trial_setting_end_behavior
  ADD ATTRIBUTE missing_payment_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.m_p_l_c_response_subscription_data_trial_setting_end_behavior(
  missing_payment_method TEXT
)
RETURNS stripe_payment_links.p_l_c_response_subscription_data_trial_setting_end_behavior
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    missing_payment_method
  )::stripe_payment_links.p_l_c_response_subscription_data_trial_setting_end_behavior;
$$;

ALTER TYPE stripe_payment_links.payment_link_create_response_transfer_data
  ADD ATTRIBUTE destination JSONB, ADD ATTRIBUTE amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_link_create_response_transfer_data(
  destination JSONB, amount BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response_transfer_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    destination, amount
  )::stripe_payment_links.payment_link_create_response_transfer_data;
$$;

ALTER TYPE stripe_payment_links.line_item
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE adjustable_quantity stripe_payment_links.line_item_adjustable_quantity,
  ADD ATTRIBUTE price TEXT,
  ADD ATTRIBUTE price_data stripe_payment_links.line_item_price_data;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_line_item(
  quantity BIGINT,
  adjustable_quantity stripe_payment_links.line_item_adjustable_quantity DEFAULT NULL,
  price TEXT DEFAULT NULL,
  price_data stripe_payment_links.line_item_price_data DEFAULT NULL
)
RETURNS stripe_payment_links.line_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    quantity, adjustable_quantity, price, price_data
  )::stripe_payment_links.line_item;
$$;

ALTER TYPE stripe_payment_links.line_item_adjustable_quantity
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE maximum BIGINT,
  ADD ATTRIBUTE minimum BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_line_item_adjustable_quantity(
  enabled BOOLEAN, maximum BIGINT DEFAULT NULL, minimum BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.line_item_adjustable_quantity
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, maximum, minimum
  )::stripe_payment_links.line_item_adjustable_quantity;
$$;

ALTER TYPE stripe_payment_links.line_item_price_data
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE product TEXT,
  ADD ATTRIBUTE product_data stripe_payment_links.line_item_price_data_product_data,
  ADD ATTRIBUTE recurring stripe_payment_links.line_item_price_data_recurring,
  ADD ATTRIBUTE tax_behavior TEXT,
  ADD ATTRIBUTE unit_amount BIGINT,
  ADD ATTRIBUTE unit_amount_decimal TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_line_item_price_data(
  currency TEXT,
  product TEXT DEFAULT NULL,
  product_data stripe_payment_links.line_item_price_data_product_data DEFAULT NULL,
  recurring stripe_payment_links.line_item_price_data_recurring DEFAULT NULL,
  tax_behavior TEXT DEFAULT NULL,
  unit_amount BIGINT DEFAULT NULL,
  unit_amount_decimal TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.line_item_price_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currency,
    product,
    product_data,
    recurring,
    tax_behavior,
    unit_amount,
    unit_amount_decimal
  )::stripe_payment_links.line_item_price_data;
$$;

ALTER TYPE stripe_payment_links.line_item_price_data_product_data
  ADD ATTRIBUTE name TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE images TEXT[],
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE tax_code TEXT,
  ADD ATTRIBUTE unit_label TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_line_item_price_data_product_data(
  name TEXT,
  description TEXT DEFAULT NULL,
  images TEXT[] DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  tax_code TEXT DEFAULT NULL,
  unit_label TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.line_item_price_data_product_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    name, description, images, metadata, tax_code, unit_label
  )::stripe_payment_links.line_item_price_data_product_data;
$$;

ALTER TYPE stripe_payment_links.line_item_price_data_recurring
  ADD ATTRIBUTE "interval" TEXT, ADD ATTRIBUTE interval_count BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_line_item_price_data_recurring(
  "interval" TEXT, interval_count BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.line_item_price_data_recurring
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "interval", interval_count
  )::stripe_payment_links.line_item_price_data_recurring;
$$;

ALTER TYPE stripe_payment_links.after_completion
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE hosted_confirmation stripe_payment_links.after_completion_hosted_confirmation,
  ADD ATTRIBUTE redirect stripe_payment_links.after_completion_redirect;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_after_completion(
  type TEXT,
  hosted_confirmation stripe_payment_links.after_completion_hosted_confirmation DEFAULT NULL,
  redirect stripe_payment_links.after_completion_redirect DEFAULT NULL
)
RETURNS stripe_payment_links.after_completion
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, hosted_confirmation, redirect
  )::stripe_payment_links.after_completion;
$$;

ALTER TYPE stripe_payment_links.after_completion_hosted_confirmation
  ADD ATTRIBUTE custom_message TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_after_completion_hosted_confirmation(
  custom_message TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.after_completion_hosted_confirmation
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    custom_message
  )::stripe_payment_links.after_completion_hosted_confirmation;
$$;

ALTER TYPE stripe_payment_links.after_completion_redirect
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_after_completion_redirect(
  url TEXT
)
RETURNS stripe_payment_links.after_completion_redirect
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(url)::stripe_payment_links.after_completion_redirect;
$$;

ALTER TYPE stripe_payment_links.automatic_tax
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE liability stripe_payment_links.automatic_tax_liability;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_automatic_tax(
  enabled BOOLEAN,
  liability stripe_payment_links.automatic_tax_liability DEFAULT NULL
)
RETURNS stripe_payment_links.automatic_tax
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled, liability)::stripe_payment_links.automatic_tax;
$$;

ALTER TYPE stripe_payment_links.automatic_tax_liability
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_automatic_tax_liability(
  type TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.automatic_tax_liability
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(type, account)::stripe_payment_links.automatic_tax_liability;
$$;

ALTER TYPE stripe_payment_links.consent_collection
  ADD ATTRIBUTE payment_method_reuse_agreement stripe_payment_links.consent_collection_payment_method_reuse_agreement,
  ADD ATTRIBUTE promotions TEXT,
  ADD ATTRIBUTE terms_of_service TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_consent_collection(
  payment_method_reuse_agreement stripe_payment_links.consent_collection_payment_method_reuse_agreement DEFAULT NULL,
  promotions TEXT DEFAULT NULL,
  terms_of_service TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.consent_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    payment_method_reuse_agreement, promotions, terms_of_service
  )::stripe_payment_links.consent_collection;
$$;

ALTER TYPE stripe_payment_links.consent_collection_payment_method_reuse_agreement
  ADD ATTRIBUTE "position" TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_consent_collection_payment_method_reuse_agreement(
  "position" TEXT
)
RETURNS stripe_payment_links.consent_collection_payment_method_reuse_agreement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "position"
  )::stripe_payment_links.consent_collection_payment_method_reuse_agreement;
$$;

ALTER TYPE stripe_payment_links.custom_field
  ADD ATTRIBUTE key TEXT,
  ADD ATTRIBUTE label stripe_payment_links.custom_field_label,
  ADD ATTRIBUTE type TEXT,
  ADD ATTRIBUTE dropdown stripe_payment_links.custom_field_dropdown,
  ADD ATTRIBUTE "numeric" stripe_payment_links.custom_field_numeric,
  ADD ATTRIBUTE optional BOOLEAN,
  ADD ATTRIBUTE text stripe_payment_links.custom_field_text;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_field(
  key TEXT,
  label stripe_payment_links.custom_field_label,
  type TEXT,
  dropdown stripe_payment_links.custom_field_dropdown DEFAULT NULL,
  "numeric" stripe_payment_links.custom_field_numeric DEFAULT NULL,
  optional BOOLEAN DEFAULT NULL,
  text stripe_payment_links.custom_field_text DEFAULT NULL
)
RETURNS stripe_payment_links.custom_field
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    key, label, type, dropdown, "numeric", optional, text
  )::stripe_payment_links.custom_field;
$$;

ALTER TYPE stripe_payment_links.custom_field_label
  ADD ATTRIBUTE custom TEXT, ADD ATTRIBUTE type TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_field_label(
  custom TEXT, type TEXT
)
RETURNS stripe_payment_links.custom_field_label
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(custom, type)::stripe_payment_links.custom_field_label;
$$;

ALTER TYPE stripe_payment_links.custom_field_dropdown
  ADD ATTRIBUTE options stripe_payment_links.custom_field_dropdown_option[],
  ADD ATTRIBUTE default_value TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_field_dropdown(
  options stripe_payment_links.custom_field_dropdown_option[],
  default_value TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.custom_field_dropdown
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    options, default_value
  )::stripe_payment_links.custom_field_dropdown;
$$;

ALTER TYPE stripe_payment_links.custom_field_dropdown_option
  ADD ATTRIBUTE label TEXT, ADD ATTRIBUTE value TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_field_dropdown_option(
  label TEXT, value TEXT
)
RETURNS stripe_payment_links.custom_field_dropdown_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(label, value)::stripe_payment_links.custom_field_dropdown_option;
$$;

ALTER TYPE stripe_payment_links.custom_field_numeric
  ADD ATTRIBUTE default_value TEXT,
  ADD ATTRIBUTE maximum_length BIGINT,
  ADD ATTRIBUTE minimum_length BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_field_numeric(
  default_value TEXT DEFAULT NULL,
  maximum_length BIGINT DEFAULT NULL,
  minimum_length BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.custom_field_numeric
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_value, maximum_length, minimum_length
  )::stripe_payment_links.custom_field_numeric;
$$;

ALTER TYPE stripe_payment_links.custom_field_text
  ADD ATTRIBUTE default_value TEXT,
  ADD ATTRIBUTE maximum_length BIGINT,
  ADD ATTRIBUTE minimum_length BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_field_text(
  default_value TEXT DEFAULT NULL,
  maximum_length BIGINT DEFAULT NULL,
  minimum_length BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.custom_field_text
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_value, maximum_length, minimum_length
  )::stripe_payment_links.custom_field_text;
$$;

ALTER TYPE stripe_payment_links.custom_text
  ADD ATTRIBUTE after_submit JSONB,
  ADD ATTRIBUTE shipping_address JSONB,
  ADD ATTRIBUTE submit JSONB,
  ADD ATTRIBUTE terms_of_service_acceptance JSONB;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_custom_text(
  after_submit JSONB DEFAULT NULL,
  shipping_address JSONB DEFAULT NULL,
  submit JSONB DEFAULT NULL,
  terms_of_service_acceptance JSONB DEFAULT NULL
)
RETURNS stripe_payment_links.custom_text
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    after_submit, shipping_address, submit, terms_of_service_acceptance
  )::stripe_payment_links.custom_text;
$$;

ALTER TYPE stripe_payment_links.invoice_creation
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE invoice_data stripe_payment_links.invoice_creation_invoice_data;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_invoice_creation(
  enabled BOOLEAN,
  invoice_data stripe_payment_links.invoice_creation_invoice_data DEFAULT NULL
)
RETURNS stripe_payment_links.invoice_creation
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled, invoice_data)::stripe_payment_links.invoice_creation;
$$;

ALTER TYPE stripe_payment_links.invoice_creation_invoice_data
  ADD ATTRIBUTE account_tax_ids JSONB,
  ADD ATTRIBUTE custom_fields JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE footer TEXT,
  ADD ATTRIBUTE issuer stripe_payment_links.invoice_creation_invoice_data_issuer,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE rendering_options JSONB;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_invoice_creation_invoice_data(
  account_tax_ids JSONB DEFAULT NULL,
  custom_fields JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  footer TEXT DEFAULT NULL,
  issuer stripe_payment_links.invoice_creation_invoice_data_issuer DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  rendering_options JSONB DEFAULT NULL
)
RETURNS stripe_payment_links.invoice_creation_invoice_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account_tax_ids,
    custom_fields,
    description,
    footer,
    issuer,
    metadata,
    rendering_options
  )::stripe_payment_links.invoice_creation_invoice_data;
$$;

ALTER TYPE stripe_payment_links.invoice_creation_invoice_data_issuer
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_invoice_creation_invoice_data_issuer(
  type TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.invoice_creation_invoice_data_issuer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, account
  )::stripe_payment_links.invoice_creation_invoice_data_issuer;
$$;

ALTER TYPE stripe_payment_links.name_collection
  ADD ATTRIBUTE business stripe_payment_links.name_collection_business,
  ADD ATTRIBUTE individual stripe_payment_links.name_collection_individual;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_name_collection(
  business stripe_payment_links.name_collection_business DEFAULT NULL,
  individual stripe_payment_links.name_collection_individual DEFAULT NULL
)
RETURNS stripe_payment_links.name_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(business, individual)::stripe_payment_links.name_collection;
$$;

ALTER TYPE stripe_payment_links.name_collection_business
  ADD ATTRIBUTE enabled BOOLEAN, ADD ATTRIBUTE optional BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_name_collection_business(
  enabled BOOLEAN, optional BOOLEAN DEFAULT NULL
)
RETURNS stripe_payment_links.name_collection_business
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled, optional)::stripe_payment_links.name_collection_business;
$$;

ALTER TYPE stripe_payment_links.name_collection_individual
  ADD ATTRIBUTE enabled BOOLEAN, ADD ATTRIBUTE optional BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_name_collection_individual(
  enabled BOOLEAN, optional BOOLEAN DEFAULT NULL
)
RETURNS stripe_payment_links.name_collection_individual
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, optional
  )::stripe_payment_links.name_collection_individual;
$$;

ALTER TYPE stripe_payment_links.optional_item
  ADD ATTRIBUTE price TEXT,
  ADD ATTRIBUTE quantity BIGINT,
  ADD ATTRIBUTE adjustable_quantity stripe_payment_links.optional_item_adjustable_quantity;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_optional_item(
  price TEXT,
  quantity BIGINT,
  adjustable_quantity stripe_payment_links.optional_item_adjustable_quantity DEFAULT NULL
)
RETURNS stripe_payment_links.optional_item
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    price, quantity, adjustable_quantity
  )::stripe_payment_links.optional_item;
$$;

ALTER TYPE stripe_payment_links.optional_item_adjustable_quantity
  ADD ATTRIBUTE enabled BOOLEAN,
  ADD ATTRIBUTE maximum BIGINT,
  ADD ATTRIBUTE minimum BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_optional_item_adjustable_quantity(
  enabled BOOLEAN, maximum BIGINT DEFAULT NULL, minimum BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.optional_item_adjustable_quantity
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    enabled, maximum, minimum
  )::stripe_payment_links.optional_item_adjustable_quantity;
$$;

ALTER TYPE stripe_payment_links.payment_intent_data
  ADD ATTRIBUTE capture_method TEXT,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE setup_future_usage TEXT,
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE statement_descriptor_suffix TEXT,
  ADD ATTRIBUTE transfer_group TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_payment_intent_data(
  capture_method TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  setup_future_usage TEXT DEFAULT NULL,
  statement_descriptor TEXT DEFAULT NULL,
  statement_descriptor_suffix TEXT DEFAULT NULL,
  transfer_group TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.payment_intent_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    capture_method,
    description,
    metadata,
    setup_future_usage,
    statement_descriptor,
    statement_descriptor_suffix,
    transfer_group
  )::stripe_payment_links.payment_intent_data;
$$;

ALTER TYPE stripe_payment_links.phone_number_collection
  ADD ATTRIBUTE enabled BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_phone_number_collection(
  enabled BOOLEAN
)
RETURNS stripe_payment_links.phone_number_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled)::stripe_payment_links.phone_number_collection;
$$;

ALTER TYPE stripe_payment_links.restriction
  ADD ATTRIBUTE completed_sessions stripe_payment_links.restriction_completed_session;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_restriction(
  completed_sessions stripe_payment_links.restriction_completed_session
)
RETURNS stripe_payment_links.restriction
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(completed_sessions)::stripe_payment_links.restriction;
$$;

ALTER TYPE stripe_payment_links.restriction_completed_session
  ADD ATTRIBUTE "limit" BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_restriction_completed_session(
  "limit" BIGINT
)
RETURNS stripe_payment_links.restriction_completed_session
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("limit")::stripe_payment_links.restriction_completed_session;
$$;

ALTER TYPE stripe_payment_links.shipping_address_collection
  ADD ATTRIBUTE allowed_countries TEXT[];

CREATE OR REPLACE FUNCTION stripe_payment_links.make_shipping_address_collection(
  allowed_countries TEXT[]
)
RETURNS stripe_payment_links.shipping_address_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    allowed_countries
  )::stripe_payment_links.shipping_address_collection;
$$;

ALTER TYPE stripe_payment_links.shipping_option
  ADD ATTRIBUTE shipping_rate TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_shipping_option(
  shipping_rate TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.shipping_option
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(shipping_rate)::stripe_payment_links.shipping_option;
$$;

ALTER TYPE stripe_payment_links.subscription_data
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE invoice_settings stripe_payment_links.subscription_data_invoice_setting,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE trial_period_days BIGINT,
  ADD ATTRIBUTE trial_settings stripe_payment_links.subscription_data_trial_setting;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_subscription_data(
  description TEXT DEFAULT NULL,
  invoice_settings stripe_payment_links.subscription_data_invoice_setting DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  trial_period_days BIGINT DEFAULT NULL,
  trial_settings stripe_payment_links.subscription_data_trial_setting DEFAULT NULL
)
RETURNS stripe_payment_links.subscription_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    description, invoice_settings, metadata, trial_period_days, trial_settings
  )::stripe_payment_links.subscription_data;
$$;

ALTER TYPE stripe_payment_links.subscription_data_invoice_setting
  ADD ATTRIBUTE issuer stripe_payment_links.subscription_data_invoice_setting_issuer;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_subscription_data_invoice_setting(
  issuer stripe_payment_links.subscription_data_invoice_setting_issuer DEFAULT NULL
)
RETURNS stripe_payment_links.subscription_data_invoice_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(issuer)::stripe_payment_links.subscription_data_invoice_setting;
$$;

ALTER TYPE stripe_payment_links.subscription_data_invoice_setting_issuer
  ADD ATTRIBUTE type TEXT, ADD ATTRIBUTE account TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_subscription_data_invoice_setting_issuer(
  type TEXT, account TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.subscription_data_invoice_setting_issuer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    type, account
  )::stripe_payment_links.subscription_data_invoice_setting_issuer;
$$;

ALTER TYPE stripe_payment_links.subscription_data_trial_setting
  ADD ATTRIBUTE end_behavior stripe_payment_links.subscription_data_trial_setting_end_behavior;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_subscription_data_trial_setting(
  end_behavior stripe_payment_links.subscription_data_trial_setting_end_behavior
)
RETURNS stripe_payment_links.subscription_data_trial_setting
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    end_behavior
  )::stripe_payment_links.subscription_data_trial_setting;
$$;

ALTER TYPE stripe_payment_links.subscription_data_trial_setting_end_behavior
  ADD ATTRIBUTE missing_payment_method TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_subscription_data_trial_setting_end_behavior(
  missing_payment_method TEXT
)
RETURNS stripe_payment_links.subscription_data_trial_setting_end_behavior
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    missing_payment_method
  )::stripe_payment_links.subscription_data_trial_setting_end_behavior;
$$;

ALTER TYPE stripe_payment_links.tax_id_collection
  ADD ATTRIBUTE enabled BOOLEAN, ADD ATTRIBUTE required TEXT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_tax_id_collection(
  enabled BOOLEAN, required TEXT DEFAULT NULL
)
RETURNS stripe_payment_links.tax_id_collection
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(enabled, required)::stripe_payment_links.tax_id_collection;
$$;

ALTER TYPE stripe_payment_links.transfer_data
  ADD ATTRIBUTE destination TEXT, ADD ATTRIBUTE amount BIGINT;

CREATE OR REPLACE FUNCTION stripe_payment_links.make_transfer_data(
  destination TEXT, amount BIGINT DEFAULT NULL
)
RETURNS stripe_payment_links.transfer_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(destination, amount)::stripe_payment_links.transfer_data;
$$;

CREATE OR REPLACE FUNCTION stripe_payment_links._create(
  line_items stripe_payment_links.line_item[],
  after_completion stripe_payment_links.after_completion DEFAULT NULL,
  allow_promotion_codes BOOLEAN DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  application_fee_percent DOUBLE PRECISION DEFAULT NULL,
  automatic_tax stripe_payment_links.automatic_tax DEFAULT NULL,
  billing_address_collection TEXT DEFAULT NULL,
  consent_collection stripe_payment_links.consent_collection DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  custom_fields stripe_payment_links.custom_field[] DEFAULT NULL,
  custom_text stripe_payment_links.custom_text DEFAULT NULL,
  customer_creation TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  inactive_message TEXT DEFAULT NULL,
  invoice_creation stripe_payment_links.invoice_creation DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  name_collection stripe_payment_links.name_collection DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  optional_items stripe_payment_links.optional_item[] DEFAULT NULL,
  payment_intent_data stripe_payment_links.payment_intent_data DEFAULT NULL,
  payment_method_collection TEXT DEFAULT NULL,
  payment_method_types TEXT[] DEFAULT NULL,
  phone_number_collection stripe_payment_links.phone_number_collection DEFAULT NULL,
  restrictions stripe_payment_links.restriction DEFAULT NULL,
  shipping_address_collection stripe_payment_links.shipping_address_collection DEFAULT NULL,
  shipping_options stripe_payment_links.shipping_option[] DEFAULT NULL,
  submit_type TEXT DEFAULT NULL,
  subscription_data stripe_payment_links.subscription_data DEFAULT NULL,
  tax_id_collection stripe_payment_links.tax_id_collection DEFAULT NULL,
  transfer_data stripe_payment_links.transfer_data DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stainless_commons_stripe._types import not_given

  response = GD["__stripe_context__"].client.payment_links.with_raw_response.create(
      line_items=GD["__stripe_context__"].strip_none(line_items),
      after_completion=not_given if after_completion is None else GD["__stripe_context__"].strip_none(after_completion),
      allow_promotion_codes=not_given if allow_promotion_codes is None else allow_promotion_codes,
      application_fee_amount=not_given if application_fee_amount is None else application_fee_amount,
      application_fee_percent=not_given if application_fee_percent is None else application_fee_percent,
      automatic_tax=not_given if automatic_tax is None else GD["__stripe_context__"].strip_none(automatic_tax),
      billing_address_collection=not_given if billing_address_collection is None else billing_address_collection,
      consent_collection=not_given if consent_collection is None else GD["__stripe_context__"].strip_none(consent_collection),
      currency=not_given if currency is None else currency,
      custom_fields=not_given if custom_fields is None else GD["__stripe_context__"].strip_none(custom_fields),
      custom_text=not_given if custom_text is None else GD["__stripe_context__"].strip_none(custom_text),
      customer_creation=not_given if customer_creation is None else customer_creation,
      expand=not_given if expand is None else expand,
      inactive_message=not_given if inactive_message is None else inactive_message,
      invoice_creation=not_given if invoice_creation is None else GD["__stripe_context__"].strip_none(invoice_creation),
      metadata=not_given if metadata is None else json.loads(metadata),
      name_collection=not_given if name_collection is None else GD["__stripe_context__"].strip_none(name_collection),
      on_behalf_of=not_given if on_behalf_of is None else on_behalf_of,
      optional_items=not_given if optional_items is None else GD["__stripe_context__"].strip_none(optional_items),
      payment_intent_data=not_given if payment_intent_data is None else GD["__stripe_context__"].strip_none(payment_intent_data),
      payment_method_collection=not_given if payment_method_collection is None else payment_method_collection,
      payment_method_types=not_given if payment_method_types is None else payment_method_types,
      phone_number_collection=not_given if phone_number_collection is None else GD["__stripe_context__"].strip_none(phone_number_collection),
      restrictions=not_given if restrictions is None else GD["__stripe_context__"].strip_none(restrictions),
      shipping_address_collection=not_given if shipping_address_collection is None else GD["__stripe_context__"].strip_none(shipping_address_collection),
      shipping_options=not_given if shipping_options is None else GD["__stripe_context__"].strip_none(shipping_options),
      submit_type=not_given if submit_type is None else submit_type,
      subscription_data=not_given if subscription_data is None else GD["__stripe_context__"].strip_none(subscription_data),
      tax_id_collection=not_given if tax_id_collection is None else GD["__stripe_context__"].strip_none(tax_id_collection),
      transfer_data=not_given if transfer_data is None else GD["__stripe_context__"].strip_none(transfer_data),
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_payment_links.create(
  line_items stripe_payment_links.line_item[],
  after_completion stripe_payment_links.after_completion DEFAULT NULL,
  allow_promotion_codes BOOLEAN DEFAULT NULL,
  application_fee_amount BIGINT DEFAULT NULL,
  application_fee_percent DOUBLE PRECISION DEFAULT NULL,
  automatic_tax stripe_payment_links.automatic_tax DEFAULT NULL,
  billing_address_collection TEXT DEFAULT NULL,
  consent_collection stripe_payment_links.consent_collection DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  custom_fields stripe_payment_links.custom_field[] DEFAULT NULL,
  custom_text stripe_payment_links.custom_text DEFAULT NULL,
  customer_creation TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  inactive_message TEXT DEFAULT NULL,
  invoice_creation stripe_payment_links.invoice_creation DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  name_collection stripe_payment_links.name_collection DEFAULT NULL,
  on_behalf_of TEXT DEFAULT NULL,
  optional_items stripe_payment_links.optional_item[] DEFAULT NULL,
  payment_intent_data stripe_payment_links.payment_intent_data DEFAULT NULL,
  payment_method_collection TEXT DEFAULT NULL,
  payment_method_types TEXT[] DEFAULT NULL,
  phone_number_collection stripe_payment_links.phone_number_collection DEFAULT NULL,
  restrictions stripe_payment_links.restriction DEFAULT NULL,
  shipping_address_collection stripe_payment_links.shipping_address_collection DEFAULT NULL,
  shipping_options stripe_payment_links.shipping_option[] DEFAULT NULL,
  submit_type TEXT DEFAULT NULL,
  subscription_data stripe_payment_links.subscription_data DEFAULT NULL,
  tax_id_collection stripe_payment_links.tax_id_collection DEFAULT NULL,
  transfer_data stripe_payment_links.transfer_data DEFAULT NULL
)
RETURNS stripe_payment_links.payment_link_create_response
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_payment_links.payment_link_create_response,
      stripe_payment_links._create(
        line_items,
        after_completion,
        allow_promotion_codes,
        application_fee_amount,
        application_fee_percent,
        automatic_tax,
        billing_address_collection,
        consent_collection,
        currency,
        custom_fields,
        custom_text,
        customer_creation,
        expand,
        inactive_message,
        invoice_creation,
        metadata,
        name_collection,
        on_behalf_of,
        optional_items,
        payment_intent_data,
        payment_method_collection,
        payment_method_types,
        phone_number_collection,
        restrictions,
        shipping_address_collection,
        shipping_options,
        submit_type,
        subscription_data,
        tax_id_collection,
        transfer_data
      )
    );
  END;
$$;