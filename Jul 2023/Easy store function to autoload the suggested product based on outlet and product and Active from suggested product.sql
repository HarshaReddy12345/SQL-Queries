create FUNCTION [dbo].[fCore_Var1] (@s xml)
RETURNS INT
AS
BEGIN
    DECLARE @Outlet INT, @ProductId INT, @SugProd INT, @OTL INT, @Name INT, @Active BIT

    SELECT @Outlet = @s.value('(/Fields/Header/Outlet)[1]', 'INT')
    SELECT @ProductId = @s.value('(/Fields/BodyData/BodyRow/iProductId)[1]', 'INT')
    SELECT @OTL = Outlet, @SugProd = Product, @Active = Active
    FROM vCore_SuggestedProducts
    WHERE Outlet = @Outlet AND Product = @ProductId

   -- IF (@Outlet = @OTL AND @ProductId = @SugProd AND @Active = 1)
        SELECT TOP 1 @Name = iMasterId
        FROM vCore_SuggestedProducts
        WHERE Outlet = @Outlet AND Product = @ProductId AND Active = 1
    RETURN @Name
END
