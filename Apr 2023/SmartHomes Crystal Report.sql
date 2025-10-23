SELECT iTransId,
       iTransId,[Floor],[Control],[Type of Load],
       CASE WHEN val = 0 THEN null ELSE val END AS val,
       [type]
FROM (
    SELECT e.iTransId,
           ISNULL(f.sName, '') AS [Floor],
           ISNULL(i.sName, '') AS [Control],
           ISNULL(e.TypeofLoad, '') AS [Type of Load],
           ISNULL(e.Switchingcircuit, 0) AS [Switching Circuit],
           ISNULL(e.NooffixturesDALI, 0) AS [No of Fixtures DALI],
           ISNULL(e.Phasecut, 0) AS [Phasecut],
           ISNULL(Keypad, 0) AS [Keypad],
           ISNULL(e.CCTV, 0) AS [CCTV],
           ISNULL(e.HFSensor, 0) AS [HFSensor],
           ISNULL(e.Fan, 0) AS [Fan],
           ISNULL(Curtain, 0) AS [Curtain],
           ISNULL(Wifi, 0) AS [Wifi],
           ISNULL(Ekey, 0) AS [Ekey],
           ISNULL(e.AC, 0) AS [AC],
           ISNULL(e.TV, 0) AS [TV],
           ISNULL(e.VDP, 0) AS [VDP],
           ISNULL(e.RTIScreen, 0) AS [RTIScreen]
    FROM vuCrm_Quote_ItemInformation_Details e WITH(NOLOCK)
    LEFT JOIN vCore_Account c WITH(NOLOCK) ON e.AccountName = c.iMasterId
    LEFT JOIN vCore_Floor f WITH(NOLOCK) ON e.Floor = f.iMasterId
    LEFT JOIN vCore_ServiceandClientScopeModule h WITH(NOLOCK) ON h.iMasterId = e.TermsAndcondition
    LEFT JOIN vCore_Control i WITH(NOLOCK) ON i.iMasterId = e.Control
    WHERE e.iTransId > 0
    AND e.iTransId = 83
) t 
UNPIVOT (
    val FOR [type] IN ([Switching Circuit], [No of Fixtures DALI], [Phasecut], [Keypad], [CCTV], [HFSensor], [Fan], [Curtain], [Wifi], [Ekey], [AC], [TV], [VDP], [RTIScreen])
) AS unpvt;


--select iTransId from vCrm_Quote where sName='SQ-57'