ALTER TYPE stripe_refunds.refund
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE charge JSONB,
  ADD ATTRIBUTE description TEXT,
  ADD ATTRIBUTE destination_details stripe_refunds.refund_destination_detail,
  ADD ATTRIBUTE failure_balance_transaction JSONB,
  ADD ATTRIBUTE failure_reason TEXT,
  ADD ATTRIBUTE instructions_email TEXT,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE next_action stripe_refunds.refund_next_action,
  ADD ATTRIBUTE payment_intent JSONB,
  ADD ATTRIBUTE pending_reason TEXT,
  ADD ATTRIBUTE presentment_details stripe.payment_flows_payment_intent_presentment_details,
  ADD ATTRIBUTE reason TEXT,
  ADD ATTRIBUTE receipt_number TEXT,
  ADD ATTRIBUTE source_transfer_reversal JSONB,
  ADD ATTRIBUTE status TEXT,
  ADD ATTRIBUTE transfer_reversal JSONB;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund(
  "id" TEXT,
  amount BIGINT,
  created BIGINT,
  currency TEXT,
  "object" TEXT,
  balance_transaction JSONB DEFAULT NULL,
  charge JSONB DEFAULT NULL,
  description TEXT DEFAULT NULL,
  destination_details stripe_refunds.refund_destination_detail DEFAULT NULL,
  failure_balance_transaction JSONB DEFAULT NULL,
  failure_reason TEXT DEFAULT NULL,
  instructions_email TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  next_action stripe_refunds.refund_next_action DEFAULT NULL,
  payment_intent JSONB DEFAULT NULL,
  pending_reason TEXT DEFAULT NULL,
  presentment_details stripe.payment_flows_payment_intent_presentment_details DEFAULT NULL,
  reason TEXT DEFAULT NULL,
  receipt_number TEXT DEFAULT NULL,
  source_transfer_reversal JSONB DEFAULT NULL,
  status TEXT DEFAULT NULL,
  transfer_reversal JSONB DEFAULT NULL
)
RETURNS stripe_refunds.refund
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    created,
    currency,
    "object",
    balance_transaction,
    charge,
    description,
    destination_details,
    failure_balance_transaction,
    failure_reason,
    instructions_email,
    metadata,
    next_action,
    payment_intent,
    pending_reason,
    presentment_details,
    reason,
    receipt_number,
    source_transfer_reversal,
    status,
    transfer_reversal
  )::stripe_refunds.refund;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE affirm stripe_refunds.refund_destination_detail_affirm,
  ADD ATTRIBUTE afterpay_clearpay stripe_refunds.refund_destination_detail_afterpay_clearpay,
  ADD ATTRIBUTE alipay stripe_refunds.refund_destination_detail_alipay,
  ADD ATTRIBUTE alma stripe_refunds.refund_destination_detail_alma,
  ADD ATTRIBUTE amazon_pay stripe_refunds.refund_destination_detail_amazon_pay,
  ADD ATTRIBUTE au_bank_transfer stripe_refunds.refund_destination_detail_au_bank_transfer,
  ADD ATTRIBUTE blik stripe_refunds.refund_destination_detail_blik,
  ADD ATTRIBUTE br_bank_transfer stripe_refunds.refund_destination_detail_br_bank_transfer,
  ADD ATTRIBUTE card stripe_refunds.refund_destination_detail_card,
  ADD ATTRIBUTE cashapp stripe_refunds.refund_destination_detail_cashapp,
  ADD ATTRIBUTE crypto stripe_refunds.refund_destination_detail_crypto,
  ADD ATTRIBUTE customer_cash_balance stripe_refunds.refund_destination_detail_customer_cash_balance,
  ADD ATTRIBUTE eps stripe_refunds.refund_destination_detail_ep,
  ADD ATTRIBUTE eu_bank_transfer stripe_refunds.refund_destination_detail_eu_bank_transfer,
  ADD ATTRIBUTE gb_bank_transfer stripe_refunds.refund_destination_detail_gb_bank_transfer,
  ADD ATTRIBUTE giropay stripe_refunds.refund_destination_detail_giropay,
  ADD ATTRIBUTE grabpay stripe_refunds.refund_destination_detail_grabpay,
  ADD ATTRIBUTE jp_bank_transfer stripe_refunds.refund_destination_detail_jp_bank_transfer,
  ADD ATTRIBUTE klarna stripe_refunds.refund_destination_detail_klarna,
  ADD ATTRIBUTE mb_way stripe_refunds.refund_destination_detail_mb_way,
  ADD ATTRIBUTE multibanco stripe_refunds.refund_destination_detail_multibanco,
  ADD ATTRIBUTE mx_bank_transfer stripe_refunds.refund_destination_detail_mx_bank_transfer,
  ADD ATTRIBUTE nz_bank_transfer stripe_refunds.refund_destination_detail_nz_bank_transfer,
  ADD ATTRIBUTE p24 stripe_refunds.refund_destination_detail_p24,
  ADD ATTRIBUTE paynow stripe_refunds.refund_destination_detail_paynow,
  ADD ATTRIBUTE paypal stripe_refunds.refund_destination_detail_paypal,
  ADD ATTRIBUTE pix stripe_refunds.refund_destination_detail_pix,
  ADD ATTRIBUTE revolut stripe_refunds.refund_destination_detail_revolut,
  ADD ATTRIBUTE sofort stripe_refunds.refund_destination_detail_sofort,
  ADD ATTRIBUTE swish stripe_refunds.refund_destination_detail_swish,
  ADD ATTRIBUTE th_bank_transfer stripe_refunds.refund_destination_detail_th_bank_transfer,
  ADD ATTRIBUTE twint stripe_refunds.refund_destination_detail_twint,
  ADD ATTRIBUTE us_bank_transfer stripe_refunds.refund_destination_detail_us_bank_transfer,
  ADD ATTRIBUTE wechat_pay stripe_refunds.refund_destination_detail_wechat_pay,
  ADD ATTRIBUTE zip stripe_refunds.refund_destination_detail_zip;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail(
  "type" TEXT,
  affirm stripe_refunds.refund_destination_detail_affirm DEFAULT NULL,
  afterpay_clearpay stripe_refunds.refund_destination_detail_afterpay_clearpay DEFAULT NULL,
  alipay stripe_refunds.refund_destination_detail_alipay DEFAULT NULL,
  alma stripe_refunds.refund_destination_detail_alma DEFAULT NULL,
  amazon_pay stripe_refunds.refund_destination_detail_amazon_pay DEFAULT NULL,
  au_bank_transfer stripe_refunds.refund_destination_detail_au_bank_transfer DEFAULT NULL,
  blik stripe_refunds.refund_destination_detail_blik DEFAULT NULL,
  br_bank_transfer stripe_refunds.refund_destination_detail_br_bank_transfer DEFAULT NULL,
  card stripe_refunds.refund_destination_detail_card DEFAULT NULL,
  cashapp stripe_refunds.refund_destination_detail_cashapp DEFAULT NULL,
  crypto stripe_refunds.refund_destination_detail_crypto DEFAULT NULL,
  customer_cash_balance stripe_refunds.refund_destination_detail_customer_cash_balance DEFAULT NULL,
  eps stripe_refunds.refund_destination_detail_ep DEFAULT NULL,
  eu_bank_transfer stripe_refunds.refund_destination_detail_eu_bank_transfer DEFAULT NULL,
  gb_bank_transfer stripe_refunds.refund_destination_detail_gb_bank_transfer DEFAULT NULL,
  giropay stripe_refunds.refund_destination_detail_giropay DEFAULT NULL,
  grabpay stripe_refunds.refund_destination_detail_grabpay DEFAULT NULL,
  jp_bank_transfer stripe_refunds.refund_destination_detail_jp_bank_transfer DEFAULT NULL,
  klarna stripe_refunds.refund_destination_detail_klarna DEFAULT NULL,
  mb_way stripe_refunds.refund_destination_detail_mb_way DEFAULT NULL,
  multibanco stripe_refunds.refund_destination_detail_multibanco DEFAULT NULL,
  mx_bank_transfer stripe_refunds.refund_destination_detail_mx_bank_transfer DEFAULT NULL,
  nz_bank_transfer stripe_refunds.refund_destination_detail_nz_bank_transfer DEFAULT NULL,
  p24 stripe_refunds.refund_destination_detail_p24 DEFAULT NULL,
  paynow stripe_refunds.refund_destination_detail_paynow DEFAULT NULL,
  paypal stripe_refunds.refund_destination_detail_paypal DEFAULT NULL,
  pix stripe_refunds.refund_destination_detail_pix DEFAULT NULL,
  revolut stripe_refunds.refund_destination_detail_revolut DEFAULT NULL,
  sofort stripe_refunds.refund_destination_detail_sofort DEFAULT NULL,
  swish stripe_refunds.refund_destination_detail_swish DEFAULT NULL,
  th_bank_transfer stripe_refunds.refund_destination_detail_th_bank_transfer DEFAULT NULL,
  twint stripe_refunds.refund_destination_detail_twint DEFAULT NULL,
  us_bank_transfer stripe_refunds.refund_destination_detail_us_bank_transfer DEFAULT NULL,
  wechat_pay stripe_refunds.refund_destination_detail_wechat_pay DEFAULT NULL,
  zip stripe_refunds.refund_destination_detail_zip DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type",
    affirm,
    afterpay_clearpay,
    alipay,
    alma,
    amazon_pay,
    au_bank_transfer,
    blik,
    br_bank_transfer,
    card,
    cashapp,
    crypto,
    customer_cash_balance,
    eps,
    eu_bank_transfer,
    gb_bank_transfer,
    giropay,
    grabpay,
    jp_bank_transfer,
    klarna,
    mb_way,
    multibanco,
    mx_bank_transfer,
    nz_bank_transfer,
    p24,
    paynow,
    paypal,
    pix,
    revolut,
    sofort,
    swish,
    th_bank_transfer,
    twint,
    us_bank_transfer,
    wechat_pay,
    zip
  )::stripe_refunds.refund_destination_detail;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_blik
  ADD ATTRIBUTE network_decline_code TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_blik(
  network_decline_code TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_blik
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    network_decline_code, reference, reference_status
  )::stripe_refunds.refund_destination_detail_blik;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_br_bank_transfer
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_br_bank_transfer(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_br_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_br_bank_transfer;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_card
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE reference_status TEXT,
  ADD ATTRIBUTE reference_type TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_card(
  "type" TEXT,
  reference TEXT DEFAULT NULL,
  reference_status TEXT DEFAULT NULL,
  reference_type TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_card
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "type", reference, reference_status, reference_type
  )::stripe_refunds.refund_destination_detail_card;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_crypto
  ADD ATTRIBUTE reference TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_crypto(
  reference TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_crypto
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(reference)::stripe_refunds.refund_destination_detail_crypto;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_eu_bank_transfer
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_eu_bank_transfer(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_eu_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_eu_bank_transfer;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_gb_bank_transfer
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_gb_bank_transfer(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_gb_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_gb_bank_transfer;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_jp_bank_transfer
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_jp_bank_transfer(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_jp_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_jp_bank_transfer;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_mb_way
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_mb_way(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_mb_way
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_mb_way;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_multibanco
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_multibanco(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_multibanco
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_multibanco;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_mx_bank_transfer
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_mx_bank_transfer(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_mx_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_mx_bank_transfer;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_p24
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_p24(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_p24
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_p24;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_paypal
  ADD ATTRIBUTE network_decline_code TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_paypal(
  network_decline_code TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_paypal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    network_decline_code
  )::stripe_refunds.refund_destination_detail_paypal;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_swish
  ADD ATTRIBUTE network_decline_code TEXT,
  ADD ATTRIBUTE reference TEXT,
  ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_swish(
  network_decline_code TEXT DEFAULT NULL,
  reference TEXT DEFAULT NULL,
  reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_swish
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    network_decline_code, reference, reference_status
  )::stripe_refunds.refund_destination_detail_swish;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_th_bank_transfer
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_th_bank_transfer(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_th_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_th_bank_transfer;
$$;

ALTER TYPE stripe_refunds.refund_destination_detail_us_bank_transfer
  ADD ATTRIBUTE reference TEXT, ADD ATTRIBUTE reference_status TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_destination_detail_us_bank_transfer(
  reference TEXT DEFAULT NULL, reference_status TEXT DEFAULT NULL
)
RETURNS stripe_refunds.refund_destination_detail_us_bank_transfer
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    reference, reference_status
  )::stripe_refunds.refund_destination_detail_us_bank_transfer;
$$;

ALTER TYPE stripe_refunds.refund_next_action
  ADD ATTRIBUTE "type" TEXT,
  ADD ATTRIBUTE display_details stripe_refunds.refund_next_action_display_detail;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_next_action(
  "type" TEXT,
  display_details stripe_refunds.refund_next_action_display_detail DEFAULT NULL
)
RETURNS stripe_refunds.refund_next_action
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW("type", display_details)::stripe_refunds.refund_next_action;
$$;

ALTER TYPE stripe_refunds.refund_next_action_display_detail
  ADD ATTRIBUTE email_sent stripe_refunds.refund_next_action_display_detail_email_sent,
  ADD ATTRIBUTE expires_at BIGINT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_next_action_display_detail(
  email_sent stripe_refunds.refund_next_action_display_detail_email_sent,
  expires_at BIGINT
)
RETURNS stripe_refunds.refund_next_action_display_detail
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    email_sent, expires_at
  )::stripe_refunds.refund_next_action_display_detail;
$$;

ALTER TYPE stripe_refunds.refund_next_action_display_detail_email_sent
  ADD ATTRIBUTE email_sent_at BIGINT, ADD ATTRIBUTE email_sent_to TEXT;

CREATE OR REPLACE FUNCTION stripe_refunds.make_refund_next_action_display_detail_email_sent(
  email_sent_at BIGINT, email_sent_to TEXT
)
RETURNS stripe_refunds.refund_next_action_display_detail_email_sent
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    email_sent_at, email_sent_to
  )::stripe_refunds.refund_next_action_display_detail_email_sent;
$$;

ALTER TYPE stripe_refunds.transfer_reversal
  ADD ATTRIBUTE "id" TEXT,
  ADD ATTRIBUTE amount BIGINT,
  ADD ATTRIBUTE created BIGINT,
  ADD ATTRIBUTE currency TEXT,
  ADD ATTRIBUTE "object" TEXT,
  ADD ATTRIBUTE transfer JSONB,
  ADD ATTRIBUTE balance_transaction JSONB,
  ADD ATTRIBUTE destination_payment_refund JSONB,
  ADD ATTRIBUTE metadata JSONB,
  ADD ATTRIBUTE source_refund JSONB;

CREATE OR REPLACE FUNCTION stripe_refunds.make_transfer_reversal(
  "id" TEXT,
  amount BIGINT,
  created BIGINT,
  currency TEXT,
  "object" TEXT,
  transfer JSONB,
  balance_transaction JSONB DEFAULT NULL,
  destination_payment_refund JSONB DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  source_refund JSONB DEFAULT NULL
)
RETURNS stripe_refunds.transfer_reversal
LANGUAGE SQL
IMMUTABLE
AS $$
  SELECT ROW(
    "id",
    amount,
    created,
    currency,
    "object",
    transfer,
    balance_transaction,
    destination_payment_refund,
    metadata,
    source_refund
  )::stripe_refunds.transfer_reversal;
$$;

CREATE OR REPLACE FUNCTION stripe_refunds._create(
  amount BIGINT DEFAULT NULL,
  charge TEXT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  instructions_email TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  origin TEXT DEFAULT NULL,
  payment_intent TEXT DEFAULT NULL,
  reason TEXT DEFAULT NULL,
  refund_application_fee BOOLEAN DEFAULT NULL,
  reverse_transfer BOOLEAN DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpython3u
AS $$
  import json
  from stripe_minimal._types import not_given

  response = GD["__stripe_context__"].client.refunds.with_raw_response.create(
      amount=not_given if amount is None else amount,
      charge=not_given if charge is None else charge,
      currency=not_given if currency is None else currency,
      customer=not_given if customer is None else customer,
      expand=not_given if expand is None else expand,
      instructions_email=not_given if instructions_email is None else instructions_email,
      metadata=not_given if metadata is None else json.loads(metadata),
      origin=not_given if origin is None else origin,
      payment_intent=not_given if payment_intent is None else payment_intent,
      reason=not_given if reason is None else reason,
      refund_application_fee=not_given if refund_application_fee is None else refund_application_fee,
      reverse_transfer=not_given if reverse_transfer is None else reverse_transfer,
  )

  # We don't parse the JSON and let PL/Python perform data mapping because PL/Python errors for omitted
  # fields instead of defaulting them to NULL, but we want to be more lenient, which we handle in the
  # caller later.
  return response.text()
$$;

CREATE OR REPLACE FUNCTION stripe_refunds.create(
  amount BIGINT DEFAULT NULL,
  charge TEXT DEFAULT NULL,
  currency TEXT DEFAULT NULL,
  customer TEXT DEFAULT NULL,
  expand TEXT[] DEFAULT NULL,
  instructions_email TEXT DEFAULT NULL,
  metadata JSONB DEFAULT NULL,
  origin TEXT DEFAULT NULL,
  payment_intent TEXT DEFAULT NULL,
  reason TEXT DEFAULT NULL,
  refund_application_fee BOOLEAN DEFAULT NULL,
  reverse_transfer BOOLEAN DEFAULT NULL
)
RETURNS stripe_refunds.refund
LANGUAGE plpgsql
AS $$
  BEGIN
    PERFORM stripe_internal.ensure_context();
    RETURN jsonb_populate_record(
      NULL::stripe_refunds.refund,
      stripe_refunds._create(
        amount,
        charge,
        currency,
        customer,
        expand,
        instructions_email,
        metadata,
        origin,
        payment_intent,
        reason,
        refund_application_fee,
        reverse_transfer
      )
    );
  END;
$$;