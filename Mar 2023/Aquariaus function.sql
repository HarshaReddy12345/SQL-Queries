ALTER FUNCTION [dbo].[fCore_Var100](@s xml)
RETURNS INT
AS
BEGIN
	DECLARE @iQty int
	DECLARE @iQtyOpp int
	DECLARE @Opportunity INT
	
	--SELECT @iQty = @s.value('(/Fields/BodyData/BodyRow/iQuantity)[1]','decimal(18,2)')
	SELECT @Opportunity = @s.value('(/Fields/Header/Opportunity)[1]','int')

	SELECT @iQtyOpp = SUM(iQuantity) FROM vuCrm_Opportunities_General_Details with(nolock) WHERE iTransId = @Opportunity;
	SELECT @iQty = COUNT(iMasterId) FROM vCore_OFMTechnicalandCommercial WHERE Opportunity = @Opportunity;

	--SET @Opportunity = (SELECT COUNT(Opportunity) FROM vCrm_OFMTechnicalandCommercial WHERE Opportunity = @Opportunity)

	IF ISNULL(@iQty,0) <= ISNULL(@iQtyOpp,0)+1
	BEGIN
		RETURN 0
	END

	RETURN 1
END


