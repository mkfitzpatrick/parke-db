# PARKE Retail — Database Design

A relational database designed for a fictional e-commerce clothing retailer. Built as part of a graduate database systems course at Northwestern University.

---

## Overview

PARKE is an online fashion retailer where customers browse products, place orders, track shipments, and request returns. This project models the full operational database behind that business — from order placement to inventory management to marketing campaigns.

---

## Schema

The database contains **12 normalized tables**:

| Table | Description |
|---|---|
| `Customers` | Customer accounts linked to email marketing lists |
| `Orders` | Customer purchase records |
| `OrderDetails` | Line items linking orders to products (many-to-many) |
| `Products` | Product catalog with pricing, material, sizing, and reviews |
| `Transactions` | Payment records linked to orders |
| `Shipments` | Carrier tracking and shipping rate per order |
| `ReturnRequests` | Return reason and approval status per order |
| `Inventory` | Stock levels per product |
| `Employees` | Staff records |
| `EmployeeOrders` | Links employees to orders they processed |
| `MarketingCampaigns` | Campaign date ranges |
| `CampaignRecipients` | Links customers to campaigns (many-to-many) |

---

## Sample Queries

The SQL file includes queries that answer real business questions:

- Which products have been ordered more than once?
- Which customers have submitted a return request?
- What is the average product price?
- Which orders involved products over $200?
- How many customers are subscribed to marketing campaigns?
- Which employee processed the most orders?
- What is the current total products in stock?

---

## Files

| File | Description |
|---|---|
| `parke_db.sql` | Full schema (CREATE TABLE), sample data (INSERT), and analytical queries (SELECT) |

---

## Tools

- SQL (Oracle syntax)
- ER Modeling

---

## Course

MSDS — Northwestern University  
Information Systems: Database Design
