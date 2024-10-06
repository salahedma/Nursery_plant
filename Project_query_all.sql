-----------------------------------------Create Database and use it-------------------------------------------------
create database nursery_plant
use nursery_plant

-----------------------------------------Create Tables-------------------------------------------------

create table season_manage (
    season_id nvarchar(10) not null primary key,
    season_name nvarchar(40),
    start_date date,
    end_date date,
    notes text
);

create table graft_types (
    graft_type_id nvarchar(10) not null primary key,
    graft_type_name nvarchar(40)
);

create table employee_types (
    employee_type_id nvarchar(10) not null primary key,
    employee_type_name nvarchar(40)
);

create table categories (
    category_id nvarchar(10) not null primary key,
    category_name nvarchar(40)
);

create table sectors (
    sector_id nvarchar(10) not null primary key,
    sector_name nvarchar(40),
    size decimal,
    location text
);

create table [types] (
    type_id nvarchar(10) not null primary key,
    category_id nvarchar(10),
    type_name nvarchar(40),
    foreign key (category_id) references categories(category_id)
);

create table seedlings (
    seedling_id nvarchar(10) not null primary key,
    type_id nvarchar(10),
    seedling_name nvarchar(20),
    barcode text,
    birth_date date,
    sale_date date,
    disposal_date date,
    purchase_price decimal,
    sale_price decimal,
    grafted nchar(3) check (grafted in ('yes', 'no')),
    graft_type_id nvarchar(10),
    grafting_date date,
    [count] int not null check ([count] >= 1),
    status text,
    image_url text default 'https://media.istockphoto.com/id/1085122436/photo/young-plant-growing-in-garden-with-sunlight.jpg?s=612x612&w=0&k=20&c=huN8N8gYoN7bXBrPGOOzbMQGr9KPo8ikvfR1hv2sA-E=',
    sector_id nvarchar(10),
    foreign key (type_id) references [types](type_id),
    foreign key (graft_type_id) references graft_types(graft_type_id),
    foreign key (sector_id) references sectors(sector_id),
    seedling_imported_country nvarchar(20)
);

create table purchase_invoices (
    purchase_invoices_id nvarchar(10) not null primary key,
    supplier_name nvarchar(40),
    purchase_date date,
    total_amount decimal,
    seedling_id nvarchar(10),
    foreign key (seedling_id) references seedlings(seedling_id)
);

create table customers (
    customer_id nvarchar(10) not null primary key,
    customer_name nvarchar(40),
    phone_number nvarchar(20) unique,
    email nvarchar(30) unique,
    address text,
    date_added date
);

create table inventory_tracking (
    inventory_id nvarchar(10) not null primary key,
    seedling_id nvarchar(10),
    quantity int,
    location text,
    tracking_state nvarchar(20),
    last_update date,
    foreign key (seedling_id) references seedlings(seedling_id)
);

create table operations_log (
    operation_id nvarchar(10) not null primary key,
    seedling_id nvarchar(10),
    operation_type text,
    operation_date date,
    notes text,
    foreign key (seedling_id) references seedlings(seedling_id)
);

create table sale_invoices (
    sale_invoice_id nvarchar(10) not null primary key,
    seedling_id nvarchar(10),
	[count] int not null check ([count] >= 0),
    sale_date date,
    total_amount decimal,
    customer_id nvarchar(10),
    foreign key (seedling_id) references seedlings(seedling_id),
    foreign key (customer_id) references customers(customer_id)
);

create table employees (
    employee_id nvarchar(10) not null primary key,
    sector_id nvarchar(10),
    employee_name nvarchar(40),
    hire_date date,
    employee_type_id nvarchar(10),
    phone_number nvarchar(20) unique,
    email nvarchar(30) unique,
    salary decimal,
    foreign key (sector_id) references sectors(sector_id),
    foreign key (employee_type_id) references employee_types(employee_type_id)
);

-----------------------------------------Insert data Into Tables-------------------------------------------------

--categories
INSERT INTO categories (category_id, category_name) VALUES ('V1', N'Vegetables');
INSERT INTO categories (category_id, category_name) VALUES ('F1', N'Fruits');
INSERT INTO categories (category_id, category_name) VALUES ('T1', N'Trees');
INSERT INTO categories (category_id, category_name) VALUES ('Fo1', N'Flowers and Ornamental Plants');
INSERT INTO categories (category_id, category_name) VALUES ('HM1', N'Herbs and Medicinal Plants');
INSERT INTO categories (category_id, category_name) VALUES ('I1', N'Indoor Plants');
select * from categories



--types
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('to', 'V1', N'Tomatoes');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('cu', 'V1', N'Cucumbers');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('po', 'V1', N'Potatoes');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pe', 'V1', N'Peppers');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ca', 'V1', N'Carrots');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('eg', 'V1', N'Eggplants');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('sp', 'V1', N'Spinach');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('on', 'V1', N'Onions');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('zu', 'V1', N'Zucchini');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('cab', 'V1', N'Cabbage');

INSERT INTO [types] (type_id, category_id, type_name) VALUES ('sr', 'F1', N'Strawberries');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('gr', 'F1', N'Grapes');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ap', 'F1', N'Apples');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ba', 'F1', N'Bananas');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('av', 'F1', N'Avocados');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pom', 'F1', N'Pomegranates');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('fi', 'F1', N'Figs');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pea', 'F1', N'Peaches');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('or', 'F1', N'Oranges');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('le', 'F1', N'Lemons');

INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ot', 'T1', N'Olive Trees');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pt', 'T1', N'Palm Trees');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pit', 'T1', N'Pine Trees');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ct', 'T1', N'Cypress Trees');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('mt', 'T1', N'Mulberry Trees');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('wt', 'T1', N'Walnut Trees');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('at', 'T1', N'Almond Trees');

INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ro', 'Fo1', N'Roses');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('la', 'Fo1', N'Lavender');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ja', 'Fo1', N'Jasmine');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('li', 'Fo1', N'Lilies');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ch', 'Fo1', N'Chrysanthemums');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pet', 'Fo1', N'Petunias');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('orc', 'Fo1', N'Orchids');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('wl', 'Fo1', N'Water Lilies');

INSERT INTO [types] (type_id, category_id, type_name) VALUES ('mi', 'HM1', N'Mint');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pa', 'HM1', N'Parsley');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('cha', 'HM1', N'Chamomile');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('th', 'HM1', N'Thyme');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('sa', 'HM1', N'Sage');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('bas', 'HM1', N'Basil');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('co', 'HM1', N'Coriander');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('ros', 'HM1', N'Rosemary');

INSERT INTO [types] (type_id, category_id, type_name) VALUES ('cac', 'I1', N'Cactus');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('spp', 'I1', N'Spider Plant');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('pl', 'I1', N'Peace Lily');
INSERT INTO [types] (type_id, category_id, type_name) VALUES ('bam', 'I1', N'Bamboo');
select * from [types]




--graft types
INSERT INTO graft_types (graft_type_id, graft_type_name) VALUES ('G1', N'Bud Grafting');
INSERT INTO graft_types (graft_type_id, graft_type_name) VALUES ('G2', N'Cleft Grafting');
INSERT INTO graft_types (graft_type_id, graft_type_name) VALUES ('G3', N'Chip Budding');
INSERT INTO graft_types (graft_type_id, graft_type_name) VALUES ('G4', N'Whip Grafting');
INSERT INTO graft_types (graft_type_id, graft_type_name) VALUES ('G5', N'Approach Grafting');
select * from graft_types



--customers 
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C1', N'Khalid Ahmed', '0501112233', 'khalid.ahmed@example.com', N'123 King Abdulaziz St, Riyadh, Saudi Arabia', '2020-05-12');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C2', N'Sara Mohammed', '0502223344', 'sara.mohammed@example.com', N'456 Al-Faisal St, Cairo, Egypt', '2021-09-07');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C3', N'Aisha Khan', '0503334455', 'aisha.khan@example.com', N'789 Al-Masjid Rd, Amman, Jordan', '2022-02-15');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C4', N'Hamza Ali', '0504445566', 'hamza.ali@example.com', N'101 Al-Shuhada St, Beirut, Lebanon', '2023-01-10');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C5', N'Nour Mohamed', '0505556677', 'nour.mohamed@example.com', N'202 Al-Hilal St, Doha, Qatar', '2024-03-20');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C6', N'Fatima Saleh', '0506667788', 'fatima.saleh@example.com', N'303 Al-Nasr St, Dubai, UAE', '2020-11-30');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C7', N'Bilal Yasin', '0507778899', 'bilal.yasin@example.com', N'404 Al-Jazeera St, Manama, Bahrain', '2021-06-25');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C8', N'Samira Rahman', '0508889900', 'samira.rahman@example.com', N'505 Al-Muharraq St, Muscat, Oman', '2022-08-17');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C9', N'Zayd Ahmad', '0509990011', 'zayd.ahmad@example.com', N'606 Al-Nour St, Tunis, Tunisia', '2023-04-05');
INSERT INTO customers (customer_id, customer_name, phone_number, email, address, date_added) VALUES ('C10', N'Yasmin Zahir', '0500001122', 'yasmin.zahir@example.com', N'707 Al-Fajr St, Algiers, Algeria', '2024-12-01');
select * from customers



