ALTER VIEW nCore_StockRep as
select a.sName ProductName,a.sCode ProductCode,b.InvQty [INV Qty],0 DNQty,0 PRQty,
0 DCqty,0 SRQty, 0 [PG Qty], 0 OSQty  ,0 [Stock Out],0 [Stock IN],
0 [Balance Stock]   ,
ISNULL(b.iCreatedDate,0) iCreatedDate,b.Product  from vCore_Product  a WITH (NOLOCK)

LEFT JOIN (select SUM(Quantity) InvQty,Product,sName,iCreatedDate from vuCore_Invoice_Product_Info_Details with(nolock) group by Product,sName,iCreatedDate) b  on a.iMasterId=b.Product 


UNION ALL

select a.sName ProductName,a.sCode ProductCode,0 [INV Qty],c.DelQty DNQty,0 PRQty,
0 DCqty,0 SRQty, 0 [PG Qty],0 OSQty,0 [Stock Out],0 [Stock IN],
0 [Balance Stock],ISNULL(c.iCreatedDate,0) iCreatedDate,c.iProductId from vCore_Product  a  WITH (NOLOCK)
LEFT JOIN (select SUM(iQuantity) DelQty,iProductId,iCreatedDate from vuCore_DeliveryNote_ProductInformation_Details with(nolock) group by iProductId,iCreatedDate) c on c.iProductId=a.iMasterId

UNION ALL

select a.sName ProductName,a.sCode ProductCode,0 [INV Qty],0 DNQty,0 PRQty,
d.DCQty DCqty,0 SRQty, 0 [PG Qty],0  ,0 [Stock Out],0 [Stock IN],
0 [Balance Stock]   ,
ISNULL(d.iCreatedDate,0) iCreatedDate,d.Product from vCore_Product  a  WITH (NOLOCK)
LEFT JOIN (select SUM(Quantity) DCQty,Product,iCreatedDate from vuCore_DCReturn_ProductInformation_Details with(nolock) group by Product,iCreatedDate) d on d.Product=a.iMasterId

UNION ALL 

select a.sName ProductName,a.sCode ProductCode,0 [INV Qty],0 DNQty,0 PRQty,
0 DCqty,e.SRQty SRQty, 0 [PG Qty],0  ,0 [Stock Out],0 [Stock IN],
0 [Balance Stock]   ,
ISNULL(e.iCreatedDate,0) iCreatedDate,e.Product from vCore_Product  a  WITH (NOLOCK)
LEFT JOIN (select SUM(Quantity) SRQty,Product,iCreatedDate from vuCore_SalesReturn_ProductInformation_Details with(nolock) group by Product,iCreatedDate)  e on e.Product=a.iMasterId

UNION ALL

select a.sName ProductName,a.sCode ProductCode,0 [INV Qty],0 DNQty,0 PRQty,
0 DCqty,0 SRQty, f.GRNQty [PG Qty],0  ,0 [Stock Out],0 [Stock IN],
0 [Balance Stock]   ,
ISNULL(f.iCreatedDate,0) iCreatedDate,f.iProductId from vCore_Product  a  WITH (NOLOCK)
LEFT JOIN (select SUM(iQuantity) GRNQty,iProductId,iCreatedDate from vuCore_PurchaseGRN_ProductInformation_Details with(nolock) group by iProductId,iCreatedDate) f on f.iProductId=a.iMasterId

UNION ALL

select a.sName ProductName,a.sCode ProductCode,0 [INV Qty],0 DNQty,g.PRQty PRQty,
0 DCqty,0 SRQty, 0 [PG Qty],0  ,0 [Stock Out],0 [Stock IN],
0 [Balance Stock]   ,
ISNULL(g.iCreatedDate,0) iCreatedDate,g.iProductId from vCore_Product  a  WITH (NOLOCK)
LEFT JOIN (select SUM(iQuantity) PRQty,iProductId,iCreatedDate from vuCore_PurchaseReturn_ProductInformation_Details with(nolock)  group by iProductId,iCreatedDate) g on g.iProductId=a.iMasterId

UNION ALL

select a.sName ProductName,a.sCode ProductCode,0 [INV Qty],0 DNQty,0 PRQty,
0 DCqty,0 SRQty, 0 [PG Qty],h.OSQty  ,0 [Stock Out],0 [Stock IN],
0 [Balance Stock]   ,
ISNULL(h.iCreatedDate,0) iCreatedDate,h.iProductId from vCore_Product  a  WITH (NOLOCK)
LEFT JOIN (select SUM(iQuantity) OSQty,iProductId,iCreatedDate from vuCore_OpeningStock_ProductInformation_Details with(nolock)  group by iProductId,iCreatedDate) h on h.iProductId=a.iMasterId
