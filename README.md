# SQL Data Warehouse Project

A data warehouse built in SQL Server using the Medallion Architecture (Bronze, Silver, Gold). It takes raw sales data from two source systems, cleans and integrates it, and delivers a business-ready data model for reporting and analysis.

---

## Project Overview

| Area | What this project covers |
|------|--------------------------|
| Data Architecture | Medallion design with Bronze, Silver and Gold layers |
| ETL Pipelines | Extracting, transforming and loading data with stored procedures |
| Data Modeling | Fact and dimension tables in a star schema |
| Data Quality | Checks for duplicates, nulls, invalid dates and inconsistent values |

---

## Data Architecture

| Layer | Purpose | Object type | Load method |
|-------|---------|-------------|-------------|
| **Bronze** | Raw data, stored exactly as received from the source files | Tables | Full load (truncate and insert) using `BULK INSERT` |
| **Silver** | Cleaned, standardized and integrated data | Tables | Full load (truncate and insert) through a stored procedure |
| **Gold** | Business-ready data in a star schema | Views | No load; built on top of Silver |

---

## Data Sources

Six CSV files from two source systems:

| Source | File | Contents | Rows |
|--------|------|----------|------|
| CRM | `cust_info.csv` | Customer details | 18,493 |
| CRM | `prd_info.csv` | Product details | 397 |
| CRM | `sales_details.csv` | Sales transactions | 60,398 |
| ERP | `CUST_AZ12.csv` | Customer birthdate and gender | 18,483 |
| ERP | `LOC_A101.csv` | Customer location | 18,484 |
| ERP | `PX_CAT_G1V2.csv` | Product categories | 37 |

---

## Project Requirements

**Objective:** build a modern data warehouse in SQL Server that consolidates sales data for analytical reporting.

- **Data sources:** import data from two systems (CRM and ERP), provided as CSV files.
- **Data quality:** clean and resolve quality issues before analysis.
- **Integration:** combine both sources into one model designed for analytical queries.
- **Scope:** latest data only; no historization.
- **Documentation:** document the data model for business and analytics users.

---

## Data Model (Gold Layer)

| Object | Type | Description |
|--------|------|-------------|
| `gold.dim_customers` | Dimension | Customer details enriched with demographic and location data |
| `gold.dim_products` | Dimension | Product details with category and subcategory |
| `gold.fact_sales` | Fact | Sales transactions linked to customers and products |

---

## Repository Structure
