# RFM Analysis with SQL

This project demonstrates an RFM (Recency, Frequency, Monetary) analysis conducted using SQL queries on an e-commerce dataset. RFM analysis is a customer segmentation technique based on recency, frequency, and monetary value of customer transactions. Below, you will find an overview of the project, the dataset used, and the key analyses performed.

## Project Overview

In this project, we perform an RFM analysis on an e-commerce dataset. The primary objectives of the analysis are as follows:

- **Recency (R):** Determining how recently a customer has made a purchase.
- **Frequency (F):** Calculating how often a customer makes purchases.
- **Monetary (M):** Measuring the monetary value of a customer's purchases.

## Dataset

The dataset used for this analysis is an e-commerce dataset containing information about customer transactions. The dataset includes the following columns:

- invoice_no
- stock_code
- description
- quantity
- invoice_date
- unit_price
- customer_id
- country

## SQL Queries

The analysis is conducted using SQL queries on the provided dataset. Here are some of the key SQL queries used in the analysis:

- **Recency Count:** This query calculates the recency for each customer, indicating how many days have passed since their last purchase.

- **Frequency Count:** This query calculates the frequency of purchases for each customer, counting the number of unique invoice numbers.

- **Monetary Count:** This query calculates the monetary value of purchases for each customer, rounding the sum of unit prices.

- **RFM Analysis:** The final query combines the recency, frequency, and monetary scores for each customer, assigning them to specific RFM segments.



