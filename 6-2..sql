CREATE DATABASE qly_khach_hang;
USE qly_khach_hang;

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
CREATE TABLE categories (
    id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL
    );

CREATE TABLE products (
    id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE order_details (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO categories (id, name)
VALUES
(1, 'Laptop'),
(2, 'Dien thoai'),
(3, 'Phu kien');

INSERT INTO customers
(id, name, email)
VALUES
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com');

INSERT INTO orders
(id, customer_id, order_date )
VALUES
(101, 1, '2026-09-20'), 
(102, 1, '2026-09-21'), 
(103, 2, '2026-09-22');

INSERT INTO products (id, name, price, category_id)
VALUES
(1, 'Laptop Dell', 25000000, 1),
(2, 'Laptop HP', 18000000, 1),
(3, 'MacBook Air', 27000000, 1),
(4, 'iPhone 17', 30000000, 2),
(5, 'Samsung S25', 28000000, 2),
(6, 'Xiaomi 15', 16000000, 2),
(7, 'Tai nghe Sony', 5000000, 3),
(8, 'Ban phim Logitech', 3000000, 3),
(9, 'Chuot Logitech', 2000000, 3);

INSERT INTO order_details
(order_id, product_id, quantity, price)
VALUES
(101, 1, 1, 25000000),
(101, 4, 1, 30000000),
(102, 2, 1, 18000000),
(103, 3, 1, 27000000);

-- 1. Thêm 2 khách hàng
INSERT INTO customers (id, name, email) 
VALUES 
(5, 'Hoang Van E', 'e@gmail.com'), 
(6, 'Vo Thi F', 'f@gmail.com');

SELECT * FROM customers;


-- 2. Khách hàng đã có ít nhất một đơn hàng
SELECT DISTINCT
    c.id,
    c.name,
    c.email
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id;


-- 3. Khách hàng chưa từng đặt đơn hàng
SELECT
    c.id,
    c.name,
    c.email
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
WHERE o.id IS NULL;


-- 4. Tổng doanh thu của mỗi khách hàng
SELECT
    c.id,
    c.name,
    COALESCE(SUM(od.quantity * od.price), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
LEFT JOIN order_details od
    ON o.id = od.order_id
GROUP BY c.id, c.name;


-- 5. Khách hàng đã mua sản phẩm có giá cao nhất
SELECT DISTINCT
    c.id,
    c.name,
    c.email
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id
INNER JOIN order_details od
    ON o.id = od.order_id
WHERE od.price = (
    SELECT MAX(price)
    FROM order_details
);