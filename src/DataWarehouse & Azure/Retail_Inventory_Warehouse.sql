use Retail_Inventory_DB;

CREATE TABLE dim_customers (
    customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Email VARCHAR(255),
    city_zipcode VARCHAR(50),
    Address VARCHAR(255),
    phone_number VARCHAR(50)
);

CREATE TABLE dim_products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255),
    Supplier_ID INT,
    Description VARCHAR(255),
    Category VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE dim_suppliers (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(255),
    Email VARCHAR(255),
    phone_number VARCHAR(50),
    Address VARCHAR(255)
);

CREATE TABLE dim_date (
    date DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT
);

CREATE TABLE dim_order_status (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(50)
);

CREATE TABLE fact_sales (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Supplier_ID INT,
    Product_ID INT,
    Sale_Date DATE,
    Quantity_Sold INT,
    Sale_Amount DECIMAL(10, 2),
    Order_ID INT,
    Order_Status_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (Product_ID) REFERENCES dim_products(Product_ID),
    FOREIGN KEY (Sale_Date) REFERENCES dim_date(date),
    FOREIGN KEY (Order_Status_ID) REFERENCES dim_order_status(status_id),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES dim_suppliers(Supplier_ID)
);


-- Populate the Customers Dimension
INSERT INTO dim_customers (customer_id, Customer_Name, Email, city_zipcode, Address, phone_number)
SELECT DISTINCT Customer_ID as id, Customer_Name, Email, city_zipcode, Address, phone_number
FROM Customers;

-- Populate the Products Dimension
INSERT INTO dim_products (Product_ID, Product_Name, Supplier_ID, Description, Category, Price)
SELECT DISTINCT Product_ID, Product_Name, Supplier_ID, Description, Category, Price
FROM Products;

-- Populate the Suppliers Dimension
INSERT INTO dim_suppliers (Supplier_ID, Supplier_Name, Email, phone_number, Address)
SELECT DISTINCT Supplier_ID, Supplier_Name, Email, phone_number, Address
FROM Suppliers;

-- Populate the Date Dimension
INSERT INTO dim_date (date, year, month, day)
SELECT DISTINCT Sale_Date, YEAR (Sale_Date), MONTH (Sale_Date), DAY(Sale_Date)
FROM Sales;

-- Populate the Order Status Dimension
INSERT INTO dim_order_status (status_id, status_name)
VALUES
    (1, 'Pending'),
    (2, 'Canceled'),
    (3, 'Completed');

-- Populate The fact Sales table
INSERT INTO fact_sales (Sale_ID, Customer_ID, Product_ID, Sale_Date, Quantity_Sold, Sale_Amount, Order_ID, Order_Status_ID, Supplier_ID)
SELECT 
    s.Sale_ID,
    s.Customer_ID,
    s.Product_ID,
    s.Sale_Date,
    s.Quantity_Sold,
    s.Sale_Amount,
    o.Order_ID,
    os.status_id,
    p.Supplier_ID
FROM 
    Sales s
JOIN Orders o ON s.Sale_ID = o.Order_ID
JOIN dim_order_status os ON o.status = os.status_name
JOIN dim_products p ON s.Product_ID = p.Product_ID;