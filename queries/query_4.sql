 WITH user_journey AS (
    SELECT
        user_id,
        MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
        MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
        MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
    FROM user_events
    GROUP BY user_id
    HAVING purchase_time IS NOT NULL 
       AND cart_time IS NOT NULL 
       AND view_time IS NOT NULL
)
SELECT
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, view_time, cart_time)), 2) AS avg_view_to_cart_mins,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, cart_time, purchase_time)), 2) AS avg_cart_to_purchase_mins
FROM user_journey;