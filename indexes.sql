
-----------------------------------------Create Indexes-------------------------------------------------

-- The reason is that we often search for seasons by time period
create index season_manage_dates_index on season_manage (start_date, end_date);

-- The barcode: important for indexing to speed up search and tracking operations
create index seedlings_barcode_index on seedlings (barcode);

-- Indexing the plant status helps speed up queries that depend on the plant's status
create index seedlings_status_index on seedlings (status);

-- The seedling_id and purchase_date are used in queries related to purchase invoices or based on the purchase date
create index purchase_invoices_seedling_index on purchase_invoices (seedling_id);
create index purchase_invoices_date_index on purchase_invoices (purchase_date);

-- Used to track inventory and find the latest updates in plant inventory
create index inventory_tracking_seedling_index on inventory_tracking (seedling_id);
create index inventory_tracking_last_update_index on inventory_tracking (last_update);

-- Links logistical operations with plants and uses the date to speed up temporal queries
create index operations_log_seedling_index on operations_log (seedling_id);
create index operations_log_date_index on operations_log (operation_date);
