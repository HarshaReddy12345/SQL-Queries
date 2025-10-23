CREATE or ALTER procedure udp_ContractToRequest(@iTransId bigint=0,@iUserId int=0)    
as    
begin      
		Declare @ContractCustom int
		select @iTransId  =dbo.fCrm_IntToAPITransId(@iTransId,0)
		select @ContractCustom=ContractCustom  from vuCrm_Calls_General_Details where iTransId=@iTransId

		declare @iMaxBodyId int;
		select @iMaxBodyId =max(iBodyId) from tuCrm_Calls_ContractAssetDetails_Details with(nolock) where iTransId>0

		INSERT into tuCrm_Calls_ContractAssetDetails_Details(iBodyId,iSequence,iTransId,ProductPartCode,Asset,
		ProductBrand,ProductDescription,ProductGroup,ProductModel,ProductType,HSNCode)
		SELECT ROW_NUMBER() OVER (ORDER BY a.iMasterId)+@iMaxBodyId,ROW_NUMBER() OVER (ORDER BY a.iMasterId)-1, @iTransId,a.Product,a.Asset,
		ProductBrand,ProductDescription,ProductGroup,ProductModel,ProductType,HSNCode
		FROM vuCore_ContractCustom_General_Details a
		WHERE a.iMasterId = @ContractCustom;
end
 
