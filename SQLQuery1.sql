create database Assignment4
USE Assignment4
create table Products
(
	PId int primary key identity(500,1),
	PName nvarchar(50) not null,
	PPrice float ,
	PTax as PPrice*0.10 persisted,
	PCompany nvarchar(50),
	PQty int Default 10,
	constraint PQty check (PQty>=1),
	constraint PCompany check (PCompany in  ('Samsung','Apple','Redmi','HTC','RealMe','Xiomi'))
)


insert into Products(PName,PPrice,PCompany) values ('EarPods',900,'Samsung'),
													('Screen gaurd',1100,'Apple'),
													('Phone case',200,'Redmi')
insert into Products(PName,PPrice,PCompany,PQty) values ('Addapter',600,'HTC',2),
													('Charge cable',300,'Xiomi',5),
													('Ipad',40000,'Apple',1)
insert into Products(PName,PPrice,PCompany) values ('RealMe note 3',38000,'RealMe'),
													('Screen gaurd',300,'Samsung'),
													('Phone case',800,'HTC')
insert into Products(PName,PPrice,PCompany,PQty) values ('Mouse',10000,'Apple',2)
	
select * from Products
----------------------------------------------------------------------
create proc GetTotalPrice
with encryption
as 
begin
select PId,PName,PPrice+PTax as PriceWithTax,PCompany,(PQty*(PPrice+PTax)) as TotalPrice from Products
end

exec GetTotalPrice
--------------------------------------------------------------------------
create proc GetTotalTax
@company varchar(50),
@TotalTax float output
with encryption
as 
select @TotalTax=sum(PTax) from Products where PCompany=@company


declare @TaxCount float
exec GetTotalTax 'Apple',@TaxCount output
print @TaxCount