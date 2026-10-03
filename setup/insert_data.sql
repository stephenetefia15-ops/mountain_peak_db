INSERT INTO categories (category_id, category_name, department) VALUES
(1, 'Hiking Boots', 'Footwear'),
(2, 'Tents', 'Camping'),
(3, 'Backpacks', 'Gear'),
(4, 'Jackets', 'Clothing'),
(5, 'Sleeping Bags', 'Camping'),
(6, 'Water Bottles', 'Accessories'),
(7, 'Hiking Poles', 'Gear'),
(8, 'Camp Stoves', 'Camping'),
(9, 'GPS Devices', 'Electronics'),
(10, 'Empty Category', 'Test Department'); -- Category with no products (childless parent)

select * from categories;

INSERT INTO suppliers (supplier_id, supplier_name, country, lead_time_days) VALUES
(1, 'OutdoorGear Inc.', 'USA', 5),
(2, 'Summit Supplies', 'Canada', 10),
(3, 'Alpine Equipment', 'Switzerland', 15),
(4, 'Wilderness Outfitters', 'USA', 7),
(5, 'Pacific Adventure Gear', 'Japan', 20),
(6, 'Nordic Outdoors', 'Sweden', 12),
(7, 'Rocky Mountain Supply', 'Canada', 8),
(8, 'Desert Trek Gear', 'Australia', 25),
(9, 'Forest Path Co.', 'USA', 6),
(10, 'Empty Supplier', 'Unknown', 30); -- Supplier with no products (childless parent)

select * from suppliers;

INSERT INTO products (product_id, product_name, category_id, supplier_id, price, cost, stock_quantity) VALUES
(1, 'TrailMaster Hiking Boot', 1, 1, 149.99, 70.00, 45),
(2, 'Expedition 3-Person Tent', 2, 3, 299.99, 150.00, 20),
(3, 'Wilderness 65L Backpack', 3, 2, 189.99, 90.00, 30),
(4, 'Alpine Waterproof Jacket', 4, 5, 199.99, 85.00, 40),
(5, 'Summit Sleeping Bag', 5, 6, 129.99, 60.00, 25),
(6, 'EcoTrek Water Bottle', 6, 9, 24.99, 5.00, 100),
(7, 'TrailSupport Hiking Poles', 7, 7, 79.99, 30.00, 35),
(8, 'Campfire Portable Stove', 8, 4, 149.99, 70.00, 15),
(9, 'NavPro GPS Device', 9, 8, 249.99, 120.00, 10),
(10, 'Trailblazer Hiking Boot', 1, 2, 159.99, 75.00, 0), -- Out of stock product
(11, 'Mountain Explorer Jacket', 4, 3, 229.99, 100.00, 22),
(12, 'Pathfinder 55L Backpack', 3, 1, 169.99, 80.00, 18),
(13, 'Everest Tent 4-Person', 2, 6, 349.99, 180.00, 8),
(14, 'Basecamp Sleeping Bag', 5, 7, 119.99, 55.00, 32),
(15, 'Adventure Water Bottle', 6, 4, 29.99, 6.00, 75),
(16, 'Orphan Product', NULL, NULL, 99.99, 40.00, 5); -- Product with no category and no supplier (orphan)

INSERT INTO stores (store_id, store_name, region, size_sqft, opening_date) VALUES
(1, 'Mountain Peak Denver', 'West', 5000, '2015-03-15'),
(2, 'Mountain Peak Seattle', 'West', 4500, '2016-05-20'),
(3, 'Mountain Peak Boston', 'East', 4800, '2017-07-10'),
(4, 'Mountain Peak Miami', 'South', 4200, '2018-02-25'),
(5, 'Mountain Peak Chicago', 'Midwest', 5500, '2018-09-12'),
(6, 'Mountain Peak Portland', 'West', 4300, '2019-04-05'),
(7, 'Mountain Peak Austin', 'South', 4700, '2020-01-18'),
(8, 'Mountain Peak Nashville', 'South', 4100, '2021-08-30'),
(9, 'Mountain Peak Minneapolis', 'Midwest', 4900, '2022-06-15'),
(10, 'Empty Store', 'North', 3000, '2023-01-01'); -- Store with no employees and no sales (childless parent)

