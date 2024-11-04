import pandas as pd

suppliers_df = pd.read_csv("D:/DEPI/src/data/Suppliers.csv")
customers_df = pd.read_csv("D:/DEPI/src/data/Customers.csv")
products_df = pd.read_csv("D:/DEPI/src/data/Products.csv")
inventory_df = pd.read_csv("D:/DEPI/src/data/Inventory.csv")
orders_df = pd.read_csv("D:/DEPI/src/data/Orders.csv")
order_line_df = pd.read_csv("D:/DEPI/src/data/Order_Line.csv")
sales_df = pd.read_csv("D:/DEPI/src/data/Sales.csv")

sales_with_details = sales_df.merge(customers_df[['Customer_ID', 'Customer_Name']], on='Customer_ID', how='left') \
                              .merge(products_df[['Product_ID', 'Product_Name', 'Category', 'Price']], on='Product_ID', how='left')


sales_with_details['Sale_Month'] = pd.to_datetime(sales_with_details['Sale_Date']).dt.month
sales_with_details['Sale_Year'] = pd.to_datetime(sales_with_details['Sale_Date']).dt.year


customer_sales = sales_with_details.groupby('Customer_ID')['Sale_Amount'].sum().reset_index()
customer_sales.columns = ['Customer_ID', 'Total_Sales']
sales_with_details = sales_with_details.merge(customer_sales, on='Customer_ID', how='left')


final_features = sales_with_details[['Customer_Name', 'Product_Name', 'Category', 'Price', 
                                      'Sale_Amount', 'Sale_Month', 'Sale_Year', 'Total_Sales']]


final_features.to_csv("ML_Feature_Data.csv", index=False)
print("Feature data saved to 'ML_Feature_Data.csv'.")