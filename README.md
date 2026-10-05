# E-Commerce Sales Funnel & Revenue Analysis (MySQL)

An end-to-end SQL analytics project that analyzes e-commerce user events to measure funnel performance, locate checkout friction, compare marketing channels, and track core revenue KPIs.

![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-4479A1?logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-CTEs%20%7C%20Aggregations-informational)

---

## Table of Contents

- [Overview](#overview)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Workflow](#workflow)
- [Business Questions](#business-questions)
- [Key Findings](#key-findings)
- [Getting Started](#getting-started)
- [Tech Stack](#tech-stack)

---

## Overview

This project answers five core business questions about how users move from first page view to purchase, which acquisition channels convert best, how long conversion takes, and how much revenue the funnel generates.

## Dataset

**File:** `data/user_events.csv`

## Project Structure

```
sales-funnel-analysis/
├── data/
│   └── user_events.csv            # Raw event data
├── queries/
│   ├── schema_and_load.sql        # Database, table creation & data load
│   └── five_funnel_queries.sql    # Five business-problem queries
├── docs/
│   └── query_insights.docx        # Insights & UX recommendations
└── README.md
```

## Workflow

1. **Schema design** — Created `sales_funnel_db` and the `user_events` table with appropriate types (`DATETIME(6)`, `DECIMAL(10,2)`) and indexes on `user_id`, `event_type`, `event_date`, and `traffic_source`.
2. **Ingestion & cleaning** — Enabled `local_infile` and loaded the CSV with `LOAD DATA LOCAL INFILE`, using `SET amount = NULLIF(TRIM(@amount), '')` to convert blank fields to `NULL`.
3. **Query development** — Wrote optimized queries using CTEs, conditional `CASE WHEN` aggregation, `TIMESTAMPDIFF()`, and `NULLIF()` for safe division.

## Business Questions

| # | Question | Techniques |
|---|---|---|
| Q1 | How many users reach each funnel stage? | `COUNT(DISTINCT)`, `CASE WHEN` |
| Q2 | What is the step-by-step conversion rate? | CTEs, `NULLIF` |
| Q3 | Which traffic sources convert most efficiently? | Grouped conditional aggregation |
| Q4 | How long does conversion take (view → cart, cart → purchase)? | `TIMESTAMPDIFF` |
| Q5 | What are total visitors, buyers, revenue, orders, and AOV? | Aggregations, `ROUND` |

## Key Findings

### Funnel Performance

| Stage | Users | Step Conversion |
|---|---:|---:|
| Page View | 5,000 | — |
| Add to Cart | 1,553 | 31.06% |
| Checkout Start | 1,103 | 71.02% |
| Payment Info | 899 | 81.50% |
| Purchase | 826 | 91.88% |

- The **91.88%** payment-to-purchase rate points to a smooth, low-friction final checkout step.
- The largest drop-off occurs at **view → cart**, making product pages the best optimization target.

### Channel Performance

- **Email** — highest purchase conversion (**33.91%**), indicating strong buyer intent.
- **Social** — lowest purchase conversion (**6.93%**) despite high traffic (1,472 views), the biggest efficiency gap.

### Revenue KPIs

| Metric | Value |
|---|---:|
| Total Revenue | $87,975.11 |
| Total Orders | 826 |
| Average Order Value | $106.51 |

### Time to Conversion

- **11.16 min** average from product view to add-to-cart
- **13.47 min** average from add-to-cart to purchase

## Getting Started

**Prerequisites:** MySQL 8.0+ and MySQL Workbench or the MySQL CLI.

## Tech Stack

- **Database:** MySQL 8.0+
- **SQL:** CTEs, `COUNT(DISTINCT)`, `CASE WHEN`, `TIMESTAMPDIFF`, `ROUND`, `NULLIF`
- **Client:** MySQL Workbench / MySQL CLI
