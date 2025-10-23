create or alter Procedure A_UpdateModule(@iTransId bigint,@iUserId int)
as 
begin

	select @iTransId = dbo.fCrm_IntToAPITransId(@iTransId,0)
	update vCrm_PMSContract set sTerms=dbo.GET_NUM2WORD(fAmountJH) where iTransId=@iTransId
end



