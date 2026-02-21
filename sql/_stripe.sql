-- A file that declares all schemas and types upfront so that their definitions don't
-- have to be topologically sorted in other files. It also creates some internal utility functions.

CREATE SCHEMA IF NOT EXISTS stripe_internal;
REVOKE ALL ON SCHEMA stripe_internal FROM PUBLIC;

CREATE OR REPLACE FUNCTION stripe_internal.ensure_empty_type(
  p_schema TEXT,
  p_type TEXT
)
RETURNS void
LANGUAGE plpgsql
AS $$
  DECLARE
    attr RECORD;
  BEGIN
    -- Create an empty type if it doesn't exist from a previous extension version.
    IF NOT EXISTS (
      SELECT 1
      FROM pg_type t
      JOIN pg_namespace n ON n.oid = t.typnamespace
      WHERE t.typname = p_type
        AND n.nspname = p_schema
    ) THEN
      EXECUTE format(
        'CREATE TYPE %I.%I AS ();',
        p_schema,
        p_type
      );
      -- Already empty, nothing to drop.
      RETURN;
    END IF;

    -- Drop all existing attributes from the previous extension version so we can readd them.
    FOR attr IN
      SELECT a.attname
      FROM pg_attribute a
      JOIN pg_type t ON t.typrelid = a.attrelid
      JOIN pg_namespace n ON n.oid = t.typnamespace
      WHERE t.typname = p_type
        AND n.nspname = p_schema
        AND a.attnum > 0
        AND NOT a.attisdropped
      ORDER BY a.attnum DESC
    LOOP
      EXECUTE format(
        'ALTER TYPE %I.%I DROP ATTRIBUTE %I;',
        p_schema,
        p_type,
        attr.attname
      );
    END LOOP;
  END;
$$;

CREATE OR REPLACE FUNCTION stripe_internal.ensure_context()
RETURNS void
LANGUAGE plpython3u
AS $$
  from types import SimpleNamespace
  from stainless_commons_stripe import Stripe

  if "__stripe_context__" in GD:
      # The context was already created.
      return

  client_options = {}
  try:
      value = plpy.execute("SELECT current_setting('stripe.base_url') AS value")[0]['value']
      client_options["base_url"] = value
  except Exception:
      # This configuration parameter was not set, but it's optional so ignore the exception.
      pass
  try:
      value = plpy.execute("SELECT current_setting('stripe.secret_key') AS value")[0]['value']
      client_options["api_key"] = value
  except Exception:
      # This configuration parameter was not set, but it's optional so ignore the exception.
      pass

  def strip_none(value):
      if isinstance(value, dict):
          return {
              k: strip_none(v)
              for k, v in value.items()
              if v is not None
          }
      elif isinstance(value, list):
          return [strip_none(v) for v in value]
      else:
          return value

  GD["__stripe_context__"] = SimpleNamespace(
      client=Stripe(**client_options),
      strip_none=strip_none,
  )
$$;

CREATE TYPE stripe_internal.page AS (
  data JSONB,
  next_request_options JSONB
);

CREATE SCHEMA IF NOT EXISTS stripe;

CREATE TYPE stripe.account_requirements_error AS ();
CREATE TYPE stripe.address AS ();
CREATE TYPE stripe.application AS ();
CREATE TYPE stripe.billing_clocks_resource_status_details_advancing_status_details AS ();
CREATE TYPE stripe.billing_clocks_resource_status_details_status_details AS ();
CREATE TYPE stripe.deleted_application AS ();
CREATE TYPE stripe.deleted_customer AS ();
CREATE TYPE stripe.deleted_tax_id AS ();
CREATE TYPE stripe.invoice_setting_custom_field AS ();
CREATE TYPE stripe.payment_flows_payment_intent_presentment_details AS ();
CREATE TYPE stripe.pyment_flows_private_payment_methods_card_present_common_wallet AS ();
CREATE TYPE stripe.payment_method_details_card_installments_plan AS ();
CREATE TYPE stripe.payment_method_details_card_present AS ();
CREATE TYPE stripe.payment_method_details_card_present_offline AS ();
CREATE TYPE stripe.payment_method_details_card_present_receipt AS ();
CREATE TYPE stripe.payment_method_details_passthrough_card AS ();
CREATE TYPE stripe.shipping AS ();
CREATE TYPE stripe.source AS ();
CREATE TYPE stripe.source_code_verification_flow AS ();
CREATE TYPE stripe.source_order AS ();
CREATE TYPE stripe.source_order_item AS ();
CREATE TYPE stripe.source_owner AS ();
CREATE TYPE stripe.source_receiver_flow AS ();
CREATE TYPE stripe.source_redirect_flow AS ();
CREATE TYPE stripe.source_type_ach_credit_transfer AS ();
CREATE TYPE stripe.source_type_ach_debit AS ();
CREATE TYPE stripe.source_type_acss_debit AS ();
CREATE TYPE stripe.source_type_alipay AS ();
CREATE TYPE stripe.source_type_au_becs_debit AS ();
CREATE TYPE stripe.source_type_bancontact AS ();
CREATE TYPE stripe.source_type_card AS ();
CREATE TYPE stripe.source_type_card_present AS ();
CREATE TYPE stripe.source_type_eps AS ();
CREATE TYPE stripe.source_type_giropay AS ();
CREATE TYPE stripe.source_type_ideal AS ();
CREATE TYPE stripe.source_type_klarna AS ();
CREATE TYPE stripe.source_type_multibanco AS ();
CREATE TYPE stripe.source_type_p24 AS ();
CREATE TYPE stripe.source_type_sepa_debit AS ();
CREATE TYPE stripe.source_type_sofort AS ();
CREATE TYPE stripe.source_type_three_d_secure AS ();
CREATE TYPE stripe.source_type_wechat AS ();
CREATE TYPE stripe.tax_code AS ();
CREATE TYPE stripe.test_helpers_test_clock AS ();

CREATE SCHEMA IF NOT EXISTS stripe_accounts;

CREATE TYPE stripe_accounts.account AS ();
CREATE TYPE stripe_accounts.account_business_profile AS ();
CREATE TYPE stripe_accounts.account_business_profile_annual_revenue AS ();
CREATE TYPE stripe_accounts.account_business_profile_monthly_estimated_revenue AS ();
CREATE TYPE stripe_accounts.account_capability AS ();
CREATE TYPE stripe_accounts.account_company AS ();
CREATE TYPE stripe_accounts.account_company_directorship_declaration AS ();
CREATE TYPE stripe_accounts.account_company_ownership_declaration AS ();
CREATE TYPE stripe_accounts.account_company_registration_date AS ();
CREATE TYPE stripe_accounts.account_company_representative_declaration AS ();
CREATE TYPE stripe_accounts.account_company_verification AS ();
CREATE TYPE stripe_accounts.account_company_verification_document AS ();
CREATE TYPE stripe_accounts.account_controller AS ();
CREATE TYPE stripe_accounts.account_controller_fee AS ();
CREATE TYPE stripe_accounts.account_controller_loss AS ();
CREATE TYPE stripe_accounts.account_controller_stripe_dashboard AS ();
CREATE TYPE stripe_accounts.account_external_account AS ();
CREATE TYPE stripe_accounts.account_future_requirement AS ();
CREATE TYPE stripe_accounts.account_group AS ();
CREATE TYPE stripe_accounts.account_individual AS ();
CREATE TYPE stripe_accounts.account_individual_additional_tos_acceptance AS ();
CREATE TYPE stripe_accounts.account_individual_additional_tos_acceptance_account AS ();
CREATE TYPE stripe_accounts.account_individual_dob AS ();
CREATE TYPE stripe_accounts.account_individual_future_requirement AS ();
CREATE TYPE stripe_accounts.account_individual_relationship AS ();
CREATE TYPE stripe_accounts.account_individual_requirement AS ();
CREATE TYPE stripe_accounts.account_individual_us_cfpb_data AS ();
CREATE TYPE stripe_accounts.account_individual_us_cfpb_data_ethnicity_detail AS ();
CREATE TYPE stripe_accounts.account_individual_us_cfpb_data_race_detail AS ();
CREATE TYPE stripe_accounts.account_individual_verification AS ();
CREATE TYPE stripe_accounts.account_individual_verification_additional_document AS ();
CREATE TYPE stripe_accounts.account_individual_verification_document AS ();
CREATE TYPE stripe_accounts.account_requirement AS ();
CREATE TYPE stripe_accounts.account_tos_acceptance AS ();
CREATE TYPE stripe_accounts.account_invoices_settings AS ();
CREATE TYPE stripe_accounts.account_requirements_alternative AS ();
CREATE TYPE stripe_accounts.account_settings AS ();
CREATE TYPE stripe_accounts.account_settings_branding AS ();
CREATE TYPE stripe_accounts.account_settings_card_payment AS ();
CREATE TYPE stripe_accounts.account_settings_card_payment_decline_on AS ();
CREATE TYPE stripe_accounts.account_settings_dashboard AS ();
CREATE TYPE stripe_accounts.account_settings_payment AS ();
CREATE TYPE stripe_accounts.account_settings_bacs_debit_payment AS ();
CREATE TYPE stripe_accounts.account_settings_card_issuing AS ();
CREATE TYPE stripe_accounts.account_settings_card_issuing_tos_acceptance AS ();
CREATE TYPE stripe_accounts.account_settings_payout AS ();
CREATE TYPE stripe_accounts.account_settings_payout_schedule AS ();
CREATE TYPE stripe_accounts.account_settings_sepa_debit_payment AS ();
CREATE TYPE stripe_accounts.account_settings_treasury AS ();
CREATE TYPE stripe_accounts.account_settings_treasury_tos_acceptance AS ();
CREATE TYPE stripe_accounts.legal_entity_japan_address AS ();

