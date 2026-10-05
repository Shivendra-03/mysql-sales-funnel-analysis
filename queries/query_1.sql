SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage1_views,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage2_cart,
    COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage3_checkout,
    COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage4_payment,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage5_purchase
FROM user_events
WHERE event_date >= DATE_SUB((SELECT MAX(event_date) FROM user_events), INTERVAL 30 DAY);

