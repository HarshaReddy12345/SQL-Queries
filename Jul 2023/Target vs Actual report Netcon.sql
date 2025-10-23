select TargetAmount,b.sName [Child_User],c.sName [Parent_User], a.ProductTarget , a.ServiceTarget ,d.fSubTotal [Achieved],
CASE when e.iProductType=7 then (a.ProductTarget-d.fSubTotal) else a.ProductTarget end [Remaining Product Target],
CASE when e.iProductType=1 then (a.ServiceTarget-d.fSubTotal) else a.ServiceTarget end [Remaining Service Target],
ISNULL(f.sName,'') [Line Of Business],ISNULL(i.sName,'') [Business Unit],
CASE d.Month when 1 then 'January'
when 2 then 'Feburary'
when 3 then 'March'
when 4 then 'April'
when 5 then 'May'
when 6 then 'June'
when 7 then 'July'
when 8 then 'August'
when 9 then 'September'
when 10 then 'October'
when 11 then 'November'
when 12 then 'December' end [Month],
CASE d.QTR when 1 then 'Q1'
when 1 then 'Q2'
when 1 then 'Q3'
when 1 then 'Q4'
when 1 then 'FY 25' end [Quarter]
from vCore_TargetvsActuals a
LEFT OUTER JOIN vCrm_Users b on a.iAssignedTo=b.iMasterId
LEFT OUTER JOIN vCrm_Users c on b.iParentId=c.iMasterId
LEFT OUTER JOIN vuCrm_SalesOrder_General_Details d on a.iAssignedTo=d.iAssignedTo
LEFT OUTER JOIN vCore_Product e on d.iProductId=e.iMasterId
LEFT OUTER JOIN vCore_LineOfBusiness f on d.LineOfBusiness=f.iMasterId
--LEFT OUTER JOIN vCore_Quarter g on d.QTR=g.iMasterId
--LEFT OUTER JOIN vCore_Month h on d.Month=h.iMasterId
LEFT OUTER JOIN vCore_BusinessUnit i on d.LineOfBusiness=i.iMasterId
where a.iMasterId>0
and dbo.fCrm_DateFromBigInt(d.iCreatedDate) between @STARTDATE and @ENDDATE
and (( 0 in (@Month) and isnull(d.Month,0)  = isnull(d.Month,0) ) or (0 not in (@Month) and isnull(d.Month,0)   in ( @Month )))
and (( 0 in (@Quarter) and isnull(d.QTR,0)  = isnull(d.QTR,0) ) or (0 not in (@Quarter) and isnull(d.QTR,0)   in ( @Quarter )))
and (( 0 in (@LineOfBusiness) and isnull(f.iMasterId,0)  = isnull(f.iMasterId,0) ) or (0 not in (@LineOfBusiness) and isnull(f.iMasterId,0)   in ( @LineOfBusiness )))
and (( 0 in (@BusinessUnit) and isnull(i.iMasterId,0)  = isnull(i.iMasterId,0) ) or (0 not in (@BusinessUnit) and isnull(i.iMasterId,0)   in ( @BusinessUnit )))
and (( 0 in (@Owner) and isnull(b.iMasterId,0)  = isnull(b.iMasterId,0) ) or (0 not in (@Owner) and isnull(b.iMasterId,0)   in ( @Owner )))



