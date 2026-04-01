-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50)
);


-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    EmailListID INT
);


-- Create Orders Table (references Customers)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    DatePurchased DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Create Transactions Table (references Orders)
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    OrderID INT UNIQUE,
    PaymentDetails VARCHAR(255),
    BillingAddress VARCHAR(255),
    PaymentType VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductCategory VARCHAR(100),
    Price DECIMAL(10,2),
    CustomerReviews VARCHAR(255),
    Material VARCHAR(100),
    Sizing VARCHAR(50)
);


-- Create OrderDetails Table (Join Table for Orders & Products)
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Create Shipments Table
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY,
    OrderID INT,
    TrackingNo VARCHAR(50),
    ShippingService VARCHAR(100),
    ShippingRate DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Create ReturnRequests Table
CREATE TABLE ReturnRequests (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    Reason VARCHAR(255),
    Status VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Create Inventory Table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    StockLevel INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Create MarketingCampaigns Table
CREATE TABLE MarketingCampaigns (
    CampaignID INT PRIMARY KEY,
    StartDate DATE,
    EndDate DATE
);


-- Create CampaignRecipients Table (Join Table for MarketingCampaigns & Customers)
CREATE TABLE CampaignRecipients (
    CampaignID INT,
    CustomerID INT,
    PRIMARY KEY (CampaignID, CustomerID),
    FOREIGN KEY (CampaignID) REFERENCES MarketingCampaigns(CampaignID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Create EmployeeOrders Table (Join Table for Employees & Orders)
CREATE TABLE EmployeeOrders (
    EmployeeID INT,
    OrderID INT,
    PRIMARY KEY (EmployeeID, OrderID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Insert Sample Customers
INSERT INTO Customers VALUES (1, 101);
INSERT INTO Customers VALUES (2, 102);
INSERT INTO Customers VALUES (3, 103);
INSERT INTO Customers VALUES (4, 104);
INSERT INTO Customers VALUES (5, 105);


-- Insert Sample Products
INSERT INTO Products VALUES (2001, 'Cashmere Sweater', 195.00, '4.8 Stars - Soft and warm!', '100% Cashmere', 'M');
INSERT INTO Products VALUES (2002, 'Oversized Denim Jacket', 225.00, '4.7 Stars - Runs big but stylish!', 'Premium Denim', 'L');
INSERT INTO Products VALUES (2003, 'Wool Cardigan', 175.00, '4.9 Stars - Perfect layering piece', 'Merino Wool', 'S');
INSERT INTO Products VALUES (2004, 'Denim Mini Shorts', 160.00, '4.5 Stars - Chic but size up!', 'Rigid Denim', 'XS');
INSERT INTO Products VALUES (2005, 'Silk Slip Dress', 310.00, '5 Stars - Stunning and high-quality!', '100% Silk', 'M');


-- Insert Sample Orders
INSERT INTO Orders VALUES (1001, 1, TO_DATE('2025-03-10', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1002, 2, TO_DATE('2025-03-11', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1003, 3, TO_DATE('2025-03-12', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1004, 4, TO_DATE('2025-03-13', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (1005, 5, TO_DATE('2025-03-14', 'YYYY-MM-DD'));


-- Insert Sample OrderDetails
INSERT INTO OrderDetails VALUES (1001, 2003, 1);
INSERT INTO OrderDetails VALUES (1002, 2003, 2);
INSERT INTO OrderDetails VALUES (1005, 2003, 1);


-- Insert Sample Transactions
INSERT INTO Transactions VALUES (5001, 1001, 'Visa **** **** **** 1234', '123 Main St, Los Angeles, CA', 'Credit Card');
INSERT INTO Transactions VALUES (5002, 1002, 'PayPal - john.doe@example.com', '456 Elm St, Chicago, IL', 'PayPal');
INSERT INTO Transactions VALUES (5003, 1003, 'MasterCard **** **** **** 5678', '789 Oak St, New York, NY', 'Credit Card');


-- Insert Sample Shipments
INSERT INTO Shipments VALUES (3001, 1001, 'TRK123456789', 'FedEx', 15.99);
INSERT INTO Shipments VALUES (3002, 1002, 'TRK987654321', 'UPS', 10.99);
INSERT INTO Shipments VALUES (3003, 1003, 'TRK555111333', 'DHL', 12.49);


-- Insert Sample ReturnRequests
INSERT INTO ReturnRequests VALUES (4001, 1001, 'Size too large', 'Approved');


-- Insert Sample Employees
INSERT INTO Employees VALUES (7001, 'Alice Johnson', 'Order Processor');
INSERT INTO Employees VALUES (7002, 'Bob Smith', 'Customer Service');
INSERT INTO Employees VALUES (7003, 'Emma Davis', 'Warehouse Staff');


-- Insert Sample EmployeeOrders
INSERT INTO EmployeeOrders VALUES (7001, 1001);
INSERT INTO EmployeeOrders VALUES (7002, 1002);
INSERT INTO EmployeeOrders VALUES (7003, 1003);


-- Insert Sample Marketing Campaigns
INSERT INTO MarketingCampaigns VALUES (9001, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-02-01', 'YYYY-MM-DD'));
INSERT INTO MarketingCampaigns VALUES (9002, TO_DATE('2025-02-15', 'YYYY-MM-DD'), TO_DATE('2025-03-15', 'YYYY-MM-DD'));
INSERT INTO MarketingCampaigns (CampaignID, StartDate, EndDate)
VALUES (9003, TO_DATE('2025-03-20', 'YYYY-MM-DD'), TO_DATE('2025-04-20', 'YYYY-MM-DD'));
COMMIT;






-- Insert Customers into Marketing Campaigns 
INSERT INTO CampaignRecipients VALUES (9001, 1);
INSERT INTO CampaignRecipients VALUES (9001, 2);
INSERT INTO CampaignRecipients VALUES (9002, 2);
INSERT INTO CampaignRecipients VALUES (9002, 3);
INSERT INTO CampaignRecipients VALUES (9003, 3);
INSERT INTO CampaignRecipients VALUES (9003, 4);
INSERT INTO CampaignRecipients VALUES (9003, 5);




COMMIT;
















SELECT Customers.CustomerID, Orders.OrderID, Orders.DatePurchased 
FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID




SELECT OrderID, TrackingNo 
FROM Shipments 
WHERE ShippingService = 'FedEx';






SELECT Orders.OrderID, Products.ProductCategory 
FROM Orders 
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID 
JOIN Products ON OrderDetails.ProductID = Products.ProductID 
WHERE Products.ProductCategory = 'Cardigan';








SELECT * 
FROM Transactions 
WHERE OrderID = 1001;




SELECT COUNT(*) AS TotalOrders FROM Orders;




SELECT ProductID, COUNT(*) AS TimesOrdered 
FROM OrderDetails 
GROUP BY ProductID 
HAVING COUNT(*) > 1;




SELECT DISTINCT Customers.CustomerID 
FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
JOIN ReturnRequests ON Orders.OrderID = ReturnRequests.OrderID;




SELECT AVG(Price) AS AveragePrice FROM Products;




SELECT * 
FROM Shipments 
ORDER BY ShippingRate DESC;




SELECT EmployeeID, COUNT(OrderID) AS OrdersProcessed 
FROM EmployeeOrders 
GROUP BY EmployeeID 
HAVING COUNT(OrderID) > 1;




SELECT * 
FROM Products 
ORDER BY Price DESC;
FETCH FIRST 5 ROWS ONLY;




SELECT * FROM ReturnRequests;








SELECT CampaignID, (EndDate - StartDate) AS Duration 
FROM MarketingCampaigns;










SELECT Suppliers.Name 
FROM Suppliers 
JOIN SupplierMaterials ON Suppliers.SupplierID = SupplierMaterials.SupplierID 
WHERE SupplierMaterials.MaterialID = 9002;


SELECT COUNT(*) AS TotalProductsInStock FROM Inventory;




SELECT p.ProductID, p.ProductCategory 
FROM Products p 
JOIN Inventory i ON p.ProductID = i.ProductID 
WHERE i.StockLevel = 0;






SELECT o.OrderID, t.PaymentDetails, t.PaymentType, p.Price 
FROM Orders o
JOIN Transactions t ON o.OrderID = t.OrderID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Price > 200;




SELECT COUNT(DISTINCT CustomerID) AS SubscribedCustomers 
FROM CampaignRecipients;




SELECT ProductID, ProductCategory, OrderCount
FROM (
    SELECT p.ProductID, p.ProductCategory, COUNT(od.OrderID) AS OrderCount
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductCategory
    ORDER BY COUNT(od.OrderID) DESC
)
WHERE ROWNUM = 1;
