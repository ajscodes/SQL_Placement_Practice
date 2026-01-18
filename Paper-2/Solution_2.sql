-- Create color Table
CREATE TABLE color (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    extra_fee DECIMAL(5,2) DEFAULT 0
);

-- Create customer Table
CREATE TABLE customer (
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    favorite_color_id INT FOREIGN KEY REFERENCES color(id)
);

-- Create category Table
CREATE TABLE category (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    parent_id INT FOREIGN KEY REFERENCES category(id) NULL
);

-- Create clothing Table
CREATE TABLE clothing (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    size VARCHAR(5) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    color_id INT FOREIGN KEY REFERENCES color(id),
    category_id INT FOREIGN KEY REFERENCES category(id)
);

-- Create clothing_order Table
CREATE TABLE clothing_order (
    id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT FOREIGN KEY REFERENCES customer(id),
    clothing_id INT FOREIGN KEY REFERENCES clothing(id),
    items INT NOT NULL,
    order_date DATE NOT NULL
);

-- Insert Sample Colors
INSERT INTO color (name, extra_fee) VALUES
('Red', 5.00),    -- has extra fee
('Green', 0.00),
('Blue', 0.00),
('Black', 5.00),  -- has extra fee
('White', 0.00);

-- Insert Sample Customers
INSERT INTO customer (first_name, last_name, favorite_color_id) VALUES
('Jay', 'Patel', 1),     -- Favorite is Red
('Dhruv', 'Shah', 2),    -- Favorite is Green
('Amit', 'Verma', 1),    -- Favorite is Red
('Priya', 'Mehta', 3),   -- Favorite is Blue
('Ravi', 'Singh', NULL), -- No favorite color
('Meera', 'Das', 5);     -- Customer with no purchases

-- Insert Sample Categories
INSERT INTO category (name, parent_id) VALUES
('Mens', NULL),          -- Main category
('Womens', NULL),        -- Main category
('T-Shirt', 1),          -- Subcategory of Mens
('Joggers', 1),          -- Subcategory of Mens
('Hoodie', 1),           -- Subcategory of Mens
('T-Shirt', 2),          -- Subcategory of Womens
('Joggers', 2);          -- Subcategory of Womens

-- Insert Sample Clothing
INSERT INTO clothing (name, size, price, color_id, category_id) VALUES
('Basic Tee', 'M', 20.00, 5, 3),        -- White, Mens T-Shirt
('V-Neck Tee', 'L', 25.00, 3, 3),        -- Blue, Mens T-Shirt (for Jay's order)
('Performance Jogger', 'L', 45.00, 4, 4), -- Black, Mens Joggers
('Cuffed Jogger', 'M', 40.00, 2, 4),      -- Green, Mens Joggers
('Graphic Hoodie', 'XL', 60.00, 1, 5),    -- Red, Mens Hoodie
('Womens Basic Tee', 'S', 20.00, 5, 6),   -- White, Womens T-Shirt
('Womens Lounge Jogger', 'M', 50.00, 4, 7); -- Black, Womens Joggers

-- Insert Sample Orders
INSERT INTO clothing_order (customer_id, clothing_id, items, order_date) VALUES
-- Jay's order for T-Shirt after 1st April 2024
(1, 2, 2, '2024-05-15'), -- Jay, V-Neck Tee, Qty 2

-- Order for financial year 2024-25
(2, 4, 1, '2024-06-10'), -- Dhruv, Cuffed Jogger, Qty 1

-- Order of favorite color
(1, 5, 1, '2024-07-01'), -- Jay, Graphic Hoodie (Red), Qty 1. Jay's fav color is Red.

-- Customer who wears XL
(4, 5, 1, '2024-08-01'), -- Priya, Graphic Hoodie (XL), Qty 1

-- Multiple orders for customer totals
(1, 3, 1, '2024-09-05'), -- Jay, Performance Jogger, Qty 1
(2, 7, 1, '2023-11-20'), -- Dhruv, Womens Lounge Jogger, Qty 1
(3, 1, 3, '2024-10-10'); -- Amit, Basic Tee, Qty 3


--1. List the customers whose favorite color is Red or Green and name is Jay or Dhruv 
select first_name, last_name, c.name
from color c join customer cu on c.id = cu.favorite_color_id
where c.name in ('red', 'green') and cu.first_name in ('jay', 'dhruv')


--2. List the different types of Joggers with their sizes.
select cl.name, size
from clothing cl join category ct on cl.category_id = ct.id where ct.name = 'joggers'


--3. List the orders of Jay of T-Shirt after 1st April 2024.  
select co.*
from clothing_order co join customer cu on co.customer_id = cu.id join clothing cl on co.clothing_id = cl.id join category cat on cl.category_id = cat.id
where cu.first_name = 'Jay' and co.order_date > '2024-04-01' and cat.name = 't-shirt'


--**4. List the customer whose favorite color is charged extra. 
select cu.first_name, cu.last_name, c.extra_fee
from color c join customer cu on c.id = cu.favorite_color_id
where c.extra_fee > 0


--**5. List category wise clothing’s maximum price, minimum price, average price and number of clothing items. 
select ct.name, max(cl.price), min(cl.price), avg(cl.price), COUNT(cl.id)
from category ct join clothing cl on ct.id = cl.category_id
group by ct.name

SELECT
    CAT.name AS category_name,
    COUNT(CL.id) AS num_items,
    MAX(CL.price) AS max_price,
    MIN(CL.price) AS min_price,
    CAST(AVG(CL.price) AS DECIMAL(10, 2)) AS avg_price
FROM clothing CL
JOIN category CAT ON CL.category_id = CAT.id
GROUP BY CAT.name;


--**6. List the customers with no purchases at  all. 
select cu.first_name, cu.last_name
from clothing_order co right join customer cu on co.customer_id = cu.id
where co.id is null

SELECT first_name, last_name
FROM customer
WHERE id NOT IN (SELECT DISTINCT customer_id FROM clothing_order);


--**7. List the orders of favorite color with all the details. 
SELECT
    O.id AS order_id,
    C.first_name AS customer_name,
    CL.name AS clothing_name,
    CO.name AS color_name,
    O.items,
    O.order_date
FROM clothing_order O
JOIN customer C ON O.customer_id = C.id
JOIN clothing CL ON O.clothing_id = CL.id
JOIN color CO ON CL.color_id = CO.id
WHERE C.favorite_color_id = CL.color_id;


--**8. List the customers with total purchase value, number of orders and number of items purchased. 
select cu.first_name, cu.last_name, SUM(co.items * cl.price) as total_purchase_value, COUNT(co.id) as 'number of orders', sum(co.items) as 'number of items'
from clothing_order co join clothing cl on co.clothing_id = cl.id join customer cu on cu.id = co.customer_id
group by cu.first_name, cu.last_name


--**9. List the Clothing item, Size, Order Value and Number of items sold during financial year 2024-25  
SELECT
    cl.name,
    cl.size,
    SUM(co.items * cl.price) AS order_value,
    SUM(co.items) AS number_of_items_sold
FROM clothing_order co
JOIN clothing cl
    ON co.clothing_id = cl.id
WHERE co.order_date >= '2024-04-01'
  AND co.order_date <= '2025-03-31'
GROUP BY
    cl.name,
    cl.size;


--**10. List the customers who wears XL size.
select distinct cu.first_name, cu.last_name
from customer cu join clothing_order co on cu.id = co.customer_id join clothing cl on cl.id = co.clothing_id
where cl.size = 'xl'
