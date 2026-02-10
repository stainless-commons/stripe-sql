ALTER TYPE stripe_account.account
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE business_profile stripe_account.account_business_profile,
  ADD ATTRIBUTE business_type TEXT,
  ADD ATTRIBUTE capabilities stripe_account.account_capability,
  ADD ATTRIBUTE charges_enabled BOOLEAN,
  ADD ATTRIBUTE company stripe_account.account_company,
  ADD ATTRIBUTE controller stripe_account.account_controller,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE default_currency TEXT,
  ADD ATTRIBUTE details_submitted BOOLEAN,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE external_accounts stripe_account.account_external_account,
  ADD ATTRIBUTE future_requirements stripe_account.account_future_requirement,
  ADD ATTRIBUTE "groups" stripe_account.account_group,
  ADD ATTRIBUTE individual stripe_account.account_individual,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE payouts_enabled BOOLEAN,
  ADD ATTRIBUTE requirements stripe_account.account_requirement,
  ADD ATTRIBUTE settings JSONB,
  ADD ATTRIBUTE tos_acceptance stripe_account.account_tos_acceptance,
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account(
  "id" TEXT,
  "object" TEXT,
  business_profile stripe_account.account_business_profile DEFAULT NULL,
  business_type TEXT DEFAULT NULL,
  capabilities stripe_account.account_capability DEFAULT NULL,
  charges_enabled BOOLEAN DEFAULT NULL,
  company stripe_account.account_company DEFAULT NULL,
  controller stripe_account.account_controller DEFAULT NULL,
  country TEXT DEFAULT NULL,
  created BIGINT DEFAULT NULL,
  default_currency TEXT DEFAULT NULL,
  details_submitted BOOLEAN DEFAULT NULL,
  email TEXT DEFAULT NULL,
  external_accounts stripe_account.account_external_account DEFAULT NULL,
  future_requirements stripe_account.account_future_requirement DEFAULT NULL,
  "groups" stripe_account.account_group DEFAULT NULL,
  individual stripe_account.account_individual DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  payouts_enabled BOOLEAN DEFAULT NULL,
  requirements stripe_account.account_requirement DEFAULT NULL,
  settings JSONB DEFAULT NULL,
  tos_acceptance stripe_account.account_tos_acceptance DEFAULT NULL,
  "type" TEXT DEFAULT NULL
)
RETURNS stripe_account.account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    "object",
    business_profile,
    business_type,
    capabilities,
    charges_enabled,
    company,
    controller,
    country,
    created,
    default_currency,
    details_submitted,
    email,
    external_accounts,
    future_requirements,
    "groups",
    individual,
    metadata,
    payouts_enabled,
    requirements,
    settings,
    tos_acceptance,
    "type"
  )::stripe_account.account;
$$;

ALTER TYPE stripe_account.account_business_profile
  ADD ATTRIBUTE annual_revenue stripe_account.account_business_profile_annual_revenue,
  ADD ATTRIBUTE estimated_worker_count BIGINT,
  ADD ATTRIBUTE mcc TEXT,
  ADD ATTRIBUTE minority_owned_business_designation TEXT[],
  ADD ATTRIBUTE monthly_estimated_revenue stripe_account.account_business_profile_monthly_estimated_revenue,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE product_description TEXT,
  ADD ATTRIBUTE support_address stripe.address,
  ADD ATTRIBUTE support_email TEXT,
  ADD ATTRIBUTE support_phone TEXT,
  ADD ATTRIBUTE support_url TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_business_profile(
  annual_revenue stripe_account.account_business_profile_annual_revenue DEFAULT NULL,
  estimated_worker_count BIGINT DEFAULT NULL,
  mcc TEXT DEFAULT NULL,
  minority_owned_business_designation TEXT[] DEFAULT NULL,
  monthly_estimated_revenue stripe_account.account_business_profile_monthly_estimated_revenue DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  product_description TEXT DEFAULT NULL,
  support_address stripe.address DEFAULT NULL,
  support_email TEXT DEFAULT NULL,
  support_phone TEXT DEFAULT NULL,
  support_url TEXT DEFAULT NULL,
  url TEXT DEFAULT NULL
)
RETURNS stripe_account.account_business_profile
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    annual_revenue,
    estimated_worker_count,
    mcc,
    minority_owned_business_designation,
    monthly_estimated_revenue,
    "name",
    product_description,
    support_address,
    support_email,
    support_phone,
    support_url,
    url
  )::stripe_account.account_business_profile;
$$;

ALTER TYPE stripe_account.account_business_profile_annual_revenue
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE fiscal_year_end TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_business_profile_annual_revenue(
  amount BIGINT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  fiscal_year_end TEXT DEFAULT NULL
)
RETURNS stripe_account.account_business_profile_annual_revenue
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, currency, fiscal_year_end
  )::stripe_account.account_business_profile_annual_revenue;
$$;

ALTER TYPE stripe_account.account_business_profile_monthly_estimated_revenue
  ADD ATTRIBUTE amount BIGINT, ADD ATTRIBUTE currency TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_business_profile_monthly_estimated_revenue(
  amount BIGINT, currency TEXT
)
RETURNS stripe_account.account_business_profile_monthly_estimated_revenue
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    amount, currency
  )::stripe_account.account_business_profile_monthly_estimated_revenue;
$$;

