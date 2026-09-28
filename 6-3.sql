USE qly_san_pham;

-- 1. Sản phẩm có giá từ 10 triệu đến 25 triệu
SELECT *
FROM products
WHERE price BETWEEN 10000000 AND 25000000;


-- 2. Sản phẩm có tên chứa "Laptop"
SELECT *
FROM products
WHERE name LIKE '%Laptop%';


-- 3. Giá trung bình của sản phẩm theo từng danh mục
SELECT
    category_id,
    AVG(price) AS average_price
FROM products
GROUP BY category_id;


-- 4. Sản phẩm có giá cao hơn giá trung bình của toàn bộ sản phẩm
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);


-- 5. Sản phẩm có giá thấp nhất trong từng danh mục
SELECT *
FROM products p
WHERE price = (
    SELECT MIN(price)
    FROM products
    WHERE category_id = p.category_id
);