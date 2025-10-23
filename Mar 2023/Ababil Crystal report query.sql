select q.iTransId,q.sName [Quote No],a.sName [Account Name],
format(dbo.fCore_IntToDate(Date),'dd/MM/yyyy') [Quote Date],
d.sName [Designation],
isnull(a.sBillingAddress,'') [Billing Address],
isnull(q.Sub,'') [sub],p.sName [Product],
q.sProdDescription [Model],
q.iQuantity [Qty],
q.fSalesPrice [Unit Price],
(CGST+fIGST+SGST) [GST],
q.fAmount [Total Price]
from vuCrm_Quote_General_Details q with(nolock)
left join vCore_Account a with(nolock) on q.AccountName=a.iMasterId
left join vCore_Product p with(nolock) on q.iProductId=p.iMasterId
left join mPay_Designation d with(nolock) on q.ToDesignation=d.iMasterId
where q.iTransId>0 and q.iTransId={?iTransId}



