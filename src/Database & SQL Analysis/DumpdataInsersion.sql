--- Suppliers 
INSERT INTO Suppliers (Supplier_Name, Email, Phone_Number, Address) VALUES
( 'ABC Suppliers', 'contact@abc.com', '1234567890', '123 Elm Street'),
( 'XYZ Wholesale', 'info@xyz.com', '9876543210', '456 Oak Avenue'),
( 'Global Imports', 'sales@global.com', '5551234567', '789 Maple Lane'),
( 'Home Comforts', 'info@homecomforts.com', '1122334455', '100 Garden Lane'),
( 'Office Pro', 'support@officepro.com', '2233445566', '200 Park Avenue'),
( 'Tech Innovations', 'contact@techinnovations.com', '3344556677', '300 River Road'),
( 'Gadget Central', 'sales@gadgetcentral.com', '4455667788', '400 Ocean Blvd'),
( 'Superior Supplies', 'info@superiorsupplies.com', '5566778899', '500 Hilltop Drive');

--- Products
INSERT INTO Products (Product_Name, Supplier_ID, Description, Category, Price) VALUES
( 'Wireless Mouse', 1, 'Ergonomic wireless mouse with 2.4GHz connection', 'Electronics', 25.99),
( 'Bluetooth Headphones', 1, 'Noise-cancelling over-ear headphones', 'Electronics', 79.99),
( 'Office Chair', 2, 'Adjustable office chair with lumbar support', 'Furniture', 149.99),
( 'Standing Desk', 2, 'Height-adjustable standing desk', 'Furniture', 299.99),
( 'LED Monitor', 3, '24-inch 1080p LED monitor', 'Electronics', 129.99),
( 'Wireless Charger', 4, 'Fast wireless charging pad', 'Electronics', 29.99),
( 'Ergonomic Desk Lamp', 5, 'Adjustable LED desk lamp', 'Furniture', 39.99),
( 'USB Flash Drive', 6, '64GB USB 3.0 flash drive', 'Electronics', 15.99),
( 'Bluetooth Speaker', 7, 'Portable Bluetooth speaker', 'Electronics', 49.99),
( 'Office Storage Cabinet', 8, '4-drawer filing cabinet', 'Furniture', 199.99),
( 'Gaming Keyboard', 1, 'RGB mechanical gaming keyboard', 'Electronics', 79.99),
( 'HDMI Cable', 2, 'High-speed HDMI cable', 'Accessories', 9.99),
( 'Laptop Stand', 3, 'Adjustable laptop stand', 'Accessories', 24.99),
( 'Noise Cancelling Earbuds', 4, 'In-ear wireless earbuds', 'Electronics', 59.99),
( 'Smartwatch', 5, 'Fitness tracking smartwatch', 'Wearables', 199.99);

--- Customers
INSERT INTO Customers (Customer_Name, Email, City_Zipcode, Address, Phone_Number) VALUES
( 'John Doe', 'john.doe@example.com', 12345, '101 Main Street', '1234567890'),
( 'Jane Smith', 'jane.smith@example.com', 67890, '202 South Street', '0987654321'),
( 'Alice Johnson', 'alice.j@example.com', 11223, '303 West Street', '5551234567'),
( 'David Wilson', 'david.wilson@example.com', 54321, '404 Hill Street', '2345678901'),
( 'Emily Davis', 'emily.davis@example.com', 67891, '505 Pine Road', '3456789012'),
( 'Frank Miller', 'frank.miller@example.com', 78912, '606 Oak Avenue', '4567890123'),
( 'Grace Taylor', 'grace.taylor@example.com', 89023, '707 Maple Lane', '5678901234'),
('Hannah Anderson', 'hannah.anderson@example.com', 90134, '808 Elm Street', '6789012345');


--- Inventory 
INSERT INTO Inventory (Product_ID, Stock_Quantity, Last_Restocked, Last_Checked) VALUES
(1, 100, '2024-09-15', '2024-10-10'),
(2, 50, '2024-09-20', '2024-10-12'),
(3, 20, '2024-08-30', '2024-10-05'),
(4, 10, '2024-09-25', '2024-10-10'),
(5, 30, '2024-10-01', '2024-10-15'),
(6, 150, '2024-10-15', '2024-10-20'),
(7, 80, '2024-10-10', '2024-10-18');



--- Orders
INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Status) VALUES
(1, '2024-10-01', 155.97, 'Completed'),
(2, '2024-10-05', 299.99, 'Pending'),
(3, '2024-10-10', 25.99, 'Completed'),
(4, '2024-10-20', 29.99, 'Completed'),
(5, '2024-10-22', 59.99, 'Pending'),
(6, '2024-10-24', 24.99, 'Completed'),
(7, '2024-10-25', 199.99, 'Pending'),
(8, '2024-10-26', 79.99, 'Completed'),
(1, '2024-10-27', 79.99, 'Completed'),
(2, '2024-10-28', 39.99, 'Completed'),
(3, '2024-10-29', 149.99, 'Pending'),
(4, '2024-10-30', 25.99, 'Completed'),
(5, '2024-10-31', 129.99, 'Completed');


--- Order_Line
INSERT INTO Order_Line (Order_ID, Product_ID, Quantity, Total) VALUES
(1, 1, 2, 51.98),
(1, 2, 1, 79.99),
(2, 4, 1, 299.99),
(3, 1, 1, 25.99),
(4, 6, 1, 29.99),
(5, 14, 1, 59.99),
(6, 13, 1, 24.99),
(7, 10, 1, 199.99),
(8, 11, 1, 79.99),
(9, 12, 1, 39.99),
(10, 7, 2, 79.98),
(11, 8, 3, 119.97),
(12, 9, 1, 25.99),
(13, 5, 1, 39.99);



--- Sales
INSERT INTO Sales (Customer_ID, Product_ID, Sale_Date, Quantity_Sold, Sale_Amount, Payment_Method)
VALUES
    (1, 1, '2024-10-01', 2, 50.00, 'Credit Card'),
    (2, 3, '2024-10-02', 1, 149.99, 'PayPal'),
    (3, 5, '2024-10-03', 1, 129.99, 'Cash'),
    (4, 2, '2024-10-04', 3, 240.00, 'Credit Card'),
    (5, 4, '2024-10-05', 1, 299.99, 'PayPal'),
    (6, 1, '2024-10-06', 2, 100.00, 'Cash'),
    (7, 2, '2024-10-07', 1, 79.99, 'Credit Card'),
    (8, 3, '2024-10-08', 2, 299.98, 'Credit Card');


