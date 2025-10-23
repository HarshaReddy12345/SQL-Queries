OVERALL STOCK ON DIFFERENT SERVER
---------------------------------
ALTER function dbo.fCore_Var8082(@s xml)
returns decimal(18,2)
as
begin
	declare @fret decimal(18,2)
	declare @sUrl varchar(max)='http://122.175.13.120/Focus8api/GetExecSqlScalar?sCompCode=020&SqlCommand=declare @fret decimal(18,2),@iMasterid int,@iWh int
	select top 1 @iMasterid=iMasterId from vCore_Product where sCode='A87M090' 
	select top 1 @iWh=iMasterId from vCore_Location where sCode='HYD' 
	select @fret=dbo.[udf_ProdBalQtyWH]('+cast(@iDate as varchar(20))+',@iMasterid,@iWh) 
	select @fret;
	s
end


select dbo.fCrm_ConvBase36ToInt(020)


select dbo.fCore_DateToInt(getdate())


https://focus14.focussoftnet.net/Focus8API/GetExecSqlScalar?sCompCode=0P0&SqlCommand=declare @fret decimal(18,2),@iMasterid int=0,@Wh int=0 
	select top 1 @iMasterid=iMasterId from vCore_Product where sCode='64224' 
	select @fret=dbo.[fCore_GetProductRate](0,64224,0,14,132646657,36,18,0,0,0,'') select @fret 
	select @fret;
 

==============================================================================================================================
OVERALL STOCK ON SAME SERVER
---------------------------------
CREATE function dbo.fCore_Var8082(@s xml)
returns decimal(18,2)
as
begin
	declare @fret decimal(18,2)

	declare @sDate varchar(20) = convert(varchar(20),dbo.fCore_DateToInt(getdate()))
	declare @iProdId int,@iWh int,@sCode varchar(300);
	select @iProdId = @s.value('(Fields/BodyData/BodyRow/iProductId)[1]','int');
	select @sCode= sCode from vCore_Product with(nolock) where iMasterId=@iProdId;

	declare @iMasterid varchar(200) 
	select top 1 @iMasterid=iMasterId from Focus82O0..vCore_Product where sCode=@sCode 
	select @fret=Focus82O0.dbo.[udf_ProdBalQtyWH]('+@iDate+',@iMasterid) 
	return @fret
end
==================================================================================================================================
WAREHOUSE WISE STOCK ON SAME SERVER
------------------------------------
ALTER function dbo.fCore_Var8082(@s xml)
returns decimal(18,2)
as
begin
	declare @fret decimal(18,2)

	declare @sDate varchar(20) = convert(varchar(20),dbo.fCore_DateToInt(getdate()))
	declare @iProdId int,@iWh int,@sCode varchar(300),@StockCode varchar(max)
	select @iProdId = @s.value('(Fields/BodyData/BodyRow/iProductId)[1]','int');
	select @iWh = @s.value('(Fields/BodyData/BodyRow/WareHouse)[1]','int');

	select @sCode= sCode from vCore_Product with(nolock) where iMasterId=@iProdId;
	select @StockCode= sCode from vCore_Location with(nolock) where iMasterId=@iWh;

	declare @iMasterid int,@iWarehouse int
	select top 1 @iMasterid=iMasterId from Focus82O0..vCore_Product where sCode=@sCode
	select top 1 @iWarehouse=iMasterId from Focus82O0..vCore_Warehouse where sCode=@StockCode

	
	select @fret=Focus82O0.dbo.[udf_ProdBalQtyWH]('+@iDate+',@iMasterid,@iWarehouse) 

	return @fret
end
==================================================================================================================================
WAREHOUSE WISE STOCK ON DIFFERENT SERVER
-------------------------------------------
ALTER function dbo.fCore_Var8082(@s xml)
returns decimal(18,2)
as
begin
	declare @fret decimal(18,2)
	declare @sUrl varchar(max)='http://150.230.234.243/Focus8api/GetExecSqlScalar?sCompCode=020&SqlCommand=';

	declare @sDate varchar(20) = convert(varchar(20),dbo.fCore_DateToInt(getdate()))
	declare @iProdId int,@sCode varchar(300),@StockPoint int,@StockCode varchar(300);
	select @iProdId = @s.value('(Fields/BodyData/BodyRow/iProductId)[1]','int');
	select @StockPoint = @s.value('(Fields/Header/StockPoint)[1]','int');
	select @sCode= sCode from vCore_Product with(nolock) where iMasterId=@iProdId;
	select @StockCode= sCode from vCore_StockPoint with(nolock) where iMasterId=@StockPoint;

	set @sUrl = @sUrl+'declare @fret decimal(18,2),@iMasterid int=0,@Wh int=0 
	select top 1 @iMasterid=iMasterId from vCore_Product with(nolock) where sCode='''+@sCode+'''
	select top 1 @Wh=iMasterId from vCore_Warehouse with(nolock) where sCode='''+@StockCode+'''
	select @fret=dbo.[udf_ProdBalQtyWH]('+@iDate+',@iMasterid,@Wh) select @fret';
	select @fret=convert(decimal(18,2),value) from OPENJSON(dbo.SendGetRequest(@sUrl)) 
	with (url varchar(500) '$.url',data2 nvarchar(max) '$.data' as JSON, result int '$.result')
	cross apply openjson(data2) with (Obj1 nvarchar(max) '$' as json)
	cross apply openjson(Obj1) 
	return @fret
end