SELECT
    COUNT(DISTINCT user_id) AS total_visitors,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_buyers,
    SUM(CASE WHEN event_type = 'purchase' THEN amount ELSE 0 END) AS total_revenue,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN event_id END) AS total_orders,
    ROUND(
        SUM(CASE WHEN event_type = 'purchase' THEN amount ELSE 0 END) / 
        NULLIF(COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN event_id END), 0), 
        2
    ) AS avg_order_value
FROM user_events;