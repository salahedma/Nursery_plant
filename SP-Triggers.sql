-----------------------------------------Create Stored Procedure-------------------------------------------------


-- SP for add data into season management table: 
create or alter procedure addseason
    @seasonname nvarchar(40),        
    @notes text                      
as
begin

    declare @startdate date, @enddate date;
  
    select @startdate = min(birth_date) 
    from seedlings;

    select @enddate = max(last_update) 
    from inventory_tracking;

    if @startdate is not null and @enddate is not null
    begin
        insert into season_manage (season_id, season_name, start_date, end_date, notes)
        values (
            concat('s', cast((select count(*) from season_manage) + 1 as nvarchar(10))),  
            @seasonname,     
            @startdate,      
            @enddate,        
            @notes           
        );

        print 'season added successfully.';
    end
    else
    begin
        print 'error: no valid data found to determine season start or end dates.';
    end
end;







-- SP for create reports : 
create or alter procedure generateseasonreport
    @season_id nvarchar(10)
as
begin
    -- data from season table
    select season_id, season_name, start_date, end_date, notes
    from season_manage
    where season_id = @season_id;

    -- data sold or purchased in one season
    select sd.seedling_id, sd.seedling_name, sd.birth_date, sd.sale_date, sd.status, sd.count, sd.sector_id
    from seedlings sd
    where sd.season_id = @season_id;

    -- data planted in one season
    select ol.operation_id, ol.seedling_id, ol.operation_type, ol.operation_date, ol.notes
    from operations_log ol
    where ol.season_id = @season_id;

    -- data from inventory tracking
    select it.inventory_id, it.seedling_id, it.quantity, it.location, it.last_update
    from inventory_tracking it
    join seedlings sd on it.seedling_id = sd.seedling_id
    where sd.season_id = @season_id;

end;

-- call : 
exec generateseasonreport 's001';




-----------------------------------------Create Triggers-------------------------------------------------

-- trigger for edit purchase_invoices : 
create trigger trg_updatepurchaseinvoicetotal
on purchase_invoices
after update, delete
as
begin
    -- check if delete or add
    declare @purchase_invoices_id nvarchar(10);
    
    -- update
    if exists (select * from inserted)
    begin
        select @purchase_invoices_id = inserted.purchase_invoices_id from inserted;
    end
    -- delete
    else if exists (select * from deleted)
    begin
        select @purchase_invoices_id = deleted.purchase_invoices_id from deleted;
    end

    -- update invoice
    update purchase_invoices
    set total_amount = (
        select sum(purchase_price * count)
        from seedlings
        where seedling_id = @purchase_invoices_id
    )
    where purchase_invoices_id = @purchase_invoices_id;
end;




-- trigger for edit sale_invoices : 
create trigger trg_updatesaleinvoicetotal
on sale_invoices
after update, delete
as
begin
    -- check if delete or add
    declare @sale_invoice_id nvarchar(10);
    
    -- edit
    if exists (select * from inserted)
    begin
        select @sale_invoice_id = inserted.sale_invoice_id from inserted;
    end
    -- delete
    else if exists (select * from deleted)
    begin
        select @sale_invoice_id = deleted.sale_invoice_id from deleted;
    end

    -- update the invoice
    update sale_invoices
    set total_amount = (
        select sum(sale_price * count)
        from seedlings
        where seedling_id = @sale_invoice_id
    )
    where sale_invoice_id = @sale_invoice_id;
end;



-- trigger for record financial transactions : 
create trigger trg_logsaleinvoiceinsert
on sale_invoices
after insert
as
begin
    declare @sale_invoice_id nvarchar(10);
    declare @sale_date date;
    declare @total_amount decimal(10, 2);
    declare @customer_id nvarchar(10);

    select @sale_invoice_id = sale_invoice_id,
           @sale_date = sale_date,
           @total_amount = total_amount,
           @customer_id = customer_id
    from inserted;

    print 'add new invoice :'
        + ' id: ' + @sale_invoice_id
        + ', date: ' + convert(nvarchar, @sale_date, 105)
        + ', total: ' + convert(nvarchar, @total_amount)
        + ', client id: ' + @customer_id;

end;



-- trigger for generate barcode : 
create trigger trg_generatebarcode
on seedlings
after insert
as
begin
    declare @sector_id nvarchar(10);
    declare @type_id nvarchar(10);
    declare @current_month nvarchar(2);
    declare @current_day nvarchar(2);
    declare @new_barcode nvarchar(50);
    
    -- get date
    set @current_month = right('0' + cast(month(getdate()) as nvarchar(2)), 2);
    set @current_day = right('0' + cast(day(getdate()) as nvarchar(2)), 2);

    declare barcode_cursor cursor for
    select sector_id, type_id from inserted;

    open barcode_cursor;
    fetch next from barcode_cursor into @sector_id, @type_id;

    while @@fetch_status = 0
    begin
        set @new_barcode = @sector_id + @type_id + @current_month + @current_day;

        -- edit barcode in added records 
        update seedlings
        set barcode = @new_barcode
        where seedling_id = (select seedling_id from inserted where sector_id = @sector_id and type_id = @type_id);

        fetch next from barcode_cursor into @sector_id, @type_id;
    end;

    close barcode_cursor;
    deallocate barcode_cursor;
end;

