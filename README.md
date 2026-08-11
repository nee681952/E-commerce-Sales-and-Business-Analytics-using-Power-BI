# E-commerce-Sales-and-Business-Analytics-using-Power-BI

## 📌 Project Overview

Developed an interactive e-commerce analytics solution using MySQL and Power BI to analyze sales, profitability, customers, products, and operational performance.

## 🎯 Business Problem

The goal of this project is to transform raw e-commerce data into meaningful business insights that help understand:

- Sales and revenue performance
- Profitability
- Customer behavior and retention
- Product performance
- Delivery and operational performance

## 📊 Dataset

The project contains data related to:

- Customers
- Orders
- Order Items
- Products
- Payments
- Employees

The dataset contains approximately **500 orders and 100 customers**.

## 🛠️ Tools & Technologies

- MySQL
- Power BI
- DAX
- SQL
- Data Analysis
- Data Visualization

## 🔎 SQL Analysis

The project includes advanced SQL analysis using:

- Joins
- Aggregations
- GROUP BY and HAVING
- Subqueries
- CTEs
- Window Functions
- CASE statements
- RFM Analysis
- Customer Retention Analysis
- Cohort Analysis

## 📈 Power BI Dashboard

Created a five-page interactive Power BI dashboard:

1. **Executive Overview**
2. **Sales & Profit Analysis**
3. **Customer Insights**
4. **Product Performance**
5. **Operations & Delivery**

Interactive filters include:

- Month
- State
- Product Category

## 📌 Key KPIs

| KPI | Value |
|---|---:|
| Total Sales | 13.04M |
| Total Profit | 3.65M |
| Total Orders | 500 |
| Total Customers | 100 |
| Average Order Value | 26.07K |
| Profit Margin | 27.98% |
| Repeat Customer Rate | 99% |

## 💡 Business Insights

The analysis provides insights into:

- Overall sales and profitability
- Top-performing products and categories
- Customer purchasing behavior
- Repeat customer performance
- State-wise sales and profitability
- Delivery performance
- Cancellation and return trends
- Payment method performance

## 🖼️ Dashboard Screenshots

### Executive Overview

<img width="2075" height="1200" alt="Executive_Overview" src="https://github.com/user-attachments/assets/c05694d4-cba9-4624-bb7a-346a0467a4c0" />

### Sales & Profit Analysis

<img width="2075" height="1200" alt="Sales_and_Profit_Analysis" src="https://github.com/user-attachments/assets/33e2f510-a848-4475-b544-3d546d0a9c66" />

### Customer Insights

<img width="1998" height="1124" alt="Customer_Insights" src="https://github.com/user-attachments/assets/aa2422b0-7bff-47da-a88f-d867334c9577" />

### Product Performance

<img width="2075" height="1200" alt="Product_Performance" src="https://github.com/user-attachments/assets/6b3bbfd0-b4a3-438b-9a7f-fbf45a23d778" />

### Operations & Delivery

<img width="2075" height="1200" alt="Operations_and_Delivery" src="https://github.com/user-attachments/assets/4f4f83dc-ecf1-4f39-85fb-407791148e9d" />

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

## 🚀 How to Use

1. Download or clone this repository.
2. Open the SQL files in MySQL.
3. Import the required dataset.
4. Run the SQL analysis queries.
5. Open the `.pbix` file using Power BI Desktop.
6. Refresh the data if required.
7. Explore the interactive dashboards using the slicers.

## 👨‍💻 Author

**Neeraj J**
