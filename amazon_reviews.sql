-- Amazon Customer Reviews Database Setup
-- Create tables for storing product and review data

CREATE TABLE Products (
product_id VARCHAR(20) PRIMARY KEY,
  product_name TEXT NOT NULL,
  category TEXT,
  price DECIMAL(10,2)
  );
CREATE TABLE Reviews (
  review_id SERIAL PRIMARY KEY,
  product_id VARCHAR(20) REFERENCES Products(product_id),
  customer_id VARCHAR(20),
  rating INTEGER CHECK (rating >= 1 AND rating >= 5),
  review_text TEXT,
  review_date DATE
);

-- Insert sample data into Products table
INSERT INTO Products (product_id, product_name, category,price) VALUES
('p001', 'Wireless Headphones', 'Electronics', 59.99),
('p002', 'Gaming Mouse', 'Electronics', 129.99),
('p003', 'Yoga Mat', 'Fitness', 19.99),
('p004', 'Amazon Astro', 'Electronics', 1599.99);

-- Insert sample data into the Reviews table
INSERT INTO Reviews (product_id, customer_id, rating, review_text, review_date) VALUES
('p001', 'C1001', 5, 'Great sound quality and battery life!', '2024-01-15'),
('p002', 'C1002', 4, 'Works well, but a little small...', '2024-01-20'),
('p003', 'C1003', 3, 'Good mat, but could be thicker for comfort.', '2024-01-22'),
('p004', 'C1004', 4, '(Paid review): Impressive technology, but very expensive.', '2023-12-26');

-- Query to get the average rating for each product
SELECT p.product_name, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY avg_rating DESC;

-- Query to find the top-rated product(s)
SELECT p.product_name, COUNT(r.review_id) AS review_count, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_name
HAVING COUNT (r.review_id) > 1
ORDER BY avg_rating DESC, review_count DESC;

-- Query to get the most active reviewers
SELECT customer_id, COUNT(review_id) AS review_count
FROM Reviews
Group By customer_id
ORDER BY review_count DESC
Limit 5;

  