CREATE SCHEMA IF NOT EXISTS stripe_balance;

CREATE TYPE stripe_balance.balance_amount AS ();
CREATE TYPE stripe_balance.balance_amount_by_source_type AS ();
CREATE TYPE stripe_balance.balance_retrieve_response AS ();
CREATE TYPE stripe_balance.balance_retrieve_response_instant_available AS ();
CREATE TYPE stripe_balance.balance_retrieve_response_instant_available_net_available AS ();
CREATE TYPE stripe_balance.balance_retrieve_response_issuing AS ();
CREATE TYPE stripe_balance.balance_retrieve_response_refund_and_dispute_prefunding AS ();

CREATE SCHEMA IF NOT EXISTS stripe_coupons;

CREATE TYPE stripe_coupons.coupon AS ();
CREATE TYPE stripe_coupons.coupon_applies_to AS ();
CREATE TYPE stripe_coupons.applies_to AS ();

CREATE SCHEMA IF NOT EXISTS stripe_customers;

CREATE TYPE stripe_customers.bank_account AS ();
CREATE TYPE stripe_customers.bank_account_future_requirement AS ();
CREATE TYPE stripe_customers.bank_account_requirement AS ();
CREATE TYPE stripe_customers.card AS ();
CREATE TYPE stripe_customers.card_network AS ();
CREATE TYPE stripe_customers.customer AS ();
CREATE TYPE stripe_customers.customer_cash_balance AS ();
CREATE TYPE stripe_customers.customer_cash_balance_setting AS ();
CREATE TYPE stripe_customers.customer_source AS ();
CREATE TYPE stripe_customers.customer_subscription AS ();
CREATE TYPE stripe_customers.customer_tax AS ();
CREATE TYPE stripe_customers.customer_tax_location AS ();
CREATE TYPE stripe_customers.customer_tax_id AS ();
CREATE TYPE stripe_customers.discount AS ();
CREATE TYPE stripe_customers.discount_source AS ();
CREATE TYPE stripe_customers.invoice_setting AS ();
CREATE TYPE stripe_customers.invoice_setting_rendering_option AS ();
CREATE TYPE stripe_customers.promotion_code AS ();
CREATE TYPE stripe_customers.promotion_code_promotion AS ();
CREATE TYPE stripe_customers.promotion_code_restriction AS ();
CREATE TYPE stripe_customers.tax_id AS ();
CREATE TYPE stripe_customers.tax_id_verification AS ();
CREATE TYPE stripe_customers.tax_ids_owner AS ();
CREATE TYPE stripe_customers.cash_balance AS ();
CREATE TYPE stripe_customers.cash_balance_setting AS ();
CREATE TYPE stripe_customers.invoice_setting1 AS ();
CREATE TYPE stripe_customers.tax AS ();
CREATE TYPE stripe_customers.tax_id_data AS ();

CREATE SCHEMA IF NOT EXISTS stripe_disputes;

