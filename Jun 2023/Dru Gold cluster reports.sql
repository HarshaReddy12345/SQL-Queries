ALTER VIEW nCore_PurchaseVoucherAndLoanFormByCluster
as
select a.sName [Purchase/Loan No],BranchName,[Cluster Manager],a.iLocation,c.Users,
 ISNULL(d.sName, '') [State],
  'MONETIZATION' [Type],
  COUNT(a.iMasterId) [No Of Transactions],
  a.HWeightafterMelting,
  (a.Date) [$Date$iCreatedDate],
  (a.Date) Date,d.iMasterId
  from vCore_PurchaseVouchers a
LEFT JOIN vCore_Location b on a.iLocation=b.iMasterId
LEFT JOIN (select c.sName [Cluster Manager],b.sName [BranchName],b.iMasterId,pu.Users from muCore_Location_ERP3PDetails pu
INNER JOIN vCore_Location b on pu.iMasterId=b.iMasterId
INNER JOIN vCrm_Users c on pu.Users=c.iMasterId) c on c.iMasterId=b.iMasterId
LEFT JOIN vCore_State d
  ON b.State = d.iMasterId
   AND d.iMasterId IN (1, 2)
   GROUP BY a.sName,
         b.sName,
         a.HWeightafterMelting,
         d.sName,
         a.Date,BranchName,[Cluster Manager],a.iLocation,c.Users,d.iMasterId

		 UNION ALL

SELECT
  a.sName [Purchase/Loan No],BranchName,[Cluster Manager],a.iLocation,c.Users,
  ISNULL(d.sName, '') [State],
  'GOLD LOAN' [Type],
  COUNT(a.iMasterId) [No Of Transactions],
  a.NDisbursementAmt,
  dbo.fCrm_DateFromBigInt(a.iCreatedDate) [$Date$iCreatedDate],
  dbo.fCrm_DateFromBigInt(a.iCreatedDate) Date,d.iMasterId
FROM vCore_LoanForm a
LEFT JOIN vCore_Location b
  ON a.iLocation = b.iMasterId
  LEFT JOIN (select c.sName [Cluster Manager],b.sName [BranchName],b.iMasterId,pu.Users from muCore_Location_ERP3PDetails pu
INNER JOIN vCore_Location b on pu.iMasterId=b.iMasterId
INNER JOIN vCrm_Users c on pu.Users=c.iMasterId) c on c.iMasterId=b.iMasterId
LEFT JOIN vCore_State d
  ON b.State = d.iMasterId
   AND d.iMasterId IN (1, 2)
GROUP BY a.sName,
         b.sName,
         a.NDisbursementAmt,
         d.sName,a.iCreatedDate,BranchName,[Cluster Manager],a.iLocation,c.Users,d.iMasterId


		  select * from nCore_PurchaseVoucherAndLoanFormByCluster
WHERE (Date) BETWEEN @STARTDATE AND @ENDDATE
and (( 0 in (@User) and isnull(Users,0)  = isnull(Users,0) ) or (0 not in (@User) and isnull(Users,0)   in ( @User )))
and (( 0 in (@Branch) and isnull(iLocation,0)  = isnull(iLocation,0) ) or (0 not in (@Branch) and isnull(iLocation,0)   in ( @Branch )))
and (( 0 in (@State) and isnull(iMasterId,0)  = isnull(iMasterId,0) ) or (0 not in (@State) and isnull(iMasterId,0)   in ( @State )))

select sTableName from vCrm_Fields where sFieldName like '%Users%'

select b.sName iLocation,COUNT(a.sName) from vCrm_Users a
join vCore_Location b on a.iLocation=b.iMasterId
group by b.sName
