WITH source_funnel AS (
    SELECT
        traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM user_events
    GROUP BY traffic_source
)
SELECT 
    traffic_source,
    views,
    carts,
    purchases,
    ROUND(carts * 100.0 / NULLIF(views, 0), 2) AS cart_conv_rate,
    ROUND(purchases * 100.0 / NULLIF(carts, 0), 2) AS purchase_conv_rate
FROM source_funnel
ORDER BY purchases DESC; 
