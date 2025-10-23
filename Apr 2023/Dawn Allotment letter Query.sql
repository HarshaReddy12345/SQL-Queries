select a.sName [BookingNo],b.sName [B1CustomerAccount],
       case b.iSalutation when 1 then 'Mr.'
	   when 2 then 'Mrs.'
	   when 3 then 'Miss'
	   when 4 then 'Ms.'
	   when 5 then 'Dr.'
	   when 6 then 'Prof.'
	   when 7 then 'Rev.'
	   when 8 then 'Other' END  [Salutation],
	   b.FathersorHusbandsName [S/o or C/O ],
	   b.sBillingAddress,b.sBillingStreet,b.sBillingCity,b.sBillingState,b.sBillingPinCode,
	   b.sMobile,
	   case when a.Noofbeneficiaries in (1) then 'NA' else c.sName end [Co_Applicant],
	   d.sName [Block],
	   e.sName [Unit],
	   Amount,
	   a.UnitAreaMts
	   from vCrm_Bookings a 
left join vCore_Account b on a.B1CustomerAccount=b.iMasterId
left join vCore_Account c on a.B2CustomerAccount=c.iMasterId
left join vCrm_Blocks d on a.iBlockId=d.iMasterId
left join vCrm_PMSUnits e on a.iUnitId=e.iMasterId
left join (Select Amount,BookingNo from vCrm_CustomerReceipt) f on a.iTransId=f.BookingNo
 where a.iTransId>0 and a.iTransId={?iTransId}