--employee types
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('MNG1', N'Manager');
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('ET2', N'Sales Representative');
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('ET3', N'Gardener');
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('ET4', N'Accountant');
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('ET5', N'Supervisor');
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('ET6', N'Technician');
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('ET7', N'Security Guard');
INSERT INTO employee_types (employee_type_id, employee_type_name) VALUES ('ET8', N'Warehouse Keeper');
select * from employee_types




--sectors
INSERT INTO sectors (sector_id, sector_name, size, location) VALUES ('S1', N'North Sector', 3000, N'North of the farm');
INSERT INTO sectors (sector_id, sector_name, size, location) VALUES ('S2', N'South Sector', 2500, N'South of the farm');
INSERT INTO sectors (sector_id, sector_name, size, location) VALUES ('S3', N'East Sector', 2000, N'East of the farm');
INSERT INTO sectors (sector_id, sector_name, size, location) VALUES ('S4', N'West Sector', 1500, N'West of the farm');
INSERT INTO sectors (sector_id, sector_name, size, location) VALUES ('S5', N'Central Sector', 2000, N'Central area of the farm');
INSERT INTO sectors (sector_id, sector_name, size, location) VALUES ('S6', N'Greenhouse Sector', 1000, N'Greenhouse area');
select * from sectors


--employees 
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E-MNG1', Null, N'Ali Ibrahim', '2022-01-15', 'MNG1', '0501112233', 'ali.ibrahim@example.com', 5000);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E1', 'S2', N'Fatima Khaled', '2021-03-10', 'ET2', '0502223344', 'fatima.khaled@example.com', 4000);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E2', 'S3', N'Omar Saleh', '2020-05-20', 'ET3', '0503334455', 'omar.saleh@example.com', 3500);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E3', 'S4', N'Layla Hassan', '2019-07-25', 'ET4', '0504445566', 'layla.hassan@example.com', 4500);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E4', 'S5', N'Zayd Ahmed', '2023-02-28', 'ET5', '0505556677', 'zayd.ahmed@example.com', 4800);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E5', 'S6', N'Aisha Noor', '2022-04-18', 'ET6', '0506667788', 'aisha.noor@example.com', 3300);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E6', 'S1', N'Hassan Youssef', '2021-06-15', 'ET2', '0507778899', 'hassan.youssef@example.com', 4200);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E7', 'S2', N'Samira Ahmed', '2020-08-30', 'ET3', '0508889900', 'samira.ahmed@example.com', 3600);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E8', 'S3', N'Tariq Mohamed', '2023-05-10', 'ET4', '0509990011', 'tariq.mohamed@example.com', 4700);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E9', 'S4', N'Nour Al-Din', '2022-09-20', 'ET5', '0510001122', 'nour.al-din@example.com', 3900);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E10', 'S5', N'Ranya Saleh', '2021-12-05', 'ET6', '0511112233', 'ranya.saleh@example.com', 3400);
INSERT INTO employees (employee_id, sector_id, employee_name, hire_date, employee_type_id, phone_number, email, salary) VALUES ('E11', 'S6', N'Omar Hadi', '2023-03-15', 'ET7', '0512223344', 'omar.hadi@example.com', 3000);

select * from employees




--seedlings 

--Vegetables
INSERT INTO seedlings (seedling_id, type_id, seedling_name, barcode, birth_date, sale_date, disposal_date, purchase_price, sale_price, grafted, graft_type_id, grafting_date, count, status, image_url, sector_id, seedling_imported_country) 
VALUES 
('to1', 'to', 'Cherry Tomatoes', '1234560000', '2022-05-01', '2022-09-01', NULL, 0.40, 1.10, 'no', NULL, NULL, 250, 'available', NULL, 'S1', 'Egypt'),
('to2', 'to', 'Roma Tomatoes', '1234560001', '2022-05-15', '2022-09-15', NULL, 0.50, 1.20, 'yes', 'G1', '2022-06-01', 230, 'available', NULL, 'S1', 'Morocco'),
('to3', 'to', 'Big Boy Tomatoes', '1234560002', '2022-06-01', '2022-10-01', NULL, 0.55, 1.25, 'no', NULL, NULL, 280, 'available', NULL, 'S1', 'UAE'),
('to4', 'to', 'Brandywine Tomatoes', '1234560003', '2022-06-15', '2022-10-15', NULL, 0.65, 1.35, 'yes', 'G2', '2022-07-01', 260, 'available', NULL, 'S1', 'Saudi Arabia'),
('to5', 'to', 'San Marzano Tomatoes', '1234560004', '2022-07-01', '2022-11-01', NULL, 0.70, 1.50, 'no', NULL, NULL, 300, 'available', NULL, 'S1', 'Jordan'),
('to6', 'to', 'Big Mama Tomatoes', '1234560005', '2022-07-15', '2022-11-15', NULL, 0.75, 1.60, 'yes', 'G1', '2022-08-01', 290, 'available', NULL, 'S1', 'Local'),

('cu1', 'cu', 'Persian Cucumbers', '1234560006', '2023-01-15', '2023-06-15', NULL, 0.30, 0.80, 'no', NULL, NULL, 150, 'available', NULL, 'S1', 'Lebanon'),
('cu2', 'cu', 'Lemon Cucumbers', '1234560007', '2023-02-01', '2023-07-01', NULL, 0.35, 0.90, 'yes', 'G2', '2023-03-01', 160, 'available', NULL, 'S1', 'Local'),
('cu3', 'cu', 'Japanese Cucumbers', '1234560008', '2023-02-15', '2023-07-15', NULL, 0.40, 1.00, 'no', NULL, NULL, 170, 'available', NULL, 'S1', 'Iraq'),
('cu4', 'cu', 'Armenian Cucumbers', '1234560009', '2023-03-01', '2023-08-01', NULL, 0.45, 1.10, 'yes', 'G3', '2023-04-01', 180, 'available', NULL, 'S1', 'Oman'),
('cu5', 'cu', 'Suyo Long Cucumbers', '1234560010', '2023-03-15', '2023-08-15', NULL, 0.50, 1.20, 'no', NULL, NULL, 190, 'available', NULL, 'S1', 'Kuwait'),
('cu6', 'cu', 'Kirby Cucumbers', '1234560011', '2023-04-01', '2023-09-01', NULL, 0.55, 1.30, 'yes', 'G2', '2023-05-01', 200, 'available', NULL, 'S1', 'Bahrain'),

('po1', 'po', 'Russet Potatoes', '1234560012', '2022-11-10', '2023-04-10', NULL, 0.60, 1.50, 'no', NULL, NULL, 140, 'available', NULL, 'S1', 'Sudan'),
('po2', 'po', 'Fingerling Potatoes', '1234560013', '2022-12-15', '2023-05-15', NULL, 0.65, 1.60, 'yes', 'G3', '2023-01-15', 130, 'available', NULL, 'S1', 'Libya'),
('po3', 'po', 'White Potatoes', '1234560014', '2023-01-05', '2023-06-05', NULL, 0.70, 1.70, 'no', NULL, NULL, 120, 'available', NULL, 'S1', 'Qatar'),
('po4', 'po', 'Kennebec Potatoes', '1234560015', '2023-02-10', '2023-07-10', NULL, 0.75, 1.80, 'yes', 'G4', '2023-03-10', 110, 'available', NULL, 'S1', 'Tunisia'),
('po5', 'po', 'Baby Potatoes', '1234560016', '2023-03-15', '2023-08-15', NULL, 0.80, 1.90, 'no', NULL, NULL, 100, 'available', NULL, 'S1', 'Algeria'),
('po6', 'po', 'Purple Potatoes', '1234560017', '2023-04-20', '2023-09-20', NULL, 0.85, 2.00, 'yes', 'G3', '2023-05-20', 90, 'available', NULL, 'S1', 'Yemen'),

('pe1', 'pe', 'Poblano Peppers', '1234560018', '2022-10-15', '2023-03-15', NULL, 0.50, 1.40, 'no', NULL, NULL, 130, 'available', NULL, 'S1', 'Jordan'),
('pe2', 'pe', 'Ancho Peppers', '1234560019', '2022-11-20', '2023-04-20', NULL, 0.55, 1.50, 'yes', 'G4', '2022-12-20', 120, 'available', NULL, 'S1', 'Morocco'),
('pe3', 'pe', 'Ghost Peppers', '1234560020', '2022-12-25', '2023-05-25', NULL, 0.60, 1.60, 'no', NULL, NULL, 110, 'available', NULL, 'S1', 'Egypt'),
('pe4', 'pe', 'Cayenne Peppers', '1234560021', '2023-01-30', '2023-06-30', NULL, 0.65, 1.70, 'yes', 'G5', '2023-02-28', 140, 'available', NULL, 'S1', 'UAE'),
('pe5', 'pe', 'Serrano Peppers', '1234560022', '2023-02-15', '2023-07-15', NULL, 0.70, 1.80, 'no', NULL, NULL, 150, 'available', NULL, 'S1', 'Saudi Arabia'),
('pe6', 'pe', 'Banana Peppers', '1234560023', '2023-03-20', '2023-08-20', NULL, 0.75, 1.90, 'yes', 'G4', '2023-04-20', 160, 'available', NULL, 'S1', 'Qatar'),

