USE qly_khach_hang;

-- 1. Thêm đơn hàng mới
INSERT INTO orders (id, customer_id, order_date)
VALUES (104, 3, '2026-09-28');

INSERT INTO order_details (order_id, product_id, quantity, price)
VALUES
(104, 1, 1, 25000000),
(104, 4, 2, 5000000);

-- 2. Tổng doanh thu toàn bộ cửa hàng
SELECT
    SUM(quantity * price) AS total
FROM order_details;


-- 3. Doanh thu trung bình của mỗi đơn hàng
SELECT
    AVG(total_tb) AS average_order
FROM (
    SELECT
        order_id,
        SUM(quantity * price) AS total_tb
    FROM order_details
    GROUP BY order_id
) AS order_totals;


-- 4. Đơn hàng có doanh thu cao nhất
SELECT
    o.id AS order_id,
    o.customer_id,
    o.order_date,
    SUM(od.quantity * od.price) AS total_amount
FROM orders o
JOIN order_details od
    ON o.id = od.order_id
GROUP BY o.id, o.customer_id, o.order_date
ORDER BY total_amount DESC
LIMIT 1;


-- 5. Top 3 sản phẩm bán chạy nhất
SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.id = od.product_id
GROUP BY p.id, p.name
ORDER BY total_quantity_sold DESC
LIMIT 3;