ALTER TYPE stripe_account.account_capability
  ADD ATTRIBUTE acss_debit_payments TEXT,
  ADD ATTRIBUTE affirm_payments TEXT,
  ADD ATTRIBUTE afterpay_clearpay_payments TEXT,
  ADD ATTRIBUTE alma_payments TEXT,
  ADD ATTRIBUTE amazon_pay_payments TEXT,
  ADD ATTRIBUTE au_becs_debit_payments TEXT,
  ADD ATTRIBUTE bacs_debit_payments TEXT,
  ADD ATTRIBUTE bancontact_payments TEXT,
  ADD ATTRIBUTE bank_transfer_payments TEXT,
  ADD ATTRIBUTE billie_payments TEXT,
  ADD ATTRIBUTE blik_payments TEXT,
  ADD ATTRIBUTE boleto_payments TEXT,
  ADD ATTRIBUTE card_issuing TEXT,
  ADD ATTRIBUTE card_payments TEXT,
  ADD ATTRIBUTE cartes_bancaires_payments TEXT,
  ADD ATTRIBUTE cashapp_payments TEXT,
  ADD ATTRIBUTE crypto_payments TEXT,
  ADD ATTRIBUTE eps_payments TEXT,
  ADD ATTRIBUTE fpx_payments TEXT,
  ADD ATTRIBUTE gb_bank_transfer_payments TEXT,
  ADD ATTRIBUTE giropay_payments TEXT,
  ADD ATTRIBUTE grabpay_payments TEXT,
  ADD ATTRIBUTE ideal_payments TEXT,
  ADD ATTRIBUTE india_international_payments TEXT,
  ADD ATTRIBUTE jcb_payments TEXT,
  ADD ATTRIBUTE jp_bank_transfer_payments TEXT,
  ADD ATTRIBUTE kakao_pay_payments TEXT,
  ADD ATTRIBUTE klarna_payments TEXT,
  ADD ATTRIBUTE konbini_payments TEXT,
  ADD ATTRIBUTE kr_card_payments TEXT,
  ADD ATTRIBUTE legacy_payments TEXT,
  ADD ATTRIBUTE link_payments TEXT,
  ADD ATTRIBUTE mb_way_payments TEXT,
  ADD ATTRIBUTE mobilepay_payments TEXT,
  ADD ATTRIBUTE multibanco_payments TEXT,
  ADD ATTRIBUTE mx_bank_transfer_payments TEXT,
  ADD ATTRIBUTE naver_pay_payments TEXT,
  ADD ATTRIBUTE nz_bank_account_becs_debit_payments TEXT,
  ADD ATTRIBUTE oxxo_payments TEXT,
  ADD ATTRIBUTE p24_payments TEXT,
  ADD ATTRIBUTE pay_by_bank_payments TEXT,
  ADD ATTRIBUTE payco_payments TEXT,
  ADD ATTRIBUTE paynow_payments TEXT,
  ADD ATTRIBUTE payto_payments TEXT,
  ADD ATTRIBUTE pix_payments TEXT,
  ADD ATTRIBUTE promptpay_payments TEXT,
  ADD ATTRIBUTE revolut_pay_payments TEXT,
  ADD ATTRIBUTE samsung_pay_payments TEXT,
  ADD ATTRIBUTE satispay_payments TEXT,
  ADD ATTRIBUTE sepa_bank_transfer_payments TEXT,
  ADD ATTRIBUTE sepa_debit_payments TEXT,
  ADD ATTRIBUTE sofort_payments TEXT,
  ADD ATTRIBUTE swish_payments TEXT,
  ADD ATTRIBUTE tax_reporting_us_1099_k TEXT,
  ADD ATTRIBUTE tax_reporting_us_1099_misc TEXT,
  ADD ATTRIBUTE transfers TEXT,
  ADD ATTRIBUTE treasury TEXT,
  ADD ATTRIBUTE twint_payments TEXT,
  ADD ATTRIBUTE us_bank_account_ach_payments TEXT,
  ADD ATTRIBUTE us_bank_transfer_payments TEXT,
  ADD ATTRIBUTE zip_payments TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_capability(
  acss_debit_payments TEXT DEFAULT NULL,
  affirm_payments TEXT DEFAULT NULL,
  afterpay_clearpay_payments TEXT DEFAULT NULL,
  alma_payments TEXT DEFAULT NULL,
  amazon_pay_payments TEXT DEFAULT NULL,
  au_becs_debit_payments TEXT DEFAULT NULL,
  bacs_debit_payments TEXT DEFAULT NULL,
  bancontact_payments TEXT DEFAULT NULL,
  bank_transfer_payments TEXT DEFAULT NULL,
  billie_payments TEXT DEFAULT NULL,
  blik_payments TEXT DEFAULT NULL,
  boleto_payments TEXT DEFAULT NULL,
  card_issuing TEXT DEFAULT NULL,
  card_payments TEXT DEFAULT NULL,
  cartes_bancaires_payments TEXT DEFAULT NULL,
  cashapp_payments TEXT DEFAULT NULL,
  crypto_payments TEXT DEFAULT NULL,
  eps_payments TEXT DEFAULT NULL,
  fpx_payments TEXT DEFAULT NULL,
  gb_bank_transfer_payments TEXT DEFAULT NULL,
  giropay_payments TEXT DEFAULT NULL,
  grabpay_payments TEXT DEFAULT NULL,
  ideal_payments TEXT DEFAULT NULL,
  india_international_payments TEXT DEFAULT NULL,
  jcb_payments TEXT DEFAULT NULL,
  jp_bank_transfer_payments TEXT DEFAULT NULL,
  kakao_pay_payments TEXT DEFAULT NULL,
  klarna_payments TEXT DEFAULT NULL,
  konbini_payments TEXT DEFAULT NULL,
  kr_card_payments TEXT DEFAULT NULL,
  legacy_payments TEXT DEFAULT NULL,
  link_payments TEXT DEFAULT NULL,
  mb_way_payments TEXT DEFAULT NULL,
  mobilepay_payments TEXT DEFAULT NULL,
  multibanco_payments TEXT DEFAULT NULL,
  mx_bank_transfer_payments TEXT DEFAULT NULL,
  naver_pay_payments TEXT DEFAULT NULL,
  nz_bank_account_becs_debit_payments TEXT DEFAULT NULL,
  oxxo_payments TEXT DEFAULT NULL,
  p24_payments TEXT DEFAULT NULL,
  pay_by_bank_payments TEXT DEFAULT NULL,
  payco_payments TEXT DEFAULT NULL,
  paynow_payments TEXT DEFAULT NULL,
  payto_payments TEXT DEFAULT NULL,
  pix_payments TEXT DEFAULT NULL,
  promptpay_payments TEXT DEFAULT NULL,
  revolut_pay_payments TEXT DEFAULT NULL,
  samsung_pay_payments TEXT DEFAULT NULL,
  satispay_payments TEXT DEFAULT NULL,
  sepa_bank_transfer_payments TEXT DEFAULT NULL,
  sepa_debit_payments TEXT DEFAULT NULL,
  sofort_payments TEXT DEFAULT NULL,
  swish_payments TEXT DEFAULT NULL,
  tax_reporting_us_1099_k TEXT DEFAULT NULL,
  tax_reporting_us_1099_misc TEXT DEFAULT NULL,
  transfers TEXT DEFAULT NULL,
  treasury TEXT DEFAULT NULL,
  twint_payments TEXT DEFAULT NULL,
  us_bank_account_ach_payments TEXT DEFAULT NULL,
  us_bank_transfer_payments TEXT DEFAULT NULL,
  zip_payments TEXT DEFAULT NULL
)
RETURNS stripe_account.account_capability
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    acss_debit_payments,
    affirm_payments,
    afterpay_clearpay_payments,
    alma_payments,
    amazon_pay_payments,
    au_becs_debit_payments,
    bacs_debit_payments,
    bancontact_payments,
    bank_transfer_payments,
    billie_payments,
    blik_payments,
    boleto_payments,
    card_issuing,
    card_payments,
    cartes_bancaires_payments,
    cashapp_payments,
    crypto_payments,
    eps_payments,
    fpx_payments,
    gb_bank_transfer_payments,
    giropay_payments,
    grabpay_payments,
    ideal_payments,
    india_international_payments,
    jcb_payments,
    jp_bank_transfer_payments,
    kakao_pay_payments,
    klarna_payments,
    konbini_payments,
    kr_card_payments,
    legacy_payments,
    link_payments,
    mb_way_payments,
    mobilepay_payments,
    multibanco_payments,
    mx_bank_transfer_payments,
    naver_pay_payments,
    nz_bank_account_becs_debit_payments,
    oxxo_payments,
    p24_payments,
    pay_by_bank_payments,
    payco_payments,
    paynow_payments,
    payto_payments,
    pix_payments,
    promptpay_payments,
    revolut_pay_payments,
    samsung_pay_payments,
    satispay_payments,
    sepa_bank_transfer_payments,
    sepa_debit_payments,
    sofort_payments,
    swish_payments,
    tax_reporting_us_1099_k,
    tax_reporting_us_1099_misc,
    transfers,
    treasury,
    twint_payments,
    us_bank_account_ach_payments,
    us_bank_transfer_payments,
    zip_payments
  )::stripe_account.account_capability;