('ca1', 'ca', 'Nantes Carrots', '1234560024', '2022-09-20', '2023-02-20', NULL, 0.40, 1.30, 'no', NULL, NULL, 110, 'available', NULL, 'S1', 'Lebanon'),
('ca2', 'ca', 'Chantenay Carrots', '1234560025', '2022-10-25', '2023-03-25', NULL, 0.45, 1.40, 'yes', 'G5', '2022-11-25', 120, 'available', NULL, 'S1', 'Oman'),
('ca3', 'ca', 'Imperator Carrots', '1234560026', '2022-11-30', '2023-04-30', NULL, 0.50, 1.50, 'no', NULL, NULL, 130, 'available', NULL, 'S1', 'Bahrain'),
('ca4', 'ca', 'Parisian Carrots', '1234560027', '2023-01-05', '2023-06-05', NULL, 0.55, 1.60, 'yes', 'G5', '2023-02-05', 140, 'available', NULL, 'S1', 'Local'),
('ca5', 'ca', 'Dragon Carrots', '1234560028', '2023-02-10', '2023-07-10', NULL, 0.60, 1.70, 'no', NULL, NULL, 150, 'available', NULL, 'S1', 'Iraq'),
('ca6', 'ca', 'Amarillo Carrots', '1234560029', '2023-03-15', '2023-08-15', NULL, 0.65, 1.80, 'yes', 'G4', '2023-04-15', 160, 'available', NULL, 'S1', 'Palestine'),

('eg1', 'eg', 'Chinese Eggplant', '1234560030', '2022-08-15', '2023-01-15', NULL, 0.80, 2.00, 'no', NULL, NULL, 120, 'available', NULL, 'S1', 'Saudi Arabia'),
('eg2', 'eg', 'White Eggplant', '1234560031', '2022-09-20', '2023-02-20', NULL, 0.85, 2.10, 'yes', 'G1', '2022-10-20', 130, 'available', NULL, 'S1', 'Egypt'),
('eg3', 'eg', 'Turkish Eggplant', '1234560032', '2022-10-25', '2023-03-25', NULL, 0.90, 2.20, 'no', NULL, NULL, 140, 'available', NULL, 'S1', 'Jordan'),
('eg4', 'eg', 'Zingy Eggplant', '1234560033', '2022-11-30', '2023-04-30', NULL, 0.95, 2.30, 'yes', 'G5', '2023-02-15', 150, 'available', NULL, 'S1', 'Morocco'),
('eg5', 'eg', 'Purple Eggplant', '1234560034', '2023-01-05', '2023-05-05', NULL, 1.00, 2.40, 'no', NULL, NULL, 160, 'available', NULL, 'S1', 'Algeria'),
('eg6', 'eg', 'Baby Eggplant', '1234569055', '2023-02-10', '2023-06-10', NULL, 1.05, 2.50, 'yes', 'G4', '2023-04-20', 170, 'available', NULL, 'S1', 'Tunisia'),

('sp1', 'sp', 'Savoy Spinach', '1234560035', '2022-06-01', '2022-12-01', NULL, 0.70, 1.80, 'no', NULL, NULL, 140, 'available', NULL, 'S1', 'Lebanon'),
('sp2', 'sp', 'Flat-Leaf Spinach', '1234560036', '2022-07-15', '2023-01-15', NULL, 0.75, 1.90, 'yes', 'G3', '2022-08-15', 150, 'available', NULL, 'S1', 'Egypt'),
('sp3', 'sp', 'Semi-Savoy Spinach', '1234560037', '2022-08-20', '2023-02-20', NULL, 0.80, 2.00, 'no', NULL, NULL, 160, 'available', NULL, 'S1', 'Jordan'),
('sp4', 'sp', 'New Zealand Spinach', '1234560038', '2022-09-25', '2023-03-25', NULL, 0.85, 2.10, 'yes', 'G2', '2022-10-25', 170, 'available', NULL, 'S1', 'Saudi Arabia'),
('sp5', 'sp', 'Korean Spinach', '1234560039', '2022-10-30', '2023-04-30', NULL, 0.90, 2.20, 'no', NULL, NULL, 180, 'available', NULL, 'S1', 'UAE'),
('sp6', 'sp', 'Winter Spinach', '1234560040', '2023-01-10', '2023-05-10', NULL, 0.95, 2.30, 'yes', 'G3', '2023-02-10', 190, 'available', NULL, 'S1', 'Qatar'),

('on1', 'on', 'Yellow Onions', '1234560041', '2022-03-01', '2022-09-01', NULL, 0.60, 1.50, 'no', NULL, NULL, 200, 'available', NULL, 'S1', 'Iraq'),
('on2', 'on', 'White Onions', '1234560042', '2022-04-10', '2022-10-10', NULL, 0.65, 1.60, 'yes', 'G4', '2022-05-10', 210, 'available', NULL, 'S1', 'Saudi Arabia'),
('on3', 'on', 'Red Onions', '1234560043', '2022-05-15', '2022-11-15', NULL, 0.70, 1.70, 'no', NULL, NULL, 220, 'available', NULL, 'S1', 'Egypt'),
('on4', 'on', 'Green Onions', '1234560044', '2022-06-20', '2022-12-20', NULL, 0.75, 1.80, 'yes', 'G2', '2022-07-20', 230, 'available', NULL, 'S1', 'Jordan'),
('on5', 'on', 'Sweet Onions', '1234560045', '2022-07-25', '2023-01-25', NULL, 0.80, 1.90, 'no', NULL, NULL, 240, 'available', NULL, 'S1', 'Tunisia'),
('on6', 'on', 'Dry Onions', '1234560046', '2022-08-30', '2023-02-28', NULL, 0.85, 2.00, 'yes', 'G3', '2022-09-30', 250, 'available', NULL, 'S1', 'Morocco'),

('zu1', 'zu', 'Green Zucchini', '1234560047', '2023-03-01', '2023-09-01', NULL, 1.00, 2.50, 'no', NULL, NULL, 150, 'available', NULL, 'S1', 'Egypt'),
('zu2', 'zu', 'Yellow Zucchini', '1234560048', '2023-04-10', '2023-10-10', NULL, 1.10, 2.60, 'yes', 'G2', '2023-05-10', 160, 'available', NULL, 'S1', 'Saudi Arabia'),
('zu3', 'zu', 'Crookneck Squash', '1234560049', '2023-05-15', '2023-11-15', NULL, 1.20, 2.70, 'no', NULL, NULL, 170, 'available', NULL, 'S1', 'Jordan'),
('zu4', 'zu', 'Pattypan Squash', '1234560050', '2023-06-20', '2023-12-20', NULL, 1.30, 2.80, 'yes', 'G5', '2023-07-20', 180, 'available', NULL, 'S1', 'Morocco'),
('zu5', 'zu', 'Round Zucchini', '1234560051', '2023-07-25', '2024-01-25', NULL, 1.40, 2.90, 'no', NULL, NULL, 190, 'available', NULL, 'S1', 'Tunisia'),
('zu6', 'zu', 'Persian Zucchini', '1234560052', '2023-08-30', '2024-02-28', NULL, 1.50, 3.00, 'yes', 'G4', '2023-09-30', 200, 'available', NULL, 'S1', 'Iraq'),

('cab1', 'cab', 'Green Cabbage', '1234560053', '2023-03-01', '2023-09-01', NULL, 1.00, 2.50, 'no', NULL, NULL, 150, 'available', NULL, 'S1', 'Egypt'),
('cab2', 'cab', 'Red Cabbage', '1234560054', '2023-04-10', '2023-10-10', NULL, 1.10, 2.60, 'yes', 'G5', '2023-05-10', 160, 'available', NULL, 'S1', 'Saudi Arabia'),
('cab3', 'cab', 'Napa Cabbage', '1234560055', '2023-05-15', '2023-11-15', NULL, 1.20, 2.70, 'no', NULL, NULL, 170, 'available', NULL, 'S1', 'Jordan'),
('cab4', 'cab', 'Savoy Cabbage', '1234560056', '2023-06-20', '2023-12-20', NULL, 1.30, 2.80, 'yes', 'G2', '2023-07-20', 180, 'available', NULL, 'S1', 'Morocco'),
('cab5', 'cab', 'Collard Greens', '1234560057', '2023-07-25', '2024-01-25', NULL, 1.40, 2.90, 'no', NULL, NULL, 190, 'available', NULL, 'S1', 'Tunisia'),
('cab6', 'cab', 'Savory Cabbage', '1234560058', '2023-08-30', '2024-02-28', NULL, 1.50, 3.00, 'yes', 'G4', '2023-09-30', 200, 'available', NULL, 'S1', 'Iraq'),

