CREATE or ALTER VIEW  vw_Inv as
select 'Invoice' [Module],a.sName [InvNo],b.sName [Account],(a.iCreatedDate) [$Datetime$InvDate],
a.Amount [Debit],0 [Credit],b.iMasterId,c.iTransId,c.sName [LeaseAgreementNo]
from vCore_LeaseReceivable a
left join vCore_Account b on a.CustomerAccount=b.iMasterId
left join vCrm_PMSContract c on a.LeaseAgreementNumber=c.iTransId
where a.iMasterId>0
--------------------------------------------------------------------------------------------------
CREATE or ALTER VIEW vw_Rec as
select 'Receipt' [Module],a.sName [RecNo],b.sName [Account],(a.iCreatedDate) [$Datetime$RecDate],
0 [Debit],a.CollectingAmount [Credit],b.iMasterId,c.iTransId,c.sName [LeaseAgreementNo]
from vCore_LeaseReceipt a
left join vCore_Account b on a.CustomerAccount=b.iMasterId
left join vCrm_PMSContract c on a.LeaseAggreementNumber=c.iTransId
where a.iMasterId>0
--------------------------------------------------------------------------------------------------------------
select top 100 percent iDocType,[Module],[InvNo],[Account],iMasterId,iTransId,[$Datetime$InvDate],SUM([Debit]) [Debit],SUM([Credit]) [Credit] from
(
select 1 iDocType,* from vw_Inv

union all
select 2 iDocType,* from vw_Rec
)aa
where  dbo.fCrm_DateFromBigInt([InvDate]) between @STARTDATE and @ENDDATE
and(( 0 in (@Account) and isnull(iMasterId,0)  = isnull(iMasterId,0) ) or (0 not in (@Account) and isnull(iMasterId,0)   in ( @Account )))
and (( 0 in (@LeaseAgreementNo) and isnull(iTransId,0)  = isnull(iTransId,0) ) or (0 not in (@LeaseAgreementNo) and isnull(iTransId,0)   
in ( @LeaseAgreementNo )))
group by InvNo,Account,[$Datetime$InvDate],aa.Module,iDocType,iMasterId,iTransId
order by InvNo asc,iDocType asc