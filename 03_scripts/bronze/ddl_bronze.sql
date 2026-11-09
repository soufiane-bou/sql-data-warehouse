-- Bronze layer DDL for data warehouse
-- This script creates schemas and tables if they do not already exist.
-- Run once to bootstrap the bronze layer.

-- Create schemas
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
GO

-- Bronze tables
-- CRM source tables
-- Customer information
CREATE TABLE IF NOT EXISTS bronze.crm_cust_info (
    cst_id              INTEGER,
    cst_key             VARCHAR(50),
    cst_firstname       VARCHAR(50),
    cst_lastname        VARCHAR(50),
    cst_marital_status  VARCHAR(20),
    cst_gndr            VARCHAR(20),
    cst_create_date     DATE
);
GO

-- Product information
CREATE TABLE IF NOT EXISTS bronze.crm_prd_info (
    prd_id        INTEGER,
    prd_key       VARCHAR(50),
    prd_nm        VARCHAR(100),
    prd_cost      NUMERIC(10,2),
    prd_line      VARCHAR(50),
    prd_start_dt  DATE,
    prd_end_dt    DATE
);
GO

-- Sales details
CREATE TABLE IF NOT EXISTS bronze.crm_sales_details (
    sls_ord_num   VARCHAR(50),
    sls_prd_key   VARCHAR(50),
    sls_cust_id   INTEGER,
    sls_order_dt  VARCHAR(10),
    sls_ship_dt   VARCHAR(10),
    sls_due_dt    VARCHAR(10),
    sls_sales     NUMERIC(12,2),
    sls_quantity  INTEGER,
    sls_price     NUMERIC(12,2)
);
GO

-- ERP source tables

-- Customer 
CREATE TABLE IF NOT EXISTS bronze.erp_cust_az12 (
    cid    VARCHAR(50),
    bdate  DATE,
    gen    VARCHAR(20)
);
GO

-- Location 
CREATE TABLE IF NOT EXISTS bronze.erp_loca101 (
    cid    VARCHAR(50),
    cntry  VARCHAR(100)
);
GO

-- Product category data
CREATE TABLE IF NOT EXISTS bronze.erp_px_cat_g1v2 (
    id           VARCHAR(50),
    cat          VARCHAR(100),
    subcat       VARCHAR(100),
    maintenance  VARCHAR(10)
);
GO
