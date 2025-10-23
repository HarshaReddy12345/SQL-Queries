CREATE PROC udp_UpdateProductStatusFromSoToSe (@iTransId bigint,@iUserId int=0)
as
BEGIN
DECLARE @ProductStatus int,@Opp int
select @iTransId=dbo.fCrm_IntToAPITransId(@iTransId,0)
select @Opp=iOpportunityId,@ProductStatus=ProductStatus from vuCrm_SalesOrder_General_Details where iTransId=@iTransId
Update a set a.ProductStatus=b.ProductStatus
from vuCrm_Opportunities_General_Details a
join vuCrm_SalesOrder_General_Details b on a.iTransId=b.iOpportunityId and a.iProductId=b.iProductId
where b.iTransId=@iTransId
END