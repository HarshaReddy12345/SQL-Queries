SELECT COUNT(1) AS [Count],b.iMasterId,b.sCode,b.sDescription,b.NetWeight, b.Rate,b.[GST Rate],b.Packaging,b.Ingredients,b.Benefits,b.PerPeicesWeight,b.HSN, b.ShelfLife,b.sImageUrl
FROM rptProduct a
INNER JOIN ( select iMasterId,
    sCode,
    sDescription,
    NetWeight,
    Rate,
    [GST Rate],
    Packaging,
    Ingredients,
    Benefits,
    PerPeicesWeight,
    HSN,
    ShelfLife,
    sImageUrl
    --COUNT(1) AS [Count] 
	from rptProduct1
	where [type] in ()  
) b ON a.iMasterId = b.iMasterId
	where b.iMasterId=5301
	GROUP BY b.sCode,b.iMasterId,
    b.sDescription,
    b.NetWeight,
    b.Rate,
    b.[GST Rate],
    b.Packaging,
    b.Ingredients,
    b.Benefits,
    b.PerPeicesWeight,
    b.HSN,
    b.ShelfLife,
    b.sImageUrl


	select * from vCore_Budget