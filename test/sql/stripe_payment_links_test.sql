SET datestyle = 'ISO';
SET stripe.secret_key = 'My API Key';

SELECT *
FROM stripe_payment_links.create(
  line_items := ARRAY[
    stripe_payment_links.make_line_item(
      quantity := 0,
      adjustable_quantity := stripe_payment_links.make_line_item_adjustable_quantity(
        enabled := TRUE, maximum := 0, minimum := 0
      ),
      price := 'price',
      price_data := stripe_payment_links.make_line_item_price_data(
        currency := 'currency',
        product := 'product',
        product_data := stripe_payment_links.make_line_item_price_data_product_data(
          name := 'name',
          description := 'description',
          images := ARRAY['string'],
          metadata := $$
          {
            "foo": "string"
          }
          $$::JSONB,
          tax_code := 'tax_code',
          unit_label := 'unit_label'
        ),
        recurring := stripe_payment_links.make_line_item_price_data_recurring(
          "interval" := 'day', interval_count := 0
        ),
        tax_behavior := 'exclusive',
        unit_amount := 0,
        unit_amount_decimal := 'unit_amount_decimal'
      )
    )
  ]
);