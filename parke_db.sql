-- ============================================================
-- PARKE Retail Database
-- Relational schema for an e-commerce fashion retailer
-- Covers: orders, products, transactions, shipments, returns,
--         inventory, employees, and marketing campaigns
-- ============================================================


-- ============================================================
-- SCHEMA: CREATE TABLES
-- ============================================================

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name       VARCHAR(100),
    Role       VARCHAR(50)
);

CREATE TABLE Customers (
    CustomerID  INT PRIMARY KEY,
    EmailListID INT
);

-- Orders reference Customers
CREATE TABLE Orders (
    OrderID       INT PRIMARY KEY,
    CustomerID    INT,
    DatePurchased DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- One transaction per order
CREATE TABLE Transactions (
    TransactionID  INT PRIMARY KEY,
    OrderID        INT UNIQUE,
    PaymentDetails VARCHAR(255),
    BillingAddress VARCHAR(255),
    PaymentType    VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Products (
    ProductID       INT PRIMARY KEY,
    ProductCategory VARCHAR(100),
    Price           DECIMAL(10,2),
    CustomerReviews VARCHAR(255),
    Material        VARCHAR(100),
    Sizing          VARCHAR(50)
);

-- Join table: Orders <-> Products (many-to-many)
CREATE TABLE OrderDetails (
    OrderID   INT,
    ProductID INT,
    Quantity  INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID)   REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Shipments (
    ShipmentID      INT PRIMARY KEY,
    OrderID         INT,
    TrackingNo      VARCHAR(50),
    ShippingService VARCHAR(100),
    ShippingRate    DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE ReturnRequests (
    ReturnID INT PRIMARY KEY,
    OrderID  INT,
    Reason   VARCHAR(255),
    Status   VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID   INT,
    StockLevel  INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE MarketingCampaigns (
    CampaignID INT PRIMARY KEY,
    StartDate  DATE,
    EndDate    DATE
);

-- Join table: MarketingCampaigns <-> Customers (many-to-many)
CREATE TABLE CampaignRecipients (
    CampaignID INT,
    CustomerID INT,
    PRIMARY KEY (CampaignID, CustomerID),
    FOREIGN KEY (CampaignID) REFERENCES MarketingCampaigns(CampaignID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Join table: Employees <-> Orders (many-to-many)
CREATE TABLE EmployeeOrders (
    EmployeeID INT,
    OrderID    INT,
    PRIMARY KEY (EmployeeID, OrderID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (OrderID)    REFERENCES Orders(OrderID)
);


-- ============================================================
-- SAMPLE DATA: INSERT STATEMENTS
-- ============================================================

-- Customers
INSERT INTO Customers VALUES (1, 101);
INSERT INTO Customers VALUES (2, 102);
INSERT INTO Customers VALUES (3, 103);
INSERT INTO Customers VALUES (4, 104);
INSERT INTO Customers VALUES (5, 105);

-- Products
INSERT INTO Products VALUES (2001, 'Cashmere Sweater',      195.00, '4.8 Stars - Soft and warm!',           '100% Cashmere',  'M');
INSERT INTO Products VALUES (2002, 'Oversized Denim Jacket', 225.00, '4.7 Stars - Runs big but stylish!',    'Premium Denim',  'L');
INSERT INTO Products VALUES (2003, 'Wool Cardigan',          175.00, '4.9 Stars - Perfect layering piece',   'Merino Wool',    'S');
INSERT INTO Products VALUES (2004, 'Denim Mini Shorts',      160.00, '4.5 Stars - Chic but size up!',        'Rigid Denim',    'XS');
INSERT INTO Products VALUES (2005, 'Silk Slip Dress',        310.00, '5 Stars - Stunning and high-quality!', '100% Silk',      'M');

-- Orders
INSERT INTO Orders VALUES (1001, 1, TO_DATE('2025-03-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1002, 2, TO_DATE('2025-03-11', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1003, 3, TO_DATE('2025-03-12', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1004, 4, TO_DATE('2025-03-13', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1005, 5, TO_DATE('2025-03-14', 'YYYY-MM-DD'));

-- Order Line Items
INSERT INTO OrderDetails VALUES (1001, 2003, 1);
INSERT INTO OrderDetails VALUES (1002, 2003, 2);
INSERT INTO OrderDetails VALUES (1005, 2003, 1);

-- Transactions
INSERT INTO Transactions VALUES (5001, 1001, 'Visa **** **** **** 1234',           '123 Main St, Los Angeles, CA', 'Credit Card');
INSERT INTO Transactions VALUES (5002, 1002, 'PayPal - john.doe@example.com',       '456 Elm St, Chicago, IL',      'PayPal');
INSERT INTO Transactions VALUES (5003, 1003, 'MasterCard **** **** **** 5678',      '789 Oak St, New York, NY',     'Credit Card');

-- Shipments
INSERT INTO Shipments VALUES (3001, 1001, 'TRK123456789', 'FedEx', 15.99);
INSERT INTO Shipments VALUES (3002, 1002, 'TRK987654321', 'UPS',   10.99);
INSERT INTO Shipments VALUES (3003, 1003, 'TRK555111333', 'DHL',   12.49);

-- Return Requests
INSERT INTO ReturnRequests VALUES (4001, 1001, 'Size too large', 'Approved');

-- Employees
INSERT INTO Employees VALUES (7001, 'Alice Johnson', 'Order Processor');
INSERT INTO Employees VALUES (7002, 'Bob Smith',     'Customer Service');
INSERT INTO Employees VALUES (7003, 'Emma Davis',    'Warehouse Staff');

-- Employee Order Assignments
INSERT INTO EmployeeOrders VALUES (7001, 1001);
INSERT INTO EmployeeOrders VALUES (7002, 1002);
INSERT INTO EmployeeOrders VALUES (7003, 1003);

-- Marketing Campaigns
INSERT INTO MarketingCampaigns VALUES (9001, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-02-01', 'YYYY-MM-DD'));
INSERT INTO MarketingCampaigns VALUES (9002, TO_DATE('2025-02-15', 'YYYY-MM-DD'), TO_DATE('2025-03-15', 'YYYY-MM-DD'));
INSERT INTO MarketingCampaigns VALUES (9003, TO_DATE('2025-03-20', 'YYYY-MM-DD'), TO_DATE('2025-04-20', 'YYYY-MM-DD'));

-- Campaign Recipients
INSERT INTO CampaignRecipients VALUES (9001, 1);
INSERT INTO CampaignRecipients VALUES (9001, 2);
INSERT INTO CampaignRecipients VALUES (9002, 2);
INSERT INTO CampaignRecipients VALUES (9002, 3);
INSERT INTO CampaignRecipients VALUES (9003, 3);
INSERT INTO CampaignRecipients VALUES (9003, 4);
INSERT INTO CampaignRecipients VALUES (9003, 5);

COMMIT;


-- ============================================================
-- ANALYTICAL QUERIES
-- ============================================================

-- All customers and their orders with purchase dates
SELECT c.CustomerID, o.OrderID, o.DatePurchased
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Orders shipped via FedEx
SELECT OrderID, TrackingNo
FROM Shipments
WHERE ShippingService = 'FedEx';

-- Orders containing a Cardigan
SELECT o.OrderID, p.ProductCategory
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p     ON od.ProductID = p.ProductID
WHERE p.ProductCategory = 'Cardigan';

-- Transaction details for a specific order
SELECT *
FROM Transactions
WHERE OrderID = 1001;

-- Total number of orders placed
SELECT COUNT(*) AS TotalOrders
FROM Orders;

-- Products ordered more than once
SELECT ProductID, COUNT(*) AS TimesOrdered
FROM OrderDetails
GROUP BY ProductID
HAVING COUNT(*) > 1;

-- Customers who have submitted a return request
SELECT DISTINCT c.CustomerID
FROM Customers c
JOIN Orders o         ON c.CustomerID = o.CustomerID
JOIN ReturnRequests r ON o.OrderID = r.OrderID;

-- Average product price across the catalog
SELECT AVG(Price) AS AveragePrice
FROM Products;

-- All shipments sorted by shipping rate (highest first)
SELECT *
FROM Shipments
ORDER BY ShippingRate DESC;

-- Employees who processed more than one order
SELECT EmployeeID, COUNT(OrderID) AS OrdersProcessed
FROM EmployeeOrders
GROUP BY EmployeeID
HAVING COUNT(OrderID) > 1;

-- Top 5 most expensive products
SELECT *
FROM Products
ORDER BY Price DESC
FETCH FIRST 5 ROWS ONLY;

-- All return requests and their status
SELECT * FROM ReturnRequests;

-- Duration of each marketing campaign in days
SELECT CampaignID, (EndDate - StartDate) AS DurationDays
FROM MarketingCampaigns;

-- Total products currently in stock
SELECT COUNT(*) AS TotalProductsInStock
FROM Inventory;

-- Products with zero stock
SELECT p.ProductID, p.ProductCategory
FROM Products p
JOIN Inventory i ON p.ProductID = i.ProductID
WHERE i.StockLevel = 0;

-- High-value orders (products over $200) with payment details
SELECT o.OrderID, t.PaymentDetails, t.PaymentType, p.Price
FROM Orders o
JOIN Transactions t  ON o.OrderID = t.OrderID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p      ON od.ProductID = p.ProductID
WHERE p.Price > 200;

-- Total number of customers subscribed to any campaign
SELECT COUNT(DISTINCT CustomerID) AS SubscribedCustomers
FROM CampaignRecipients;

-- Best-selling product by order count
SELECT ProductID, ProductCategory, OrderCount
FROM (
    SELECT p.ProductID, p.ProductCategory, COUNT(od.OrderID) AS OrderCount
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductCategory
    ORDER BY COUNT(od.OrderID) DESC
)
WHERE ROWNUM = 1;