CREATE TYPE stripe_disputes.application_fee AS ();
CREATE TYPE stripe_disputes.application_fee_refund AS ();
CREATE TYPE stripe_disputes.application_fee_fee_source AS ();
CREATE TYPE stripe_disputes.balance_transaction AS ();
CREATE TYPE stripe_disputes.balance_transaction_fee_detail AS ();
CREATE TYPE stripe_disputes.charge AS ();
CREATE TYPE stripe_disputes.charge_billing_detail AS ();
CREATE TYPE stripe_disputes.charge_fraud_detail AS ();
CREATE TYPE stripe_disputes.charge_outcome AS ();
CREATE TYPE stripe_disputes.charge_radar_option AS ();
CREATE TYPE stripe_disputes.charge_refund AS ();
CREATE TYPE stripe_disputes.charge_transfer_data AS ();
CREATE TYPE stripe_disputes.connect_collection_transfer AS ();
CREATE TYPE stripe_disputes.cstmer_blance_rsource_csh_blance_trnsaction_adjsted_fr_ovrdraft AS ();
CREATE TYPE stripe_disputes.cstomer_blance_rsource_csh_blance_trnsaction_applied_to_payment AS ();
CREATE TYPE stripe_disputes.cstomer_blance_rsource_csh_blance_trnsaction_rfunded_frm_pyment AS ();
CREATE TYPE stripe_disputes.cstmer_blnce_rsource_csh_blance_trnsaction_trnsferred_to_blance AS ();
CREATE TYPE stripe_disputes.cstmer_blance_rsource_csh_blance_trnsaction_unpplied_frm_pyment AS ();
CREATE TYPE stripe_disputes.customer_cash_balance_transaction AS ();
CREATE TYPE stripe_disputes.customer_cash_balance_transaction_funded AS ();
CREATE TYPE stripe_disputes.customer_cash_balance_transaction_funded_bank_transfer AS ();
CREATE TYPE stripe_disputes.cstomer_csh_blance_trnsaction_fnded_bnk_trnsfer_eu_bnk_transfer AS ();
CREATE TYPE stripe_disputes.cstomer_csh_blance_trnsaction_fnded_bnk_trnsfer_gb_bnk_transfer AS ();
CREATE TYPE stripe_disputes.cstomer_csh_blance_trnsaction_fnded_bnk_trnsfer_jp_bnk_transfer AS ();
CREATE TYPE stripe_disputes.cstomer_csh_blance_trnsaction_fnded_bnk_trnsfer_us_bnk_transfer AS ();
CREATE TYPE stripe_disputes.dispute AS ();
CREATE TYPE stripe_disputes.dispute_evidence AS ();
CREATE TYPE stripe_disputes.dispute_evidence_enhanced_evidence AS ();
CREATE TYPE stripe_disputes.dispute_evidence_enhanced_evidence_visa_compelling_evidence_3 AS ();
CREATE TYPE stripe_disputes.d_evdnce_enhncd_evdnce_vsa_cmpllng_evdnce_3_prr_undsptd_trnsctn AS ();
CREATE TYPE stripe_disputes.d_e_e_e_vsa_cmpllng_evdnce_3_prr_undsptd_trnsctn_shppng_addrss AS ();
CREATE TYPE stripe_disputes.dspte_evdnce_enhncd_evdnce_vsa_cmpllng_evdnce_3_dsptd_trnsction AS ();
CREATE TYPE stripe_disputes.d_e_e_evdnce_vsa_cmpllng_evdnce_3_dsptd_trnsctn_shppng_addrss AS ();
CREATE TYPE stripe_disputes.dispute_evidence_enhanced_evidence_visa_compliance AS ();
CREATE TYPE stripe_disputes.dispute_evidence_detail AS ();
CREATE TYPE stripe_disputes.dispute_evidence_detail_enhanced_eligibility AS ();
CREATE TYPE stripe_disputes.dspute_evdence_dtail_enhnced_elgibility_vsa_cmpelling_evdence_3 AS ();
CREATE TYPE stripe_disputes.dispute_evidence_detail_enhanced_eligibility_visa_compliance AS ();
CREATE TYPE stripe_disputes.dispute_payment_method_detail AS ();
CREATE TYPE stripe_disputes.dispute_payment_method_detail_amazon_pay AS ();
CREATE TYPE stripe_disputes.dispute_payment_method_detail_card AS ();
CREATE TYPE stripe_disputes.dispute_payment_method_detail_klarna AS ();
CREATE TYPE stripe_disputes.dispute_payment_method_detail_paypal AS ();
CREATE TYPE stripe_disputes.fee_refund AS ();
CREATE TYPE stripe_disputes.file AS ();
CREATE TYPE stripe_disputes.file_link AS ();
CREATE TYPE stripe_disputes.file_link1 AS ();
CREATE TYPE stripe_disputes.issuing_authorization AS ();
CREATE TYPE stripe_disputes.issuing_authorization_merchant_data AS ();
CREATE TYPE stripe_disputes.issuing_authorization_request_history AS ();
CREATE TYPE stripe_disputes.issuing_authorization_verification_data AS ();
CREATE TYPE stripe_disputes.issing_authorization_verification_data_authentication_exemption AS ();
CREATE TYPE stripe_disputes.issuing_authorization_verification_data_three_d_secure AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fleet AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fleet_cardholder_prompt_data AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown_fuel AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown_non_fuel AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fleet_reported_breakdown_tax AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fraud_challenge AS ();
CREATE TYPE stripe_disputes.issuing_authorization_fuel AS ();
CREATE TYPE stripe_disputes.issuing_authorization_network_data AS ();
CREATE TYPE stripe_disputes.issuing_authorization_pending_request AS ();
CREATE TYPE stripe_disputes.issuing_authorization_treasury AS ();
CREATE TYPE stripe_disputes.issuing_authorization_amount_details AS ();
CREATE TYPE stripe_disputes.issuing_card AS ();
CREATE TYPE stripe_disputes.issuing_card_spending_control AS ();
CREATE TYPE stripe_disputes.issuing_card_spending_control_spending_limit AS ();
CREATE TYPE stripe_disputes.issuing_card_latest_fraud_warning AS ();
CREATE TYPE stripe_disputes.issuing_card_shipping AS ();
CREATE TYPE stripe_disputes.issuing_card_shipping_address_validation AS ();
CREATE TYPE stripe_disputes.issuing_card_shipping_custom AS ();
CREATE TYPE stripe_disputes.issuing_card_wallet AS ();
CREATE TYPE stripe_disputes.issuing_card_wallet_apple_pay AS ();
CREATE TYPE stripe_disputes.issuing_card_wallet_google_pay AS ();
CREATE TYPE stripe_disputes.issuing_cardholder AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_address AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_authorization_controls AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_card_issuing AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_company AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_id_document AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_individual AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_individual_dob AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_requirements AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_spending_limit AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_user_terms_acceptance AS ();
CREATE TYPE stripe_disputes.issuing_cardholder_verification AS ();
CREATE TYPE stripe_disputes.issuing_dispute AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_canceled AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_duplicate AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_fraudulent AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_merchandise_not_as_described AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_no_valid_authorization AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_not_received AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_other AS ();
CREATE TYPE stripe_disputes.issuing_dispute_evidence_service_not_as_described AS ();
CREATE TYPE stripe_disputes.issuing_dispute_treasury AS ();
CREATE TYPE stripe_disputes.issuing_transaction AS ();
CREATE TYPE stripe_disputes.issuing_transaction_merchant_data AS ();
CREATE TYPE stripe_disputes.issuing_transaction_amount_detail AS ();
CREATE TYPE stripe_disputes.issuing_transaction_network_data AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail_fleet AS ();
CREATE TYPE stripe_disputes.issing_transaction_purchase_detail_fleet_cardholder_prompt_data AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail_fleet_reported_breakdown AS ();
CREATE TYPE stripe_disputes.issing_trnsaction_purchase_detail_fleet_reported_breakdown_fuel AS ();
CREATE TYPE stripe_disputes.issing_trnsaction_prchase_dtail_flet_rported_breakdown_non_fuel AS ();
CREATE TYPE stripe_disputes.issing_transaction_purchase_detail_fleet_reported_breakdown_tax AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail_flight AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail_flight_segment AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail_fuel AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail_lodging AS ();
CREATE TYPE stripe_disputes.issuing_transaction_purchase_detail_receipt AS ();
CREATE TYPE stripe_disputes.issuing_transaction_treasury AS ();
CREATE TYPE stripe_disputes.payment_method_details AS ();
CREATE TYPE stripe_disputes.payment_method_details_ach_credit_transfer AS ();
CREATE TYPE stripe_disputes.payment_method_details_ach_debit AS ();
CREATE TYPE stripe_disputes.payment_method_details_acss_debit AS ();
CREATE TYPE stripe_disputes.payment_method_details_affirm AS ();
CREATE TYPE stripe_disputes.payment_method_details_afterpay_clearpay AS ();
CREATE TYPE stripe_disputes.payment_method_details_alipay AS ();
CREATE TYPE stripe_disputes.payment_method_details_alma AS ();
CREATE TYPE stripe_disputes.payment_method_details_alma_installment AS ();
CREATE TYPE stripe_disputes.payment_method_details_amazon_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_amazon_pay_funding AS ();
CREATE TYPE stripe_disputes.payment_method_details_au_becs_debit AS ();
CREATE TYPE stripe_disputes.payment_method_details_bacs_debit AS ();
CREATE TYPE stripe_disputes.payment_method_details_billie AS ();
CREATE TYPE stripe_disputes.payment_method_details_blik AS ();
CREATE TYPE stripe_disputes.payment_method_details_boleto AS ();
CREATE TYPE stripe_disputes.payment_method_details_card AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_check AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_extended_authorization AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_incremental_authorization AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_installment AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_multicapture AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_network_token AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_overcapture AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_three_d_secure AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet_amex_express_checkout AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet_apple_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet_google_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet_link AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet_masterpass AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet_samsung_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_card_wallet_visa_checkout AS ();
CREATE TYPE stripe_disputes.payment_method_details_cashapp AS ();
CREATE TYPE stripe_disputes.payment_method_details_crypto AS ();
CREATE TYPE stripe_disputes.payment_method_details_customer_balance AS ();
CREATE TYPE stripe_disputes.payment_method_details_ep AS ();
CREATE TYPE stripe_disputes.payment_method_details_fpx AS ();
CREATE TYPE stripe_disputes.payment_method_details_giropay AS ();
CREATE TYPE stripe_disputes.payment_method_details_grabpay AS ();
CREATE TYPE stripe_disputes.payment_method_details_interac_present AS ();
CREATE TYPE stripe_disputes.payment_method_details_interac_present_receipt AS ();
CREATE TYPE stripe_disputes.payment_method_details_kakao_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_klarna AS ();
CREATE TYPE stripe_disputes.payment_method_details_klarna_payer_detail AS ();
CREATE TYPE stripe_disputes.payment_method_details_klarna_payer_detail_address AS ();
CREATE TYPE stripe_disputes.payment_method_details_konbini AS ();
CREATE TYPE stripe_disputes.payment_method_details_konbini_store AS ();
CREATE TYPE stripe_disputes.payment_method_details_kr_card AS ();
CREATE TYPE stripe_disputes.payment_method_details_link AS ();
CREATE TYPE stripe_disputes.payment_method_details_mb_way AS ();
CREATE TYPE stripe_disputes.payment_method_details_mobilepay AS ();
CREATE TYPE stripe_disputes.payment_method_details_mobilepay_card AS ();
CREATE TYPE stripe_disputes.payment_method_details_multibanco AS ();
CREATE TYPE stripe_disputes.payment_method_details_naver_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_nz_bank_account AS ();
CREATE TYPE stripe_disputes.payment_method_details_oxxo AS ();
CREATE TYPE stripe_disputes.payment_method_details_p24 AS ();
CREATE TYPE stripe_disputes.payment_method_details_pay_by_bank AS ();
CREATE TYPE stripe_disputes.payment_method_details_payco AS ();
CREATE TYPE stripe_disputes.payment_method_details_paynow AS ();
CREATE TYPE stripe_disputes.payment_method_details_paypal AS ();
CREATE TYPE stripe_disputes.payment_method_details_paypal_seller_protection AS ();
CREATE TYPE stripe_disputes.payment_method_details_payto AS ();
CREATE TYPE stripe_disputes.payment_method_details_pix AS ();
CREATE TYPE stripe_disputes.payment_method_details_promptpay AS ();
CREATE TYPE stripe_disputes.payment_method_details_revolut_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_revolut_pay_funding AS ();
CREATE TYPE stripe_disputes.payment_method_details_samsung_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_satispay AS ();
CREATE TYPE stripe_disputes.payment_method_details_sepa_debit AS ();
CREATE TYPE stripe_disputes.payment_method_details_stripe_account AS ();
CREATE TYPE stripe_disputes.payment_method_details_swish AS ();
CREATE TYPE stripe_disputes.payment_method_details_twint AS ();
CREATE TYPE stripe_disputes.payment_method_details_wechat AS ();
CREATE TYPE stripe_disputes.payment_method_details_wechat_pay AS ();
CREATE TYPE stripe_disputes.payment_method_details_zip AS ();
CREATE TYPE stripe_disputes.payment_method_details_bancontact_dispute AS ();
CREATE TYPE stripe_disputes.payment_method_details_ideal_dispute AS ();
CREATE TYPE stripe_disputes.payment_method_details_sofort_dispute AS ();
CREATE TYPE stripe_disputes.payment_method_details_us_bank_account AS ();
CREATE TYPE stripe_disputes.payout AS ();
CREATE TYPE stripe_disputes.payout_trace_id AS ();
CREATE TYPE stripe_disputes.topup AS ();
CREATE TYPE stripe_disputes.transfer AS ();
CREATE TYPE stripe_disputes.transfer_reversal AS ();
CREATE TYPE stripe_disputes.evidence AS ();