$$;

ALTER TYPE stripe_account.account_company
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE address_kana stripe_account.legal_entity_japan_address,
  ADD ATTRIBUTE address_kanji stripe_account.legal_entity_japan_address,
  ADD ATTRIBUTE directors_provided BOOLEAN,
  ADD ATTRIBUTE directorship_declaration stripe_account.account_company_directorship_declaration,
  ADD ATTRIBUTE executives_provided BOOLEAN,
  ADD ATTRIBUTE export_license_id TEXT,
  ADD ATTRIBUTE export_purpose_code TEXT,
  ADD ATTRIBUTE "name" TEXT,
  ADD ATTRIBUTE name_kana TEXT,
  ADD ATTRIBUTE name_kanji TEXT,
  ADD ATTRIBUTE owners_provided BOOLEAN,
  ADD ATTRIBUTE ownership_declaration stripe_account.account_company_ownership_declaration,
  ADD ATTRIBUTE ownership_exemption_reason TEXT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE registration_date stripe_account.account_company_registration_date,
  ADD ATTRIBUTE representative_declaration stripe_account.account_company_representative_declaration,
  ADD ATTRIBUTE "structure" TEXT,
  ADD ATTRIBUTE tax_id_provided BOOLEAN,
  ADD ATTRIBUTE tax_id_registrar TEXT,
  ADD ATTRIBUTE vat_id_provided BOOLEAN,
  ADD ATTRIBUTE verification stripe_account.account_company_verification;

CREATE OR REPLACE FUNCTION stripe_account.make_account_company(
  address stripe.address DEFAULT NULL,
  address_kana stripe_account.legal_entity_japan_address DEFAULT NULL,
  address_kanji stripe_account.legal_entity_japan_address DEFAULT NULL,
  directors_provided BOOLEAN DEFAULT NULL,
  directorship_declaration stripe_account.account_company_directorship_declaration DEFAULT NULL,
  executives_provided BOOLEAN DEFAULT NULL,
  export_license_id TEXT DEFAULT NULL,
  export_purpose_code TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  name_kana TEXT DEFAULT NULL,
  name_kanji TEXT DEFAULT NULL,
  owners_provided BOOLEAN DEFAULT NULL,
  ownership_declaration stripe_account.account_company_ownership_declaration DEFAULT NULL,
  ownership_exemption_reason TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  registration_date stripe_account.account_company_registration_date DEFAULT NULL,
  representative_declaration stripe_account.account_company_representative_declaration DEFAULT NULL,
  "structure" TEXT DEFAULT NULL,
  tax_id_provided BOOLEAN DEFAULT NULL,
  tax_id_registrar TEXT DEFAULT NULL,
  vat_id_provided BOOLEAN DEFAULT NULL,
  verification stripe_account.account_company_verification DEFAULT NULL
)
RETURNS stripe_account.account_company
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    address,
    address_kana,
    address_kanji,
    directors_provided,
    directorship_declaration,
    executives_provided,
    export_license_id,
    export_purpose_code,
    "name",
    name_kana,
    name_kanji,
    owners_provided,
    ownership_declaration,
    ownership_exemption_reason,
    phone,
    registration_date,
    representative_declaration,
    "structure",
    tax_id_provided,
    tax_id_registrar,
    vat_id_provided,
    verification
  )::stripe_account.account_company;
$$;

ALTER TYPE stripe_account.account_company_directorship_declaration
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_company_directorship_declaration(
  "date" BIGINT DEFAULT NULL, ip TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_account.account_company_directorship_declaration
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, user_agent
  )::stripe_account.account_company_directorship_declaration;
$$;

ALTER TYPE stripe_account.account_company_ownership_declaration
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_company_ownership_declaration(
  "date" BIGINT DEFAULT NULL, ip TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_account.account_company_ownership_declaration
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, user_agent
  )::stripe_account.account_company_ownership_declaration;
$$;

ALTER TYPE stripe_account.account_company_registration_date
  ADD ATTRIBUTE "day" BIGINT,
  ADD ATTRIBUTE "month" BIGINT,
  ADD ATTRIBUTE "year" BIGINT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_company_registration_date(
  "day" BIGINT DEFAULT NULL,
  "month" BIGINT DEFAULT NULL,
  "year" BIGINT DEFAULT NULL
)
RETURNS stripe_account.account_company_registration_date
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "day", "month", "year"
  )::stripe_account.account_company_registration_date;
