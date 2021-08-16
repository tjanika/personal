/*
Ezt a Scriptet Toth Janos irta

FIGYELEM FONTOS INFORMACIOK:

Add meg hol vannak a csv file:  ugorj a 920.sorra
A masteren allva kell elinditani
Az agent-nek futni kell a jobok mukodesehez.

A Log es a PostCode tablan szandekoson nincsenek idegen kulcsok.



*********************************************************************************************************************************
Az adatbazis letrehozasa
*********************************************************************************************************************************
*/
use [master]
print '+-----Uzenetek:-----------------------------+' 
print  ''
if  (SELECT 1 FROM sys.databases where name='UsedCar')  is not null 
begin
print 'Volt mar UsedCar nevu adatbazis itt,     '
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = 'UsedCar'
use [master]
ALTER DATABASE [UsedCar] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE UsedCar
print 'letoroltem azt a peldanyt es              ' 
CREATE DATABASE UsedCar COLLATE Hungarian_CI_AS
print 'letrehoztam ezt a peldanyt.               '
end
else 
begin
CREATE DATABASE UsedCar COLLATE Hungarian_CI_AS
print 'Letrehoztam az UsedCar nevu adatbazist    '
end

go
/*
*********************************************************************************************************************************
A naplo letrehozasa
*********************************************************************************************************************************
*/
USE [UsedCar]
CREATE TABLE [Log] (
LogID int IDENTITY Not null PRIMARY KEY,
UserName varchar(100) Not null DEFAULT SUSER_SNAME(),
[Date] datetime2 DEFAULT  SYSDATETIME(),
TableName varchar(20) Not null ,
[Action] varchar(20) Not null,
[Status] bit not null,
[Description] varchar(max) Not null
)





DECLARE @jobId binary(16)

SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = 'Adatbazis.Teljes.mentese')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
go

DECLARE @jobId binary(16)

SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = 'Log.mentes')
IF (@jobId IS NOT NULL)
BEGIN
    EXEC msdb.dbo.sp_delete_job @jobId
END
go

use msdb     drop user    szandor 


/*
*********************************************************************************************************************************
Az USER-ek letrehozasa
*********************************************************************************************************************************
*/
USE [master] 
go
DROP LOGIN zabraham
USE [master] DROP LOGIN vdavid
USE [master] DROP LOGIN fdrafael
USE [master] DROP LOGIN ssalamon
USE [master] DROP LOGIN kbela
USE [master] DROP LOGIN njozsef
USE [master] DROP LOGIN gjozsef	
USE [master] DROP LOGIN fdavid	
USE [master] DROP LOGIN klipot
USE [master] DROP LOGIN bignac
USE [master] DROP LOGIN kmaria
USE [master] DROP LOGIN dantalne
USE [master] DROP LOGIN sjulcsa
USE [master] DROP LOGIN bmarcellne
USE [master] DROP LOGIN szandor


USE [master] CREATE LOGIN 	vdavid	    WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	vdavid	FOR LOGIN 	vdavid	ALTER ROLE [db_datareader] ADD MEMBER 	vdavid
USE [master] CREATE LOGIN 	zabraham	WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	zabraham	FOR LOGIN 	zabraham	ALTER ROLE [db_datareader] ADD MEMBER 	zabraham
USE [master] CREATE LOGIN 	fdrafael	WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	fdrafael	FOR LOGIN 	fdrafael	ALTER ROLE [db_datareader] ADD MEMBER 	fdrafael
USE [master] CREATE LOGIN 	ssalamon	WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	ssalamon	FOR LOGIN 	ssalamon	ALTER ROLE [db_datareader] ADD MEMBER 	ssalamon
USE [master] CREATE LOGIN 	kbela	    WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	kbela	FOR LOGIN 	kbela	ALTER ROLE [db_datareader] ADD MEMBER 	kbela
USE [master] CREATE LOGIN 	njozsef	    WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	njozsef	FOR LOGIN 	njozsef	ALTER ROLE [db_datareader] ADD MEMBER 	njozsef
USE [master] CREATE LOGIN 	gjozsef	    WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	gjozsef	FOR LOGIN 	gjozsef	ALTER ROLE [db_datareader] ADD MEMBER 	gjozsef
USE [master] CREATE LOGIN 	fdavid	    WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	fdavid	FOR LOGIN 	fdavid	ALTER ROLE [db_datareader] ADD MEMBER 	fdavid
USE [master] CREATE LOGIN 	klipot	    WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	klipot	FOR LOGIN 	klipot	ALTER ROLE [db_datareader] ADD MEMBER 	klipot
USE [master] CREATE LOGIN 	bignac	    WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	bignac	FOR LOGIN 	bignac	ALTER ROLE [db_datareader] ADD MEMBER 	bignac
USE [master] CREATE LOGIN 	kmaria	     WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	kmaria	FOR LOGIN 	kmaria	ALTER ROLE [db_datawriter] ADD MEMBER 	kmaria
USE [master] CREATE LOGIN 	dantalne	WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	dantalne	FOR LOGIN 	dantalne	ALTER ROLE [db_datawriter] ADD MEMBER 	dantalne
USE [master] CREATE LOGIN 	sjulcsa	WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	sjulcsa	FOR LOGIN 	sjulcsa	ALTER ROLE [db_datawriter] ADD MEMBER 	sjulcsa
USE [master] CREATE LOGIN 	bmarcellne WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	bmarcellne	FOR LOGIN 	bmarcellne	ALTER ROLE [db_datawriter] ADD MEMBER 	bmarcellne
USE [master] CREATE LOGIN 	szandor	WITH PASSWORD='Password', DEFAULT_DATABASE=UsedCar, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF USE UsedCar CREATE USER 	szandor	FOR LOGIN 	szandor	ALTER ROLE [db_owner] ADD MEMBER 	szandor
use msdb     create user    szandor for login szandor alter role SQLAgentUserRole ADD Member szandor

go
/*
*********************************************************************************************************************************
Az Application role letrehozasa
*********************************************************************************************************************************
*/
USE [UsedCar]


CREATE  APPLICATION ROLE [WebShop] WITH PASSWORD = 'WebShop'
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [WebShop]
insert [Log] (TableName,[Action],[status], [Description]) values ('NONE','CREATE ROLE',1,'Sikerult felvenni az Application Role-t')

go
/*
*********************************************************************************************************************************
Full napi mentes job letrehozasa
*********************************************************************************************************************************
*/




USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'Adatbazis.Teljes.mentese', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'szandor', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'Adatbazis.Teljes.mentese'
----, @server_name = N'PC'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'Adatbazis.Teljes.mentese', @step_name=N'1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [UsedCar] TO  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\UsedCar.bak'' WITH NOFORMAT, NOINIT, SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
', 
		@database_name=N'master', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'Adatbazis.Teljes.mentese', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'szandor', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'Adatbazis.Teljes.mentese', @name=N'Naponta', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20210729, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO


/*
*********************************************************************************************************************************
Logmentes orankent  job letrehozasa
*********************************************************************************************************************************
*/




USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'Log.mentes', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'szandor', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'Log.mentes'
---, @server_name = N'PC'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'Log.mentes', @step_name=N'1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP LOG [UsedCar] TO  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\UsedCar.bak'' WITH NOFORMAT, NOINIT, SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
', 
		@database_name=N'master', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'Log.mentes', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'szandor', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'Log.mentes', @name=N'Orankent', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20210729, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO


/*
*********************************************************************************************************************************
Rekordokat ellenorzo fuggvenyek letrehozasa
*********************************************************************************************************************************
*/


