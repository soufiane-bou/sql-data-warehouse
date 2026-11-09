-- =============================================================
-- Procedure: bronze.load_bronze()
-- Description: Loads all bronze-layer tables from CSV files.
--              Logs the execution time of each truncate and load.
-- =============================================================
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    v_start    TIMESTAMP;
    v_end      TIMESTAMP;
    v_proc_start TIMESTAMP;
BEGIN
    v_proc_start := clock_timestamp();

    RAISE NOTICE '=========================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE 'Start time: %', v_proc_start;
    RAISE NOTICE '=========================================';

    -- =========================================================
    -- CRM Tables
    -- =========================================================
    RAISE NOTICE '--- Loading CRM tables ---';

    -- crm_cust_info --------------------------------------------
    RAISE NOTICE '>> Truncate: crm_cust_info';
    v_start := clock_timestamp();
    TRUNCATE TABLE bronze.crm_cust_info;
    v_end := clock_timestamp();
    RAISE NOTICE '>> Truncate crm_cust_info completed in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    RAISE NOTICE '>> Load: crm_cust_info';
    v_start := clock_timestamp();
    COPY bronze.crm_cust_info (
        cst_id,
        cst_key,
        cst_firstname,
        cst_lastname,
        cst_marital_status,
        cst_gndr,
        cst_create_date
    )
    FROM 'R:\Data engineer\sql-data-warehouse-project-main -postgres\01_datasets\source_crm\cust_info.csv'
    WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
    v_end := clock_timestamp();
    RAISE NOTICE '>> crm_cust_info loaded in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    -- crm_prd_info ---------------------------------------------
    RAISE NOTICE '>> Truncate: crm_prd_info';
    v_start := clock_timestamp();
    TRUNCATE TABLE bronze.crm_prd_info;
    v_end := clock_timestamp();
    RAISE NOTICE '>> Truncate crm_prd_info completed in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    RAISE NOTICE '>> Load: crm_prd_info';
    v_start := clock_timestamp();
    COPY bronze.crm_prd_info (
        prd_id,
        prd_key,
        prd_nm,
        prd_cost,
        prd_line,
        prd_start_dt,
        prd_end_dt
    )
    FROM 'R:\Data engineer\sql-data-warehouse-project-main -postgres\01_datasets\source_crm\prd_info.csv'
    WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
    v_end := clock_timestamp();
    RAISE NOTICE '>> crm_prd_info loaded in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    -- crm_sales_details ----------------------------------------
    RAISE NOTICE '>> Truncate: crm_sales_details';
    v_start := clock_timestamp();
    TRUNCATE TABLE bronze.crm_sales_details;
    v_end := clock_timestamp();
    RAISE NOTICE '>> Truncate crm_sales_details completed in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    RAISE NOTICE '>> Load: crm_sales_details';
    v_start := clock_timestamp();
    COPY bronze.crm_sales_details (
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_sales,
        sls_quantity,
        sls_price
    )
    FROM 'R:\Data engineer\sql-data-warehouse-project-main -postgres\01_datasets\source_crm\sales_details.csv'
    WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
    v_end := clock_timestamp();
    RAISE NOTICE '>> crm_sales_details loaded in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    -- =========================================================
    -- ERP Tables
    -- =========================================================
    RAISE NOTICE '--- Loading ERP tables ---';

    -- erp_cust_az12 --------------------------------------------
    RAISE NOTICE '>> Truncate: erp_cust_az12';
    v_start := clock_timestamp();
    TRUNCATE TABLE bronze.erp_cust_az12;
    v_end := clock_timestamp();
    RAISE NOTICE '>> Truncate erp_cust_az12 completed in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    RAISE NOTICE '>> Load: erp_cust_az12';
    v_start := clock_timestamp();
    COPY bronze.erp_cust_az12 (
        cid,
        bdate,
        gen
    )
    FROM 'R:\Data engineer\sql-data-warehouse-project-main -postgres\01_datasets\source_erp\CUST_AZ12.csv'
    WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
    v_end := clock_timestamp();
    RAISE NOTICE '>> erp_cust_az12 loaded in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    -- erp_loca101 ----------------------------------------------
    RAISE NOTICE '>> Truncate: erp_loca101';
    v_start := clock_timestamp();
    TRUNCATE TABLE bronze.erp_loca101;
    v_end := clock_timestamp();
    RAISE NOTICE '>> Truncate erp_loca101 completed in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    RAISE NOTICE '>> Load: erp_loca101';
    v_start := clock_timestamp();
    COPY bronze.erp_loca101 (
        cid,
        cntry
    )
    FROM 'R:\Data engineer\sql-data-warehouse-project-main -postgres\01_datasets\source_erp\LOC_A101.csv'
    WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
    v_end := clock_timestamp();
    RAISE NOTICE '>> erp_loca101 loaded in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    -- erp_px_cat_g1v2 ------------------------------------------
    RAISE NOTICE '>> Truncate: erp_px_cat_g1v2';
    v_start := clock_timestamp();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    v_end := clock_timestamp();
    RAISE NOTICE '>> Truncate erp_px_cat_g1v2 completed in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    RAISE NOTICE '>> Load: erp_px_cat_g1v2';
    v_start := clock_timestamp();
    COPY bronze.erp_px_cat_g1v2 (
        id,
        cat,
        subcat,
        maintenance
    )
    FROM 'R:\Data engineer\sql-data-warehouse-project-main -postgres\01_datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (FORMAT CSV, HEADER, DELIMITER ',', ENCODING 'UTF8');
    v_end := clock_timestamp();
    RAISE NOTICE '>> erp_px_cat_g1v2 loaded in % seconds', EXTRACT(EPOCH FROM v_end - v_start);

    -- =========================================================
    -- Summary
    -- =========================================================
    v_end := clock_timestamp();
    RAISE NOTICE '=========================================';
    RAISE NOTICE 'Bronze Layer Loading Completed';
    RAISE NOTICE 'Total duration: % seconds', EXTRACT(EPOCH FROM v_end - v_proc_start);
    RAISE NOTICE '=========================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '================================';
        RAISE NOTICE 'ERROR OCCURRED DURING BRONZE LOADING';
        RAISE NOTICE 'Error: %', SQLERRM;
        RAISE NOTICE 'SQLSTATE: %', SQLSTATE;
        RAISE NOTICE '================================';
END;
$$;


CALL bronze.load_bronze();
