-- Create a CTE to combine product and sales data

WITH CTE AS(
SELECT
a.Product,
a.Category,
a.Brand,
a.Description,
a.Sale_Price,
a.Cost_Price,
a.Image_url,
b.Date,
b.Customer_Type,
b.Discount_Band,
b.Units_Sold,
(Sale_price*Units_Sold) AS revenue,
(Cost_price*Units_Sold) AS total_cost,
format(Date, 'MMMM') AS month,
format(Date, 'yyyy') AS year
FROM Product_data a
INNER JOIN product_sales b
ON a.Product_ID = b.Product)

SELECT *,
(1-Discount*1.0/100)* revenue AS discount_revenue
FROM CTE AS a
INNER JOIN discount_data AS b

ON a.Discount_Band = b.Discount_Band AND a.month = b.Month