--Fruits
('sr1', 'sr', 'Cherokee Strawberry', '1234560059', '2023-03-10', '2023-09-10', NULL, 1.00, 2.50, 'no', NULL, NULL, 100, 'available', NULL, 'S2', 'Egypt'),
('sr2', 'sr', 'Albion Strawberry', '1234560060', '2023-04-12', '2023-10-12', NULL, 1.10, 2.60, 'yes', 'G1', '2023-05-12', 110, 'available', NULL, 'S2', 'United Arab Emirates'),
('sr3', 'sr', 'Cascadia Strawberry', '1234560061', '2023-05-15', '2023-11-15', NULL, 1.20, 2.70, 'no', NULL, NULL, 120, 'available', NULL, 'S2', 'Jordan'),
('sr4', 'sr', 'Aroma Strawberry', '1234560062', '2023-06-18', '2023-12-18', NULL, 1.30, 2.80, 'yes', 'G2', '2023-07-18', 130, 'available', NULL, 'S2', 'Kuwait'),
('sr5', 'sr', 'SanAndreasStrawberry', '1234560063', '2023-07-20', '2024-01-20', NULL, 1.40, 2.90, 'no', NULL, NULL, 140, 'available', NULL, 'S2', 'Morocco'),
('sr6', 'sr', 'Beverly Strawberry', '1234560064', '2023-08-30', '2024-02-28', NULL, 1.50, 3.00, 'yes', 'G1', '2023-09-30', 150, 'available', NULL, 'S2', 'Lebanon'),

('gr1', 'gr', 'Table Grapes', '1234561001', '2023-03-01', '2023-09-01', NULL, 1.50, 3.50, 'no', NULL, NULL, 100, 'available', NULL, 'S2', 'USA'),
('gr2', 'gr', 'Wine Grapes', '1234561002', '2023-04-05', '2023-10-05', NULL, 1.60, 3.80, 'yes', 'G2', '2023-05-05', 150, 'available', NULL, 'S2', 'Italy'),
('gr3', 'gr', 'Zinfandel Grapes', '1234561003', '2023-05-10', '2023-11-10', NULL, 1.70, 4.00, 'no', NULL, NULL, 120, 'available', NULL, 'S2', 'California'),
('gr4', 'gr', 'Chardonnay Grapes', '1234561004', '2023-06-15', '2023-12-15', NULL, 1.80, 4.20, 'yes', 'G3', '2023-07-15', 130, 'available', NULL, 'S2', 'France'),
('gr5', 'gr', 'Sultana Grapes', '1234561005', '2023-07-20', '2024-01-20', NULL, 1.90, 4.50, 'no', NULL, NULL, 140, 'available', NULL, 'S2', 'Turkey'),
('gr6', 'gr', 'Muscat Grapes', '1234561006', '2023-08-25', '2024-02-25', NULL, 2.00, 5.00, 'yes', 'G2', '2023-09-25', 160, 'available', NULL, 'S2', 'Egypt'),

('ap1', 'ap', 'Sunsugar Apple', '1234561007', '2023-01-01', '2023-07-01', NULL, 1.00, 2.50, 'no', NULL, NULL, 100, 'available', NULL, 'S2', 'Egypt'),
('ap2', 'ap', 'Ambrosia Apple', '1234561008', '2023-02-05', '2023-08-05', NULL, 1.10, 2.80, 'yes', 'G3', '2023-03-05', 120, 'available', NULL, 'S2', 'Saudi Arabia'),
('ap3', 'ap', 'Braeburn Apple', '1234561009', '2023-03-10', '2023-09-10', NULL, 1.20, 3.00, 'no', NULL, NULL, 110, 'available', NULL, 'S2', 'UAE'),
('ap4', 'ap', 'McIntosh Apple', '1234561010', '2023-04-15', '2023-10-15', NULL, 1.30, 3.20, 'yes', 'G4', '2023-05-15', 130, 'available', NULL, 'S2', 'Jordan'),
('ap5', 'ap', 'Fuji Apple', '1234561011', '2023-05-20', '2023-11-20', NULL, 1.40, 3.50, 'no', NULL, NULL, 140, 'available', NULL, 'S2', 'Morocco'),
('ap6', 'ap', 'Honeycrisp Apple', '1234561012', '2023-06-25', '2023-12-25', NULL, 1.50, 3.80, 'yes', 'G3', '2023-07-25', 150, 'available', NULL, 'S2', 'Kuwait'),

('ba1', 'ba', 'Cavendish Banana', '1234561013', '2023-01-01', '2023-07-01', NULL, 0.50, 1.20, 'no', NULL, NULL, 150, 'available', NULL, 'S2', 'Ecuador'),
('ba2', 'ba', 'Plantain Banana', '1234561014', '2023-02-05', '2023-08-05', NULL, 0.55, 1.30, 'yes', 'G4', '2023-03-05', 160, 'available', NULL, 'S2', 'Philippines'),
('ba3', 'ba', 'Apple Banana', '1234561015', '2023-03-10', '2023-09-10', NULL, 0.60, 1.50, 'no', NULL, NULL, 170, 'available', NULL, 'S2', 'Costa Rica'),
('ba4', 'ba', 'Burro Banana', '1234561016', '2023-04-15', '2023-10-15', NULL, 0.65, 1.70, 'yes', 'G5', '2023-05-15', 180, 'available', NULL, 'S2', 'Colombia'),
('ba5', 'ba', 'Goldfinger Banana', '1234561017', '2023-05-20', '2023-11-20', NULL, 0.70, 1.80, 'no', NULL, NULL, 190, 'available', NULL, 'S2', 'Dominican Republic'),
('ba6', 'ba', 'Manzano Banana', '1234561018', '2023-06-25', '2023-12-25', NULL, 0.75, 2.00, 'yes', 'G4', '2023-07-25', 200, 'available', NULL, 'S2', 'Honduras'),

('av1', 'av', 'Hass Avocado', '1234561019', '2023-01-01', NULL, NULL, 1.00, 2.50, 'no', NULL, NULL, 100, 'available', NULL, 'S2', 'local'),
('av2', 'av', 'Fuerte Avocado', '1234561020', '2023-02-05', NULL, NULL, 1.10, 2.80, 'yes', 'G5', '2023-03-05', 120, 'available', NULL, 'S2', 'France'),
('av3', 'av', 'Bacon Avocado', '1234561021', '2023-03-10', NULL, NULL, 1.20, 3.00, 'no', NULL, NULL, 140, 'available', NULL, 'S2', 'Spain'),
('av4', 'av', 'Zutano Avocado', '1234561022', '2023-04-15', NULL, NULL, 1.30, 3.20, 'yes', 'G3', '2023-05-15', 160, 'available', NULL, 'S2', 'local'),
('av5', 'av', 'Reed Avocado', '1234561023', '2023-05-20', NULL, NULL, 1.40, 3.50, 'no', NULL, NULL, 180, 'available', NULL, 'S2', 'Tunisia'),
('av6', 'av', 'Gwen Avocado', '1234561024', '2023-06-25', NULL, NULL, 1.50, 3.80, 'yes', 'G4', '2023-07-25', 200, 'available', NULL, 'S2', 'Jordan'),

('pom1', 'pom', 'Kazake Pomegranate', '1234561025', '2023-01-10', '2023-07-10', NULL, 1.00, 2.50, 'yes', 'G1', '2023-02-10', 150, 'available', NULL, 'S2', 'Turkey'),
('pom2', 'pom', 'Hersk Pomegranate', '1234561026', '2023-02-15', '2023-08-15', NULL, 1.10, 2.60, 'no', NULL, NULL, 160, 'available', NULL, 'S2', 'USA'),
('pom3', 'pom', 'Angeleno Pomegranate', '1234561027', '2023-03-20', '2023-09-20', NULL, 1.20, 2.70, 'yes', 'G2', '2023-03-15', 170, 'available', NULL, 'S2', 'Iran'),
('pom4', 'pom', 'Parfianka Pomegranate', '123451028', '2023-04-25', '2023-10-25', NULL, 1.30, 2.80, 'no', NULL, NULL, 180, 'available', NULL, 'S2', 'Local'),
('pom5', 'pom', 'Gandia Pomegranate', '1234561029', '2023-05-30', '2023-11-30', NULL, 1.40, 2.90, 'yes', 'G1', '2023-04-20', 190, 'available', NULL, 'S2', 'Egypt'),
('pom6', 'pom', 'Black Pomegranate', '1234561030', '2023-06-05', '2023-12-05', NULL, 1.50, 3.00, 'no', NULL, NULL, 200, 'available', NULL, 'S2', 'Spain'),

('fi1', 'fi', 'Brown Turkey Fig', '1234561031', '2023-01-05', '2023-07-05', NULL, 1.20, 3.00, 'yes', 'G1', '2023-02-05', 150, 'available', NULL, 'S2', 'Turkey'),
('fi2', 'fi', 'Kadota Fig', '1234561032', '2023-02-10', '2023-08-10', NULL, 1.30, 3.20, 'no', NULL, NULL, 160, 'available', NULL, 'S2', 'USA'),
('fi3', 'fi', 'Calimyrna Fig', '1234561033', '2023-03-15', '2023-09-15', NULL, 1.40, 3.50, 'yes', 'G2', '2023-03-10', 170, 'available', NULL, 'S2', 'Iran'),
('fi4', 'fi', 'Sierra Fig', '1234561034', '2023-04-20', '2023-10-20', NULL, 1.50, 3.70, 'no', NULL, NULL, 180, 'available', NULL, 'S2', 'Local'),
('fi5', 'fi', 'Alma Fig', '1234561035', '2023-05-25', '2023-11-25', NULL, 1.60, 4.00, 'yes', 'G1', '2023-04-15', 190, 'available', NULL, 'S2', 'Egypt'),
('fi6', 'fi', 'Smyrna Fig', '1234561036', '2023-06-30', '2023-12-30', NULL, 1.70, 4.20, 'no', NULL, NULL, 200, 'available', NULL, 'S2', 'Spain'),