CREATE SCHEMA IF NOT EXISTS stripe_invoices;

CREATE TYPE stripe_invoices.api_errors AS ();
CREATE TYPE stripe_invoices.automatic_tax_invoice AS ();
CREATE TYPE stripe_invoices.billing_bill_resource_invoicing_parents_invoice_parent AS ();
CREATE TYPE stripe_invoices.blling_bll_rsource_invicing_parents_invoice_parent_quote_detail AS ();
CREATE TYPE stripe_invoices.blling_bll_rsource_invicing_parents_invoice_subscription_parent AS ();
CREATE TYPE stripe_invoices.billing_credit_balance_transaction AS ();
CREATE TYPE stripe_invoices.billing_credit_grant AS ();
CREATE TYPE stripe_invoices.billing_credit_grant_applicability_config AS ();
CREATE TYPE stripe_invoices.billing_credit_grant_applicability_config_scope AS ();
CREATE TYPE stripe_invoices.billing_credit_grant_applicability_config_scope_price AS ();
CREATE TYPE stripe_invoices.billing_credit_grants_resource_amount AS ();
CREATE TYPE stripe_invoices.billing_credit_grants_resource_balance_credit AS ();
CREATE TYPE stripe_invoices.bllng_crdit_grnts_rsource_blance_crdits_applcation_invice_vided AS ();
CREATE TYPE stripe_invoices.billing_credit_grants_resource_balance_credits_applied AS ();
CREATE TYPE stripe_invoices.billing_credit_grants_resource_balance_debit AS ();
CREATE TYPE stripe_invoices.billing_credit_grants_resource_monetary_amount AS ();
CREATE TYPE stripe_invoices.connect_account_reference AS ();
CREATE TYPE stripe_invoices.deleted_discount AS ();
CREATE TYPE stripe_invoices.deleted_discount_source AS ();
CREATE TYPE stripe_invoices.discounts_resource_discount_amount AS ();
CREATE TYPE stripe_invoices.invoice AS ();
CREATE TYPE stripe_invoices.invoice_line AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_acss_debit AS ();
CREATE TYPE stripe_invoices.invice_pyment_stting_pyment_mthod_opton_acss_dbit_mndate_option AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_bancontact AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_card AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_card_installment AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_customer_balance AS ();
CREATE TYPE stripe_invoices.invce_pymnt_sttng_pyment_mthod_opton_cstomer_blance_bnk_trnsfer AS ();
CREATE TYPE stripe_invoices.i_p_sttng_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_konbini AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_payto AS ();
CREATE TYPE stripe_invoices.invice_pyment_stting_payment_method_option_payto_mandate_option AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_sepa_debit AS ();
CREATE TYPE stripe_invoices.invoice_payment_setting_payment_method_option_us_bank_account AS ();
CREATE TYPE stripe_invoices.invce_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncial_cnnction AS ();
CREATE TYPE stripe_invoices.i_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr AS ();
CREATE TYPE stripe_invoices.invoice_status_transition AS ();
CREATE TYPE stripe_invoices.invoice_confirmation_secret AS ();
CREATE TYPE stripe_invoices.invoice_customer_tax_id AS ();
CREATE TYPE stripe_invoices.invoice_payment AS ();
CREATE TYPE stripe_invoices.invoice_rendering AS ();
CREATE TYPE stripe_invoices.invoice_rendering_pdf AS ();
CREATE TYPE stripe_invoices.invoice_shipping_cost AS ();
CREATE TYPE stripe_invoices.invoice_shipping_cost_tax AS ();
CREATE TYPE stripe_invoices.invoice_threshold_reason AS ();
CREATE TYPE stripe_invoices.invoice_threshold_reason_item_reason AS ();
CREATE TYPE stripe_invoices.invoice_total_tax AS ();
CREATE TYPE stripe_invoices.invoice_total_tax_tax_rate_detail AS ();
CREATE TYPE stripe_invoices.invoice_payment1 AS ();
CREATE TYPE stripe_invoices.invoice_payment_status_transition AS ();
CREATE TYPE stripe_invoices.invoices_payments_invoice_payment_associated_payment AS ();
CREATE TYPE stripe_invoices.invoices_resource_from_invoice AS ();
CREATE TYPE stripe_invoices.invoices_resource_pretax_credit_amount AS ();
CREATE TYPE stripe_invoices.line_item AS ();
CREATE TYPE stripe_invoices.line_item_period AS ();
CREATE TYPE stripe_invoices.line_item_parent AS ();
CREATE TYPE stripe_invoices.line_item_parent_invoice_item_detail AS ();
CREATE TYPE stripe_invoices.line_item_parent_invoice_item_detail_proration_detail AS ();
CREATE TYPE stripe_invoices.lne_itm_prent_invice_item_detail_proration_detail_credited_item AS ();
CREATE TYPE stripe_invoices.line_item_parent_subscription_item_detail AS ();
CREATE TYPE stripe_invoices.line_item_parent_subscription_item_detail_proration_detail AS ();
CREATE TYPE stripe_invoices.lne_itm_prent_sbscription_itm_dtail_prration_dtail_crdited_item AS ();
CREATE TYPE stripe_invoices.line_item_pricing AS ();
CREATE TYPE stripe_invoices.line_item_pricing_price_detail AS ();
CREATE TYPE stripe_invoices.line_item_tax AS ();
CREATE TYPE stripe_invoices.line_item_tax_tax_rate_detail AS ();
CREATE TYPE stripe_invoices.payment_method AS ();
CREATE TYPE stripe_invoices.payment_method_billing_detail AS ();
CREATE TYPE stripe_invoices.payment_method_acss_debit AS ();
CREATE TYPE stripe_invoices.payment_method_affirm AS ();
CREATE TYPE stripe_invoices.payment_method_afterpay_clearpay AS ();
CREATE TYPE stripe_invoices.payment_method_alipay AS ();
CREATE TYPE stripe_invoices.payment_method_alma AS ();
CREATE TYPE stripe_invoices.payment_method_amazon_pay AS ();
CREATE TYPE stripe_invoices.payment_method_au_becs_debit AS ();
CREATE TYPE stripe_invoices.payment_method_bacs_debit AS ();
CREATE TYPE stripe_invoices.payment_method_bancontact AS ();
CREATE TYPE stripe_invoices.payment_method_billie AS ();
CREATE TYPE stripe_invoices.payment_method_blik AS ();
CREATE TYPE stripe_invoices.payment_method_boleto AS ();
CREATE TYPE stripe_invoices.payment_method_card_present AS ();
CREATE TYPE stripe_invoices.payment_method_card_present_network AS ();
CREATE TYPE stripe_invoices.payment_method_cashapp AS ();
CREATE TYPE stripe_invoices.payment_method_crypto AS ();
CREATE TYPE stripe_invoices.payment_method_custom AS ();
CREATE TYPE stripe_invoices.payment_method_custom_logo AS ();
CREATE TYPE stripe_invoices.payment_method_customer_balance AS ();
CREATE TYPE stripe_invoices.payment_method_ep AS ();
CREATE TYPE stripe_invoices.payment_method_fpx AS ();
CREATE TYPE stripe_invoices.payment_method_giropay AS ();
CREATE TYPE stripe_invoices.payment_method_grabpay AS ();
CREATE TYPE stripe_invoices.payment_method_ideal AS ();
CREATE TYPE stripe_invoices.payment_method_interac_present AS ();
CREATE TYPE stripe_invoices.payment_method_interac_present_network AS ();
CREATE TYPE stripe_invoices.payment_method_kakao_pay AS ();
CREATE TYPE stripe_invoices.payment_method_klarna AS ();
CREATE TYPE stripe_invoices.payment_method_klarna_dob AS ();
CREATE TYPE stripe_invoices.payment_method_konbini AS ();
CREATE TYPE stripe_invoices.payment_method_kr_card AS ();
CREATE TYPE stripe_invoices.payment_method_link AS ();
CREATE TYPE stripe_invoices.payment_method_mb_way AS ();
CREATE TYPE stripe_invoices.payment_method_mobilepay AS ();
CREATE TYPE stripe_invoices.payment_method_multibanco AS ();
CREATE TYPE stripe_invoices.payment_method_naver_pay AS ();
CREATE TYPE stripe_invoices.payment_method_nz_bank_account AS ();
CREATE TYPE stripe_invoices.payment_method_oxxo AS ();
CREATE TYPE stripe_invoices.payment_method_p24 AS ();
CREATE TYPE stripe_invoices.payment_method_pay_by_bank AS ();
CREATE TYPE stripe_invoices.payment_method_payco AS ();
CREATE TYPE stripe_invoices.payment_method_paynow AS ();
CREATE TYPE stripe_invoices.payment_method_paypal AS ();
CREATE TYPE stripe_invoices.payment_method_payto AS ();
CREATE TYPE stripe_invoices.payment_method_pix AS ();
CREATE TYPE stripe_invoices.payment_method_promptpay AS ();
CREATE TYPE stripe_invoices.payment_method_radar_option AS ();
CREATE TYPE stripe_invoices.payment_method_revolut_pay AS ();
CREATE TYPE stripe_invoices.payment_method_samsung_pay AS ();
CREATE TYPE stripe_invoices.payment_method_satispay AS ();
CREATE TYPE stripe_invoices.payment_method_sofort AS ();
CREATE TYPE stripe_invoices.payment_method_swish AS ();
CREATE TYPE stripe_invoices.payment_method_twint AS ();
CREATE TYPE stripe_invoices.payment_method_us_bank_account AS ();
CREATE TYPE stripe_invoices.payment_method_us_bank_account_network AS ();
CREATE TYPE stripe_invoices.payment_method_us_bank_account_status_detail AS ();
CREATE TYPE stripe_invoices.payment_method_us_bank_account_status_detail_blocked AS ();
CREATE TYPE stripe_invoices.payment_method_wechat_pay AS ();
CREATE TYPE stripe_invoices.payment_method_zip AS ();
CREATE TYPE stripe_invoices.payment_method_card AS ();
CREATE TYPE stripe_invoices.payment_method_card_check AS ();
CREATE TYPE stripe_invoices.payment_method_card_network AS ();
CREATE TYPE stripe_invoices.payment_method_card_three_d_secure_usage AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet_amex_express_checkout AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet_apple_pay AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet_google_pay AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet_link AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet_masterpass AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet_samsung_pay AS ();
CREATE TYPE stripe_invoices.payment_method_card_wallet_visa_checkout AS ();
CREATE TYPE stripe_invoices.payment_method_card_generated_card AS ();
CREATE TYPE stripe_invoices.payment_method_card_generated_card_payment_method_detail AS ();
CREATE TYPE stripe_invoices.payment_method_details_payment_record_us_bank_account AS ();
CREATE TYPE stripe_invoices.payment_method_sepa_debit AS ();
CREATE TYPE stripe_invoices.payment_record AS ();
CREATE TYPE stripe_invoices.payment_record_processor_detail AS ();
CREATE TYPE stripe_invoices.payment_record_processor_detail_custom AS ();
CREATE TYPE stripe_invoices.payment_record_customer_detail AS ();
CREATE TYPE stripe_invoices.payment_record_shipping_detail AS ();
CREATE TYPE stripe_invoices.payment_record_shipping_detail_address AS ();
CREATE TYPE stripe_invoices.payments_primitives_payment_records_resource_amount AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_resource_payment_method_details AS ();
CREATE TYPE stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_ach_crdt_trnsfr AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_ach_dbit AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_acss_dbit AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_affrm AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_aftrpy_clrpay AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_alpay AS ();
CREATE TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_alma AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_alma_instllmnt AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_amzon_py AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_amzn_py_fndng AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_au_bcs_dbit AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_bcs_dbit AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bllie AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_bllng_dtail AS ();
CREATE TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_bllng_dtl_addrss AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_blk AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_bleto AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_crd AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_crd_chck AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_instllmnt AS ();
CREATE TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_instllmnt_pln AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtils_crd_ntwrk_tkn AS ();
CREATE TYPE stripe_invoices.pymnts_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_thre_d_scre AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_crd_wllet AS ();
CREATE TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_apple_py AS ();
CREATE TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_crd_wllt_ggle_py AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_cshapp AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_crypto AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_cstom AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_cstmer_blnce AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_details_ep AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_fpx AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_gropay AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_grbpay AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_intrc_prsnt AS ();
CREATE TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_intrc_prsnt_rcpt AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_kkao_py AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_klrna AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtil AS ();
CREATE TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_klrna_pyr_dtl_addrss AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_knbini AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_knbini_stre AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcords_rsource_pyment_mthod_dtails_kr_crd AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_lnk AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_mb_wy AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_mbilepay AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_mblepay_crd AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_mltibanco AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_nver_py AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsurce_pymnt_mthd_dtils_nz_bnk_accnt AS ();
CREATE TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_oxxo AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_p24 AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_py_by_bnk AS ();
CREATE TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyco AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pynow AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_pypal AS ();
CREATE TYPE stripe_invoices.p_prmtvs_pymnt_rcrds_rsrce_pymnt_mthd_dtls_pypl_sllr_prtctn AS ();
CREATE TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pyto AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_pix AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_prmptpay AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_rvolut_py AS ();
CREATE TYPE stripe_invoices.pymnts_prmtves_pymnt_rcrds_rsrce_pymnt_mthd_dtls_rvlut_py_fndng AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthod_dtails_smsung_py AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsource_pyment_mthod_dtails_stispay AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_spa_dbit AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pymnt_mthd_dtils_strpe_accnt AS ();
CREATE TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_swsh AS ();
CREATE TYPE stripe_invoices.pymnts_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_twnt AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pyment_rcords_rsource_pyment_mthod_dtails_wchat AS ();
CREATE TYPE stripe_invoices.pymnts_prmtives_pymnt_rcrds_rsurce_pyment_mthod_dtails_wchat_py AS ();
CREATE TYPE stripe_invoices.pyments_prmitives_pyment_rcords_rsource_pyment_mthod_dtails_zip AS ();
CREATE TYPE stripe_invoices.sepa_debit_generated_from AS ();
CREATE TYPE stripe_invoices.shipping_rate_delivery_estimate_bound AS ();
CREATE TYPE stripe_invoices.tax_rate AS ();
CREATE TYPE stripe_invoices.tax_rate_flat_amount AS ();
CREATE TYPE stripe_invoices.automatic_tax AS ();
CREATE TYPE stripe_invoices.automatic_tax_liability AS ();
CREATE TYPE stripe_invoices.from_invoice AS ();
CREATE TYPE stripe_invoices.issuer AS ();
CREATE TYPE stripe_invoices.payment_setting AS ();
CREATE TYPE stripe_invoices.payment_setting_payment_method_option AS ();
CREATE TYPE stripe_invoices.rendering AS ();
CREATE TYPE stripe_invoices.rendering_pdf AS ();
CREATE TYPE stripe_invoices.shipping_cost AS ();
CREATE TYPE stripe_invoices.shipping_cost_shipping_rate_data AS ();
CREATE TYPE stripe_invoices.shipping_cost_shipping_rate_data_delivery_estimate AS ();
CREATE TYPE stripe_invoices.shipping_cost_shipping_rate_data_delivery_estimate_maximum AS ();
CREATE TYPE stripe_invoices.shipping_cost_shipping_rate_data_delivery_estimate_minimum AS ();
CREATE TYPE stripe_invoices.shipping_cost_shipping_rate_data_fixed_amount AS ();
CREATE TYPE stripe_invoices.shipping_detail AS ();
CREATE TYPE stripe_invoices.shipping_detail_address AS ();
CREATE TYPE stripe_invoices.transfer_data AS ();

