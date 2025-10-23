ALTER function dbo.fCore_Var8082(@s xml)
returns decimal(18,2)
as
begin
	declare @fret decimal(18,2)
	declare @sUrl varchar(max)='http://122.175.13.120/Focus8api/GetExecSqlScalar?sCompCode=020&SqlCommand=';

	declare @iDate int =  dbo.fCore_DateToInt(getdate())

	declare @iProdId int,@iWh int,@sCode varchar(max),@lCode varchar(max);
	select @iProdId = @s.value('(Fields/BodyData/BodyRow/iProductId)[1]','int');
	select @iWh = @s.value('(Fields/BodyData/BodyRow/location)[1]','int');
	select @sCode= sCode from vCore_Product with(nolock) where iMasterId=@iProdId;
	select @lCode= sCode from vCore_Location with(nolock) where iMasterId=@iWh;

	set @sUrl = @sUrl+'declare @fret decimal(18,2),@iMasterid int=0,@Wh int=0 
	select top 1 @iMasterid=iMasterId from vCore_Product with(nolock) where sCode='''+@sCode+'''
	select top 1 @Wh=iMasterId from vCore_Location with(nolock) where sCode='''+@lCode+'''
	select @fret=dbo.[udf_ProdBalQtyWH]('+cast(@iDate as varchar(20))+',@iMasterid,@Wh) select @fret';

	
	select @fret=convert(decimal(18,2),value) from OPENJSON(dbo.SendGetRequest(@sUrl)) 
	with (url varchar(500) '$.url',data2 nvarchar(max) '$.data' as JSON, result int '$.result')
	cross apply openjson(data2) with (Obj1 nvarchar(max) '$' as json)
	cross apply openjson(Obj1) 
	return @fret
	end

--http://122.175.13.120/Focus8api/GetExecSqlScalar?sCompCode=020&SqlCommand=declare @fret decimal(18,2),@iMasterid int,@iWh int
--	select top 1 @iMasterid=iMasterId from vCore_Product where sCode='A87M090' 
--	select top 1 @iWh=iMasterId from vCore_Location where sCode='HYD' 
--	select @fret=dbo.[udf_ProdBalQtyWH](132581380,@iMasterid,@iWh) 
--	select @fret;

	--select  sName from vCore_Product where sCode='A87M090' 