('pea1', 'pea', 'Redhaven Peach', '1234561037', '2023-01-10', '2023-07-10', NULL, 1.50, 3.50, 'yes', 'G5', '2023-02-10', 120, 'available', NULL, 'S2', 'USA'),
('pea2', 'pea', 'Glohaven Peach', '1234561038', '2023-02-15', '2023-08-15', NULL, 1.60, 3.80, 'no', NULL, NULL, 130, 'available', NULL, 'S2', 'Chile'),
('pea3', 'pea', 'Climax Peach', '1234561039', '2023-03-20', '2023-09-20', NULL, 1.70, 4.00, 'yes', 'G4', '2023-03-15', 140, 'available', NULL, 'S2', 'South Africa'),
('pea4', 'pea', 'Donut Peach', '1234561040', '2023-04-25', '2023-10-25', NULL, 1.80, 4.20, 'no', NULL, NULL, 150, 'available', NULL, 'S2', 'Local'),
('pea5', 'pea', 'Fayette Peach', '1234561041', '2023-05-30', '2023-11-30', NULL, 1.90, 4.50, 'yes', 'G5', '2023-04-20', 160, 'available', NULL, 'S2', 'Spain'),
('pea6', 'pea', 'Crimson Snow Peach', '1234561042', '2023-06-15', '2023-12-15', NULL, 2.00, 4.70, 'no', NULL, NULL, 170, 'available', NULL, 'S2', 'Italy'),

('or1', 'or', 'Valencia Orange', '1234561043', '2023-01-05', '2023-07-05', NULL, 1.20, 2.50, 'no', NULL, NULL, 150, 'available', NULL, 'S2', 'Spain'),
('or2', 'or', 'Blood Orange', '1234561044', '2023-02-10', '2023-08-10', NULL, 1.30, 2.80, 'yes', 'G3', '2023-03-15', 160, 'available', NULL, 'S2', 'Italy'),
('or3', 'or', 'Seville Orange', '1234561045', '2023-03-15', '2023-09-15', NULL, 1.40, 3.00, 'no', NULL, NULL, 170, 'available', NULL, 'S2', 'USA'),
('or4', 'or', 'Cara Cara Orange', '1234561046', '2023-04-20', '2023-10-20', NULL, 1.50, 3.20, 'yes', 'G1', '2023-04-25', 180, 'available', NULL, 'S2', 'Local'),
('or5', 'or', 'Washington Navel Orange', '1234561047', '2023-05-25', '2023-11-25', NULL, 1.60, 3.50, 'no', NULL, NULL, 190, 'available', NULL, 'S2', 'Brazil'),
('or6', 'or', 'Bergamot Orange', '1234561048', '2023-06-30', '2023-12-30', NULL, 1.70, 3.70, 'yes', 'G4', '2023-05-15', 200, 'available', NULL, 'S2', 'Egypt'),

('le1', 'le', 'Eureka Lemon', '1234561049', '2023-01-10', '2023-07-10', NULL, 0.80, 2.00, 'no', NULL, NULL, 150, 'available', NULL, 'S2', 'USA'),
('le2', 'le', 'Lisbon Lemon', '1234561050', '2023-02-15', '2023-08-15', NULL, 0.85, 2.20, 'yes', 'G2', '2023-03-20', 160, 'available', NULL, 'S2', 'Spain'),
('le3', 'le', 'Meyer Lemon', '1234561051', '2023-03-20', '2023-09-20', NULL, 0.90, 2.50, 'no', NULL, NULL, 170, 'available', NULL, 'S2', 'China'),
('le4', 'le', 'Verna Lemon', '1234561052', '2023-04-25', '2023-10-25', NULL, 0.95, 2.80, 'yes', 'G5', '2023-04-30', 180, 'available', NULL, 'S2', 'Local'),
('le5', 'le', 'Villafranca Lemon', '1234561053', '2023-05-30', '2023-11-30', NULL, 1.00, 3.00, 'no', NULL, NULL, 190, 'available', NULL, 'S2', 'Italy'),
('le6', 'le', 'Limetta Lemon', '1234561054', '2023-06-15', '2023-12-15', NULL, 1.05, 3.20, 'yes', 'G4', '2023-06-20', 200, 'available', NULL, 'S2', 'Mexico'),

--Trees	
('ot1', 'ot', 'Picual Olive', '1234562000', '2023-01-05', '2023-07-05', NULL, 1.20, 2.50, 'no', NULL, NULL, 100, 'available', NULL, 'S3', 'Spain'),
('ot2', 'ot', 'Coratina Olive', '1234562001', '2023-02-10', '2023-08-10', NULL, 1.30, 2.80, 'yes', 'G1', '2023-03-15', 120, 'available', NULL, 'S3', 'Italy'),
('ot3', 'ot', 'Arbequina Olive', '1234562002', '2023-03-15', '2023-09-15', NULL, 1.40, 3.00, 'no', NULL, NULL, 130, 'available', NULL, 'S3', 'Portugal'),
('ot4', 'ot', 'Frantoio Olive', '1234562003', '2023-04-20', '2023-10-20', NULL, 1.50, 3.20, 'yes', 'G2', '2023-04-25', 140, 'available', NULL, 'S3', 'Local'),
('ot5', 'ot', 'Manzanilla Olive', '1234562004', '2023-05-25', '2023-11-25', NULL, 1.60, 3.50, 'no', NULL, NULL, 150, 'available', NULL, 'S3', 'Tunisia'),
('ot6', 'ot', 'Leccino Olive', '1234562005', '2023-06-30', '2023-12-30', NULL, 1.70, 3.80, 'yes', 'G1', '2023-07-05', 160, 'available', NULL, 'S3', 'Greece'),

('pt1', 'pt', 'Medjool Date Palm', '1234562006', '2023-01-10', '2023-07-10', NULL, 2.00, 4.50, 'no', NULL, NULL, 80, 'available', NULL, 'S3', 'Morocco'),
('pt2', 'pt', 'Deglet Noor Date Palm', '1234562007', '2023-02-15', '2023-08-15', NULL, 2.10, 4.70, 'yes', 'G5', '2023-03-20', 90, 'available', NULL, 'S3', 'Tunisia'),
('pt3', 'pt', 'Barhi Date Palm', '1234562008', '2023-03-20', '2023-09-20', NULL, 2.20, 4.90, 'no', NULL, NULL, 100, 'available', NULL, 'S3', 'Saudi Arabia'),
('pt4', 'pt', 'Khalas Date Palm', '1234562009', '2023-04-25', '2023-10-25', NULL, 2.30, 5.00, 'yes', 'G4', '2023-05-30', 110, 'available', NULL, 'S3', 'UAE'),
('pt5', 'pt', 'Sukkary Date Palm', '1234562010', '2023-05-30', '2023-11-30', NULL, 2.40, 5.20, 'no', NULL, NULL, 120, 'available', NULL, 'S3', 'Egypt'),
('pt6', 'pt', 'Zahidi Date Palm', '1234562011', '2023-06-15', '2023-12-15', NULL, 2.50, 5.50, 'yes', 'G3', '2023-07-20', 130, 'available', NULL, 'S3', 'Algeria'),

('pit1', 'pit', 'Pinus Brutia', '1234562012', '2023-01-12', '2023-07-12', NULL, 1.00, 2.50, 'no', NULL, NULL, 50, 'available', NULL, 'S3', 'Turkey'),
('pit2', 'pit', 'Stone Pine', '1234562013', '2023-02-20', '2023-08-20', NULL, 1.10, 2.70, 'yes', 'G2', '2023-03-25', 60, 'available', NULL, 'S3', 'Italy'),
('pit3', 'pit', 'Monterey Pine', '1234562014', '2023-03-15', '2023-09-15', NULL, 1.20, 2.90, 'no', NULL, NULL, 70, 'available', NULL, 'S3', 'USA'),
('pit4', 'pit', 'Japanese Black Pine', '1234562015', '2023-04-10', '2023-10-10', NULL, 1.30, 3.00, 'yes', 'G1', '2023-05-15', 80, 'available', NULL, 'S3', 'Japan'),
('pit5', 'pit', 'Corsican Pine', '1234562016', '2023-05-05', '2023-11-05', NULL, 1.40, 3.20, 'no', NULL, NULL, 90, 'available', NULL, 'S3', 'France'),
('pit6', 'pit', 'Eastern White Pine', '1234562017', '2023-06-12', '2023-12-12', NULL, 1.50, 3.50, 'yes', 'G3', '2023-07-20', 100, 'available', NULL, 'S3', 'Canada'),

