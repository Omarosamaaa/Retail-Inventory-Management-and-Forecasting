import random
from faker import Faker
import pandas as pd
import pyodbc
from datetime import datetime
faker = Faker()

# DataBase Connection
import pyodbc

conn = pyodbc.connect(
    'Driver={ODBC Driver 18 for SQL Server};'
    'Server=tcp:retail-inventory-management.database.windows.net,1433;'
    'Database=Retail_Inventory_DB;'
    'Uid=REFAAT;'
    'Pwd=MrRevo@#1999;'
    'Encrypt=yes;'
    'TrustServerCertificate=no;'
    'Connection Timeout=30;'
)

cursor = conn.cursor()

num_suppliers = 100
num_products = 400
num_customers = 500
num_inventory = 200  
num_orders = 800
num_order_lines_per_order = 5
num_sales = 500

# Generate and populate Suppliers table
def populate_suppliers():
    suppliers_data = []
    for _ in range(num_suppliers):
        suppliers_data.append((  
            faker.company(),
            faker.email(),
            faker.phone_number()[:15], 
            faker.address(),
        
        ))
    
    cursor.executemany("""
        INSERT INTO Suppliers (Supplier_Name, Email, phone_number, Address) 
        VALUES (?, ?, ?, ?)
    """, suppliers_data)
    conn.commit()
    print("Suppliers data inserted successfully.")

# Generate and populate Customers table
def populate_customers():
    customers_data = []
    for _ in range(num_customers):
        name = faker.name()
        email = faker.email()

        phone_number = ''.join(filter(str.isdigit, faker.phone_number()))  
        phone_number = int(phone_number[:15]) if phone_number else None

   
        zipcode = ''.join(filter(str.isdigit, faker.zipcode()))
        zipcode = int(zipcode) if zipcode else None 

        address = faker.address()

        customers_data.append((name, email, zipcode, address, phone_number))

    cursor.executemany("""
        INSERT INTO Customers (Customer_Name, Email, city_zipcode, Address, phone_number) 
        VALUES (?, ?, ?, ?, ?)
    """, customers_data)
    conn.commit()
    print("Customers data inserted successfully.")



# Generate and populate Products table
def populate_products():
    cursor.execute("SELECT Supplier_ID FROM Suppliers")  
    existing_supplier_ids = [row[0] for row in cursor.fetchall()]
    
    products_data = []
    for _ in range(num_products):
        products_data.append((  
            faker.word(),
            random.choice(existing_supplier_ids),  
            faker.sentence(nb_words=6),  
            faker.random.choice(['Electronics', 'Furniture', 'Office Supplies']),  
            round(random.uniform(5, 100), 2)  
        ))
    
    cursor.executemany("""
        INSERT INTO Products (Product_Name, Supplier_ID, Description, Category, Price) 
        VALUES (?, ?, ?, ?, ?)
    """, products_data)
    conn.commit()
    print("Products data inserted successfully.")

# Generate and populate Inventory table

def populate_inventory():
    cursor.execute("SELECT Product_ID FROM Products")  
    existing_product_ids = [row[0] for row in cursor.fetchall()]
    
    inventory_data = []
    for _ in range(num_inventory):
        product_id = random.choice(existing_product_ids)
        stock_quantity = random.randint(1, 100)
        
        last_restocked = faker.date_this_year().strftime('%Y-%m-%d')
        last_checked = faker.date_this_year().strftime('%Y-%m-%d')

        inventory_data.append((product_id, stock_quantity, last_restocked, last_checked))
    
    cursor.executemany("""
        INSERT INTO Inventory (Product_ID, Stock_Quantity, Last_Restocked, Last_Checked) 
        VALUES (?, ?, ?, ?)
    """, inventory_data)
    conn.commit()
    print("Inventory data inserted successfully.")

# Generate and populate Orders table
def populate_orders():
    cursor.execute("SELECT Customer_ID FROM Customers") 
    existing_customer_ids = [row[0] for row in cursor.fetchall()]
    
    orders_data = []
    for _ in range(num_orders):
        orders_data.append((  
            random.choice(existing_customer_ids),  
            faker.date_this_year().strftime('%Y-%m-%d'),  
            round(random.uniform(20, 300), 2),  
            random.choice(['Completed', 'Pending', 'Cancelled'])  
        ))
    
    cursor.executemany("""
        INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Status) 
        VALUES (?, ?, ?, ?)
    """, orders_data)
    conn.commit()
    print("Orders data inserted successfully.")

# Generate and populate Order_Line table
def populate_order_line():
    cursor.execute("SELECT Order_ID FROM Orders")  
    existing_order_ids = [row[0] for row in cursor.fetchall()]
    
    cursor.execute("SELECT Product_ID FROM Products")  
    existing_product_ids = [row[0] for row in cursor.fetchall()]

    order_line_data = []
    used_combinations = set()  

    for order_id in existing_order_ids:
        for _ in range(num_order_lines_per_order):
            while True:
                product_id = random.choice(existing_product_ids)
             
                if (order_id, product_id) not in used_combinations:
                    used_combinations.add((order_id, product_id))
                    break  

            quantity = random.randint(1, 5)  
            total = round(random.uniform(5, 100), 2)  

            order_line_data.append((order_id, product_id, quantity, total))

    cursor.executemany("""
        INSERT INTO Order_Line (Order_ID, Product_ID, Quantity, Total) 
        VALUES (?, ?, ?, ?)
    """, order_line_data)
    conn.commit()
    print("Order Line data inserted successfully.")


# Generate and populate Sales table
def populate_sales():
    cursor.execute("SELECT Customer_ID FROM Customers")  
    existing_customer_ids = [row[0] for row in cursor.fetchall()]
    
    cursor.execute("SELECT Product_ID FROM Products")  
    existing_product_ids = [row[0] for row in cursor.fetchall()]

    sales_data = []
    for _ in range(num_sales):
        sales_data.append((  
            random.choice(existing_customer_ids),  
            random.choice(existing_product_ids),  
            faker.date_this_year().strftime('%Y-%m-%d'),  
            random.randint(1, 3),  
            round(random.uniform(5, 100), 2), 
            random.choice(['Credit Card', 'PayPal', 'Cash'])  
        ))
    
    cursor.executemany("""
        INSERT INTO Sales (Customer_ID, Product_ID, Sale_Date, Quantity_Sold, Sale_Amount, Payment_Method) 
        VALUES (?, ?, ?, ?, ?, ?)
    """, sales_data)
    conn.commit()
    print("Sales data inserted successfully.")

# Function to fetch all data from each table and save to CSV
def fetch_and_save_to_csv():
    tables = ['Suppliers', 'Products', 'Customers', 'Inventory', 'Orders', 'Order_Line', 'Sales']
    for table in tables:
        df = pd.read_sql_query(f"SELECT * FROM {table}", conn)
        df.to_csv(f"{table}.csv", index=False)
        print(f"Data from {table} saved to {table}.csv.")


# populate_suppliers()
# populate_customers()
# populate_products()
# populate_inventory()
# populate_orders()
populate_order_line()
# populate_sales()


#fetch_and_save_to_csv()                 # to save CSV Files


cursor.close()
conn.close()