CREATE SCHEMA IF NOT EXISTS stripe_invoiceitems;

CREATE TYPE stripe_invoiceitems.invoiceitem_create_response AS ();
CREATE TYPE stripe_invoiceitems.invoiceitem_create_response_period AS ();
CREATE TYPE stripe_invoiceitems.invoiceitem_create_response_parent AS ();
CREATE TYPE stripe_invoiceitems.invoiceitem_create_response_parent_subscription_detail AS ();
CREATE TYPE stripe_invoiceitems.invoiceitem_create_response_pricing AS ();
CREATE TYPE stripe_invoiceitems.invoiceitem_create_response_pricing_price_detail AS ();
CREATE TYPE stripe_invoiceitems.invoiceitem_create_response_proration_detail AS ();
CREATE TYPE stripe_invoiceitems.period AS ();
CREATE TYPE stripe_invoiceitems.price_data AS ();
CREATE TYPE stripe_invoiceitems.pricing AS ();

CREATE SCHEMA IF NOT EXISTS stripe_payment_links;

CREATE TYPE stripe_payment_links.custom_text_position AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_after_completion AS ();
CREATE TYPE stripe_payment_links.pyment_lnk_create_response_after_completion_hosted_confirmation AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_after_completion_redirect AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_automatic_tax AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_custom_field AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_custom_field_label AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_custom_field_dropdown AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_custom_field_dropdown_option AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_custom_field_numeric AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_custom_field_text AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_custom_text AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_phone_number_collection AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_shipping_option AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_tax_id_collection AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_consent_collection AS ();
CREATE TYPE stripe_payment_links.pymnt_lnk_crte_rspnse_cnsnt_cllction_pyment_mthod_ruse_agrement AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_invoice_creation AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_invoice_creation_invoice_data AS ();
CREATE TYPE stripe_payment_links.pymnt_lnk_crte_rsponse_invice_cration_invice_dta_rndering_opton AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_line_item AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_line_item_data AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_line_item_data_adjustable_quantity AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_line_item_data_discount AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_line_item_data_tax AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_name_collection AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_name_collection_business AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_name_collection_individual AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_optional_item AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_optional_item_adjustable_quantity AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_payment_intent_data AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_restriction AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_restriction_completed_session AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_shipping_address_collection AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_subscription_data AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_subscription_data_invoice_setting AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_subscription_data_trial_setting AS ();
CREATE TYPE stripe_payment_links.pymnt_lnk_crate_rsponse_sbscription_dta_tral_stting_end_bhavior AS ();
CREATE TYPE stripe_payment_links.payment_link_create_response_transfer_data AS ();
CREATE TYPE stripe_payment_links.line_item AS ();
CREATE TYPE stripe_payment_links.line_item_adjustable_quantity AS ();
CREATE TYPE stripe_payment_links.line_item_price_data AS ();
CREATE TYPE stripe_payment_links.line_item_price_data_product_data AS ();
CREATE TYPE stripe_payment_links.line_item_price_data_recurring AS ();
CREATE TYPE stripe_payment_links.after_completion AS ();
CREATE TYPE stripe_payment_links.after_completion_hosted_confirmation AS ();
CREATE TYPE stripe_payment_links.after_completion_redirect AS ();
CREATE TYPE stripe_payment_links.automatic_tax AS ();
CREATE TYPE stripe_payment_links.automatic_tax_liability AS ();
CREATE TYPE stripe_payment_links.consent_collection AS ();
CREATE TYPE stripe_payment_links.consent_collection_payment_method_reuse_agreement AS ();
CREATE TYPE stripe_payment_links.custom_field AS ();
CREATE TYPE stripe_payment_links.custom_field_label AS ();
CREATE TYPE stripe_payment_links.custom_field_dropdown AS ();
CREATE TYPE stripe_payment_links.custom_field_dropdown_option AS ();
CREATE TYPE stripe_payment_links.custom_field_numeric AS ();
CREATE TYPE stripe_payment_links.custom_field_text AS ();
CREATE TYPE stripe_payment_links.custom_text AS ();
CREATE TYPE stripe_payment_links.invoice_creation AS ();
CREATE TYPE stripe_payment_links.invoice_creation_invoice_data AS ();
CREATE TYPE stripe_payment_links.invoice_creation_invoice_data_issuer AS ();
CREATE TYPE stripe_payment_links.name_collection AS ();
CREATE TYPE stripe_payment_links.name_collection_business AS ();
CREATE TYPE stripe_payment_links.name_collection_individual AS ();
CREATE TYPE stripe_payment_links.optional_item AS ();
CREATE TYPE stripe_payment_links.optional_item_adjustable_quantity AS ();
CREATE TYPE stripe_payment_links.payment_intent_data AS ();
CREATE TYPE stripe_payment_links.phone_number_collection AS ();
CREATE TYPE stripe_payment_links.restriction AS ();
CREATE TYPE stripe_payment_links.restriction_completed_session AS ();
CREATE TYPE stripe_payment_links.shipping_address_collection AS ();
CREATE TYPE stripe_payment_links.shipping_option AS ();
CREATE TYPE stripe_payment_links.subscription_data AS ();
CREATE TYPE stripe_payment_links.subscription_data_invoice_setting AS ();
CREATE TYPE stripe_payment_links.subscription_data_invoice_setting_issuer AS ();
CREATE TYPE stripe_payment_links.subscription_data_trial_setting AS ();
CREATE TYPE stripe_payment_links.subscription_data_trial_setting_end_behavior AS ();
CREATE TYPE stripe_payment_links.tax_id_collection AS ();
CREATE TYPE stripe_payment_links.transfer_data AS ();

