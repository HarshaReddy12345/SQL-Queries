CREATE OR ALTER PROCEDURE udp_UpdateGrid (@iMasterId BIGINT, @iUserId INT)
AS
BEGIN
		Declare @ProductionOrder int
		declare @Inventory int
		SELECT @iMasterId = dbo.fCrm_IntToAPITransId(@iMasterId, 0)
		select @ProductionOrder=ProductionOrder from vuCore_ProductionStageUpdate_General_Details WITH(NOLOCK) where iMasterId=@iMasterId
		select @Inventory=ConsumeInventory from vCore_Stage WITH(NOLOCK) where iMasterId in(Select  CurrentStage 
		from muCore_ProductionStageUpdate a WITH(NOLOCK) where a.iMasterId=@iMasterId)
		if (@Inventory=2)
		begin
		INSERT INTO muCore_ProductionStageUpdate_InventoryConsumption_Details (iRowIndex, iMasterId, Product, AvailableQty, ConsumedInventory)
		SELECT ROW_NUMBER() OVER (ORDER BY a.iMasterId) - 1, @iMasterId, a.Product, a.FrameQtyAvailable, a.FrameQuantitySelected 
		FROM vuCore_ProductionOrders_General_Details a WITH(NOLOCK)
		INNER JOIN muCore_Stage d WITH(NOLOCK) ON a.POStage = d.iMasterId
		WHERE a.iMasterId = @ProductionOrder 
		end
END


