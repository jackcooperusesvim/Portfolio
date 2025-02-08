SELECT 
    ROUND(
        SUM(
            CASE WHEN 
                d.customer_pref_delivery_date = d.order_date 
            THEN 1 
            ELSE 0 
            END
        )
        *100
        /COUNT(
            COALESCE(
                d.delivery_id
                ,0
            )
        )
        ,2
    ) AS immediate_percentage

FROM Delivery d
    LEFT JOIN
    (SELECT customer_id, MIN(order_date) AS first_order_date
        FROM Delivery
        GROUP BY customer_id) fod

    ON fod.first_order_date = order_date 
    WHERE d.customer_id = fod.customer_id