('ct1', 'ct', 'Italian Cypress', '1334562018', '2023-01-15', '2023-07-15', NULL, 1.60, 3.80, 'no', NULL, NULL, 40, 'available', NULL, 'S3', 'Italy'),
('ct2', 'ct', 'Cypress of Sylvester', '1334562019', '2023-02-18', '2023-08-18', NULL, 1.70, 4.00, 'yes', 'G4', '2023-03-20', 50, 'available', NULL, 'S3', 'Spain'),
('ct3', 'ct', 'Himalayan Cypress', '1334562020', '2023-03-22', '2023-09-22', NULL, 1.80, 4.20, 'no', NULL, NULL, 60, 'available', NULL, 'S3', 'Nepal'),
('ct4', 'ct', 'Arborvitae', '1334562021', '2023-04-10', '2023-10-10', NULL, 1.90, 4.50, 'yes', 'G5', '2023-05-25', 70, 'available', NULL, 'S3', 'USA'),
('ct5', 'ct', 'Spanish Cypress', '1334562022', '2023-05-12', '2023-11-12', NULL, 2.00, 4.80, 'no', NULL, NULL, 80, 'available', NULL, 'S3', 'Spain'),
('ct6', 'ct', 'Cypress', '1334562023', '2023-06-05', '2023-12-05', NULL, 2.10, 5.00, 'yes', 'G2', '2023-07-30', 90, 'available', NULL, 'S3', 'Greece'),

('mt1', 'mt', 'White Mulberry', '2234562024', '2023-01-20', '2023-07-20', NULL, 1.50, 3.00, 'no', NULL, NULL, 40, 'available', NULL, 'S3', 'China'),
('mt2', 'mt', 'Black Mulberry', '2234562025', '2023-02-15', '2023-08-15', NULL, 1.60, 3.20, 'yes', 'G1', '2023-03-15', 50, 'available', NULL, 'S3', 'Turkey'),
('mt3', 'mt', 'Red Mulberry', '2234562026', '2023-03-10', '2023-09-10', NULL, 1.70, 3.50, 'no', NULL, NULL, 60, 'available', NULL, 'S3', 'USA'),
('mt4', 'mt', 'Dwarf Mulberry', '2234562027', '2023-04-05', '2023-10-05', NULL, 1.80, 3.70, 'yes', 'G2', '2023-05-20', 70, 'available', NULL, 'S3', 'India'),
('mt5', 'mt', 'Kashmiri Mulberry', '2234562028', '2023-05-12', '2023-11-12', NULL, 1.90, 4.00, 'no', NULL, NULL, 80, 'available', NULL, 'S3', 'Kashmir'),
('mt6', 'mt', 'American Mulberry', '2234562029', '2023-06-01', '2023-12-01', NULL, 2.00, 4.20, 'yes', 'G3', '2023-07-15', 90, 'available', NULL, 'S3', 'USA'),

('wt1', 'wt', 'American Walnut', '1234562030', '2023-01-10', '2023-07-10', NULL, 2.50, 5.00, 'no', NULL, NULL, 40, 'available', NULL, 'S3', 'USA'),
('wt2', 'wt', 'English Walnut', '1234562031', '2023-02-14', '2023-08-14', NULL, 2.60, 5.20, 'yes', 'G4', '2023-03-20', 50, 'available', NULL, 'S3', 'UK'),
('wt3', 'wt', 'Indian Walnut', '1234562032', '2023-03-05', '2023-09-05', NULL, 2.70, 5.50, 'no', NULL, NULL, 60, 'available', NULL, 'S3', 'India'),
('wt4', 'wt', 'Australian Walnut', '1234562033', '2023-04-20', '2023-10-20', NULL, 2.80, 5.80, 'yes', 'G5', '2023-05-25', 70, 'available', NULL, 'S3', 'Australia'),
('wt5', 'wt', 'Chinese Walnut', '1234562034', '2023-05-30', '2023-11-30', NULL, 2.90, 6.00, 'no', NULL, NULL, 80, 'available', NULL, 'S3', 'China'),
('wt6', 'wt', 'Black Walnut', '1234562035', '2023-06-15', '2023-12-15', NULL, 3.00, 6.20, 'yes', 'G1', '2023-07-30', 90, 'available', NULL, 'S3', 'USA'),

('att1', 'at', 'Sweet Almond', '1234562036', '2023-01-10', '2023-07-10', NULL, 3.50, 7.00, 'yes', 'G1', '2023-03-01', 100, 'available', NULL, 'S3', 'USA'),
('att2', 'at', 'Bitter Almond', '1234562037', '2023-02-14', '2023-08-14', NULL, 3.70, 7.50, 'no', NULL, NULL, 120, 'available', NULL, 'S3', 'Spain'),
('att3', 'at', 'Nonpareil Almond', '1234562038', '2023-03-05', '2023-09-05', NULL, 3.80, 7.80, 'yes', 'G2', '2023-05-15', 130, 'available', NULL, 'S3', 'USA'),
('att4', 'at', 'Tuono Almond', '1234562039', '2023-04-20', '2023-10-20', NULL, 3.90, 8.00, 'no', NULL, NULL, 140, 'available', NULL, 'S3', 'Italy'),
('att5', 'at', 'Blond Almond', '1234562040', '2023-05-30', '2023-11-30', NULL, 4.00, 8.20, 'yes', 'G1', '2023-06-30', 150, 'available', NULL, 'S3', 'France'),
('att6', 'at', 'Spanish Almond', '1234562041', '2023-06-15', '2023-12-15', NULL, 4.10, 8.50, 'no', NULL, NULL, 160, 'available', NULL, 'S3', 'Spain'),

--Flowers and Ornamental Plants	
('ro1', 'ro', 'Grandiflora Rose', '1234563000', '2023-01-05', '2023-07-05', NULL, 2.00, 5.00, 'no', NULL, NULL, 80, 'available', NULL, 'S4', 'USA'),
('ro2', 'ro', 'Polyantha Rose', '1234563001', '2023-02-10', '2023-08-10', NULL, 2.20, 5.50, 'yes', 'G1', '2023-03-01', 90, 'available', NULL, 'S4', 'France'),
('ro3', 'ro', 'Climbing Rose', '1234563002', '2023-03-15', '2023-09-15', NULL, 2.50, 6.00, 'no', NULL, NULL, 70, 'available', NULL, 'S4', 'Italy'),
('ro4', 'ro', 'Miniature Rose', '1234563003', '2023-04-20', '2023-10-20', NULL, 1.80, 4.50, 'yes', 'G2', '2023-05-15', 100, 'available', NULL, 'S4', 'Spain'),
('ro5', 'ro', 'Damask Rose', '1234563004', '2023-05-25', '2023-11-25', NULL, 2.30, 5.20, 'no', NULL, NULL, 110, 'available', NULL, 'S4', 'Turkey'),
('ro6', 'ro', 'Moss Rose', '1234563005', '2023-06-30', '2023-12-30', NULL, 2.40, 5.80, 'yes', 'G3', '2023-07-15', 120, 'available', NULL, 'S4', 'Egypt'),

('la1', 'la', 'Spanish Lavender', '1234563006', '2023-01-10', '2023-07-10', NULL, 1.50, 4.00, 'no', NULL, NULL, 60, 'available', NULL, 'S4', 'Spain'),
('la2', 'la', 'Lavandin', '1234563007', '2023-02-15', '2023-08-15', NULL, 1.70, 4.50, 'yes', 'G4', '2023-03-10', 70, 'available', NULL, 'S4', 'France'),
('la3', 'la', 'Italian Lavender', '1234563008', '2023-03-20', '2023-09-20', NULL, 1.80, 5.00, 'no', NULL, NULL, 80, 'available', NULL, 'S4', 'Italy'),
('la4', 'la', 'Egyptian Lavender', '1234563009', '2023-04-25', '2023-10-25', NULL, 1.60, 4.20, 'yes', 'G5', '2023-05-20', 90, 'available', NULL, 'S4', 'Egypt'),
('la5', 'la', 'Broadleaf Lavender', '1234563010', '2023-05-30', '2023-11-30', NULL, 1.90, 5.30, 'no', NULL, NULL, 50, 'available', NULL, 'S4', 'Morocco'),
('la6', 'la', 'English Lavender', '1234563011', '2023-06-15', '2023-12-15', NULL, 2.00, 5.60, 'yes', 'G4', '2023-07-10', 100, 'available', NULL, 'S4', 'United Kingdom'),

('ja1', 'ja', 'Arabian Jasmine', '1234563012', '2023-01-05', '2023-07-05', NULL, 2.50, 6.00, 'no', NULL, NULL, 40, 'available', NULL, 'S4', 'Saudi Arabia'),
('ja2', 'ja', 'Spanish Jasmine', '1234563013', '2023-02-10', '2023-08-10', NULL, 2.70, 6.50, 'yes', 'G2', '2023-03-12', 50, 'available', NULL, 'S4', 'Spain'),
('ja3', 'ja', 'Winter Jasmine', '1234563014', '2023-03-15', '2023-09-15', NULL, 2.60, 6.20, 'no', NULL, NULL, 30, 'available', NULL, 'S4', 'France'),
('ja4', 'ja', 'Italian Jasmine', '1234563015', '2023-04-20', '2023-10-20', NULL, 2.80, 6.80, 'yes', 'G1', '2023-05-18', 45, 'available', NULL, 'S4', 'Italy'),
('ja5', 'ja', 'Pink Jasmine', '1234563016', '2023-05-25', '2023-11-25', NULL, 2.90, 7.00, 'no', NULL, NULL, 35, 'available', NULL, 'S4', 'Turkey'),
('ja6', 'ja', 'Royal Jasmine', '1234563017', '2023-06-30', '2023-12-30', NULL, 3.00, 7.50, 'yes', 'G5', '2023-07-20', 60, 'available', NULL, 'S4', 'Egypt'),