USE [UsedCar]
go
CREATE  OR ALTER FUNCTION PostCodeCheck ( @Postcode int ) RETURNS VARCHAR(5) AS BEGIN IF EXISTS (SELECT * FROM PostCode WHERE PostCode = @Postcode) return 'True'    return 'False' END 
go 
CREATE  OR ALTER FUNCTION CityCheck  ( @City as VARCHAR(100), @Postcode int ) RETURNS VARCHAR(5) AS BEGIN IF EXISTS (SELECT * FROM PostCode WHERE   City = @City and PostCode=@Postcode ) return 'True' return 'False' END 
go 
CREATE OR ALTER  FUNCTION PhoneCheck ( @Phone VARCHAR(11) ) RETURNS VARCHAR(5) AS BEGIN IF ( (Substring(@Phone,3,2) IN ('20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','40','42','44','45','46','47','48','49','50','51','52','53','54','55','56','57','59','60','61','62','63','66','68','69','70','72','73','74','75','76','77','78','79','80','82','83','84','85','87','88','89','90','91','92','93','94','95','96','99'))) OR ((  (Substring(@Phone,3,1)='1'))) return 'True' return 'False' END 
go 
CREATE or alter  FUNCTION TAXNumberCheck (@TaxNumber Varchar(11) ) RETURNS VARCHAR(5) AS BEGIN if ( 10-((Substring(@TAXNumber,1,1)*9+Substring(@TAXNumber,2,1)*7+Substring(@TAXNumber,3,1)*3+Substring(@TAXNumber,4,1)+Substring(@TAXNumber,5,1)*9+Substring(@TAXNumber,6,1)*7+Substring(@TAXNumber,7,1)*3) % 10) = Substring(@TAXNumber,8,1))  AND (Substring(@TAXNumber,9,1) in (1,2,3,4,5)) AND (Substring(@TAXNumber,10,2) in ('02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','51')) return 'True' return 'False' END 
go
CREATE  OR ALTER FUNCTION CarPrice ( @CarID int	 ) RETURNS int AS BEGIN declare @CarPrice int set  @CarPrice = (SELECT Price FROM Car WHERE CarID = @CarID) return @CarPrice  END
go                   
CREATE OR ALTER FUNCTION VATValue ( @VATID int	 ) RETURNS int AS BEGIN declare @VATValue   int set  @VATValue   = (SELECT VATValue FROM VAT WHERE VATID = @VATID) return @VATValue  END
go
CREATE  OR ALTER FUNCTION VATIDCheck ( @VATID int ) RETURNS VARCHAR(5) AS BEGIN IF EXISTS (SELECT [VATID] FROM [VAT] where  [from] <(cast(SYSDATETIME() as date)) and [to]> (cast(SYSDATETIME() as date)) ) return 'True'    return 'False' END 
go
insert [Log] (TableName,[Action],[status], [Description]) values ('NONE','CREATE FUNCTION',1,'Sikerult felvenni a Fuggvenyeket')
go




/*
*********************************************************************************************************************************
Tablak letrehozasa
*********************************************************************************************************************************
*/

BEGIN TRY
	BEGIN TRAN

create  table  DictPaymentMode(
DictPaymentModeID tinyint  Not null,
DictPaymentMode varchar(20) NOT NULL 
CONSTRAINT PK_DictPaymentMode_DictPaymentModeID PRIMARY KEY (DictPaymentModeID)
)


create table  DictStat(
DictStatID int Not null identity(1,1),
Stat varchar(20) NOT NULL 
CONSTRAINT PK_DictStat_DictStatID  PRIMARY KEY (DictStatID )
)


create table  VAT(
VATID int Not null identity(1,1),
VATValue tinyint NOT NULL ,
[From] date NOT NULL ,
[TO] date NOT NULL ,
CONSTRAINT CK_Afa CHECK ([from]<[to]),
CONSTRAINT PK_VAT_VATID  PRIMARY KEY (VATID )
)

create table  CarBrand(
CarBrandID int Not null identity(0,1),
Brand varchar(20) NOT NULL 
CONSTRAINT PK_CarBrand_CarBrandID  PRIMARY KEY (CarBrandID )
)


create table  CarModel(
CarModelID int  Not null identity(0,1),
CarBrandID int NOT NULL ,
Model varchar(70) NOT NULL 
CONSTRAINT PK_CarModel_CarModelID  PRIMARY KEY (CarModelID ),
CONSTRAINT FK_CarModel_CarBrand_CarMarkaID FOREIGN KEY (CarBrandID) REFERENCES CarBrand (CarBrandID)	ON DELETE CASCADE,
)


create table  Employee(
EmployeeID int Not null identity(1,1),
FullName varchar(50) NOT NULL,
Post varchar(10) NOT NULL CHECK (Post IN ('Számlázás', 'Eladó', 'Igazgato')),
Payment int NOT NULL,
LoginName varchar(20) NOT NULL,
CONSTRAINT PK_Employee_EmployeeID  PRIMARY KEY (EmployeeID )
)



create table Car (
CarID int  Not null,
CarBrandID int NOT NULL ,
CarModelID int NOT NULL , 
Note varchar(max),
YearofManufacture smallint CHECK (YearofManufacture>1900),
Price int NOT NULL CHECK (Price>100000),
LicensePlate varchar(6) not null CHECK (Len(LicensePlate)=6), 
CONSTRAINT PK_Car_CarID  PRIMARY KEY (CarID ),
CONSTRAINT FK_Car_CarBrand_CarBrandID FOREIGN KEY (CarBrandID) REFERENCES CarBrand (CarBrandID),
CONSTRAINT FK_Car_CarModel_CarModelID FOREIGN KEY (CarModelID) REFERENCES CarModel (CarModelID)
)



create table CarDetail(
CarDetailID int identity(1,1),
CarID int NOT NULL ,
Height smallint Not null ,
[Length] smallint NOT NULL ,
Width smallint NOT NULL ,
Driveline  varchar(10) NOT NULL ,
Hybrid bit NOT NULL ,
Fuel varchar(10) NOT NULL ,
Transmission varchar(10) NOT NULL ,
Climate bit NOT NULL ,
NoPreviousOwner tinyint NOT NULL ,
FuelInfoCity tinyint NOT NULL ,
FuelInfoHighway tinyint NOT NULL ,
Km int NOT NULL
CONSTRAINT PK_CarDetail_CarDetailID PRIMARY KEY (CarDetailID),
CONSTRAINT FK_CarDetail_Car_CarID FOREIGN KEY (CarID) REFERENCES Car(CarID)
)



create table  PostCode(
PostCodeID int Not null identity(0,1),
PostCode int CHECK ((1000<PostCode) and (PostCode<9999)) NOT NULL,
City varchar(100) NOT NULL
CONSTRAINT PK_PostCode_PostCodeID PRIMARY KEY (PostCodeID)
)









create table  Client(
ClientID int  Not null identity(1,1),
FullName varchar(50) NOT NULL,
Postcode   int      NOT NULL ,
City varchar(100)  NOT NULL,
Street  varchar(100)    NOT NULL  ,
Phone VARCHAR(13) NOT NULL,
TAXNumber Varchar(13) Null ,
CONSTRAINT PK_Client_ClientID PRIMARY KEY (ClientID),
CONSTRAINT CK_PostCodeCheck CHECK  (dbo.PostCodeCheck(Postcode) = 'True'),
CONSTRAINT CK_CityCheck  CHECK  (dbo.CityCheck(City,Postcode) = 'True'),
CONSTRAINT CK_PhoneCheck  CHECK  (dbo.PhoneCheck(Phone) = 'True'),
CONSTRAINT CK_TAXNumberCheck  CHECK  (dbo.TAXNumberCheck(TAXNumber) = 'True')
)