CREATE SCHEMA IF NOT EXISTS stripe_payment_intents;

CREATE TYPE stripe_payment_intents.payment_flows_installment_options AS ();
CREATE TYPE stripe_payment_intents.payment_intent AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail_error AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail_line_item AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail_line_item_data AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_amount_detail_line_item_data_payment_method_option AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_amunt_dtail_lne_itm_dta_payment_method_option_card AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_amnt_dtil_lne_itm_dta_pyment_mthod_opton_crd_prsent AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_amunt_dtail_lne_itm_dta_pyment_mthod_option_klarna AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_amunt_dtail_lne_itm_dta_pyment_mthod_option_paypal AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail_line_item_data_tax AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail_shipping AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail_tax AS ();
CREATE TYPE stripe_payment_intents.payment_intent_amount_detail_tip AS ();
CREATE TYPE stripe_payment_intents.payment_intent_automatic_payment_method AS ();
CREATE TYPE stripe_payment_intents.payment_intent_hook AS ();
CREATE TYPE stripe_payment_intents.payment_intent_hook_input AS ();
CREATE TYPE stripe_payment_intents.payment_intent_hook_input_tax AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_alipay_handle_redirect AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_boleto_display_detail AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_card_await_notification AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_nxt_acton_cshapp_hndle_redirect_or_display_qr_code AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_nxt_actn_cshpp_hndle_rdrect_or_dsplay_qr_cde_qr_cde AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_display_bank_transfer_instruction AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_nxt_actn_dsply_bnk_trnsfr_instrcton_fnancial_addrss AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_nxt_actn_dsply_bnk_trnsfr_instrctn_fnncl_addrss_aba AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_nxt_actn_dsply_bnk_trnsfr_instrctn_fnncl_addrss_ibn AS ();
CREATE TYPE stripe_payment_intents.p_intnt_nxt_actn_dsply_bnk_trnsfr_instrctn_fnncl_addrss_srt_cde AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_nxt_actn_dsply_bnk_trnsfr_instrctn_fnncl_addrss_spi AS ();
CREATE TYPE stripe_payment_intents.p_intnt_nxt_actn_dsply_bnk_trnsfr_instrctn_fnncl_addrss_swft AS ();
CREATE TYPE stripe_payment_intents.p_intnt_nxt_actn_dsply_bnk_trnsfr_instrctn_fnncl_addrss_zngn AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_konbini_display_detail AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_nxt_action_konbini_display_detail_store_familymart AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_konbini_display_detail_store_lawson AS ();
CREATE TYPE stripe_payment_intents.pyment_intent_next_action_konbini_display_detail_store_ministop AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_next_action_konbini_display_detail_store_seicomart AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_multibanco_display_detail AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_oxxo_display_detail AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_paynow_display_qr_code AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_pix_display_qr_code AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_promptpay_display_qr_code AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_redirect_to_url AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_nxt_acton_swish_handle_redirect_or_display_qr_code AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_nxt_actn_swsh_hndle_rdirect_or_dsplay_qr_cde_qr_cde AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_verify_with_microdeposit AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_wechat_pay_display_qr_code AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_android_app AS ();
CREATE TYPE stripe_payment_intents.payment_intent_next_action_wechat_pay_redirect_to_ios_app AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_detail AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_configuration_detail AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_acss_debit AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_acss_debit_mandate_option AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_affirm AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_afterpay_clearpay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_alipay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_alma AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_amazon_pay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_au_becs_debit AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_bacs_debit AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_bacs_debit_mandate_option AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_bancontact AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_billie AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_blik AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_boleto AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_card AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_card_installment AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_card_mandate_option AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_card_present AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_cashapp AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_crypto AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_customer_balance AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_pyment_mthod_option_customer_balance_bank_transfer AS ();
CREATE TYPE stripe_payment_intents.p_intnt_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_ep AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_fpx AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_giropay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_grabpay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_ideal AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_interac_present AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_kakao_pay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_klarna AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_konbini AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_kr_card AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_link AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_mb_way AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_mobilepay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_multibanco AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_naver_pay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_nz_bank_account AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_oxxo AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_p24 AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_pay_by_bank AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_payco AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_paynow AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_paypal AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_payto AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_pix AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_promptpay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_revolut_pay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_samsung_pay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_satispay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_sepa_debit AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_sepa_debit_mandate_option AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_sofort AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_swish AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_twint AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_us_bank_account AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_pyment_mthod_opton_us_bnk_accunt_fnancial_cnnection AS ();
CREATE TYPE stripe_payment_intents.pymnt_intnt_pymnt_mthd_optn_us_bnk_accnt_fnncial_cnnction_flter AS ();
CREATE TYPE stripe_payment_intents.pyment_intnt_pyment_mthod_option_us_bank_account_mandate_option AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_wechat_pay AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_option_zip AS ();
CREATE TYPE stripe_payment_intents.payment_intent_processing AS ();
CREATE TYPE stripe_payment_intents.payment_intent_processing_card AS ();
CREATE TYPE stripe_payment_intents.payment_intent_processing_card_customer_notification AS ();
CREATE TYPE stripe_payment_intents.payment_intent_payment_method_options_mandate_options_payto AS ();
CREATE TYPE stripe_payment_intents.payment_intent_type_specific_payment_method_options_client AS ();
CREATE TYPE stripe_payment_intents.payment_method_options_card_present_routing AS ();
CREATE TYPE stripe_payment_intents.payment_transfer_data AS ();
CREATE TYPE stripe_payment_intents.review AS ();
CREATE TYPE stripe_payment_intents.review_ip_address_location AS ();
CREATE TYPE stripe_payment_intents.review_session AS ();

