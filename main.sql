create database SportsStore;
go
use SportsStore;


go
create table Products (
                          ProductID int primary key identity(1,1),
                          ProductName varchar(100) not null check (ProductName != ''),
                          ProductType varchar(50) not null check (ProductType != ''),
                          QuantityInStock int,
                          CostPrice decimal(10, 2),
                          Manufacturer varchar(100),
                          SalePrice decimal(10, 2));


go
create table Employees (
                           EmployeeID int primary key identity(1,1),
                           FullName varchar(max) not null check (FullName != ''),
                           Position varchar(50) not null check (Position != ''),
                           HireDate date not null check (HireDate <= getdate()),
                           Gender varchar(10) not null,
                           Salary decimal(10, 2));


go
create table Customers (
                           CustomerID int primary key identity(1,1),
                           FullName varchar(max) not null check (FullName != ''),
                           Email varchar(100) not null check (Email != ''),
                           PhoneNumber varchar(20),
                           Gender varchar(10),
                           OrderHistory varchar(max),
                           DiscountRate decimal(5, 2),
                           IsSubscribedToNewsletter bit not null default 0);


go
create table Sales (
                       SaleID int primary key identity(1,1),
                       ProductID int not null,
                       SalePrice decimal(10, 2),
                       Quantity int not null,
                       SaleDate date check (SaleDate <= getdate()),
                       EmployeeID int not null,
                       CustomerID int not null,
                       foreign key (ProductID) references Products(ProductID),
                       foreign key (EmployeeID) references Employees(EmployeeID),
                       foreign key (CustomerID) references Customers(CustomerID));


go
create table History (
                         HistoryID int primary key identity(1,1),
                         SaleID int not null,
                         ProductID int not null,
                         SalePrice decimal(10, 2),
                         Quantity int,
                         SaleDate date check (SaleDate <= getdate()),
                         EmployeeID int not null,
                         CustomerID int not null,
                         foreign key (SaleID) references Sales(SaleID),
                         foreign key (ProductID) references Products(ProductID),
                         foreign key (EmployeeID) references Employees(EmployeeID),
                         foreign key (CustomerID) references Customers(CustomerID));


go
create table Archive (
                         ArchiveID int primary key identity(1,1),
                         ProductID int not null,
                         ProductName varchar(100) not null,
                         ProductType varchar(50),
                         CostPrice decimal(10, 2),
                         Manufacturer varchar(100),
                         SalePrice decimal(10, 2),
                         foreign key (ProductID) references Products(ProductID));


go
create table LastUnit (
                          LastUnitID int primary key identity(1,1),
                          ProductID int not null,
                          ProductName varchar(max) not null,
                          ProductType varchar(50),
                          SalePrice decimal(10, 2),
                          Manufacturer varchar(100),
                          foreign key (ProductID) references Products(ProductID));


go
create table EmployeeArchive (
                                 EmployeeArchiveID int primary key identity(1,1),
                                 EmployeeID int not null,
                                 FullName varchar(max) not null,
                                 Position varchar(50),
                                 HireDate date check (HireDate <= getdate()),
                                 Gender varchar(10),
                                 Salary decimal(10, 2),
                                 foreign key (EmployeeID) references Employees(EmployeeID));


go
insert into Products (ProductName, ProductType, QuantityInStock, CostPrice, Manufacturer, SalePrice) values
    ('Football', 'Sporting Life', 10, 10.00, 'Adidas', 20.00),
    ('Basketball', 'Sporting Life', 20, 15.00, 'Nike', 25.00),
    ('Volleyball', 'Sport Life', 30, 20.00, 'Mikasa', 30.00),
    ('Tennis racket', 'Sporting Life', 40, 25.00, 'Wilson', 35.00),
    ('Golf club', 'Sporting Life', 50, 30.00, 'Callaway', 40.00),
    ('Dumbbell', 'Sport, run and barbell', 60, 35.00, 'Reebok', 45.00),
    ('Barbell', 'Sport, run and barbell', 70, 40.00, 'York', 50.00),
    ('Sunscreen', 'Sport, run and barbell', 80, 45.00, 'Banana Boat', 55.00),
    ('Sunglasses', 'Sport, run and barbell', 90, 50.00, 'Ray-Ban', 60.00),
    ('Hat', 'Sport, run and barbell', 100, 55.00, 'New Era', 65.00);

go
insert into Employees (FullName, Position, HireDate, Gender, Salary) values
    ('John Doe', 'Manager', '2010-01-01', 'Male', 50000.00),
    ('Jane Smith', 'Seller', '2012-05-15', 'Female', 30000.00),
    ('Alice Johnson', 'Seller', '2018-07-20', 'Female', 32000.00),
    ('Bob Brown', 'Seller', '2019-03-10', 'Male', 31000.00),
    ('Charlie Wilson', 'Seller', '2020-11-25', 'Male', 33000.00),
    ('Diana Taylor', 'Seller', '2021-06-30', 'Female', 34000.00);

go
insert into Customers (FullName, Email, PhoneNumber, Gender, OrderHistory, DiscountRate, IsSubscribedToNewsletter) values
    ('Michael Scott', 'michael@dundermifflin.com', '123-456-7890', 'Male', 'Order1, Order2', 5.00, 1),
    ('Pam Beesly', 'pam@dundermifflin.com', '234-567-8901', 'Female', 'Order3, Order4', 10.00, 0),
    ('Jim Halpert', 'jim@dundermifflin.com', '345-678-9012', 'Male', 'Order5, Order6', 7.50, 1);

go
insert into Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID) values
    (1, 20.00, 2, '2023-01-01', 1, 1),
    (2, 25.00, 1, '2023-01-02', 2, 2),
    (3, 30.00, 3, '2023-01-03', 3, 3);

