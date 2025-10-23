SELECT
  ISNULL(requestno, '') [rqt],
  *
FROM (SELECT
  iTransId Contractid,
  iCustAssetId,
  OrderMonth,
  OrderYear,
  MonthYear,
  --RWeek,
  Week,
  sName
FROM (SELECT DISTINCT
       --RWeek,
       Week,
       MonthYear,
       OrderYear,
       OrderMonth
     FROM date_week_sequenc
     WHERE iDate BETWEEN (SELECT
       iStartDate
     FROM vCrm_Contract
     WHERE iTransId = 65
	 )
     AND (SELECT
       iEndDate
     FROM vCrm_Contract
     WHERE iTransId = 65
	 )
	 ) w,
     vuCrm_Contract_General_Details
WHERE iTransId = 65
) weeks
RIGHT OUTER JOIN (SELECT
  c.sName [Contract Name],
  c.iTransId,
  c.iCustomerId,
  cus.sName CustomerName,
  c.iFrequencyId,
  r.iProductId,
  r.iDueDate,
  c.iCustAssetId CustAssetId,
  ft.sName Frequency,
  CASE
    WHEN ISNULL(r.sName, '') <> '' THEN 1
  END requestno,
  datediff(ww,datediff(d,0,dateadd(m,datediff(m,7,dbo.fCore_IntToDate(iDueDate)),0)
    )/7*7,dateadd(d,-1,dbo.fCore_IntToDate(iDueDate)))+1 [DueWeek]
FROM vuCrm_Contract_General_Details c
--JOIN tuCrm_Contract_General_Details ca
--  ON c.iTransId = ca.iTransId
JOIN vCrm_Calls r
  ON r.iCustAssetId = c.iCustAssetId
  AND r.iContractId = c.iTransId
JOIN vCrm_FrequencyTemplate ft
  ON c.iFrequencyId = ft.iFrequencyId
JOIN vCore_Account cus
  ON c.iCustomerId = cus.iMasterId
WHERE c.iTransId > 0
AND c.iTransId = 65) AA
  ON AA.DueWeek = weeks.Week
  AND weeks.iCustAssetId = AA.CustAssetId
  AND AA.iTransId = weeks.Contractid
LEFT JOIN (SELECT
  COUNT(b.iTransId) [Cnt],
  a.iContractId,
  c.iMasterId
FROM tCrm_ContractSchedule a
INNER JOIN vCrm_CustAssets b
  ON a.iCustAsset = b.iTransId
INNER JOIN vCore_Product c
  ON b.iProductId = c.iMasterId
WHERE iTransId > 0 
GROUP BY a.iContractId,
         c.iMasterId) bb
  ON AA.iProductId = bb.iMasterId
  AND AA.iTransId = bb.iContractId

--------------------------------------------------------------------------------------------------------

alter VIEW date_week_sequenc as
WITH numbers AS (
  SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS num
  FROM sys.columns AS c1
  CROSS JOIN sys.columns AS c2
),
date_sequence AS (
  SELECT DATEADD(day, num - 1, '2000-01-01') AS date
  FROM numbers
  WHERE num <= DATEDIFF(day, '2000-01-01', '2030-01-01')
),
date_week_sequence AS (
  SELECT DISTINCT 
         datediff(ww,datediff(d,0,dateadd(m,datediff(m,7,date),0)
    )/7*7,dateadd(d,-1,date))+1 Week,
         CONCAT(
           DATENAME(MONTH, date), 
           '-', 
           DATEPART(YEAR, date)
         ) AS MonthYear,
         DATEPART(YEAR, date) AS OrderYear,
         DATEPART(MONTH, date) AS OrderMonth,
		 dbo.fCore_DateToInt(date) [iDate]
  FROM date_sequence
)
select * from date_week_sequence

