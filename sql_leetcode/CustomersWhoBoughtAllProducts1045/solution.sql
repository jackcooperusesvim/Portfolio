SELECT 
    c.customer_id
FROM
    Customer c 
    JOIN
        (
            SELECT 
                product_key, 
                COUNT(product_key) OVER() AS product_count 
            FROM Product
        ) p

        ON c.product_key = p.product_key

HAVING COUNT(DISTINCT p.product_key)=MAX(p.product_count)
GROUP BY c.customer_id
