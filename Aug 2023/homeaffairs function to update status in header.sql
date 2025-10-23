CREATE or ALTER FUNCTION dbo.fCore_Var1003(@s xml)
RETURNS varchar(50)
AS
BEGIN
    DECLARE @Status varchar(50), @Id int, @DeliveredCount int, @TotalCount int,@Res int
    SELECT @Id = @s.value('(/Fields/Header/TransId)[1]','int')
    SELECT @DeliveredCount = COUNT(*) FROM vuCore_FDSalesOrder_Inventory_Details WITH(NOLOCK) 
	WHERE iMasterId = @Id AND InvStatus = 6
    SELECT @Res = COUNT(*) FROM vuCore_FDSalesOrder_Inventory_Details WITH(NOLOCK) 
	WHERE iMasterId = @Id AND InvStatus = 2
    SELECT @TotalCount = COUNT(*) FROM vuCore_FDSalesOrder_Inventory_Details WITH(NOLOCK)
	WHERE iMasterId = @Id

    IF (@DeliveredCount = @TotalCount)
        SET @Status ='Delivered'  
    ELSE IF @DeliveredCount >0
        SET @Status = 'Partial Delivered'  
    ELSE if @Res= @TotalCount
        SET @Status = 'Reserved' 

    RETURN @Status
END