CREATE SCHEMA IF NOT EXISTS stripe_prices;

CREATE TYPE stripe_prices.price AS ();
CREATE TYPE stripe_prices.price_custom_unit_amount AS ();
CREATE TYPE stripe_prices.price_recurring AS ();
CREATE TYPE stripe_prices.price_tier AS ();
CREATE TYPE stripe_prices.price_transform_quantity AS ();
CREATE TYPE stripe_prices.custom_unit_amount AS ();
CREATE TYPE stripe_prices.product_data AS ();
CREATE TYPE stripe_prices.recurring AS ();
CREATE TYPE stripe_prices.tier AS ();
CREATE TYPE stripe_prices.transform_quantity AS ();
CREATE TYPE stripe_prices.recurring1 AS ();

CREATE SCHEMA IF NOT EXISTS stripe_products;

CREATE TYPE stripe_products.product AS ();
CREATE TYPE stripe_products.product_marketing_feature AS ();
CREATE TYPE stripe_products.product_package_dimension AS ();
CREATE TYPE stripe_products.default_price_data AS ();
CREATE TYPE stripe_products.default_price_data_custom_unit_amount AS ();
CREATE TYPE stripe_products.default_price_data_recurring AS ();
CREATE TYPE stripe_products.marketing_feature AS ();
CREATE TYPE stripe_products.package_dimension AS ();

CREATE SCHEMA IF NOT EXISTS stripe_refunds;

CREATE TYPE stripe_refunds.refund AS ();
CREATE TYPE stripe_refunds.refund_destination_detail AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_affirm AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_afterpay_clearpay AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_alipay AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_alma AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_amazon_pay AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_au_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_blik AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_br_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_card AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_cashapp AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_crypto AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_customer_cash_balance AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_ep AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_eu_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_gb_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_giropay AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_grabpay AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_jp_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_klarna AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_mb_way AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_multibanco AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_mx_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_nz_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_p24 AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_paynow AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_paypal AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_pix AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_revolut AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_sofort AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_swish AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_th_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_twint AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_us_bank_transfer AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_wechat_pay AS ();
CREATE TYPE stripe_refunds.refund_destination_detail_zip AS ();
CREATE TYPE stripe_refunds.refund_next_action AS ();
CREATE TYPE stripe_refunds.refund_next_action_display_detail AS ();
CREATE TYPE stripe_refunds.refund_next_action_display_detail_email_sent AS ();
CREATE TYPE stripe_refunds.transfer_reversal AS ();

CREATE SCHEMA IF NOT EXISTS stripe_subscriptions;