go
insert into History (SaleID, ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID) values
    (1, 1, 20.00, 2, '2023-01-01', 1, 1),
    (2, 2, 25.00, 1, '2023-01-02', 2, 2),
    (3, 3, 30.00, 3, '2023-01-03', 3, 3);

go
insert into Archive (ProductID, ProductName, ProductType, CostPrice, Manufacturer, SalePrice) values
    (1, 'Football', 'Sporting Life', 10.00, 'Adidas', 20.00);

go
insert into LastUnit (ProductID, ProductName, ProductType, SalePrice, Manufacturer) values
    (1, 'Football', 'Sporting Life', 20.00, 'Adidas');


go
insert into EmployeeArchive (EmployeeID, FullName, Position, HireDate, Gender, Salary) values
    (1, 'John Doe', 'Manager', '2010-01-01', 'Male', 50000.00);


--1:
create trigger trg_SaleInsert
on Sales
after insert
as
begin
    insert into History (SaleID, ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
    select inserted.SaleID, ProductID, inserted.SalePrice, inserted.Quantity, inserted.SaleDate, inserted.EmployeeID, inserted.CustomerID
    from inserted;
end;

select * from Products;
select * from History;

insert into Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID) values
    (1, 20.00, 2, '2023-01-01', 1, 1);

select * from Products;
select * from History;


--2:

select * from Products;
select * from Archive;

create trigger trg_Archive
on Sales
after insert
as
begin
    update Products
    set QuantityInStock = QuantityInStock - inserted.Quantity
    from inserted
    where Products.ProductID = inserted.ProductID
    insert into Archive (ProductID, ProductName, ProductType, CostPrice, Manufacturer, SalePrice)
    select ProductID, ProductName, ProductType, CostPrice, Manufacturer, SalePrice
    from Products
    where QuantityInStock = 0
end;

insert into Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID) values
    (1, 20.00, 10, '2023-01-01', 1, 1);
select * from Products;
select * from Archive;


--3:

select * from Customers;

create trigger trg_PreventDuplicateCustomer
on Customers
instead of insert
as
begin
    if exists (select 1 from Customers c
              inner join inserted i on c.FullName = i.FullName and c.Email = i.Email)
    begin
        raiserror('Customer already exists', 16, 1);
    end
    else
    begin
        insert into Customers (FullName, Email, PhoneNumber, Gender, OrderHistory, DiscountRate, IsSubscribedToNewsletter)
        select FullName, Email, PhoneNumber, Gender, OrderHistory, DiscountRate, IsSubscribedToNewsletter
        from inserted;
    end
end;

insert into Customers (FullName, Email, PhoneNumber, Gender, OrderHistory, DiscountRate, IsSubscribedToNewsletter) values
('Michael Scott', 'michael@dundermifflin.com', '123-456-7890', 'Male', 'Order1, Order2', 5.00, 1)
select * from Customers;

--4:


create trigger trg_PreventDeleteCustomer
on Customers
instead of delete
as
begin
    raiserror('Cannot delete existing customers', 16, 1);
end;

delete from Customers where CustomerID = 1;

select * from Customers;

--5:


create trigger trg_PreventDeleteOldEmployees
on Employees
instead of delete
as
begin
    if exists (select 1 from Employees where HireDate < '2015-01-01')
    begin
        raiserror('Cannot delete employees hired before 2015', 16, 1);
    end
    else
    begin
        delete from Employees where EmployeeID in (select EmployeeID from deleted);
    end
end;

delete from Employees where EmployeeID = 1;

select * from Employees;


--6:


create trigger trg_CheckCustomerTotal
on Sales
after insert
as
begin
    declare @CustomerID int;
    declare @TotalAmount decimal(10, 2);
    select @CustomerID = CustomerID from inserted;
    select @TotalAmount = sum(SalePrice * Quantity) from Sales where CustomerID = @CustomerID;
    if @TotalAmount > 50000
    begin
        update Customers
        set DiscountRate = 15.00
        where CustomerID = @CustomerID;
    end
end;

select * from Customers;

insert into Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID) values
    (2, 25.00, 1000, '2023-01-01', 2, 2);

select * from Customers;
select * from Sales;


--7:


create trigger trg_PreventAddSpecificManufacturer
on Products
instead of insert
as
begin
    if exists (select 1 from inserted where Manufacturer = 'Sport, sun and barbell')
    begin
        raiserror('Cannot add products from the manufacturer "Sport, sun and barbell"', 16, 1);
    end
    else
    begin
        insert into Products (ProductName, ProductType, QuantityInStock, CostPrice, Manufacturer, SalePrice)
        select ProductName, ProductType, QuantityInStock, CostPrice, Manufacturer, SalePrice
        from inserted;
    end
end;

insert into Products (ProductName, ProductType, QuantityInStock, CostPrice, Manufacturer, SalePrice) values
('New Product', 'Sporting Life', 10, 10.00, 'Sport, sun and barbell', 20.00);


--8:

create trigger trg_CheckProductStock
on Sales
after insert
as
begin
    declare @ProductID int;
    declare @QuantityInStock int;
    select @ProductID = ProductID from inserted;
    select @QuantityInStock = QuantityInStock from Products where ProductID = @ProductID;
    if @QuantityInStock = 1
    begin
        insert into LastUnit (ProductID, ProductName, ProductType, SalePrice, Manufacturer)
        select ProductID, ProductName, ProductType, SalePrice, Manufacturer
        from Products
        where ProductID = @ProductID;
    end
end;

select * from Products;
select * from LastUnit;

insert into Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID) values
    (5, 20.00, 1, '2023-01-01', 1, 1);

select * from Products;
select * from LastUnit;


drop database SportsStore;