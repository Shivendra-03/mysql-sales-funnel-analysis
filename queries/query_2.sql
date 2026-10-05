WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage1_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage5_purchase
    FROM user_events
)
SELECT
    stage1_views,
    stage2_cart,
    stage3_checkout,
    stage4_payment,
    stage5_purchase,
    ROUND(stage2_cart * 100.0 / NULLIF(stage1_views, 0), 2) AS view_to_cart_rate,
    ROUND(stage3_checkout * 100.0 / NULLIF(stage2_cart, 0), 2) AS cart_to_checkout_rate,
    ROUND(stage4_payment * 100.0 / NULLIF(stage3_checkout, 0), 2) AS checkout_to_payment_rate,
    ROUND(stage5_purchase * 100.0 / NULLIF(stage4_payment, 0), 2) AS payment_to_purchase_rate
FROM funnel_stages; 
