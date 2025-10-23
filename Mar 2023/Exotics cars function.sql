Alter function [dbo].[fCore_Var100](@s xml)
returns int
as
begin
	declare @iProductId int
	Declare @iAccount int
	Declare @iLocationId int
	declare @Placeofsupply int
	declare @jurisdiction int
	declare @isTaxable int

	declare @fPercentage decimal(18,2)

	select @iProductId=@s.value('(/Fields/BodyData/BodyRow/Product1)[1]','int')
	select @iAccount=@s.value('(/Fields/Header/Customer)[1]','int')
	select @iLocationId=@s.value('(/Fields/Header/iLocationId)[1]','int')


	select top 1 @Placeofsupply = Placeofsupply from vCore_Account with(nolock) where iMasterId=@iAccount
	select top 1 @jurisdiction = jurisdiction from vCore_Location with(nolock) where iMasterId=@iLocationId
	select top 1 @isTaxable = ISNULL(iMasterId,0) from vCore_Product with(nolock) where iMasterId=@iProductId and Tax=1

	if(ISNULL(@isTaxable,0)=0)
	begin
		return 0.00;
	end

	select top 1 @fPercentage =TaxesPerct from vuCore_TaxMaster_General_Details with(nolock) 
	where iMasterId>0 and dbo.fCore_IntToDate(WEFDate)<=GETDATE() 
	and Placeofsupply=@Placeofsupply and jurisdiction=@jurisdiction order by WEFDate desc

	return @fPercentage
end



select * from vRpt_StockBlanace
