CREATE or ALTER view rptProduct as  
SELECT  
    sCode,  
    iMasterId,  
    a.sName,  
    ISNULL(sDescription, '') AS [sDescription],  
    NetWeight,  
    Rate,  
    CONCAT(GSTRate, '%') AS [GST Rate],  
    Packaging,  
    Ingredients,  
    Benefits,  
    PerPeicesWeight,  
    HSN,  
    ShelfLife,  
    CONCAT('http://localhost:8181/ResourceFromCRM/getres?cc=&docid=', iDocId) AS sImageUrl,  
    CAST(ISNULL(Brand, '') as VARCHAR(max)) AS Brand,  
    ISNULL(Budget, 0) AS Budget,  
    ISNULL(Category, 0) AS Category,  
    Holi,  
    Diwali,  
    NewYear,  
    GaneshChaturthi,  
    OtherFestival,  
    IndependanceDay,  
    DoctorsDay,  
    WomensDay,  
    MothersDay,  
    ValentinesDay,  
    Launch,  
    YearCelebration,  
    HealthRelated,  
    BreakfastKit,  
    EmployeeGifting,  
    WinterTheme,  
    ThemeSeries  ,SummerTheme
FROM vCore_Product a  
LEFT JOIN (  
    SELECT dbo.fCrm_getAPITransId(vCrm_Documents.iMasterId, 2563, 0) AS iDocId, iRelatedTo  
    FROM vCrm_Documents WITH (NOLOCK)  
    WHERE iModuleTypeId = 2306 AND iFieldId = 300576  
) AS Docs ON Docs.iRelatedTo = a.iMasterId  
WHERE a.iMasterId>0