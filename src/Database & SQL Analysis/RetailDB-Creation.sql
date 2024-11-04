Create database Retail_Inventory_DB;
use Retail_Inventory_DB;

CREATE TABLE "Products"(
    "Product_ID" INT NOT NULL IDENTITY(1,1),
    "Product_Name" NVARCHAR(255) NOT NULL,
    "Supplier_ID" INT NOT NULL,
    "Description" NVARCHAR(1000) NOT NULL,
    "Category" NVARCHAR(255) NOT NULL,
    "Price" DECIMAL(10, 2) NOT NULL
);
ALTER TABLE
    "Products" ADD CONSTRAINT "products_product_id_primary" PRIMARY KEY("Product_ID");
CREATE TABLE "Sales"(
    "Sale_ID" INT NOT NULL IDENTITY(1,1),
    "Customer_ID" INT NOT NULL,
    "Product_ID" INT NOT NULL,
    "Sale_Date" DATETIME NOT NULL,
    "Quantity_Sold" SMALLINT NOT NULL,
    "Sale_Amount" DECIMAL(10, 2) NOT NULL,
    "Payment_Method" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "Sales" ADD CONSTRAINT "sales_sale_id_primary" PRIMARY KEY("Sale_ID");
CREATE TABLE "Customers"(
    "Customer_ID" INT NOT NULL IDENTITY(1,1),
    "Customer_Name" NVARCHAR(255) NOT NULL,
    "Email" NVARCHAR(255) NOT NULL,
    "city_zipcode" BIGINT NOT NULL,
    "Address" NVARCHAR(255) NOT NULL,
    "phone_number" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "Customers" ADD CONSTRAINT "customers_id_primary" PRIMARY KEY("Customer_ID");
CREATE TABLE "Order_Line"(
    "Order_ID" INT NOT NULL  ,
    "Product_ID" INT NOT NULL ,
    "Quantity" INT NOT NULL,
	PRIMARY KEY (Order_ID, Product_ID),
    "Total" DECIMAL(10, 2) NOT NULL
);

CREATE TABLE "Orders"(
    "Order_ID" INT NOT NULL IDENTITY(1,1),
    "Customer_ID" INT NOT NULL,
    "Order_Date" DATETIME NOT NULL,
    "Total_Amount" DECIMAL(10, 2) NOT NULL,
    "Status" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "Orders" ADD CONSTRAINT "orders_order_id_primary" PRIMARY KEY("Order_ID");
CREATE TABLE "Suppliers"(
    "Supplier_ID" INT NOT NULL IDENTITY(1,1),
    "Supplier_Name" NVARCHAR(255) NOT NULL,
    "Email" NVARCHAR(255) NOT NULL,
    "phone_number" NVARCHAR(20) NOT NULL,
    "Address" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "Suppliers" ADD CONSTRAINT "suppliers_supplier_id_primary" PRIMARY KEY("Supplier_ID");
CREATE TABLE "Inventory"(
    "Inventory_ID" INT NOT NULL IDENTITY(1,1),
    "Product_ID" INT NOT NULL,
    "Stock_Quantity" INT NOT NULL,
    "Last_Restocked" DATETIME NOT NULL,
    "Last_Checked" DATETIME NOT NULL
);
ALTER TABLE
    "Inventory" ADD CONSTRAINT "inventory_inventory_id_primary" PRIMARY KEY("Inventory_ID");
ALTER TABLE
    "Products" ADD CONSTRAINT "products_supplier_id_foreign" FOREIGN KEY("Supplier_ID") REFERENCES "Suppliers"("Supplier_ID");
ALTER TABLE
    "Sales" ADD CONSTRAINT "sales_product_id_foreign" FOREIGN KEY("Product_ID") REFERENCES "Products"("Product_ID");
ALTER TABLE
    "Order_Line" ADD CONSTRAINT "order_line_product_id_foreign" FOREIGN KEY("Product_ID") REFERENCES "Products"("Product_ID");
ALTER TABLE
    "Order_Line" ADD CONSTRAINT "order_line_order_id_foreign" FOREIGN KEY("Order_ID") REFERENCES "Orders"("Order_ID");
ALTER TABLE
    "Sales" ADD CONSTRAINT "sales_customer_id_foreign" FOREIGN KEY("Customer_ID") REFERENCES "Customers"("Customer_ID");
ALTER TABLE
    "Orders" ADD CONSTRAINT "orders_customer_id_foreign" FOREIGN KEY("Customer_ID") REFERENCES "Customers"("Customer_ID");
ALTER TABLE
    "Inventory" ADD CONSTRAINT "inventory_product_id_foreign" FOREIGN KEY("Product_ID") REFERENCES "Products"("Product_ID");