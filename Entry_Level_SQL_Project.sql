-- Q1: List all customers from the USA
SELECT * FROM Customers
WHERE Country = 'USA';

-- Q2: Show the top 5 most expensive products
SELECT ProductName, Price FROM Products
ORDER BY Price DESC
LIMIT 5;

-- Q3: Find the total quantity of products ordered per product
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Orders
GROUP BY ProductID;

-- Q4: Show CustomerName, ProductName, and Quantity for each order
SELECT c.CustomerName, p.ProductName, o.Quantity
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID;

-- Q5: Show total revenue per customer
SELECT c.CustomerName, SUM(o.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerName;

-- Q6: Find customers who have spent more than $2000 in total
SELECT c.CustomerName, SUM(o.Quantity * p.Price) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerName
HAVING TotalSpent > 2000;

-- Q7: Categorize products as 'High' if Price > 1000, else 'Low'
SELECT ProductName, Price,
  CASE 
    WHEN Price > 1000 THEN 'High'
    ELSE 'Low'
  END AS PriceCategory
FROM Products;

-- Q8: Find customers who placed more than 3 orders
SELECT CustomerID FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 3;

-- Q9: Get monthly sales totals
SELECT strftime('%Y-%m', OrderDate) AS Month,
       SUM(Quantity * Price) AS MonthlySales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY Month
ORDER BY Month;

-- Q10: List all orders and show 'Unknown' if customer name is missing
SELECT o.OrderID, COALESCE(c.CustomerName, 'Unknown') AS CustomerName
FROM Orders o
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID;

-- Q11: List the unique countries from the Customers table
SELECT DISTINCT Country FROM Customers;

-- Q12: Find the first 5 characters of each product name
SELECT SUBSTRING(ProductName, 1, 5) AS ProductShortName FROM Products;

-- Q13: How many orders are there in the Orders table?
SELECT COUNT(*) AS OrderCount FROM Orders;

-- Q14: Find customers who have ordered the same product
SELECT o1.CustomerID AS Customer1, o2.CustomerID AS Customer2, o1.ProductID
FROM Orders o1
JOIN Orders o2 ON o1.ProductID = o2.ProductID AND o1.CustomerID != o2.CustomerID;

-- Q15: Find orders that were placed in the last 30 days
SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

-- Q16: Show CustomerName, ProductName, and OrderDate for each order
SELECT c.CustomerName, p.ProductName, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID;

-- Q17: Combine results from two queries to show all customers from both USA and Canada
SELECT CustomerName FROM Customers WHERE Country = 'USA'
UNION
SELECT CustomerName FROM Customers WHERE Country = 'Canada';

-- Q18: Increase the price of all products in the Electronics category by 10%
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Electronics';

-- Q19: Delete all orders from the year 2024
DELETE FROM Orders
WHERE OrderDate LIKE '2024%';

-- Q20: Show orders for specific products (e.g., Laptop and Smartphone)
SELECT * FROM Orders
WHERE ProductID IN (101, 102);