create  table Invoice(
InvoiceID int  Not null identity(1,1)  ,
ClientID  int NOT NULL, 
InvoiceDate date NOT NULL CHECK (InvoiceDate = cast(SYSDATETIME()as date)),
ShipDate date  NOT NULL,
EmployeeID int NOT NULL ,
CONSTRAINT PK_Invoice_InvoiceID PRIMARY KEY (InvoiceID),
CONSTRAINT FK_Invoice_Client_ClientID FOREIGN KEY (ClientID) REFERENCES Client (ClientID)	ON DELETE CASCADE,
CONSTRAINT FK_Invoice_Employee_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)	ON DELETE CASCADE
)




create  table InvoiceDetail(
InvoiceDetailID int  Not null identity(1,1),
InvoiceID  int not null , 
CarID int not null ,          
Unit tinyint DEFAULT 1 NOT NULL,
Discount tinyint DEFAULT 0 NULL,
VATID int NOT NULL ,
DictPaymentMode tinyint  ,
DictStat int   ,
ListPrice as  dbo.CarPrice(CarID),
ListPriceMultiplyPiece as ((dbo.CarPrice(CarID))*Unit) ,
ListPriceMultiplyPieceWithVAT as (((dbo.CarPrice(CarID))*Unit)*((100-(dbo.VATValue(VATID))))/100),
ListPriceMultiplyPieceWithVATWithDiscount as (round((((dbo.CarPrice(CarID))*Unit)*((100-(dbo.VATValue(VATID))))/100)*((100-(Discount))/100.0),2)),

CONSTRAINT PK_InvoiceDetail_InvoiceDetailID PRIMARY KEY (InvoiceDetailID),
CONSTRAINT FK_InvoiceDetail_Invoice_InvoiceID FOREIGN KEY (InvoiceID) REFERENCES Invoice (InvoiceID)	ON DELETE CASCADE ,
CONSTRAINT FK_InvoiceDetail_Car_CarID             FOREIGN KEY (CarID)          REFERENCES Car (CarID)	        ON DELETE CASCADE ,
CONSTRAINT FK_InvoiceDetail_VAT_VatValue          FOREIGN KEY (VatID) REFERENCES VAT (VATID)	ON DELETE CASCADE ,
CONSTRAINT FK_InvoiceDetail_DictPayment_DictPaymentModeID    FOREIGN KEY (DictPaymentMode) REFERENCES DictPaymentMode (DictPaymentModeID),
CONSTRAINT FK_InvoiceDetail_SzotarStatisztikaID_Statisztika FOREIGN KEY (DictStat) REFERENCES DictStat (DictStatID)	ON DELETE CASCADE ,
CONSTRAINT CK_VATIDCheck  CHECK  (dbo.VATIDCheck(VATID) = 'True')
)

COMMIT TRAN
	
insert [Log] (TableName,[Action],[status], [Description]) values ('NONE','CREATE TABLE',1,'Sikerult felvenni a táblákat')
END TRY
	BEGIN CATCH
	ROLLBACK TRAN
insert [Log] (TableName,[Action],[status], [Description]) values ('NONE','CREATE TABLE',0,'Nem sikerult felvenni a táblákat')
	END CATCH











 ALTER TABLE DictPaymentMode           ADD CONSTRAINT AK_DictPaymentMode_DictPaymentMode            UNIQUE (DictPaymentMode)
 ALTER TABLE Employee                  ADD CONSTRAINT AK_Employee_LoginName                         UNIQUE (LoginName)
 ALTER TABLE CarBrand                  ADD CONSTRAINT AK_CarBrand_Brand                             UNIQUE (Brand)
















go

/*
*********************************************************************************************************************************
Triggerek letrehozasa
*********************************************************************************************************************************
*/


CREATE OR ALTER TRIGGER TR_InvoiceDetail_INSERT ON InvoiceDetail FOR INSERT
AS
	INSERT [Log] (TableName, [Action],[status], [Description]) Select 'InvoiceDetail','INSERT',1,CONCAT('CarID:',[CarID],', Unit:',[Unit],', Discount:',[Discount],', VATID:',[VATID],', DictPaymentMode:',[DictPaymentMode],', DictStat:',[DictStat]) FROM inserted
GO

CREATE OR ALTER TRIGGER  TR_InvoiceDetail_UPDATE ON InvoiceDetail FOR Update
AS
	INSERT [Log] (TableName, [Action],[status], [Description]) Select 'InvoiceDetail','UPDATE',1,CONCAT('CarID:',d.[CarID],', Unit:',d.[Unit],', Discount:',d.[Discount],', VATID:',d.[VATID],', DictPaymentMode:',d.[DictPaymentMode],', DictStat:',d.[DictStat],'===>','CarID:',i.[CarID],', Unit:',i.[Unit],', Discount:',i.[Discount],', VATID:',i.[VATID],', DictPaymentMode:',i.[DictPaymentMode],', DictStat:',i.[DictStat])  FROM inserted i JOIN deleted d  ON I.InvoiceDetailID = D.InvoiceDetailID 
GO

CREATE OR ALTER TRIGGER  TR_InvoiceDetail_DELETE ON InvoiceDetail FOR DELETE
AS
	INSERT [Log] (TableName, [Action],[status], [Description]) Select 'InvoiceDetail','DELETE',1,CONCAT([CarID],' ',[Unit],' ',[Discount],' ',[VATID],' ',[DictPaymentMode],' ',[DictStat]) FROM deleted
GO

CREATE OR ALTER TRIGGER  TR_Invoice_INSERT ON Invoice FOR INSERT
AS
	INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Invoice','INSERT',1,CONCAT('InvoiceID:',[InvoiceID],', ClientID:',[ClientID],', InvoiceDate:',[InvoiceDate],', EmployeeID:',[EmployeeID]) FROM inserted
GO

CREATE OR ALTER TRIGGER  TR_Invoice_UPDATE ON Invoice FOR Update
AS
    INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Invoice','UPDATE',1,CONCAT(d.[InvoiceID],' ', d.[ClientID] ,' ',d.[InvoiceDate], ' ',d.[ShipDate], ' ',d.[EmployeeID],'===>',i.[InvoiceID], ' ',i.[ClientID], ' ',i.[InvoiceDate], ' ',i.[ShipDate], ' ',i.[EmployeeID]) FROM inserted i JOIN deleted d  ON I.InvoiceID = D.InvoiceID 
GO

CREATE OR ALTER TRIGGER TR_Invoice_DELETE ON Invoice FOR DELETE
AS
 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Invoice','DELETE',1,CONCAT([InvoiceID],' ', [ClientID], ' ',[InvoiceDate], ' ',[ShipDate], ' ',[EmployeeID]) FROM deleted
GO

CREATE OR ALTER TRIGGER TR_Car_DELETE ON dbo.Car INSTEAD OF DELETE
	AS
	Rollback
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Car','DELETE',0,CONCAT('Valaki ki akarta torolni a ',[CarID],' autot! ') FROM deleted
GO

CREATE OR ALTER TRIGGER TR_Car_UPDATE ON dbo.Car FOR Update
	AS
	
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Car','UPDATE',1,CONCAT(d.[CarID],' ', d.[CarBrandID],' ', d.[CarModelID],' ', d.[Note],' ', d.[YearofManufacture],' ', d.[Price],' ', d.[LicensePlate],'===>',i.[CarID],' ', i.[CarBrandID],' ',i.[CarModelID],' ', i.[Note],' ',i.[YearofManufacture],' ', i.[Price],' ', i.[LicensePlate])  FROM inserted i JOIN deleted d  ON I.CarID = D.CarID 
GO

CREATE OR ALTER TRIGGER TR_Car_INSERT ON dbo.Car FOR Insert
	AS

	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Car','INSERT',1,CONCAT('CarID:',[CarID] ,' CarBrandID:', [CarBrandID], ' CarModelID:',[CarModelID], ' Note:',[Note],' YearofManufacture:' ,[YearofManufacture],' Price:', [Price], ' LicensePlate:',[LicensePlate]) FROM inserted