('li1', 'li', 'Asiatic Lily', '1234563018', '2023-01-10', '2023-07-10', NULL, 1.50, 5.00, 'no', NULL, NULL, 20, 'available', NULL, 'S4', 'Netherlands'),
('li2', 'li', 'Oriental Lily', '1234563019', '2023-02-15', '2023-08-15', NULL, 1.70, 5.50, 'yes', 'G5', '2023-03-15', 25, 'available', NULL, 'S4', 'Japan'),
('li3', 'li', 'Tiger Lily', '1234563020', '2023-03-20', '2023-09-20', NULL, 1.60, 5.20, 'no', NULL, NULL, 30, 'available', NULL, 'S4', 'China'),
('li4', 'li', 'Daylily', '1234563021', '2023-04-25', '2023-10-25', NULL, 1.80, 5.80, 'yes', 'G4', '2023-05-20', 15, 'available', NULL, 'S4', 'USA'),
('li5', 'li', 'Trumpet Lily', '1234563022', '2023-05-30', '2023-11-30', NULL, 1.90, 6.00, 'no', NULL, NULL, 22, 'available', NULL, 'S4', 'Canada'),
('li6', 'li', 'Chocolate Lily', '1234563023', '2023-06-10', '2023-12-10', NULL, 2.00, 6.50, 'yes', 'G4', '2023-07-25', 18, 'available', NULL, 'S4', 'Mexico'),

('ch1', 'ch', 'Garden Chrysanthemum', '1234570000', '2023-01-15', '2023-07-15', NULL, 1.50, 5.00, 'no', NULL, NULL, 30, 'available', NULL, 'S4', 'China'),
('ch2', 'ch', 'Golden Chrysanthemum', '1234570001', '2023-02-10', '2023-08-10', NULL, 1.70, 5.50, 'yes', 'G3', '2023-03-10', 28, 'available', NULL, 'S4', 'Japan'),
('ch3', 'ch', 'Japanese Chrysanthemum', '1234570002', '2023-03-05', '2023-09-05', NULL, 1.60, 5.20, 'no', NULL, NULL, 25, 'available', NULL, 'S4', 'Korea'),
('ch4', 'ch', 'Shasta Daisy', '1234570003', '2023-04-20', '2023-10-20', NULL, 1.80, 5.80, 'yes', 'G3', '2023-05-15', 32, 'available', NULL, 'S4', 'USA'),
('ch5', 'ch', 'Spider Chrysanthemum', '1234570004', '2023-05-25', '2023-11-25', NULL, 1.90, 6.00, 'no', NULL, NULL, 20, 'available', NULL, 'S4', 'Mexico'),
('ch6', 'ch', 'Cascade Chrysanthemum', '1234570005', '2023-06-30', '2023-12-30', NULL, 2.00, 6.50, 'yes', 'G3', '2023-07-20', 18, 'available', NULL, 'S4', 'Italy'),

('pet1', 'pet', 'Grandiflora Petunia', '1234580000', '2023-01-10', '2023-07-10', NULL, 1.20, 3.50, 'no', NULL, NULL, 40, 'available', NULL, 'S4', 'USA'),
('pet2', 'pet', 'Multiflora Petunia', '1234580001', '2023-02-15', '2023-08-15', NULL, 1.30, 3.80, 'yes', 'G1', '2023-03-15', 35, 'available', NULL, 'S4', 'Canada'),
('pet3', 'pet', 'Milliflora Petunia', '1234580002', '2023-03-20', '2023-09-20', NULL, 1.10, 3.20, 'no', NULL, NULL, 45, 'available', NULL, 'S4', 'Mexico'),
('pet4', 'pet', 'Supertunia', '1234580003', '2023-04-25', '2023-10-25', NULL, 1.50, 4.00, 'yes', 'G5', '2023-05-25', 50, 'available', NULL, 'S4', 'Brazil'),
('pet5', 'pet', 'Wave Petunia', '1234580004', '2023-05-30', '2023-11-30', NULL, 1.40, 3.90, 'no', NULL, NULL, 30, 'available', NULL, 'S4', 'Argentina'),
('pet6', 'pet', 'Double Petunia', '1234580005', '2023-06-15', '2023-12-15', NULL, 1.60, 4.20, 'yes', 'G1', '2023-07-15', 25, 'available', NULL, 'S4', 'Chile'),

('orc1', 'orc', 'Dendrobium Orchid', '1234590000', '2023-02-01', '2023-08-01', NULL, 2.50, 6.50, 'no', NULL, NULL, 20, 'available', NULL, 'S4', 'Thailand'),
('orc2', 'orc', 'Cymbidium Orchid', '1234590001', '2023-03-15', '2023-09-15', NULL, 2.80, 7.00, 'yes', 'G5', '2023-04-15', 15, 'available', NULL, 'S4', 'India'),
('orc3', 'orc', 'Vanda Orchid', '1234590002', '2023-04-20', '2023-10-20', NULL, 3.00, 7.50, 'no', NULL, NULL, 25, 'available', NULL, 'S4', 'Brazil'),
('orc4', 'orc', 'Laelia Orchid', '1234590003', '2023-05-10', '2023-11-10', NULL, 2.60, 6.80, 'yes', 'G3', '2023-06-10', 30, 'available', NULL, 'S4', 'Ecuador'),

('wl1', 'wl', 'Blue Water Lily', '1234591000', '2023-03-01', '2023-09-01', NULL, 3.00, 8.00, 'no', NULL, NULL, 20, 'available', NULL, 'S4', 'India'),
('wl2', 'wl', 'Pink Water Lily', '1234591001', '2023-04-05', '2023-10-05', NULL, 3.20, 8.50, 'yes', 'G4', '2023-05-05', 15, 'available', NULL, 'S4', 'Thailand'),
('wl3', 'wl', 'Dwarf Water Lily', '1234591002', '2023-05-10', '2023-11-10', NULL, 2.80, 7.50, 'no', NULL, NULL, 25, 'available', NULL, 'S4', 'China'),
('wl4', 'wl', 'Tropical Water Lily', '1234591003', '2023-06-15', '2023-12-15', NULL, 3.50, 9.00, 'yes', 'G5', '2023-07-15', 30, 'available', NULL, 'S4', 'Vietnam'),
('wl5', 'wl', 'Wild Water Lily', '1234591004', '2023-07-20', '2024-01-20', NULL, 3.00, 8.20, 'no', NULL, NULL, 18, 'available', NULL, 'S4', 'Brazil'),
('wl6', 'wl', 'Purple Water Lily', '1234591005', '2023-08-25', '2024-02-25', NULL, 3.40, 8.70, 'yes', 'G3', '2023-09-25', 22, 'available', NULL, 'S4', 'Local'),

--Herbs and Medicinal Plants	
('mi1', 'mi', 'Peppermint', '1234592000', '2023-01-01', '2023-07-01', NULL, 1.00, 3.50, 'no', NULL, NULL, 50, 'available', NULL, 'S5', 'Egypt'),
('mi2', 'mi', 'Spearmint', '1234592001', '2023-02-05', '2023-08-05', NULL, 1.10, 3.70, 'yes', 'G1', '2023-03-05', 55, 'available', NULL, 'S5', 'Morocco'),
('mi3', 'mi', 'Lemon Mint', '1234592002', '2023-03-10', '2023-09-10', NULL, 1.20, 4.00, 'no', NULL, NULL, 60, 'available', NULL, 'S5', 'Turkey'),
('mi4', 'mi', 'Chocolate Mint', '1234592003', '2023-04-15', '2023-10-15', NULL, 1.30, 4.50, 'yes', 'G2', '2023-05-15', 65, 'available', NULL, 'S5', 'Spain'),
('mi5', 'mi', 'Bergamot Mint', '1234592004', '2023-05-20', '2023-11-20', NULL, 1.40, 4.70, 'no', NULL, NULL, 70, 'available', NULL, 'S5', 'Italy'),
('mi6', 'mi', 'Water Mint', '1234592005', '2023-06-25', '2023-12-25', NULL, 1.50, 5.00, 'yes', 'G3', '2023-07-25', 75, 'available', NULL, 'S5', 'Local'),

('pa1', 'pa', 'Curly Leaf Parsley', '1234593000', '2023-01-15', '2023-07-15', NULL, 0.80, 2.50, 'no', NULL, NULL, 40, 'available', NULL, 'S5', 'Italy'),
('pa2', 'pa', 'Flat Leaf Parsley', '1234593001', '2023-02-20', '2023-08-20', NULL, 0.85, 2.70, 'yes', 'G5', '2023-03-20', 45, 'available', NULL, 'S5', 'Local'),

