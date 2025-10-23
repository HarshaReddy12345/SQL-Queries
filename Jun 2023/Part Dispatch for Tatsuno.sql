select 
       a.sName [Dispatch NUmber],
	   b.sName [Creator],
	   c.sName [TIPL Service Centre],
	   CASE WHEN a.DispatchDate<>'' then FORMAT(dbo.fCore_IntToDate(a.DispatchDate),'dd/MM/yyyy')  end [DispatchDate],
	   a.CourierName,CASE WHEN a.CourierDate<>'' then FORMAT(dbo.fCore_IntToDate(a.CourierDate),'dd/MM/yyyy')  end [CourierDate],
	   a.DocketNumber,a.DeliveryChallanNo,
	   CASE a.StatusDispatch when 1 then 'In Transit'
	   when 2 then 'Delivered' end StatusDispatch,
	   CASE a.DispatchMode when 1 then 'Air'
	   when 2 then 'Surface' end DispatchMode,a.NoOfBoxes,a.Weght,
	   a.Remarks,
	   f.sName [Engineer],g.sName [Part Request Number],
	   h.sName [Job Number],
	   CASE WHEN h.Date<>'' then FORMAT(dbo.fCore_IntToDate(h.Date),'dd/MM/yyyy') end  [RequestDate] ,
	   k.sName [RetailOutLet],j.sName [Customer],i.sName [Item],g.iQuantity [Required Quantity],
	   a.Quantity [Dispatch Qty],a.BatchNumber,a.Price,
	   CASE WHEN a.iApprovalDate <>'' then FORMAT(dbo.fCore_IntToDateTime(a.iApprovalDate),'dd/MM/yyyy hh:mm:ss') end [ApprovalDate],
	   CONCAT(i.sCode,'',i.sDescription) [Item Code-Description]
from vuCore_DispensingUnit_BatchGrid_Details a
INNER join vCrm_Users b on a.iAssignedTo=b.iMasterId
INNER join vCore_Location c on a.iLocation=c.iMasterId
INNER JOIN vCrm_Users f on a.Engineer=f.iMasterId
INNER JOIN vuCore_partsrequest_General_Details g on a.PartRequestNumber=g.iMasterId
INNER JOIN vCrm_Calls h on a.JobRequestNumber=h.iTransId
INNER JOIN tuCrm_Calls cc on h.iTransId=cc.iTransId
INNER JOIN vCore_Product i on a.Item=i.iMasterId
INNER JOIN vCore_Account j on h.iAccountId=j.iMasterId
LEFT JOIN vCore_Retailoutlet k on h.RetailOutletName=k.iMasterId
where a.iMasterId>0
and a.DispatchDate BETWEEN @STARTDATE and @ENDDATE
and (( 0 in (@DocketNumber) and isnull(a.DocketNumber,'')  = isnull(a.DocketNumber,'') ) 
or (0 not in (@DocketNumber) and isnull(a.DocketNumber,'')   in ( @DocketNumber )))
and (( 0 in (@Engineer) and isnull(a.Engineer,0)  = isnull(a.Engineer,0) ) or (0 not in (@Engineer) and isnull(a.Engineer,0)   in ( @Engineer )))
