# E-commerce-Sales-and-Business-Analytics-using-Power-BI

Files:
1. customers.csv - 100 customers
2. products.csv - 50 products
3. orders.csv - 500 orders
4. order_items.csv - order line items
5. employees.csv - 20 sales employees

Relationships:
customers.customer_id -> orders.customer_id
employees.employee_id -> orders.employee_id
orders.order_id -> order_items.order_id
products.product_id -> order_items.product_id

Project flow:
Excel cleaning -> MySQL SQL analysis -> Power BI dashboard -> business insights