$$;

ALTER TYPE stripe_account.account_company_representative_declaration
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_company_representative_declaration(
  "date" BIGINT DEFAULT NULL, ip TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_account.account_company_representative_declaration
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, user_agent
  )::stripe_account.account_company_representative_declaration;
$$;

ALTER TYPE stripe_account.account_company_verification
  ADD ATTRIBUTE "document" stripe_account.account_company_verification_document;

CREATE OR REPLACE FUNCTION stripe_account.make_account_company_verification(
  "document" stripe_account.account_company_verification_document
)
RETURNS stripe_account.account_company_verification
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("document")::stripe_account.account_company_verification;
$$;

ALTER TYPE stripe_account.account_company_verification_document
  ADD ATTRIBUTE back JSONB,
  ADD ATTRIBUTE details TEXT,
  ADD ATTRIBUTE details_code TEXT,
  ADD ATTRIBUTE front JSONB;

CREATE OR REPLACE FUNCTION stripe_account.make_account_company_verification_document(
  back JSONB DEFAULT NULL,
  details TEXT DEFAULT NULL,
  details_code TEXT DEFAULT NULL,
  front JSONB DEFAULT NULL
)
RETURNS stripe_account.account_company_verification_document
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    back, details, details_code, front
  )::stripe_account.account_company_verification_document;
$$;

ALTER TYPE stripe_account.account_controller
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE fees stripe_account.account_controller_fee,
  ADD ATTRIBUTE is_controller BOOLEAN,
  ADD ATTRIBUTE losses stripe_account.account_controller_loss,
  ADD ATTRIBUTE requirement_collection TEXT,
  ADD ATTRIBUTE stripe_dashboard stripe_account.account_controller_stripe_dashboard;

CREATE OR REPLACE FUNCTION stripe_account.make_account_controller(
  "type" TEXT,
  fees stripe_account.account_controller_fee DEFAULT NULL,
  is_controller BOOLEAN DEFAULT NULL,
  losses stripe_account.account_controller_loss DEFAULT NULL,
  requirement_collection TEXT DEFAULT NULL,
  stripe_dashboard stripe_account.account_controller_stripe_dashboard DEFAULT NULL
)
RETURNS stripe_account.account_controller
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    fees,
    is_controller,
    losses,
    requirement_collection,
    stripe_dashboard
  )::stripe_account.account_controller;
$$;

ALTER TYPE stripe_account.account_controller_fee
  ADD ATTRIBUTE payer TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_controller_fee(
  payer TEXT
)
RETURNS stripe_account.account_controller_fee
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(payer)::stripe_account.account_controller_fee;
$$;

ALTER TYPE stripe_account.account_controller_loss
  ADD ATTRIBUTE payments TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_controller_loss(
  payments TEXT
)
RETURNS stripe_account.account_controller_loss
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(payments)::stripe_account.account_controller_loss;
$$;

ALTER TYPE stripe_account.account_controller_stripe_dashboard
  ADD ATTRIBUTE "type" TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_controller_stripe_dashboard(
  "type" TEXT
)
RETURNS stripe_account.account_controller_stripe_dashboard
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type")::stripe_account.account_controller_stripe_dashboard;
$$;

ALTER TYPE stripe_account.account_external_account
  ADD ATTRIBUTE "data" JSONB[],
  ADD ATTRIBUTE has_more BOOLEAN,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE url TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_external_account(
  "data" JSONB[], has_more BOOLEAN, "object" TEXT, url TEXT
)
RETURNS stripe_account.account_external_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "data", has_more, "object", url
  )::stripe_account.account_external_account;
$$;

ALTER TYPE stripe_account.account_future_requirement
  ADD ATTRIBUTE alternatives stripe_account.account_requirements_alternative[],
  ADD ATTRIBUTE current_deadline BIGINT,
  ADD ATTRIBUTE currently_due TEXT[],
  ADD ATTRIBUTE disabled_reason TEXT,
  ADD ATTRIBUTE errors stripe.account_requirements_error[],
  ADD ATTRIBUTE eventually_due TEXT[],
  ADD ATTRIBUTE past_due TEXT[],
  ADD ATTRIBUTE pending_verification TEXT[];

CREATE OR REPLACE FUNCTION stripe_account.make_account_future_requirement(
  alternatives stripe_account.account_requirements_alternative[] DEFAULT NULL,
  current_deadline BIGINT DEFAULT NULL,
  currently_due TEXT[] DEFAULT NULL,
  disabled_reason TEXT DEFAULT NULL,
  errors stripe.account_requirements_error[] DEFAULT NULL,
  eventually_due TEXT[] DEFAULT NULL,
  past_due TEXT[] DEFAULT NULL,
  pending_verification TEXT[] DEFAULT NULL
)
RETURNS stripe_account.account_future_requirement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    alternatives,
    current_deadline,
    currently_due,
    disabled_reason,
    errors,
    eventually_due,
    past_due,
    pending_verification
  )::stripe_account.account_future_requirement;
$$;

ALTER TYPE stripe_account.account_group
  ADD ATTRIBUTE payments_pricing TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_group(
  payments_pricing TEXT DEFAULT NULL
)
RETURNS stripe_account.account_group
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(payments_pricing)::stripe_account.account_group;
$$;

