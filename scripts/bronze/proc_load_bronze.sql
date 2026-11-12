use DWH;
go

create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
begin try
set @batch_start_time = getdate();
print '===================================';
print 'Loading Bronze Layer';
print '===================================';

print '-----------------------------------';
print 'Loading CRM Tables';
print '-----------------------------------';

set @start_time = getdate();
print '>> Truncating Table: bronze.crm_cust_info';
truncate table bronze.crm_cust_info;
print '>> Inserting Data Into: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
from 'C:\2-WORK\2 STUDY\7-Analytics\SQL COURSE\DATA BASE\sql-ultimate-course-main\1st PROJECT\sql-data-warehouse-project-main\01_datasets\source_crm\cust_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------';

set @start_time = getdate();
print '>> Truncating Table: bronze.crm_prd_info';
truncate table bronze.crm_prd_info;
print '>> Inserting Data Into: bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
from 'C:\2-WORK\2 STUDY\7-Analytics\SQL COURSE\DATA BASE\sql-ultimate-course-main\1st PROJECT\sql-data-warehouse-project-main\01_datasets\source_crm\prd_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------';

set @start_time = getdate();
print '>> Truncating Table: bronze.crm_sales_details';
truncate table bronze.crm_sales_details;
print '>> Inserting Data Into: bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
from 'C:\2-WORK\2 STUDY\7-Analytics\SQL COURSE\DATA BASE\sql-ultimate-course-main\1st PROJECT\sql-data-warehouse-project-main\01_datasets\source_crm\sales_details.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------';

print '-----------------------------------';
print 'Loading ERP Tables';
print '-----------------------------------';

set @start_time = getdate();
print '>> Truncating Table: bronze.erp_loc_a101';
truncate table bronze.erp_loc_a101;
print '>> Inserting Data Into: bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
from 'C:\2-WORK\2 STUDY\7-Analytics\SQL COURSE\DATA BASE\sql-ultimate-course-main\1st PROJECT\sql-data-warehouse-project-main\01_datasets\source_erp\LOC_A101.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------';

set @start_time = getdate();
print '>> Truncating Table: bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12;
print '>> Inserting Data Into: bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
from 'C:\2-WORK\2 STUDY\7-Analytics\SQL COURSE\DATA BASE\sql-ultimate-course-main\1st PROJECT\sql-data-warehouse-project-main\01_datasets\source_erp\CUST_AZ12.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------';

set @start_time = getdate();
print '>> Truncating Table: bronze.erp_px_cat_g1v2';
truncate table bronze.erp_px_cat_g1v2;
print '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\2-WORK\2 STUDY\7-Analytics\SQL COURSE\DATA BASE\sql-ultimate-course-main\1st PROJECT\sql-data-warehouse-project-main\01_datasets\source_erp\PX_CAT_G1V2.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------';

set @batch_end_time = getdate();
print '===================================';
print 'Loading Bronze Layer is Completed';
print '   - Total Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds';
print '===================================';

select 'crm_cust_info' as table_name, count(*) as row_count from bronze.crm_cust_info
union all select 'crm_prd_info', count(*) from bronze.crm_prd_info
union all select 'crm_sales_details', count(*) from bronze.crm_sales_details
union all select 'erp_loc_a101', count(*) from bronze.erp_loc_a101
union all select 'erp_cust_az12', count(*) from bronze.erp_cust_az12
union all select 'erp_px_cat_g1v2', count(*) from bronze.erp_px_cat_g1v2;
end try
begin catch
print '===================================';
print 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
print 'Error Message: ' + error_message();
print 'Error Number: ' + cast(error_number() as nvarchar);
print 'Error State: ' + cast(error_state() as nvarchar);
print '===================================';
end catch
end
go

exec bronze.load_bronze;