GO

CREATE OR ALTER TRIGGER TR_CarBrand_DELETE ON dbo.CarBrand INSTEAD OF DELETE
	AS
	Rollback
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'CarBrand','DELETE',0,CONCAT('Valaki ki akarta torolni a ',[CarBrandID],' automarkat! ') FROM deleted
GO

CREATE OR ALTER TRIGGER TR_CarBrand_UPDATE ON dbo.CarBrand FOR Update
	AS
	
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'CarBrand','UPDATE',1,CONCAT(d.[CarBrandID],' ', d.[Brand],'===>',i.[CarBrandID],' ', i.[Brand])  FROM inserted i JOIN deleted d  ON I.CarBrandID = D.CarBrandID 
GO

CREATE OR ALTER TRIGGER TR_CarBrand_INSERT ON dbo.CarBrand FOR Insert
	AS

	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'CarBrand','INSERT',1,CONCAT('CarBrandID:',[CarBrandID] ,' Brand:', [Brand]) FROM inserted
GO

CREATE OR ALTER TRIGGER TR_DictPaymentMode_DELETE ON dbo.DictPaymentMode INSTEAD OF DELETE
	AS
	Rollback
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'DictPaymentMode','DELETE',0,CONCAT('Valaki ki akarta torolni a ',[DictPaymentModeID],' Fizetesi modot! ') FROM deleted
GO

CREATE OR ALTER TRIGGER TR_DictPaymentMode_UPDATE ON dbo.DictPaymentMode INSTEAD OF Update
	AS
	Rollback
	 INSERT [Log] (TableName, [Action],[status], [Description]) Values ('DictPaymentMode','UPDATE',0,'Valaki ki akarta modositani akarta  a  fizetesi modot! ')
GO

CREATE OR ALTER TRIGGER TR_DictPaymentMode_INSERT ON dbo.DictPaymentMode INSTEAD OF Insert
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'DictPaymentMode','INSERT',1,CONCAT('DictPaymentModeID:',[DictPaymentModeID] ,' DictPaymentMode:', [DictPaymentMode]) FROM inserted
GO

CREATE OR ALTER TRIGGER TR_PostCode_InsertUpdateDelete ON dbo.PostCode INSTEAD OF Insert,UPDATE,DELETE
	AS
	rollback
	 INSERT [Log] (TableName, [Action],[status], [Description]) Values ('PostCode','Insert,UPDATE,DELETE',0,'Valaki ki akarta modositani akarta  az iranyitoszamokat!')
GO

CREATE OR ALTER TRIGGER TR_Employee_DELETE ON dbo.Employee FOR   DELETE
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Employee','DELETE',0,CONCAT('Valaki ki akarta torolni a ',[EmployeeID],' alkalmazotat ') FROM deleted
GO

CREATE OR ALTER TRIGGER TR_Employee_UPDATE ON dbo.Employee FOR  Update
	AS
		 INSERT [Log] (TableName, [Action],[status], [Description]) SELECT 'Employee','UPDATE',0,CONCAT('EmployeeID:',D.[EmployeeID] ,' FullName:' ,D.[FullName],' Post:', D.[Post], ' Payment:',D.[Payment], ' LoginName:',D.[LoginName],'===>',' EmployeeID:',I.[EmployeeID] ,' FullName:' ,I.[FullName],' Post:', I.[Post], ' Payment:',I.[Payment], ' LoginName:',I.[LoginName])FROM inserted i JOIN deleted d  ON I.EmployeeID = D.EmployeeID
GO

CREATE OR ALTER TRIGGER TR_Employee_INSERT ON dbo.Employee FOR   Insert
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Employee','INSERT',1,CONCAT('EmployeeID:',[EmployeeID] ,' FullName:' ,[FullName],' Post:', [Post], ' Payment:',[Payment], ' LoginName:',[LoginName]) FROM inserted
GO

CREATE OR ALTER TRIGGER TR_Client_DELETE ON dbo.Client INSTEAD OF DELETE
	AS
	rollback
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Client','DELETE',1,[ClientID] FROM deleted
GO

CREATE OR ALTER TRIGGER TR_Client_UPDATE ON dbo.Client INSTEAD OF  Update
	AS
	rollback
		 INSERT [Log] (TableName, [Action],[status], [Description]) SELECT 'Client','UPDATE',1,CONCAT('ClientID:',d.[ClientID] ,' FullName:' ,d.[FullName],' Postcode:', d.[Postcode], ' City:',d.[City], ' Street:',d.[Street], ' Phone:', d.[Phone], ' TAXNumber:',d.[TAXNumber],'===>','ClientID:',i.[ClientID] ,' FullName:' ,i.[FullName],' Postcode:', i.[Postcode], ' City:',i.[City], ' Street:',i.[Street], ' Phone:', i.[Phone], ' TAXNumber:',i.[TAXNumber])FROM inserted i JOIN deleted d  ON I.ClientID = D.ClientID
GO

CREATE OR ALTER TRIGGER TR_Client_INSERT ON dbo.Client FOR   Insert
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'Client','INSERT',1,CONCAT('ClientID:',[ClientID] ,' FullName:' ,[FullName],' Postcode:', [Postcode], ' City:',[City], ' Street:',[Street], ' Phone:', [Phone], ' TAXNumber:',[TAXNumber]) FROM inserted
GO

CREATE OR ALTER TRIGGER TR_CarDetail_DELETE ON dbo.CarDetail FOR   DELETE
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'CarDetail','DELETE',1,[CarDetailID] FROM deleted
GO

CREATE OR ALTER TRIGGER TR_CarDetail_UPDATE ON dbo.CarDetail FOR  Update
	AS
		 INSERT [Log] (TableName, [Action],[status], [Description]) SELECT 'CarDetail','UPDATE',1,CONCAT('CarID:' ,d.[CarID],' Height:', d.[Height], ' Length:',d.[Length], ' Width:',d.[Width], ' Driveline:', d.[Driveline], ' Hybrid:',d.[Hybrid], ' Fuel:', d.[Fuel], ' Transmission:',d.[Transmission] ,' Climate:', d.[Climate], ' NoPreviousOwner:',d.[NoPreviousOwner], ' FuelInfoCity:',d.[FuelInfoCity], ' FuelInfoHighway:', d.[FuelInfoHighway], ' Km:',d.[Km],'===>','CarDetailID:',i.[CarDetailID] ,' CarID:' ,i.[CarID],' Height:', i.[Height], ' Length:',i.[Length], ' Width:',i.[Width], ' Driveline:', i.[Driveline], ' Hybrid:',i.[Hybrid], ' Fuel:', i.[Fuel], ' Transmission:',i.[Transmission], ' Climate:', i.[Climate], ' NoPreviousOwner:',i.[NoPreviousOwner], ' FuelInfoCity:',i.[FuelInfoCity] ,' FuelInfoHighway:', i.[FuelInfoHighway], ' Km:',i.[Km])FROM inserted i JOIN deleted d  ON I.CarDetailID = D.CarDetailID
GO

CREATE OR ALTER TRIGGER TR_CarDetail_INSERT ON dbo.CarDetail FOR   Insert
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'CarDetail','INSERT',1,CONCAT(' CarID:' ,[CarID],' Height:', [Height], ' Length:',[Length], ' Width:',[Width], ' Driveline:', [Driveline], ' Hybrid:',[Hybrid], ' Fuel:', [Fuel], ' Transmission:',[Transmission] ,' Climate:', [Climate], ' NoPreviousOwner:',[NoPreviousOwner], ' FuelInfoCity:',[FuelInfoCity], ' FuelInfoHighway:', [FuelInfoHighway], ' Km:',[Km]) FROM inserted 
GO