CREATE TYPE stripe_subscriptions.automatic_tax_subscription AS ();
CREATE TYPE stripe_subscriptions.default_settings AS ();
CREATE TYPE stripe_subscriptions.default_settings_automatic_tax AS ();
CREATE TYPE stripe_subscriptions.mandate AS ();
CREATE TYPE stripe_subscriptions.mandate_customer_acceptance AS ();
CREATE TYPE stripe_subscriptions.mandate_customer_acceptance_offline AS ();
CREATE TYPE stripe_subscriptions.mandate_customer_acceptance_online AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_acss_debit AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_amazon_pay AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_au_becs_debit AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_bacs_debit AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_card AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_cashapp AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_kakao_pay AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_klarna AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_kr_card AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_link AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_naver_pay AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_nz_bank_account AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_paypal AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_payto AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_revolut_pay AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_sepa_debit AS ();
CREATE TYPE stripe_subscriptions.mandate_payment_method_detail_us_bank_account AS ();
CREATE TYPE stripe_subscriptions.mandate_multi_use AS ();
CREATE TYPE stripe_subscriptions.mandate_single_use AS ();
CREATE TYPE stripe_subscriptions.payment_method_details_bancontact_setup_attempt AS ();
CREATE TYPE stripe_subscriptions.payment_method_details_ideal_setup_attempt AS ();
CREATE TYPE stripe_subscriptions.payment_method_details_sofort_setup_attempt AS ();
CREATE TYPE stripe_subscriptions.pending_update AS ();
CREATE TYPE stripe_subscriptions.phase_automatic_tax AS ();
CREATE TYPE stripe_subscriptions.schedule AS ();
CREATE TYPE stripe_subscriptions.schedule_billing_mode AS ();
CREATE TYPE stripe_subscriptions.schedule_billing_mode_flexible AS ();
CREATE TYPE stripe_subscriptions.schedule_current_phase AS ();
CREATE TYPE stripe_subscriptions.schedule_add_invoice_item AS ();
CREATE TYPE stripe_subscriptions.schedule_add_invoice_item_period AS ();
CREATE TYPE stripe_subscriptions.schedule_add_invoice_item_period_end AS ();
CREATE TYPE stripe_subscriptions.schedule_add_invoice_item_period_start AS ();
CREATE TYPE stripe_subscriptions.schedule_configuration_item AS ();
CREATE TYPE stripe_subscriptions.schedule_configuration_item_billing_threshold AS ();
CREATE TYPE stripe_subscriptions.schedule_phase_configuration AS ();
CREATE TYPE stripe_subscriptions.schedule_phase_setting AS ();
CREATE TYPE stripe_subscriptions.schedule_setting AS ();
CREATE TYPE stripe_subscriptions.setup_attempt AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_acss_debit AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_amazon_pay AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_au_becs_debit AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_bacs_debit AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_boleto AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_card AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_check AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_three_d_secure AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_wallet AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_wallet_apple_pay AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_wallet_google_pay AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_cashapp AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_kakao_pay AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_klarna AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_kr_card AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_link AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_naver_pay AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_nz_bank_account AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_paypal AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_payto AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_revolut_pay AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_sepa_debit AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_us_bank_account AS ();
CREATE TYPE stripe_subscriptions.setup_attempt_payment_method_details_card_present AS ();
CREATE TYPE stripe_subscriptions.setup_intent AS ();
CREATE TYPE stripe_subscriptions.setup_intent_automatic_payment_method AS ();
CREATE TYPE stripe_subscriptions.setup_intent_next_action AS ();
CREATE TYPE stripe_subscriptions.stup_intnt_nxt_acton_cashapp_handle_redirect_or_display_qr_code AS ();
CREATE TYPE stripe_subscriptions.stp_intnt_nxt_actn_cshapp_hndle_rdirect_or_dsplay_qr_cde_qr_cde AS ();
CREATE TYPE stripe_subscriptions.setup_intent_next_action_redirect_to_url AS ();
CREATE TYPE stripe_subscriptions.setup_intent_next_action_verify_with_microdeposit AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_configuration_detail AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_acss_debit AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_acss_debit_mandate_option AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_amazon_pay AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_bacs_debit AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_bacs_debit_mandate_option AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_card AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_card_mandate_option AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_card_present AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_klarna AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_link AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_paypal AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_payto AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_sepa_debit AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_sepa_debit_mandate_option AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_option_us_bank_account AS ();
CREATE TYPE stripe_subscriptions.stup_intnt_pyment_mthod_opton_us_bnk_accunt_fnancial_connection AS ();
CREATE TYPE stripe_subscriptions.stp_intnt_pymnt_mthd_optn_us_bnk_accnt_fnancial_cnnection_flter AS ();
CREATE TYPE stripe_subscriptions.stup_intnt_payment_method_option_us_bank_account_mandate_option AS ();
CREATE TYPE stripe_subscriptions.setup_intent_payment_method_options_mandate_options_payto AS ();
CREATE TYPE stripe_subscriptions.setup_intent_type_specific_payment_method_options_client AS ();
CREATE TYPE stripe_subscriptions.stackable_discount AS ();
CREATE TYPE stripe_subscriptions.subscription AS ();
CREATE TYPE stripe_subscriptions.subscription_billing_mode AS ();
CREATE TYPE stripe_subscriptions.subscription_billing_mode_flexible AS ();
CREATE TYPE stripe_subscriptions.subscription_item AS ();
CREATE TYPE stripe_subscriptions.subscription_billing_cycle_anchor_config AS ();
CREATE TYPE stripe_subscriptions.subscription_cancellation_detail AS ();
CREATE TYPE stripe_subscriptions.subscription_pause_collection AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_acss_debit AS ();
CREATE TYPE stripe_subscriptions.sbscrption_pymnt_sttng_pymnt_mthod_opton_acss_dbit_mndate_opton AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_bancontact AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_card AS ();
CREATE TYPE stripe_subscriptions.sbscription_pyment_stting_pyment_mthod_opton_crd_mandate_option AS ();
CREATE TYPE stripe_subscriptions.sbscription_pyment_stting_pyment_method_option_customer_balance AS ();
CREATE TYPE stripe_subscriptions.sbscrption_pymnt_sttng_pymnt_mthd_optn_cstmer_blnce_bnk_trnsfer AS ();
CREATE TYPE stripe_subscriptions.s_p_sttng_pymnt_mthd_optn_cstmr_blnce_bnk_trnsfr_eu_bnk_trnsfr AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_konbini AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_payto AS ();
CREATE TYPE stripe_subscriptions.sbscription_pyment_stting_pyment_mthod_opton_pyto_mndate_option AS ();
CREATE TYPE stripe_subscriptions.subscription_payment_setting_payment_method_option_sepa_debit AS ();
CREATE TYPE stripe_subscriptions.sbscription_pyment_stting_payment_method_option_us_bank_account AS ();
CREATE TYPE stripe_subscriptions.sbscrptn_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnncton AS ();
CREATE TYPE stripe_subscriptions.s_pymnt_sttng_pymnt_mthd_optn_us_bnk_accnt_fnncl_cnnctn_fltr AS ();
CREATE TYPE stripe_subscriptions.subscription_pending_invoice_item_interval AS ();
CREATE TYPE stripe_subscriptions.subscription_trial_setting AS ();
CREATE TYPE stripe_subscriptions.subscription_trial_setting_end_behavior AS ();
CREATE TYPE stripe_subscriptions.subscription_billing_thresholds AS ();
CREATE TYPE stripe_subscriptions.subscription_invoice_settings AS ();
CREATE TYPE stripe_subscriptions.subscription_item1 AS ();
CREATE TYPE stripe_subscriptions.subscription_item_billing_threshold AS ();
CREATE TYPE stripe_subscriptions.subscription_transfer_data AS ();
CREATE TYPE stripe_subscriptions.add_invoice_item AS ();
CREATE TYPE stripe_subscriptions.add_invoice_item_discount AS ();
CREATE TYPE stripe_subscriptions.add_invoice_item_period AS ();
CREATE TYPE stripe_subscriptions.add_invoice_item_period_end AS ();
CREATE TYPE stripe_subscriptions.add_invoice_item_period_start AS ();
CREATE TYPE stripe_subscriptions.add_invoice_item_price_data AS ();
CREATE TYPE stripe_subscriptions.automatic_tax AS ();
CREATE TYPE stripe_subscriptions.automatic_tax_liability AS ();
CREATE TYPE stripe_subscriptions.cancellation_detail AS ();
CREATE TYPE stripe_subscriptions.invoice_setting AS ();
CREATE TYPE stripe_subscriptions.invoice_setting_issuer AS ();
CREATE TYPE stripe_subscriptions.item AS ();
CREATE TYPE stripe_subscriptions.item_price_data AS ();
CREATE TYPE stripe_subscriptions.item_price_data_recurring AS ();
CREATE TYPE stripe_subscriptions.payment_setting AS ();
CREATE TYPE stripe_subscriptions.payment_setting_payment_method_option AS ();
CREATE TYPE stripe_subscriptions.trial_setting AS ();
CREATE TYPE stripe_subscriptions.trial_setting_end_behavior AS ();
CREATE TYPE stripe_subscriptions.automatic_tax1 AS ();
CREATE TYPE stripe_subscriptions.cancellation_detail1 AS ();