ALTER TYPE stripe_account.account_individual
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE account TEXT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE additional_tos_acceptances stripe_account.account_individual_additional_tos_acceptance,
  ADD ATTRIBUTE address stripe.address,
  ADD ATTRIBUTE address_kana stripe_account.legal_entity_japan_address,
  ADD ATTRIBUTE address_kanji stripe_account.legal_entity_japan_address,
  ADD ATTRIBUTE dob stripe_account.account_individual_dob,
  ADD ATTRIBUTE email TEXT,
  ADD ATTRIBUTE first_name TEXT,
  ADD ATTRIBUTE first_name_kana TEXT,
  ADD ATTRIBUTE first_name_kanji TEXT,
  ADD ATTRIBUTE full_name_aliases TEXT[],
  ADD ATTRIBUTE future_requirements stripe_account.account_individual_future_requirement,
  ADD ATTRIBUTE gender TEXT,
  ADD ATTRIBUTE id_number_provided BOOLEAN,
  ADD ATTRIBUTE id_number_secondary_provided BOOLEAN,
  ADD ATTRIBUTE last_name TEXT,
  ADD ATTRIBUTE last_name_kana TEXT,
  ADD ATTRIBUTE last_name_kanji TEXT,
  ADD ATTRIBUTE maiden_name TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE nationality TEXT,
  ADD ATTRIBUTE phone TEXT,
  ADD ATTRIBUTE political_exposure TEXT,
  ADD ATTRIBUTE registered_address stripe.address,
  ADD ATTRIBUTE relationship stripe_account.account_individual_relationship,
  ADD ATTRIBUTE requirements stripe_account.account_individual_requirement,
  ADD ATTRIBUTE ssn_last_4_provided BOOLEAN,
  ADD ATTRIBUTE us_cfpb_data stripe_account.account_individual_us_cfpb_data,
  ADD ATTRIBUTE verification stripe_account.account_individual_verification;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual(
  "id" TEXT,
  account TEXT,
  created BIGINT,
  "object" TEXT,
  additional_tos_acceptances stripe_account.account_individual_additional_tos_acceptance DEFAULT NULL,
  address stripe.address DEFAULT NULL,
  address_kana stripe_account.legal_entity_japan_address DEFAULT NULL,
  address_kanji stripe_account.legal_entity_japan_address DEFAULT NULL,
  dob stripe_account.account_individual_dob DEFAULT NULL,
  email TEXT DEFAULT NULL,
  first_name TEXT DEFAULT NULL,
  first_name_kana TEXT DEFAULT NULL,
  first_name_kanji TEXT DEFAULT NULL,
  full_name_aliases TEXT[] DEFAULT NULL,
  future_requirements stripe_account.account_individual_future_requirement DEFAULT NULL,
  gender TEXT DEFAULT NULL,
  id_number_provided BOOLEAN DEFAULT NULL,
  id_number_secondary_provided BOOLEAN DEFAULT NULL,
  last_name TEXT DEFAULT NULL,
  last_name_kana TEXT DEFAULT NULL,
  last_name_kanji TEXT DEFAULT NULL,
  maiden_name TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  nationality TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  political_exposure TEXT DEFAULT NULL,
  registered_address stripe.address DEFAULT NULL,
  relationship stripe_account.account_individual_relationship DEFAULT NULL,
  requirements stripe_account.account_individual_requirement DEFAULT NULL,
  ssn_last_4_provided BOOLEAN DEFAULT NULL,
  us_cfpb_data stripe_account.account_individual_us_cfpb_data DEFAULT NULL,
  verification stripe_account.account_individual_verification DEFAULT NULL
)
RETURNS stripe_account.account_individual
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    account,
    created,
    "object",
    additional_tos_acceptances,
    address,
    address_kana,
    address_kanji,
    dob,
    email,
    first_name,
    first_name_kana,
    first_name_kanji,
    full_name_aliases,
    future_requirements,
    gender,
    id_number_provided,
    id_number_secondary_provided,
    last_name,
    last_name_kana,
    last_name_kanji,
    maiden_name,
    metadata,
    nationality,
    phone,
    political_exposure,
    registered_address,
    relationship,
    requirements,
    ssn_last_4_provided,
    us_cfpb_data,
    verification
  )::stripe_account.account_individual;
$$;

ALTER TYPE stripe_account.account_individual_additional_tos_acceptance
  ADD ATTRIBUTE account stripe_account.account_individual_additional_tos_acceptance_account;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_additional_tos_acceptance(
  account stripe_account.account_individual_additional_tos_acceptance_account DEFAULT NULL
)
RETURNS stripe_account.account_individual_additional_tos_acceptance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    account
  )::stripe_account.account_individual_additional_tos_acceptance;
$$;

ALTER TYPE stripe_account.account_individual_additional_tos_acceptance_account
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_additional_tos_acceptance_account(
  "date" BIGINT DEFAULT NULL, ip TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_account.account_individual_additional_tos_acceptance_account
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, user_agent
  )::stripe_account.account_individual_additional_tos_acceptance_account;
$$;

ALTER TYPE stripe_account.account_individual_dob
  ADD ATTRIBUTE "day" BIGINT,
  ADD ATTRIBUTE "month" BIGINT,
  ADD ATTRIBUTE "year" BIGINT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_dob(
  "day" BIGINT DEFAULT NULL,
  "month" BIGINT DEFAULT NULL,
  "year" BIGINT DEFAULT NULL
)
RETURNS stripe_account.account_individual_dob
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("day", "month", "year")::stripe_account.account_individual_dob;
$$;

ALTER TYPE stripe_account.account_individual_future_requirement
  ADD ATTRIBUTE currently_due TEXT[],
  ADD ATTRIBUTE errors stripe.account_requirements_error[],
  ADD ATTRIBUTE eventually_due TEXT[],
  ADD ATTRIBUTE past_due TEXT[],
  ADD ATTRIBUTE pending_verification TEXT[],
  ADD ATTRIBUTE alternatives stripe_account.account_requirements_alternative[];

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_future_requirement(
  currently_due TEXT[],
  errors stripe.account_requirements_error[],
  eventually_due TEXT[],
  past_due TEXT[],
  pending_verification TEXT[],
  alternatives stripe_account.account_requirements_alternative[] DEFAULT NULL
)
RETURNS stripe_account.account_individual_future_requirement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currently_due,
    errors,
    eventually_due,
    past_due,
    pending_verification,
    alternatives
  )::stripe_account.account_individual_future_requirement;
$$;

