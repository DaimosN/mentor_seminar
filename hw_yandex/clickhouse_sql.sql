--Объединение с таблицей товаров (JOIN с order_items)
SELECT 
    o.payment_status,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity) AS total_products,
    SUM(o.total_amount) AS total_order_amount,
    SUM(oi.product_price * oi.quantity) AS total_product_amount,
    ROUND(AVG(oi.product_price), 2) AS avg_product_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.payment_status
ORDER BY total_order_amount DESC;


--Статистика по датам
SELECT 
    toDate(order_date) AS order_day,
    COUNT(*) AS order_count,
    SUM(total_amount) AS daily_total_amount,
    ROUND(AVG(total_amount), 2) AS avg_order_amount
FROM orders
GROUP BY order_day
ORDER BY order_day;


--Самые активные пользователи
SELECT 
    user_id,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_spent,
    ROUND(AVG(total_amount), 2) AS avg_order_amount
FROM orders
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;

--Дополнительный анализ: самые популярные товары
SELECT 
    product_name,
    SUM(quantity) AS total_sold,
    SUM(product_price * quantity) AS total_revenue,
    ROUND(AVG(product_price), 2) AS avg_price
FROM order_items
GROUP BY product_name
ORDER BY total_sold DESC
LIMIT 10;