INSERT INTO employees (employee_id, store_id, first_name, last_name, position, hire_date, salary, manager_id) VALUES
(1, 1, 'John', 'Smith', 'Store Manager', '2015-03-15', 75000.00, NULL),
(2, 1, 'Emily', 'Johnson', 'Assistant Manager', '2015-04-20', 55000.00, NULL),
(3, 1, 'Michael', 'Brown', 'Sales Associate', '2015-05-10', 35000.00, NULL),
(4, 1, 'Jessica', 'Davis', 'Sales Associate', '2016-03-05', 35000.00, NULL),
(5, 2, 'David', 'Wilson', 'Store Manager', '2016-05-20', 72000.00, NULL),
(6, 2, 'Sarah', 'Miller', 'Assistant Manager', '2016-06-15', 53000.00, NULL),
(7, 2, 'Robert', 'Taylor', 'Sales Associate', '2016-07-10', 34000.00, NULL),
(8, 3, 'Jennifer', 'Anderson', 'Store Manager', '2017-07-10', 73000.00, NULL),
(9, 3, 'Daniel', 'Thomas', 'Assistant Manager', '2017-08-05', 54000.00, NULL),
(10, 3, 'Laura', 'Jackson', 'Sales Associate', '2017-09-20', 34500.00, NULL),
(11, 4, 'William', 'White', 'Store Manager', '2018-02-25', 71000.00, NULL),
(12, 4, 'Elizabeth', 'Harris', 'Assistant Manager', '2018-03-15', 52000.00, NULL),
(13, 5, 'James', 'Martin', 'Store Manager', '2018-09-12', 74000.00, NULL),
(14, 5, 'Patricia', 'Thompson', 'Assistant Manager', '2018-10-05', 54500.00, NULL),
(15, 5, 'Richard', 'Garcia', 'Sales Associate', '2018-11-15', 35500.00, NULL),
(16, NULL, 'Orphan', 'Employee', 'Unassigned', '2022-12-01', 40000.00, NULL); -- Employee not assigned to any store (orphan)

UPDATE employees SET manager_id = 1 WHERE employee_id IN (2, 3, 4);
UPDATE employees SET manager_id = 5 WHERE employee_id IN (6, 7);
UPDATE employees SET manager_id = 8 WHERE employee_id IN (9, 10);
UPDATE employees SET manager_id = 11 WHERE employee_id = 12;
UPDATE employees SET manager_id = 13 WHERE employee_id IN (14, 15);

INSERT INTO customers (customer_id, first_name, last_name, email, join_date, loyalty_tier) VALUES
(1, 'Alex', 'Roberts', 'alex.roberts@email.com', '2018-04-10', 'Gold'),
(2, 'Olivia', 'Clark', 'olivia.clark@email.com', '2018-07-22', 'Silver'),
(3, 'Benjamin', 'Lewis', 'benjamin.lewis@email.com', '2019-01-15', 'Bronze'),
(4, 'Sophia', 'Walker', 'sophia.walker@email.com', '2019-05-30', 'Gold'),
(5, 'Ethan', 'Hall', 'ethan.hall@email.com', '2020-02-12', 'Silver'),
(6, 'Emma', 'Young', 'emma.young@email.com', '2020-06-25', 'Bronze'),
(7, 'Jacob', 'Allen', 'jacob.allen@email.com', '2020-11-08', 'Gold'),
(8, 'Ava', 'King', 'ava.king@email.com', '2021-03-17', 'Silver'),
(9, 'Matthew', 'Wright', 'matthew.wright@email.com', '2021-09-02', 'Bronze'),
(10, 'Charlotte', 'Scott', 'charlotte.scott@email.com', '2022-01-20', 'None'),
(11, 'Non-purchasing', 'Customer', 'nonpurchasing@email.com', '2023-05-15', 'None'); -- Customer with no purchases (childless parent)

INSERT INTO sales (sale_id, store_id, employee_id, customer_id, sale_date, total_amount) VALUES
(1, 1, 3, 1, '2023-01-05 10:23:45', 479.97),
(2, 1, 4, 2, '2023-01-10 14:30:22', 329.98),
(3, 2, 7, 3, '2023-01-15 11:45:30', 254.98),
(4, 3, 10, 4, '2023-01-20 15:10:55', 549.97),
(5, 4, 12, 5, '2023-02-02 09:20:15', 199.99),
(6, 5, 15, 6, '2023-02-10 13:05:40', 374.98),
(7, 1, 3, 7, '2023-02-15 16:45:10', 174.98),
(8, 2, 7, 8, '2023-02-25 10:30:25', 599.98),
(9, 3, 10, 9, '2023-03-05 12:15:35', 129.99),
(10, 4, 12, 1, '2023-03-15 14:25:50', 229.99),
(11, 5, 14, 2, '2023-03-20 17:40:05', 399.98),
(12, 1, 2, 3, '2023-04-01 09:55:20', 249.99),
(13, 2, 6, 4, '2023-04-10 11:30:45', 349.98),