ALTER TYPE stripe_account.account_individual_relationship
  ADD ATTRIBUTE authorizer BOOLEAN,
  ADD ATTRIBUTE director BOOLEAN,
  ADD ATTRIBUTE executive BOOLEAN,
  ADD ATTRIBUTE legal_guardian BOOLEAN,
  ADD ATTRIBUTE "owner" BOOLEAN,
  ADD ATTRIBUTE percent_ownership DOUBLE PRECISION,
  ADD ATTRIBUTE representative BOOLEAN,
  ADD ATTRIBUTE title TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_relationship(
  authorizer BOOLEAN DEFAULT NULL,
  director BOOLEAN DEFAULT NULL,
  executive BOOLEAN DEFAULT NULL,
  legal_guardian BOOLEAN DEFAULT NULL,
  "owner" BOOLEAN DEFAULT NULL,
  percent_ownership DOUBLE PRECISION DEFAULT NULL,
  representative BOOLEAN DEFAULT NULL,
  title TEXT DEFAULT NULL
)
RETURNS stripe_account.account_individual_relationship
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    authorizer,
    director,
    executive,
    legal_guardian,
    "owner",
    percent_ownership,
    representative,
    title
  )::stripe_account.account_individual_relationship;
$$;

ALTER TYPE stripe_account.account_individual_requirement
  ADD ATTRIBUTE currently_due TEXT[],
  ADD ATTRIBUTE errors stripe.account_requirements_error[],
  ADD ATTRIBUTE eventually_due TEXT[],
  ADD ATTRIBUTE past_due TEXT[],
  ADD ATTRIBUTE pending_verification TEXT[],
  ADD ATTRIBUTE alternatives stripe_account.account_requirements_alternative[];

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_requirement(
  currently_due TEXT[],
  errors stripe.account_requirements_error[],
  eventually_due TEXT[],
  past_due TEXT[],
  pending_verification TEXT[],
  alternatives stripe_account.account_requirements_alternative[] DEFAULT NULL
)
RETURNS stripe_account.account_individual_requirement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    currently_due,
    errors,
    eventually_due,
    past_due,
    pending_verification,
    alternatives
  )::stripe_account.account_individual_requirement;
$$;

ALTER TYPE stripe_account.account_individual_us_cfpb_data
  ADD ATTRIBUTE ethnicity_details stripe_account.account_individual_us_cfpb_data_ethnicity_detail,
  ADD ATTRIBUTE race_details stripe_account.account_individual_us_cfpb_data_race_detail,
  ADD ATTRIBUTE self_identified_gender TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_us_cfpb_data(
  ethnicity_details stripe_account.account_individual_us_cfpb_data_ethnicity_detail DEFAULT NULL,
  race_details stripe_account.account_individual_us_cfpb_data_race_detail DEFAULT NULL,
  self_identified_gender TEXT DEFAULT NULL
)
RETURNS stripe_account.account_individual_us_cfpb_data
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    ethnicity_details, race_details, self_identified_gender
  )::stripe_account.account_individual_us_cfpb_data;
$$;

ALTER TYPE stripe_account.account_individual_us_cfpb_data_ethnicity_detail
  ADD ATTRIBUTE ethnicity TEXT[], ADD ATTRIBUTE ethnicity_other TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_us_cfpb_data_ethnicity_detail(
  ethnicity TEXT[] DEFAULT NULL, ethnicity_other TEXT DEFAULT NULL
)
RETURNS stripe_account.account_individual_us_cfpb_data_ethnicity_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    ethnicity, ethnicity_other
  )::stripe_account.account_individual_us_cfpb_data_ethnicity_detail;
$$;

ALTER TYPE stripe_account.account_individual_us_cfpb_data_race_detail
  ADD ATTRIBUTE race TEXT[], ADD ATTRIBUTE race_other TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_us_cfpb_data_race_detail(
  race TEXT[] DEFAULT NULL, race_other TEXT DEFAULT NULL
)
RETURNS stripe_account.account_individual_us_cfpb_data_race_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    race, race_other
  )::stripe_account.account_individual_us_cfpb_data_race_detail;
$$;

ALTER TYPE stripe_account.account_individual_verification
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE additional_document stripe_account.account_individual_verification_additional_document,
  ADD ATTRIBUTE details TEXT,
  ADD ATTRIBUTE details_code TEXT,
  ADD ATTRIBUTE "document" stripe_account.account_individual_verification_document;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_verification(
  status TEXT,
  additional_document stripe_account.account_individual_verification_additional_document DEFAULT NULL,
  details TEXT DEFAULT NULL,
  details_code TEXT DEFAULT NULL,
  "document" stripe_account.account_individual_verification_document DEFAULT NULL
)
RETURNS stripe_account.account_individual_verification
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    status, additional_document, details, details_code, "document"
  )::stripe_account.account_individual_verification;
$$;

ALTER TYPE stripe_account.account_individual_verification_additional_document
  ADD ATTRIBUTE back JSONB,
  ADD ATTRIBUTE details TEXT,
  ADD ATTRIBUTE details_code TEXT,
  ADD ATTRIBUTE front JSONB;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_verification_additional_document(
  back JSONB DEFAULT NULL,
  details TEXT DEFAULT NULL,
  details_code TEXT DEFAULT NULL,
  front JSONB DEFAULT NULL
)
RETURNS stripe_account.account_individual_verification_additional_document
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    back, details, details_code, front
  )::stripe_account.account_individual_verification_additional_document;
$$;

ALTER TYPE stripe_account.account_individual_verification_document
  ADD ATTRIBUTE back JSONB,
  ADD ATTRIBUTE details TEXT,
  ADD ATTRIBUTE details_code TEXT,
  ADD ATTRIBUTE front JSONB;

CREATE OR REPLACE FUNCTION stripe_account.make_account_individual_verification_document(
  back JSONB DEFAULT NULL,
  details TEXT DEFAULT NULL,
  details_code TEXT DEFAULT NULL,
  front JSONB DEFAULT NULL
)
RETURNS stripe_account.account_individual_verification_document
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    back, details, details_code, front
  )::stripe_account.account_individual_verification_document;
$$;

ALTER TYPE stripe_account.account_requirement
  ADD ATTRIBUTE alternatives stripe_account.account_requirements_alternative[],
  ADD ATTRIBUTE current_deadline BIGINT,
  ADD ATTRIBUTE currently_due TEXT[],
  ADD ATTRIBUTE disabled_reason TEXT,
  ADD ATTRIBUTE errors stripe.account_requirements_error[],
  ADD ATTRIBUTE eventually_due TEXT[],
  ADD ATTRIBUTE past_due TEXT[],
  ADD ATTRIBUTE pending_verification TEXT[];

