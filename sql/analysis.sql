-- =============================================
-- E-Commerce Sales Data Analysis
-- Dataset: Amazon India Fashion Sales
-- =============================================

-- 1. Total Revenue Generated
SELECT 
    SUM(Amount) AS Total_Revenue,
    COUNT([Order ID]) AS Total_Orders
FROM ecommerce_sales
WHERE Status != 'Cancelled';

-- 2. Monthly Revenue Trend
SELECT 
    MONTH(Date) AS Month,
    SUM(Amount) AS Monthly_Revenue,
    COUNT([Order ID]) AS Total_Orders
FROM ecommerce_sales
WHERE Status != 'Cancelled'
GROUP BY MONTH(Date)
ORDER BY Month;

-- 3. Top 10 Best Selling Categories
SELECT 
    Category,
    COUNT([Order ID]) AS Total_Orders,
    SUM(Amount) AS Total_Revenue
FROM ecommerce_sales
WHERE Status != 'Cancelled'
GROUP BY Category
ORDER BY Total_Orders DESC;

-- 4. Order Status Breakdown
SELECT 
    Status,
    COUNT([Order ID]) AS Total_Orders,
    ROUND(COUNT([Order ID]) * 100.0 / 
    (SELECT COUNT(*) FROM ecommerce_sales), 2) AS Percentage
FROM ecommerce_sales
GROUP BY Status
ORDER BY Total_Orders DESC;

-- 5. Top 10 States by Revenue
SELECT TOP 10
    [ship-state] AS State,
    SUM(Amount) AS Total_Revenue,
    COUNT([Order ID]) AS Total_Orders
FROM ecommerce_sales
WHERE Status != 'Cancelled'
GROUP BY [ship-state]
ORDER BY Total_Revenue DESC;

-- 6. B2B vs B2C Sales Comparison
SELECT 
    B2B,
    COUNT([Order ID]) AS Total_Orders,
    SUM(Amount) AS Total_Revenue
FROM ecommerce_sales
WHERE Status != 'Cancelled'
GROUP BY B2B;

-- 7. Cancellation Rate by Category
SELECT 
    Category,
    COUNT([Order ID]) AS Total_Orders,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Orders,
    ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / 
    COUNT([Order ID]), 2) AS Cancellation_Rate
FROM ecommerce_sales
GROUP BY Category
ORDER BY Cancellation_Rate DESC;

-- 8. Fulfilment Method Performance
SELECT 
    Fulfilment,
    COUNT([Order ID]) AS Total_Orders,
    SUM(Amount) AS Total_Revenue
FROM ecommerce_sales
WHERE Status != 'Cancelled'
GROUP BY Fulfilment;