CREATE OR ALTER TRIGGER TR_CarModel_DELETE ON dbo.CarModel FOR   DELETE
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'CarModel','DELETE',1,[CarModelID] FROM deleted
GO

CREATE OR ALTER TRIGGER TR_CarModel_UPDATE ON dbo.CarModel FOR  Update
	AS
		 INSERT [Log] (TableName, [Action],[status], [Description]) SELECT 'CarModel','UPDATE',1,CONCAT('CarModelID:',d.[CarModelID] ,' CarBrandID:' ,d.[CarBrandID],' Model:', d.[Model],'===>','CarModelID:',i.[CarModelID] ,' CarBrandID:' ,i.[CarBrandID],' Model:', i.[Model])FROM inserted i JOIN deleted d  ON I.CarModelID = D.CarModelID
GO

CREATE OR ALTER TRIGGER TR_CarModel_INSERT ON dbo.CarModel FOR   Insert
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'CarModel','INSERT',1,CONCAT('CarModelID:',[CarModelID] ,' CarBrandID:' ,[CarBrandID],' Model:', [Model]) FROM inserted
GO

CREATE OR ALTER TRIGGER TR_DictStat_DELETE ON dbo.DictStat FOR   DELETE
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'DictStat','DELETE',1,[DictStatID] FROM deleted
GO

CREATE OR ALTER TRIGGER TR_DictStat_UPDATE ON dbo.DictStat FOR  Update
	AS
		 INSERT [Log] (TableName, [Action],[status], [Description]) SELECT 'DictStat','UPDATE',1,CONCAT('DictStatID:',d.[DictStatID] ,' Stat' ,d.[Stat],'===>','DictStatID:',i.[DictStatID] ,' Stat' ,i.[Stat])FROM inserted i JOIN deleted d  ON I.DictStatID = D.DictStatID
GO

CREATE OR ALTER TRIGGER TR_DictStat_INSERT ON dbo.DictStat FOR   Insert
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'DictStat','INSERT',1,CONCAT('DictStatID:',[DictStatID] ,' Stat' ,[Stat]) FROM inserted
GO

CREATE OR ALTER TRIGGER TR_VAT_DELETE ON dbo.VAT FOR   DELETE
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'VAT','DELETE',1,[VATID] FROM deleted
GO

CREATE OR ALTER TRIGGER TR_VAT_UPDATE ON dbo.VAT FOR  Update
	AS
		 INSERT [Log] (TableName, [Action],[status], [Description]) SELECT 'VAT','UPDATE',1,CONCAT('VATID:',d.[VATID] ,' VATValue' ,d.[VATValue],' From:' , d.[From], ' TO:', d.[TO],'===>','VATID:',i.[VATID] ,' VATValue' ,i.[VATValue],' From:' , i.[From], ' TO:', i.[TO])FROM inserted i JOIN deleted d  ON I.VATID = D.VATID
GO

CREATE OR ALTER TRIGGER TR_VAT_INSERT ON dbo.VAT FOR   Insert
	AS
	 INSERT [Log] (TableName, [Action],[status], [Description]) Select 'VAT','INSERT',1,CONCAT('VATID:',[VATID] ,' VATValue' ,[VATValue],' From:' , [From], ' TO:', [TO]) FROM inserted
GO

/*DataLoad*/

GO
CREATE OR ALTER PROC DataLoad	
 @Directory varchar(max)
AS
BEGIN
 declare @command1 varchar(max)
 declare @command2 varchar(max)
 declare @command3 varchar(max)
 declare @command4 varchar(max)
 declare @command5 varchar(max)
 declare @command6 varchar(max)
 declare @command7 varchar(max)
SET NOCOUNT ON

set @command1 ='BULK INSERT PostCode FROM ''' + @Directory +'PostCode.csv'' WITH (CODEPAGE = 1250,FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n''   )' 
	BEGIN TRY
	exec (@command1) 