CREATE OR REPLACE FUNCTION stripe_account.make_account_requirement(
  alternatives stripe_account.account_requirements_alternative[] DEFAULT NULL,
  current_deadline BIGINT DEFAULT NULL,
  currently_due TEXT[] DEFAULT NULL,
  disabled_reason TEXT DEFAULT NULL,
  errors stripe.account_requirements_error[] DEFAULT NULL,
  eventually_due TEXT[] DEFAULT NULL,
  past_due TEXT[] DEFAULT NULL,
  pending_verification TEXT[] DEFAULT NULL
)
RETURNS stripe_account.account_requirement
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    alternatives,
    current_deadline,
    currently_due,
    disabled_reason,
    errors,
    eventually_due,
    past_due,
    pending_verification
  )::stripe_account.account_requirement;
$$;

ALTER TYPE stripe_account.account_tos_acceptance
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE service_agreement TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_tos_acceptance(
  "date" BIGINT DEFAULT NULL,
  ip TEXT DEFAULT NULL,
  service_agreement TEXT DEFAULT NULL,
  user_agent TEXT DEFAULT NULL
)
RETURNS stripe_account.account_tos_acceptance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, service_agreement, user_agent
  )::stripe_account.account_tos_acceptance;
$$;

ALTER TYPE stripe_account.account_invoices_settings
  ADD ATTRIBUTE default_account_tax_ids JSONB[],
  ADD ATTRIBUTE hosted_payment_method_save TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_invoices_settings(
  default_account_tax_ids JSONB[] DEFAULT NULL,
  hosted_payment_method_save TEXT DEFAULT NULL
)
RETURNS stripe_account.account_invoices_settings
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    default_account_tax_ids, hosted_payment_method_save
  )::stripe_account.account_invoices_settings;
$$;

ALTER TYPE stripe_account.account_requirements_alternative
  ADD ATTRIBUTE alternative_fields_due TEXT[],
  ADD ATTRIBUTE original_fields_due TEXT[];

CREATE OR REPLACE FUNCTION stripe_account.make_account_requirements_alternative(
  alternative_fields_due TEXT[], original_fields_due TEXT[]
)
RETURNS stripe_account.account_requirements_alternative
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    alternative_fields_due, original_fields_due
  )::stripe_account.account_requirements_alternative;
$$;

ALTER TYPE stripe_account.account_settings
  ADD ATTRIBUTE branding stripe_account.account_settings_branding,
  ADD ATTRIBUTE card_payments stripe_account.account_settings_card_payment,
  ADD ATTRIBUTE dashboard stripe_account.account_settings_dashboard,
  ADD ATTRIBUTE payments stripe_account.account_settings_payment,
  ADD ATTRIBUTE bacs_debit_payments stripe_account.account_settings_bacs_debit_payment,
  ADD ATTRIBUTE card_issuing stripe_account.account_settings_card_issuing,
  ADD ATTRIBUTE invoices JSONB,
  ADD ATTRIBUTE payouts stripe_account.account_settings_payout,
  ADD ATTRIBUTE sepa_debit_payments stripe_account.account_settings_sepa_debit_payment,
  ADD ATTRIBUTE treasury stripe_account.account_settings_treasury;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings(
  branding stripe_account.account_settings_branding,
  card_payments stripe_account.account_settings_card_payment,
  dashboard stripe_account.account_settings_dashboard,
  payments stripe_account.account_settings_payment,
  bacs_debit_payments stripe_account.account_settings_bacs_debit_payment DEFAULT NULL,
  card_issuing stripe_account.account_settings_card_issuing DEFAULT NULL,
  invoices JSONB DEFAULT NULL,
  payouts stripe_account.account_settings_payout DEFAULT NULL,
  sepa_debit_payments stripe_account.account_settings_sepa_debit_payment DEFAULT NULL,
  treasury stripe_account.account_settings_treasury DEFAULT NULL
)
RETURNS stripe_account.account_settings
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    branding,
    card_payments,
    dashboard,
    payments,
    bacs_debit_payments,
    card_issuing,
    invoices,
    payouts,
    sepa_debit_payments,
    treasury
  )::stripe_account.account_settings;
$$;

ALTER TYPE stripe_account.account_settings_branding
  ADD ATTRIBUTE icon JSONB,
  ADD ATTRIBUTE logo JSONB,
  ADD ATTRIBUTE primary_color TEXT,
  ADD ATTRIBUTE secondary_color TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_branding(
  icon JSONB DEFAULT NULL,
  logo JSONB DEFAULT NULL,
  primary_color TEXT DEFAULT NULL,
  secondary_color TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_branding
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    icon, logo, primary_color, secondary_color
  )::stripe_account.account_settings_branding;
$$;

ALTER TYPE stripe_account.account_settings_card_payment
  ADD ATTRIBUTE decline_on stripe_account.account_settings_card_payment_decline_on,
  ADD ATTRIBUTE statement_descriptor_prefix TEXT,
  ADD ATTRIBUTE statement_descriptor_prefix_kana TEXT,
  ADD ATTRIBUTE statement_descriptor_prefix_kanji TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_card_payment(
  decline_on stripe_account.account_settings_card_payment_decline_on DEFAULT NULL,
  statement_descriptor_prefix TEXT DEFAULT NULL,
  statement_descriptor_prefix_kana TEXT DEFAULT NULL,
  statement_descriptor_prefix_kanji TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_card_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    decline_on,
    statement_descriptor_prefix,
    statement_descriptor_prefix_kana,
    statement_descriptor_prefix_kanji
  )::stripe_account.account_settings_card_payment;
$$;

ALTER TYPE stripe_account.account_settings_card_payment_decline_on
  ADD ATTRIBUTE avs_failure BOOLEAN, ADD ATTRIBUTE cvc_failure BOOLEAN;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_card_payment_decline_on(
  avs_failure BOOLEAN, cvc_failure BOOLEAN
)
RETURNS stripe_account.account_settings_card_payment_decline_on
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    avs_failure, cvc_failure
  )::stripe_account.account_settings_card_payment_decline_on;
$$;

