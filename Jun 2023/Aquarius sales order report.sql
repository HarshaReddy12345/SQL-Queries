        
ALTER   VIEW   vExt_opp as        
  SELECT        
    oo.iTransId[Tid],      
    dd.iMasterId,      
    so.iOpportunityId,        
    dd.sName[Division],        
    oo.sName[Opportunity],        
    oo.iAssignedTo,
	ic.sName[iIndustry],        
    dbo.fCrm_GetNumberListValue('1,Roads,2,Dams,3,Airports,4,Housing,5,High Rise,6,Canals,7,Precast,8,Others ',otc.[Application])[Application],       
    rr.sName[Region] ,       
    vl.sName[Location] ,       
    otc.RegionalManagerOtherRemarks[Regional Manager Other Remarks] ,       
    uu.sName[Sales Engineer],        
    dc.sName[Dealer] ,       
    so.sName[Sales Order No],        
    dbo.fCrm_GetNumberListValue('1,New Business,2,Existing Business,3,Upgrade,4,Partner Sale',oo.iOpportunityType)[Customer R/N],        
    otc.Accountname [Customer Name],        
    otc.CUSTOMERPANNO[PAN NO],        
    otc.CUSTOMERTANNO[TAN NO] ,       
    Acc.GSTNo,        
    oo.LeadNo[Reference],        
       oo.iCreatedDate[$Datetime$iCreatedDate],        
    otc.HOAddress[Head Office Addresss with Pin Code],        
    otc.ContactPersonHO[Contact Person From Head Office],      
    otc.DesignationHO,        
    otc.HOPhone,        
    otc.HOEMail[HO Email],        
    otc.BillingAddress,        
    otc.DeliveryAddress,        
    otc.ContactPersonSITEDeliveryAddress[Contact Person SITE Delivery Address],        
    otc.PONo[PO No],        
    FORMAT(dbo.fCore_IntToDate(otc.PODate),'dd/MM/yyyy') [PODate],        
    so.fSalesPrice[Basic Price],        
    so.fIGST[IGST%],        
    so.CGST[CGST%],        
    so.SGST[SGST%],        
    so.fIGSTAmount[IGST Amount],        
    so.CGSTAmount[CGST Amount],        
    so.SGSTAmount[SGST Amount],         
    so.fAmount[Net Amount],        
    dbo.fCrm_GetNumberListValue('1,TDS By Customer,2,TCS By Us',otc.TDSTCS)[TCS],        
    so.fGrandTotal[Base Net Amount],        
    pc.sName[Product Capacity],        
    pm.sName[Product Model],        
    dbo.fCrm_GetNumberListValue('1,YES,2,NO',so.OFMRCVD)[OFM RCVD],        
    FORMAT(dbo.fCore_IntToDate(so.POSenttoFactory),'dd/MM/yyyy') [POSenttoFactory],        
    FORMAT(dbo.fCore_IntToDate(so.OFMSenttoFactory),'dd/MM/yyyy') [OFMSenttoFactory],        
    FORMAT(dbo.fCore_IntToDate(so.OFMSenttoService),'dd/MM/yyyy') [OFMSenttoService],        
    dbo.fCrm_GetNumberListValue('1,Yes,2,No',so.DORCVD)[DO RCVD],        
    otc.Financername,        
    otc.Creditperioddays[Credit Period],        
    otc.DisbursementAmount[Disbursement Amount],        
    FORMAT(dbo.fCore_IntToDate(otc.DOValidityDate),'dd/MM/yyyy')  [DOValidityDate],        
    FORMAT(dbo.fCore_IntToDate(so.FinalDispatchInstruction),'dd/MM/yyyy') [FinalDispatchInstruction],        
    cASE
        WHEN ISNUMERIC(so.ExpectedDeliveryDate) = 1 THEN FORMAT(dbo.fCore_IntToDate(CONVERT(INT, so.ExpectedDeliveryDate)), 'dd/MM/yyyy')
        ELSE NULL -- or any default value for invalid dates
    END AS ExpectedDeliveryDate ,      
    FORMAT(dbo.fCore_IntToDate(so.Dwgdate),'dd/MM/yyyy') [Dwgdate],       
    so.TaxInvoiceNo,        
    FORMAT(dbo.fCore_IntToDate(so.TaxInvoiceDate),'dd/MM/yyyy') [TaxInvoiceDate],        
    so.McSrNo,        
    FORMAT(dbo.fCore_IntToDate(so.CommissioningDate),'dd/MM/yyyy')  [CommissionDate],        
    so.AdvancePayment[Amount Received],        
    so.BalanceAmount,        
    otc.AgreedPaymentTerms[Payment Terms],        
     cASE
        WHEN ISNUMERIC(so.ExpectedDeliveryDate) = 1 THEN FORMAT(dbo.fCore_IntToDate(CONVERT(INT, ad.PaymentDueDate)), 'dd/MM/yyyy')
        ELSE NULL -- or any default value for invalid dates
    END AS [PaymentDueDate],     
    so.DealerCommRefNo[Dealer Comm Ref No],        
    so.DealerCommPercentage[Dealer Comm. %],        
    so.DealerCommAmount[Dealer Comm Amount],        
    so.RBValue,        
    so.RBDifference,        
    so.TransportAmount,        
    otc.FOCAmountIFANYINR[Extra FOC Amount],        
    otc.CREDITNOTEAMOUNTIFANYINR[Credit Note Amount],        
    otc.TPCAMOUNTIFANYINR[TPC Amount],        
    so.ABGNo[Advance Bank Guarantee],        
    FORMAT(dbo.fCore_IntToDate(so.ABGExpirydate),'dd/MM/yyyy') [ABGExpirydate],        
    so.PBGNo,        
    FORMAT(dbo.fCore_IntToDate(so.PBGExpiryDate),'dd/MM/yyyy') [PBGExpiryDate]        
  FROM vCrm_Opportunities oo         
  LEFT JOIN vCore_Region rr WITH (NOLOCK)        
    ON oo.Region = rr.iMasterId        
  LEFT JOIN vCore_Location vl WITH (NOLOCK)        
    ON oo.iLocationId = vl.iMasterId        
  LEFT JOIN vCore_DealerCustom dc WITH (NOLOCK)        
    ON oo.Dealer = dc.iMasterId        
  LEFT JOIN vCore_Account Acc WITH (NOLOCK)        
    ON oo.iAccount = Acc.iMasterId        
  LEFT JOIN vCore_Division dd WITH (NOLOCK)        
    ON Acc.Division = dd.iMasterId        
  LEFT JOIN vCore_IndustryCustom ic WITH (NOLOCK)        
    ON Acc.iIndustry = ic.iMasterId        
  LEFT JOIN vCore_OFMTechnicalandCommercial otc WITH (NOLOCK)        
    ON oo.iTransId = otc.Opportunity        
  LEFT JOIN vuCrm_SalesOrder_General_Details so WITH (NOLOCK)        
    ON oo.iTransId = so.iOpportunityId        
  LEFT join vuCrm_SalesOrder_AdvancePaymentDetails_Details ad        
    on so.iTransId=ad.iTransId        
  LEFT JOIN vCore_Product pd WITH (NOLOCK)        
    ON pd.iMasterId = so.iProductId        
  LEFT JOIN vCore_ProductCapacity pc WITH (NOLOCK)        
    ON pc.iMasterId = so.ProductCapacity        
  LEFT JOIN vCore_ProductModel pm WITH (NOLOCK)        
    ON pm.iMasterId = so.ProductModel        
  LEFT join vCrm_Users uu  WITH (NOLOCK)        
    ON oo.iAssignedTo=uu.iMasterId        
    where oo.iTransId>0 --and dd.iMasterId=1      
    --and so.sName='SO-65'