('cha1', 'cha', 'Roman Chamomile', '1234594000', '2023-01-10', '2023-07-10', NULL, 0.30, 1.20, 'no', NULL, NULL, 80, 'available', NULL, 'S5', 'France'),
('cha2', 'cha', 'Moroccan Chamomile', '1234594001', '2023-02-15', '2023-08-15', NULL, 0.35, 1.40, 'yes', 'G3', '2023-03-15', 85, 'available', NULL, 'S5', 'Morocco'),
('cha3', 'cha', 'Egyptian Chamomile', '1234594002', '2023-03-20', '2023-09-20', NULL, 0.40, 1.60, 'no', NULL, NULL, 90, 'available', NULL, 'S5', 'Egypt'),

('th1', 'th', 'Common Thyme', '1234594100', '2023-04-10', '2023-10-10', NULL, 0.20, 0.80, 'no', NULL, NULL, 100, 'available', NULL, 'S5', 'Spain'),
('th2', 'th', 'Lemon Thyme', '1234594101', '2023-05-15', '2023-11-15', NULL, 0.25, 0.90, 'yes', 'G5', '2023-06-15', 110, 'available', NULL, 'S5', 'Italy'),
('th3', 'th', 'Creeping Thyme', '1234594102', '2023-06-20', '2023-12-20', NULL, 0.30, 1.00, 'no', NULL, NULL, 120, 'available', NULL, 'S5', 'France'),
('th4', 'th', 'Wild Thyme', '1234594103', '2023-07-25', '2024-01-25', NULL, 0.35, 1.10, 'yes', 'G5', '2023-08-25', 130, 'available', NULL, 'S5', 'Morocco'),
('th5', 'th', 'Portuguese Thyme', '1234594104', '2023-08-30', '2024-02-28', NULL, 0.40, 1.20, 'no', NULL, NULL, 140, 'available', NULL, 'S5', 'Portugal'),

('sa1', 'sa', 'Common Sage', '1234595100', '2023-02-01', '2023-08-01', NULL, 0.30, 1.10, 'no', NULL, NULL, 120, 'available', NULL, 'S5', 'Greece'),
('sa2', 'sa', 'Spanish Sage', '1234595101', '2023-03-10', '2023-09-10', NULL, 0.35, 1.20, 'yes', 'G3', '2023-04-10', 130, 'available', NULL, 'S5', 'Spain'),
('sa3', 'sa', 'Greek Sage', '1234595102', '2023-04-15', '2023-10-15', NULL, 0.40, 1.30, 'no', NULL, NULL, 140, 'available', NULL, 'S5', 'Greece'),
('sa4', 'sa', 'Golden Sage', '1234595103', '2023-05-20', '2023-11-20', NULL, 0.45, 1.40, 'yes', 'G4', '2023-06-20', 150, 'available', NULL, 'S5', 'France'),
('sa5', 'sa', 'Scarlet Sage', '1234595104', '2023-06-25', '2023-12-25', NULL, 0.50, 1.50, 'no', NULL, NULL, 160, 'available', NULL, 'S5', 'Italy'),

('bas1', 'bas', 'Lemon Basil', '1234595200', '2023-01-15', '2023-07-15', NULL, 0.20, 0.80, 'no', NULL, NULL, 100, 'available', NULL, 'S5', 'Thailand'),
('bas2', 'bas', 'Purple Basil', '1234595201', '2023-02-25', '2023-08-25', NULL, 0.25, 0.90, 'yes', 'G1', '2023-03-25', 110, 'available', NULL, 'S5', 'Egypt'),
('bas3', 'bas', 'Holy Basil', '1234595202', '2023-03-30', '2023-09-30', NULL, 0.30, 1.00, 'no', NULL, NULL, 120, 'available', NULL, 'S5', 'India'),
('bas4', 'bas', 'Greek Basil', '1234595203', '2023-04-10', '2023-10-10', NULL, 0.35, 1.10, 'yes', 'G5', '2023-05-10', 130, 'available', NULL, 'S5', 'Greece'),

('co1', 'co', 'Common Cilantro', '1234595300', '2023-01-20', '2023-07-20', NULL, 0.15, 0.60, 'no', NULL, NULL, 90, 'available', NULL, 'S5', 'Mexico'),
('co2', 'co', 'Coriander Cilantro', '1234595301', '2023-02-18', '2023-08-18', NULL, 0.18, 0.70, 'yes', 'G4', '2023-03-18', 100, 'available', NULL, 'S5', 'India'),
('co3', 'co', 'Mexican Coriander', '1234595302', '2023-03-25', '2023-09-25', NULL, 0.20, 0.80, 'no', NULL, NULL, 110, 'available', NULL, 'S5', 'Guatemala'),
('co4', 'co', 'Long Leaf Cilantro', '1234595303', '2023-04-15', '2023-10-15', NULL, 0.25, 0.85, 'yes', 'G2', '2023-05-15', 120, 'available', NULL, 'S5', 'Peru'),

('ros1', 'ros', 'Common Rosemary', '1234595400', '2023-02-01', '2023-08-01', NULL, 0.30, 1.00, 'no', NULL, NULL, 130, 'available', NULL, 'S5', 'Spain'),
('ros2', 'ros', 'Creeping Rosemary', '1234595401', '2023-03-15', '2023-09-15', NULL, 0.35, 1.20, 'yes', 'G3', '2023-04-15', 140, 'available', NULL, 'S5', 'France'),
('ros3', 'ros', 'Blue Rosemary', '1234595402', '2023-04-10', '2023-10-10', NULL, 0.40, 1.30, 'no', NULL, NULL, 150, 'available', NULL, 'S5', 'Italy'),
('ros4', 'ros', 'Tuscan Blue Rosemary', '1234595403', '2023-05-05', '2023-11-05', NULL, 0.45, 1.40, 'yes', 'G1', '2023-06-05', 160, 'available', NULL, 'S5', 'Greece'),
('ros5', 'ros', 'Pink Rosemary', '1234595404', '2023-06-20', '2023-12-20', NULL, 0.50, 1.50, 'no', NULL, NULL, 170, 'available', NULL, 'S5', 'Turkey'),
('ros6', 'ros', 'White Rosemary', '1234595405', '2023-07-25', '2024-01-25', NULL, 0.55, 1.60, 'yes', 'G2', '2023-08-25', 180, 'available', NULL, 'S5', 'Local');
select * from seedlings



--purchase invoices
INSERT INTO purchase_invoices (purchase_invoices_id, supplier_name, purchase_date, total_amount, seedling_id)
VALUES
('inv001', 'Green Thumb Nursery', '2023-01-15', 1500.00, 'ba1'),
('inv002', 'Tropical Plants Co.', '2023-02-20', 2500.50, 'po3'),
('inv003', 'Orchid House', '2023-03-05', 1800.75, 'or1'),
('inv004', 'Fruitful Harvest', '2023-04-12', 2200.00, 'pe2'),
('inv005', 'Garden Oasis', '2023-05-30', 3000.00, 'ca4'),
('inv006', 'Local Farmers', '2023-06-15', 1300.25, 'le1');
select * from purchase_invoices

--sale invoices
INSERT INTO sale_invoices (sale_invoice_id, seedling_id, sale_date, total_amount, customer_id)
VALUES
('S1', 'cu1', '2023-06-01', 500.00, 'C1'),
('S2', 'pe3', '2023-06-05', 300.50, 'C2'),
('S3', 'po1', '2023-06-10', 450.75, 'C3'),
('S4', 'ca2', '2023-06-15', 600.00, 'C4'),
('S5', 'or2', '2023-06-20', 800.25, 'C5'),
('S6', 'eg1', '2023-06-25', 700.00, 'C6');
select * from sale_invoices


--operations log
INSERT INTO operations_log (operation_id, seedling_id, operation_type, operation_date, notes)
VALUES
('op1', 'cu1', 'Purchase', '2023-09-01', 'Initial stock for Persian Cucumbers'),
('op2', 'pe2', 'Sale', '2023-09-05', 'Sold 50 units of Plantain Banana'),
('op3', 'po3', 'Adjustment', '2023-09-10', 'Adjusted stock after inventory check'),
('op4', 'ca4', 'Purchase', '2023-09-15', 'Received 200 Nantes Carrots'),
('op5', 'or1', 'Sale', '2023-09-20', 'Sold 30 units of Valencia Orange'),
('op6', 'eg3', 'Adjustment', '2023-09-25', 'Removed damaged stock of Turkish Eggplant');
select * from operations_log

--inventory tracking
INSERT INTO inventory_tracking (inventory_id, seedling_id, quantity,tracking_state,location,last_update)
VALUES
('inv1', 'cu1', 100, 'damaged', 'Greenhouse A', '2023-09-01'),
('inv2', 'pe2', 150, 'for sale', 'Warehouse B', '2023-09-05'),
('inv3', 'po3', 200, 'sold', 'Greenhouse C', '2023-09-10'),
('inv4', 'ca4', 250, 'for sale', 'Warehouse A', '2023-09-15'),
('inv5', 'or1', 300, 'for sale', 'Greenhouse D', '2023-09-20'),
('inv6', 'eg3', 180, 'for sale', 'Warehouse B', '2023-09-25');
select * from inventory_tracking





