ALTER TYPE stripe_account.account_settings_dashboard
  ADD ATTRIBUTE display_name TEXT, ADD ATTRIBUTE timezone TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_dashboard(
  display_name TEXT DEFAULT NULL, timezone TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_dashboard
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(display_name, timezone)::stripe_account.account_settings_dashboard;
$$;

ALTER TYPE stripe_account.account_settings_payment
  ADD ATTRIBUTE statement_descriptor TEXT,
  ADD ATTRIBUTE statement_descriptor_kana TEXT,
  ADD ATTRIBUTE statement_descriptor_kanji TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_payment(
  statement_descriptor TEXT DEFAULT NULL,
  statement_descriptor_kana TEXT DEFAULT NULL,
  statement_descriptor_kanji TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    statement_descriptor, statement_descriptor_kana, statement_descriptor_kanji
  )::stripe_account.account_settings_payment;
$$;

ALTER TYPE stripe_account.account_settings_bacs_debit_payment
  ADD ATTRIBUTE display_name TEXT, ADD ATTRIBUTE service_user_number TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_bacs_debit_payment(
  display_name TEXT DEFAULT NULL, service_user_number TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_bacs_debit_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    display_name, service_user_number
  )::stripe_account.account_settings_bacs_debit_payment;
$$;

ALTER TYPE stripe_account.account_settings_card_issuing
  ADD ATTRIBUTE tos_acceptance stripe_account.account_settings_card_issuing_tos_acceptance;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_card_issuing(
  tos_acceptance stripe_account.account_settings_card_issuing_tos_acceptance DEFAULT NULL
)
RETURNS stripe_account.account_settings_card_issuing
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tos_acceptance)::stripe_account.account_settings_card_issuing;
$$;

ALTER TYPE stripe_account.account_settings_card_issuing_tos_acceptance
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_card_issuing_tos_acceptance(
  "date" BIGINT DEFAULT NULL, ip TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_card_issuing_tos_acceptance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, user_agent
  )::stripe_account.account_settings_card_issuing_tos_acceptance;
$$;

ALTER TYPE stripe_account.account_settings_payout
  ADD ATTRIBUTE debit_negative_balances BOOLEAN,
  ADD ATTRIBUTE schedule stripe_account.account_settings_payout_schedule,
  ADD ATTRIBUTE statement_descriptor TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_payout(
  debit_negative_balances BOOLEAN,
  schedule stripe_account.account_settings_payout_schedule,
  statement_descriptor TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_payout
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    debit_negative_balances, schedule, statement_descriptor
  )::stripe_account.account_settings_payout;
$$;

ALTER TYPE stripe_account.account_settings_payout_schedule
  ADD ATTRIBUTE delay_days BIGINT,
  ADD ATTRIBUTE "interval" TEXT,
  ADD ATTRIBUTE monthly_anchor BIGINT,
  ADD ATTRIBUTE monthly_payout_days BIGINT[],
  ADD ATTRIBUTE weekly_anchor TEXT,
  ADD ATTRIBUTE weekly_payout_days TEXT[];

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_payout_schedule(
  delay_days BIGINT,
  "interval" TEXT,
  monthly_anchor BIGINT DEFAULT NULL,
  monthly_payout_days BIGINT[] DEFAULT NULL,
  weekly_anchor TEXT DEFAULT NULL,
  weekly_payout_days TEXT[] DEFAULT NULL
)
RETURNS stripe_account.account_settings_payout_schedule
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    delay_days,
    "interval",
    monthly_anchor,
    monthly_payout_days,
    weekly_anchor,
    weekly_payout_days
  )::stripe_account.account_settings_payout_schedule;
$$;

ALTER TYPE stripe_account.account_settings_sepa_debit_payment
  ADD ATTRIBUTE creditor_id TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_sepa_debit_payment(
  creditor_id TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_sepa_debit_payment
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(creditor_id)::stripe_account.account_settings_sepa_debit_payment;
$$;

ALTER TYPE stripe_account.account_settings_treasury
  ADD ATTRIBUTE tos_acceptance stripe_account.account_settings_treasury_tos_acceptance;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_treasury(
  tos_acceptance stripe_account.account_settings_treasury_tos_acceptance DEFAULT NULL
)
RETURNS stripe_account.account_settings_treasury
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(tos_acceptance)::stripe_account.account_settings_treasury;
$$;

ALTER TYPE stripe_account.account_settings_treasury_tos_acceptance
  ADD ATTRIBUTE "date" BIGINT,
  ADD ATTRIBUTE ip TEXT,
  ADD ATTRIBUTE user_agent TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_account_settings_treasury_tos_acceptance(
  "date" BIGINT DEFAULT NULL, ip TEXT DEFAULT NULL, user_agent TEXT DEFAULT NULL
)
RETURNS stripe_account.account_settings_treasury_tos_acceptance
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "date", ip, user_agent
  )::stripe_account.account_settings_treasury_tos_acceptance;
$$;

ALTER TYPE stripe_account.legal_entity_japan_address
  ADD ATTRIBUTE city TEXT,
  ADD ATTRIBUTE country TEXT,
  ADD ATTRIBUTE line1 TEXT,
  ADD ATTRIBUTE line2 TEXT,
  ADD ATTRIBUTE postal_code TEXT,
  ADD ATTRIBUTE "state" TEXT,
  ADD ATTRIBUTE town TEXT;

CREATE OR REPLACE FUNCTION stripe_account.make_legal_entity_japan_address(
  city TEXT DEFAULT NULL,
  country TEXT DEFAULT NULL,
  line1 TEXT DEFAULT NULL,
  line2 TEXT DEFAULT NULL,
  postal_code TEXT DEFAULT NULL,
  "state" TEXT DEFAULT NULL,
  town TEXT DEFAULT NULL
)
RETURNS stripe_account.legal_entity_japan_address
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    city, country, line1, line2, postal_code, "state", town
  )::stripe_account.legal_entity_japan_address;
$$;

CREATE OR REPLACE FUNCTION stripe_account._retrieve(expand TEXT[] DEFAULT NULL)
RETURNS JSONB
LANGUAGE plpython3u
STABLE
AS $$
  from stripe_minimal._types import not_given

  response = GD["__stripe_context__"].client.accounts.with_raw_response.retrieve(
      expand=not_given if expand is None else expand,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_account.retrieve(expand TEXT[] DEFAULT NULL)
RETURNS stripe_account.account
LANGUAGE plpgsql
STABLE
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_account.account, stripe_account._retrieve(expand)
    );
  END;
$$;