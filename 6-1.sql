CREATE DATABASE qly_san_pham;
USE qly_san_pham;

CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO categories (id, name)
VALUES
(1, 'Laptop'),
(2, 'Dien thoai'),
(3, 'Phu kien');

INSERT INTO products (id, name, price, category_id)
VALUES
(1, 'Laptop Dell', 25000000, 1),
(2, 'Macbook Air', 18000000, 1),
(3, 'iPhone 17', 30000000, 2),
(4, 'iPhone 16', 28000000, 2),
(5, 'Tai nghe', 5000000, 3);

-- Thêm 3 sản phẩm
INSERT INTO products (id, name, price, category_id)
VALUES
(6, 'MacBook Pro', 27000000, 1),
(7, 'iPhone 18', 39000000, 2),
(8, 'Ban phim may tinh', 3000000, 3);

-- Cập nhật giá
UPDATE products
SET price = 20000000
WHERE id = 2;
SELECT * FROM products;

-- Xóa sản phẩm
DELETE FROM products
WHERE id = 8;
SELECT * FROM products;

-- Hiển thị sản phẩm, giảm dần theo giá
SELECT *
FROM products
ORDER BY price DESC;

-- Thống kê số lượng sản phẩm theo danh mục
SELECT c.name AS category_name,
    COUNT(p.id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.id = p.category_id
GROUP BY c.id, c.name;