insert [Log] (TableName,[Action],[status], [Description]) values ('PostCode','BULK INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
	BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('PostCode','BULK INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
	END CATCH

set @command2 ='BULK INSERT CarModel FROM ''' + @Directory +'CarModel.csv'' WITH (CODEPAGE = 1250,FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n''   )' 
	BEGIN TRY
	exec (@command2) 
insert [Log] (TableName,[Action],[status], [Description]) values ('CarModel','BULK INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
	BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('CarModel','BULK INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
	END CATCH

set @command3 ='BULK INSERT Client FROM ''' + @Directory +'Client.csv'' WITH (CODEPAGE = 1250,FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n''   )' 
	BEGIN TRY
	exec (@command3) 
insert [Log] (TableName,[Action],[status], [Description]) values ('Client','BULK INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
	BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('Client','BULK INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
	END CATCH

set @command4 ='BULK INSERT Car FROM ''' + @Directory +'Car.csv'' WITH (CODEPAGE = 1250,FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n''   )' 
	BEGIN TRY
	exec (@command4) 
insert [Log] (TableName,[Action],[status], [Description]) values ('Car','BULK INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
	BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('Car','BULK INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
	END CATCH

set @command5 ='BULK INSERT Invoice FROM ''' + @Directory +'Invoice.csv'' WITH (CODEPAGE = 1250,FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n''   )' 
	BEGIN TRY
	exec (@command5) 
insert [Log] (TableName,[Action],[status], [Description]) values ('Invoice','BULK INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
	BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('Invoice','BULK INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
	END CATCH

set @command6 ='BULK INSERT InvoiceDetail FROM ''' + @Directory +'InvoiceDetail.csv'' WITH (CODEPAGE = 1250,FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n''   )' 
	BEGIN TRY
	exec (@command6) 
insert [Log] (TableName,[Action],[status], [Description]) values ('InvoiceDetail','BULK INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
	BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('InvoiceDetail','BULK INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
	END CATCH

set @command7 ='BULK INSERT CarDetail FROM ''' + @Directory +'CarDetail.csv'' WITH (CODEPAGE = 1250,FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n''   )' 
	BEGIN TRY
	exec (@command7) 
insert [Log] (TableName,[Action],[status], [Description]) values ('CarDetail','BULK INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
	BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('CarDetail','BULK INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
	END CATCH

BEGIN TRY
BEGIN TRAN
INSERT INTO CarBrand (Brand) VALUES ('Alfa Romeo')
INSERT INTO CarBrand (Brand) VALUES ('Aston Martin')
INSERT INTO CarBrand (Brand) VALUES ('Audi')
INSERT INTO CarBrand (Brand) VALUES ('Bentley')
INSERT INTO CarBrand (Brand) VALUES ('BMW')
INSERT INTO CarBrand (Brand) VALUES ('Cadillac')
INSERT INTO CarBrand (Brand) VALUES ('Chery')
INSERT INTO CarBrand (Brand) VALUES ('Chevrolet')
INSERT INTO CarBrand (Brand) VALUES ('Chrysler')
INSERT INTO CarBrand (Brand) VALUES ('Citroen')
INSERT INTO CarBrand (Brand) VALUES ('Dacia')
INSERT INTO CarBrand (Brand) VALUES ('Daewoo')
INSERT INTO CarBrand (Brand) VALUES ('Daihatsu')
INSERT INTO CarBrand (Brand) VALUES ('DFM')
INSERT INTO CarBrand (Brand) VALUES ('Dodge')
INSERT INTO CarBrand (Brand) VALUES ('Ferrari')
INSERT INTO CarBrand (Brand) VALUES ('Fiat')
INSERT INTO CarBrand (Brand) VALUES ('Ford')
INSERT INTO CarBrand (Brand) VALUES ('Geely')
INSERT INTO CarBrand (Brand) VALUES ('Honda')
INSERT INTO CarBrand (Brand) VALUES ('Hyundai')
INSERT INTO CarBrand (Brand) VALUES ('Infiniti')
INSERT INTO CarBrand (Brand) VALUES ('Isuzu')
INSERT INTO CarBrand (Brand) VALUES ('Jaguar')
INSERT INTO CarBrand (Brand) VALUES ('Jeep')
INSERT INTO CarBrand (Brand) VALUES ('Kia')
INSERT INTO CarBrand (Brand) VALUES ('Lada')
INSERT INTO CarBrand (Brand) VALUES ('Lamborghini')
INSERT INTO CarBrand (Brand) VALUES ('Lancia')
INSERT INTO CarBrand (Brand) VALUES ('Land Rover')
INSERT INTO CarBrand (Brand) VALUES ('Maserati')
INSERT INTO CarBrand (Brand) VALUES ('Mazda')
INSERT INTO CarBrand (Brand) VALUES ('Mercedes')
INSERT INTO CarBrand (Brand) VALUES ('Mini')
INSERT INTO CarBrand (Brand) VALUES ('Mitsubishi')
INSERT INTO CarBrand (Brand) VALUES ('Nissan')
INSERT INTO CarBrand (Brand) VALUES ('Opel')
INSERT INTO CarBrand (Brand) VALUES ('Peugeot')
INSERT INTO CarBrand (Brand) VALUES ('Porsche')
INSERT INTO CarBrand (Brand) VALUES ('Proton')
INSERT INTO CarBrand (Brand) VALUES ('Renault')
INSERT INTO CarBrand (Brand) VALUES ('Rover')
INSERT INTO CarBrand (Brand) VALUES ('Saab')
INSERT INTO CarBrand (Brand) VALUES ('Seat')
INSERT INTO CarBrand (Brand) VALUES ('Skoda')
INSERT INTO CarBrand (Brand) VALUES ('Smart')
INSERT INTO CarBrand (Brand) VALUES ('SsangYong')
INSERT INTO CarBrand (Brand) VALUES ('Subaru')
INSERT INTO CarBrand (Brand) VALUES ('Suzuki')
INSERT INTO CarBrand (Brand) VALUES ('Tata')
INSERT INTO CarBrand (Brand) VALUES ('Tofas')
INSERT INTO CarBrand (Brand) VALUES ('Toyota')
INSERT INTO CarBrand (Brand) VALUES ('Volkswagen')
INSERT INTO CarBrand (Brand) VALUES ('Volvo')
COMMIT TRAN
insert [Log] (TableName,[Action],[status], [Description]) values ('CarBrand','INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
BEGIN CATCH
ROLLBACK TRAN 
insert [Log] (TableName,[Action],[status], [Description]) values ('CarBrand','INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
END CATCH
BEGIN TRY
INSERT INTO DictStat (Stat) VALUES ('Ár')
INSERT INTO DictStat (Stat) VALUES ('Akció')
INSERT INTO DictStat (Stat) VALUES ('Reklám')
INSERT INTO DictStat (Stat) VALUES ('Márkahûség')
INSERT INTO DictStat (Stat) VALUES ('Egyéb')
insert [Log] (TableName,[Action],[status], [Description]) values ('DictStat','INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('DictStat','INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
END CATCH
BEGIN TRY
INSERT INTO DictPaymentMode (DictPaymentModeID,DictPaymentMode) VALUES (1,'Készpénz')
INSERT INTO DictPaymentMode (DictPaymentModeID,DictPaymentMode) VALUES (2,'Bankártya')
INSERT INTO DictPaymentMode (DictPaymentModeID,DictPaymentMode) VALUES (3,'Átutalás')
INSERT INTO DictPaymentMode (DictPaymentModeID,DictPaymentMode) VALUES (4,'Hitel')
INSERT INTO DictPaymentMode (DictPaymentModeID,DictPaymentMode) VALUES (5,'Egyéb')
insert [Log] (TableName,[Action],[status], [Description]) values ('DictPaymentMode','INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('DictPaymentMode','INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
END CATCH
BEGIN TRY
INSERT INTO VAT (VATValue,[from],[to]) VALUES (25,'19950101','20051231')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (25,'20090701','20111231')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (27,'20120101','99991231')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (20,'20051001','20090630')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (5,'20040101','99991231')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (0,'19950101','20031231')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (12,'19950101','20031231')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (15,'20040101','20090630')
INSERT INTO VAT (VATValue,[from],[to]) VALUES (18,'20090701','99991231')
insert [Log] (TableName,[Action],[status], [Description]) values ('VAT','INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
BEGIN CATCH
insert [Log] (TableName,[Action],[status], [Description]) values ('VAT','INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
END CATCH
BEGIN TRY
BEGIN TRAN
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Szegvári Andor','Igazgato',1500000,'szandor')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Kósa Mária','Számlázás',300000,'kmaria')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Deutsch Antalné','Számlázás',300000,'dantalne')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Schütz Julcsa','Számlázás',300000,'sjulcsa')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Baracs Marcellné','Számlázás',300000,'bmarcellne')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Valerius Dávid','Eladó',300000,'vdavid')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Zwebner Ábrahám','Eladó',300000,'zabraham')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Fuchs Dávid Rafael','Eladó',300000,'fdrafael')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Schück Salamon','Eladó',300000,'ssalamon')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Krón Béla','Eladó',300000,'kbela')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Nagy József','Eladó',300000,'njozsef')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Gábor József','Eladó',300000,'gjozsef')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Fischer Dávid','Eladó',300000,'fdavid')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Kronberger Lipót','Eladó',300000,'klipot')
INSERT INTO Employee (FullName,Post,Payment,LoginName) VALUES ('Brüll Ignác','Eladó',300000,'bignac')
COMMIT TRAN
insert [Log] (TableName,[Action],[status], [Description]) values ('Employee','INSERT',1,'Sikerult betolteni az adatokat a táblába')
END TRY
BEGIN CATCH
ROLLBACK TRAN 
insert [Log] (TableName,[Action],[status], [Description]) values ('Employee','INSERT',0,'Nem sikerult betolteni az adatokat a táblába')
END CATCH
end






go




EXEC dbo.DataLoad @Directory='c:\'


go







/*
*********************************************************************************************************************************
View -k letrehozasa
*********************************************************************************************************************************
*/

go
CREATE OR ALTER VIEW dbo.vCar AS
----A 20 legolcsobb még nem eladott auto tulajdonsagai:
SELECT top 20
 CarBrand.Brand, CarModel.Model, [Note], [YearofManufacture], [Price],
   [Driveline], [Hybrid], [Fuel], [Transmission], [Climate], [NoPreviousOwner], [FuelInfoCity], [FuelInfoHighway], [Km]

  FROM car
  inner join CarModel on carmodel.CarModelID=car.CarModelID
  inner join CarBrand on CarBrand.CarBrandID=car.CarBrandID
  inner join CarDetail on CarDetail.CarID=car.CarID
  left join InvoiceDetail on car.CarID=InvoiceDetail.CarID where InvoiceDetail.CarID is null 
  order by Price


GO
CREATE OR ALTER VIEW vCarOfHalfYear 
AS

SELECT distinct Brand	  
  FROM [UsedCar].[dbo].[InvoiceDetail]
  join Invoice on Invoice.InvoiceID=InvoiceDetail.InvoiceID
  join car on car.carid=InvoiceDetail.CarID
  join CarBrand on CarBrand.CarBrandID=car.CarBrandID
  where unit >1 and 
  Discount=0 and
InvoiceDate> dateadd(m,-6,SYSdatetime())





GO
CREATE OR ALTER VIEW dbo.vInvoice AS
---Az ev dolgozoja tabla 
 
 select  FullName,[2000], [2001] ,[2002],[2003],[2004],[2005],[2006],[2007],[2008],[2009],[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019],[2020],[2021]

 FROM (
 		SELECT  FullName,year(InvoiceDate) [Year] ,ListPriceMultiplyPieceWithVATWithDiscount
 FROM Invoice
  inner join Employee on Invoice.EmployeeID=Employee.EmployeeID
 inner join InvoiceDetail on InvoiceDetail.InvoiceID=Invoice.InvoiceID ) q
 
 pivot (
 SUM(ListPriceMultiplyPieceWithVATWithDiscount)
  for [Year] in ([2000], [2001], [2002],[2003],[2004],[2005],[2006],[2007],[2008],[2009],[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019],[2020],[2021])  ) piv

 go
go
CREATE OR ALTER VIEW dbo.vInvoiceDetail2 AS
---Melyik dolgozo melyik fizetesi modbol (afankent) mennyit csinalt


select 
FullName,
DictPaymentMode.DictPaymentMode,
VATValue,Count(1) [No]
 


from [dbo].[InvoiceDetail]
inner join Invoice on Invoice.InvoiceID=InvoiceDetail.InvoiceID
inner join [dbo].[Employee] on [dbo].[Employee].EmployeeID=Invoice.EmployeeID
inner join [dbo].[DictPaymentMode] on [dbo].[DictPaymentMode].DictPaymentModeID=InvoiceDetail.DictPaymentMode
inner join VAT on VAT.VATID=InvoiceDetail.VATID
group by 
FullName,
DictPaymentMode.DictPaymentMode,
VATValue


go
CREATE OR ALTER VIEW dbo.vInvoiceDetail AS
------Honnan van a legtobb vasarlonk

select top (10) City,count(1) [No]

 from InvoiceDetail
inner join Invoice on Invoice.InvoiceID=InvoiceDetail.InvoiceID
inner join Client on Invoice.ClientID=Client.ClientID
group by City
order by [No] desc

go



/*
*********************************************************************************************************************************
Tarolt Eljarasok
*********************************************************************************************************************************
*/


go

CREATE or ALTER PROCEDURE db_datawriter.NewInvoice 

@ClientID int, 
@InvoiceDate date,
@ShipDate date, 
@EmployeeID int, 
@CarID int, 
@Unit tinyint =1, 
@Discount tinyint=0, 
@VATID int, 
@DictPaymentMode tinyint=1, 
@DictStat int=1



       
AS SET NOCOUNT ON
BEGIN 
declare @t table(t int)
BEGIN TRY
BEGIN TRAN
   INSERT INTO Invoice (ClientID,InvoiceDate,ShipDate,EmployeeID) OUTPUT INSERTED.InvoiceID  INTO @T  VALUES   (  @ClientID, @InvoiceDate, @ShipDate, @EmployeeID)
   INSERT INTO InvoiceDetail(InvoiceID,CarID,Unit,Discount,VATID,DictPaymentMode,DictStat)  VALUES   (   (select t from @t),@CarID, @Unit, @Discount, @VATID,@DictPaymentMode,@DictStat) 
COMMIT TRAN
  insert [Log] (TableName,[Action],[status], [Description]) values ('Invoice','INSERT',1,'Sikerult felvenni az adatokat a táblába')
END TRY
BEGIN CATCH
	ROLLBACK TRAN 
    insert [Log] (TableName,[Action],[status], [Description]) values ('Invoice','INSERT',0,'Nem sikerult felvenni az adatokat a táblába')
END CATCH
END 

GO





---Szamla felvet Proba
--exec db_datawriter.NewInvoice
--   @ClientID    = '15',
--   @InvoiceDate ='20210722',
--   @ShipDate         = '20210712',
--    @EmployeeID = '10' ,
--    @CarID =323, 
--     @VATID =2, 
--     @DictStat =2





CREATE OR ALTER PROCEDURE dbo.Search
@Brand varchar(20)=NULL,
@Model varchar(70)=NULL,
@Note varchar(max)=NULL,
@YearofManufacture smallint=NULL,
@Price int=NULL,
@Driveline varchar(10)=NULL,
@Hybrid bit=1,
@Fuel varchar(10)=NULL,
@Transmission varchar(10)=NULL,
@Climate bit=1,
@NoPreviousOwner tinyint=NULL,
@FuelInfoCity tinyint=NULL,
@FuelInfoHighway tinyint=NULL,
@Km int = NULL


AS
BEGIN
SET NOCOUNT ON

select Brand,Model,Note,YearofManufacture,Price,Driveline,Hybrid,Fuel,Transmission,Climate,NoPreviousOwner,FuelInfoCity,FuelInfoHighway,Km
from Car 
join CarBrand on Car.CarBrandID=CarBrand.CarBrandID
join CarModel on CarModel.CarModelID=car.CarModelID 
join CarDetail on CarDetail.CarID=Car.CarID
where 
 (car.CarID not in (select CarID from InvoiceDetail)) AND
 (@Brand IS NULL OR CarBrand.Brand LIKE '%' + @Brand + '%') AND
 (@Model IS NULL OR CarModel.Model LIKE '%' + @Model + '%') AND
 (@Note IS NULL OR Car.Note LIKE '%' + @Note + '%') AND
 (@YearofManufacture IS NULL OR Car.YearofManufacture = @YearofManufacture) AND
 (@Price IS NULL OR  (Car.Price / @Price)<1.5    ) AND
 (@Km IS NULL OR  (CarDetail.Km / @Km)<1.5    ) AND
 (@FuelInfoHighway  IS NULL OR  CarDetail.FuelInfoHighway <= @FuelInfoHighway     ) AND
 (@FuelInfoCity  IS NULL OR  CarDetail.FuelInfoCity <= @FuelInfoCity     ) AND
 (@NoPreviousOwner   IS NULL OR  CarDetail.NoPreviousOwner  <= @NoPreviousOwner      ) AND
 (@Hybrid IS NULL OR CarDetail.Hybrid = @Hybrid) AND
 (@Climate IS NULL OR CarDetail.Climate = @Climate) AND
 (@Fuel  IS NULL OR Cardetail.Fuel  LIKE '%' + @Fuel  + '%') AND
 (@Driveline  IS NULL OR Cardetail.Driveline  LIKE '%' + @Driveline  + '%') AND
 (@Transmission  IS NULL OR Cardetail.Transmission  LIKE '%' + @Transmission  + '%') 
 order by Price
END
GO





--exec Search @Brand='Alfa',@fuel='diz',@YearofManufacture=2014
 


	
	
	GO

GRANT EXECUTE ON [dbo].[Search] TO [WebShop]
GRANT SELECT ON [dbo].[vCarOfHalfYear] TO [WebShop]



	/*
*********************************************************************************************************************************
A naplo triggere
*********************************************************************************************************************************
*/
go
CREATE OR ALTER TRIGGER TR_Log ON [Log] FOR  UPDATE, DELETE
AS
	IF @@NESTLEVEL = 1 ROLLBACK TRAN
GO	


use [UsedCar]
GO
DENY ALTER ON 	Car	TO	bmarcellne
DENY DELETE ON	Car	TO	bmarcellne
DENY INSERT ON 	Car	TO	bmarcellne
DENY UPDATE ON	Car	TO	bmarcellne
DENY ALTER ON 	CarDetail	TO	bmarcellne
DENY DELETE ON	CarDetail	TO	bmarcellne
DENY INSERT ON 	CarDetail	TO	bmarcellne
DENY UPDATE ON	CarDetail	TO	bmarcellne
DENY ALTER ON 	CarBrand	TO	bmarcellne
DENY DELETE ON	CarBrand	TO	bmarcellne
DENY INSERT ON 	CarBrand	TO	bmarcellne
DENY UPDATE ON	CarBrand	TO	bmarcellne
DENY ALTER ON 	CarModel	TO	bmarcellne
DENY DELETE ON	CarModel	TO	bmarcellne
DENY INSERT ON 	CarModel	TO	bmarcellne
DENY UPDATE ON	CarModel	TO	bmarcellne
DENY ALTER ON 	DictStat	TO	bmarcellne
DENY DELETE ON	DictStat	TO	bmarcellne
DENY INSERT ON 	DictStat	TO	bmarcellne
DENY UPDATE ON	DictStat	TO	bmarcellne
DENY ALTER ON 	Employee	TO	bmarcellne
DENY DELETE ON	Employee	TO	bmarcellne
DENY INSERT ON 	Employee	TO	bmarcellne
DENY UPDATE ON	Employee	TO	bmarcellne
DENY ALTER ON 	PostCode	TO	bmarcellne
DENY DELETE ON	PostCode	TO	bmarcellne
DENY INSERT ON 	PostCode	TO	bmarcellne
DENY UPDATE ON	PostCode	TO	bmarcellne
DENY ALTER ON 	Log	TO	bmarcellne
DENY DELETE ON	Log	TO	bmarcellne
DENY INSERT ON 	Log	TO	bmarcellne
DENY UPDATE ON	Log	TO	bmarcellne
DENY ALTER ON 	Car	TO	kmaria
DENY DELETE ON	Car	TO	kmaria
DENY INSERT ON 	Car	TO	kmaria
DENY UPDATE ON	Car	TO	kmaria
DENY ALTER ON 	CarDetail	TO	kmaria
DENY DELETE ON	CarDetail	TO	kmaria
DENY INSERT ON 	CarDetail	TO	kmaria
DENY UPDATE ON	CarDetail	TO	kmaria
DENY ALTER ON 	CarBrand	TO	kmaria
DENY DELETE ON	CarBrand	TO	kmaria
DENY INSERT ON 	CarBrand	TO	kmaria
DENY UPDATE ON	CarBrand	TO	kmaria
DENY ALTER ON 	CarModel	TO	kmaria
DENY DELETE ON	CarModel	TO	kmaria
DENY INSERT ON 	CarModel	TO	kmaria
DENY UPDATE ON	CarModel	TO	kmaria
DENY ALTER ON 	DictStat	TO	kmaria
DENY DELETE ON	DictStat	TO	kmaria
DENY INSERT ON 	DictStat	TO	kmaria
DENY UPDATE ON	DictStat	TO	kmaria
DENY ALTER ON 	Employee	TO	kmaria
DENY DELETE ON	Employee	TO	kmaria
DENY INSERT ON 	Employee	TO	kmaria
DENY UPDATE ON	Employee	TO	kmaria
DENY ALTER ON 	PostCode	TO	kmaria
DENY DELETE ON	PostCode	TO	kmaria
DENY INSERT ON 	PostCode	TO	kmaria
DENY UPDATE ON	PostCode	TO	kmaria
DENY ALTER ON 	Log	TO	kmaria
DENY DELETE ON	Log	TO	kmaria
DENY INSERT ON 	Log	TO	kmaria
DENY UPDATE ON	Log	TO	kmaria
DENY ALTER ON 	Car	TO	dantalne
DENY DELETE ON	Car	TO	dantalne
DENY INSERT ON 	Car	TO	dantalne
DENY UPDATE ON	Car	TO	dantalne
DENY ALTER ON 	CarDetail	TO	dantalne
DENY DELETE ON	CarDetail	TO	dantalne
DENY INSERT ON 	CarDetail	TO	dantalne
DENY UPDATE ON	CarDetail	TO	dantalne
DENY ALTER ON 	CarBrand	TO	dantalne
DENY DELETE ON	CarBrand	TO	dantalne
DENY INSERT ON 	CarBrand	TO	dantalne
DENY UPDATE ON	CarBrand	TO	dantalne
DENY ALTER ON 	CarModel	TO	dantalne
DENY DELETE ON	CarModel	TO	dantalne
DENY INSERT ON 	CarModel	TO	dantalne
DENY UPDATE ON	CarModel	TO	dantalne
DENY ALTER ON 	DictStat	TO	dantalne
DENY DELETE ON	DictStat	TO	dantalne
DENY INSERT ON 	DictStat	TO	dantalne
DENY UPDATE ON	DictStat	TO	dantalne
DENY ALTER ON 	Employee	TO	dantalne
DENY DELETE ON	Employee	TO	dantalne
DENY INSERT ON 	Employee	TO	dantalne
DENY UPDATE ON	Employee	TO	dantalne
DENY ALTER ON 	PostCode	TO	dantalne
DENY DELETE ON	PostCode	TO	dantalne
DENY INSERT ON 	PostCode	TO	dantalne
DENY UPDATE ON	PostCode	TO	dantalne
DENY ALTER ON 	Log	TO	dantalne
DENY DELETE ON	Log	TO	dantalne
DENY INSERT ON 	Log	TO	dantalne
DENY UPDATE ON	Log	TO	dantalne
DENY ALTER ON 	Car	TO	sjulcsa
DENY DELETE ON	Car	TO	sjulcsa
DENY INSERT ON 	Car	TO	sjulcsa
DENY UPDATE ON	Car	TO	sjulcsa
DENY ALTER ON 	CarDetail	TO	sjulcsa
DENY DELETE ON	CarDetail	TO	sjulcsa
DENY INSERT ON 	CarDetail	TO	sjulcsa
DENY UPDATE ON	CarDetail	TO	sjulcsa
DENY ALTER ON 	CarBrand	TO	sjulcsa
DENY DELETE ON	CarBrand	TO	sjulcsa
DENY INSERT ON 	CarBrand	TO	sjulcsa
DENY UPDATE ON	CarBrand	TO	sjulcsa
DENY ALTER ON 	CarModel	TO	sjulcsa
DENY DELETE ON	CarModel	TO	sjulcsa
DENY INSERT ON 	CarModel	TO	sjulcsa
DENY UPDATE ON	CarModel	TO	sjulcsa
DENY ALTER ON 	DictStat	TO	sjulcsa
DENY DELETE ON	DictStat	TO	sjulcsa
DENY INSERT ON 	DictStat	TO	sjulcsa
DENY UPDATE ON	DictStat	TO	sjulcsa
DENY ALTER ON 	Employee	TO	sjulcsa
DENY DELETE ON	Employee	TO	sjulcsa
DENY INSERT ON 	Employee	TO	sjulcsa
DENY UPDATE ON	Employee	TO	sjulcsa
DENY ALTER ON 	PostCode	TO	sjulcsa
DENY DELETE ON	PostCode	TO	sjulcsa
DENY INSERT ON 	PostCode	TO	sjulcsa
DENY UPDATE ON	PostCode	TO	sjulcsa
DENY ALTER ON 	Log	TO	sjulcsa
DENY DELETE ON	Log	TO	sjulcsa
DENY INSERT ON 	Log	TO	sjulcsa
DENY UPDATE ON	Log	TO	sjulcsa

use [UsedCar]
go
GRANT EXECUTE ON [dbo].[Search] TO vdavid
GRANT EXECUTE ON [dbo].[Search] TO zabraham
GRANT EXECUTE ON [dbo].[Search] TO fdrafael
GRANT EXECUTE ON [dbo].[Search] TO ssalamon
GRANT EXECUTE ON [dbo].[Search] TO kbela
GRANT EXECUTE ON [dbo].[Search] TO njozsef
GRANT EXECUTE ON [dbo].[Search] TO gjozsef
GRANT EXECUTE ON [dbo].[Search] TO fdavid
GRANT EXECUTE ON [dbo].[Search] TO klipot
GRANT EXECUTE ON [dbo].[Search] TO bignac
