SELECT DISTINCT vrCore_Product.sName,vrCore_Product.sCode,vrCore_Product.iCategory Brand,
SUM(tCore_Indta_0.fQuantityInBase) Balance
FROM tCore_Header_0 
 JOIN tCore_Data_0 ON tCore_Header_0.iHeaderId = tCore_Data_0.iHeaderId
 JOIN tCore_Indta_0 ON tCore_Indta_0.iBodyId = tCore_Data_0.iBodyId
 JOIN cCore_Vouchers_0 WITH (READUNCOMMITTED) ON cCore_Vouchers_0.iVoucherType=tCore_Header_0.iVoucherType 
JOIN vrCore_Product ON tCore_Indta_0.iProduct = vrCore_Product.iMasterId AND vrCore_Product.iTreeId = 0
LEFT JOIN dbo.fCore_GetProductTreeSequenceByLangId(0,0,0) ATree ON ATree.iMasterId = tCore_Indta_0.iProduct
LEFT JOIN mCore_ProductLanguage ON mCore_ProductLanguage.iMasterId = vrCore_Product.iMasterId AND iLanguageId = 0
LEFT JOIN vrCore_Product GroupProduct ON GroupProduct.iMasterId = vrCore_Product.iParentId AND GroupProduct.iTreeId = 0 
JOIN vrCore_Division ON vrCore_Division.iMasterId = tCore_Data_0.iInvTag AND vrCore_Division.iTreeId = 0 
WHERE tCore_Header_0.bUpdateStocks = 1  AND tCore_Data_0.bSuspendUpdateStocks <> 1
AND tCore_Header_0.bSuspended = 0 AND tCore_Data_0.iAuthStatus < 2
AND tCore_Header_0.iDate <= @Date AND vrCore_Product.iProductType <> 'Service' 
--AND vrCore_Product.iProductTypeId <> 1 AND vrCore_Product.iProductTypeId <> 5
GROUP BY vrCore_Product.sName,vrCore_Product.sCode,mCore_ProductLanguage.sName,vrCore_Product.iMasterId,GroupProduct.sName ,
vrCore_Product.iDefaultBaseUnit,vrCore_Product.iCategory,vrCore_Product.iProductType 
having SUM(tCore_Indta_0.fQuantityInBase)<>0