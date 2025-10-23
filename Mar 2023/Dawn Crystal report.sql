	SELECT
	  *,
	  dbo.fCore_IntToDate(installment_due_date) dinstallment_due_date
	FROM (
	SELECT
	  a.sName [receivable_no],a.iMasterId,a.BookingNo,
	  CASE
		WHEN ISNULL(a.InstallmentNo, '') = '' THEN c.sName
		ELSE a.InstallmentNo
	  END as [payment_againest],
	  CASE
		WHEN ISNULL(a.InstallmentNo, '') <> '' THEN 1
		ELSE 2
	  END  as [ipayment_againest],
	  a.InstallmentDueDate [installment_due_date],
	  a.AmountDue [amount_due],
	  [paid_amt],
	  ISNULL(a.AmountDue, 0.00) - ISNULL([paid_amt], 0.00) [balance_amount],
	  d.CreatedOn [created_on],
	  d.iTransId
	  ,case
	      when ( CASE
		WHEN ISNULL(a.InstallmentNo, '') = '' THEN c.sName
		ELSE a.InstallmentNo
	  END) = 'Booking Amount' then 1 
	      when ( CASE
		WHEN ISNULL(a.InstallmentNo, '') = '' THEN c.sName
		ELSE a.InstallmentNo
	  END) = 'Agreement Amount' then 2 
		  when ( CASE
		WHEN ISNULL(a.InstallmentNo, '') = '' THEN c.sName
		ELSE a.InstallmentNo
	  END) like 'Installment%' then 3
          when ( CASE
		WHEN ISNULL(a.InstallmentNo, '') = '' THEN c.sName
		ELSE a.InstallmentNo
	  END) != 'Booking Amount' and ( CASE
		WHEN ISNULL(a.InstallmentNo, '') = '' THEN c.sName
		ELSE a.InstallmentNo
	  END)  != 'Agreement Amount'
		  and ( CASE
		WHEN ISNULL(a.InstallmentNo, '') = '' THEN c.sName
		ELSE a.InstallmentNo
	  END) not like 'Installment%' then 4
		  end  as selection
      FROM vCore_Receivables a WITH (NOLOCK)
	LEFT JOIN (SELECT
	  ReceivableNo,
	  SUM(Amount) [paid_amt]
	FROM vCore_CustomerReceipt b WITH (NOLOCK)
	WHERE b.iMasterId > 0
	GROUP BY ReceivableNo
    ) B
	  ON a.iMasterId = B.ReceivableNo
	LEFT JOIN vCrm_Charges c WITH (NOLOCK)
	  ON a.Charges = c.iMasterId
	LEFT JOIN vCrm_Bookings d WITH (NOLOCK)
	  ON a.BookingNo = d.sName
	WHERE d.iTransId = 65
	) A
	WHERE A.balance_amount > 0.00
	and 
	(payment_againest='Booking Amount' or payment_againest='Agreement Amount' or payment_againest='Plc')
	AND ((ipayment_againest = 1
	AND dbo.fCrm_DATEDIFF(1, created_on, installment_due_date) <= 60)
	OR ([ipayment_againest] = 2))
    order by selection asc,payment_againest asc

======================================================================================================
select 
       format(GETDATE(),'dd/MM/yyyy') Date,
       b.sName [Booking No],
	   a.sName [Mr/Mrs],
	   b.FathersorHusbandsName [s/w/d/o],
	   b.sAddress,
	   b.sCity,
	   b.sState,
	   b.sPinCode,b.sMobile,
	   u.sName [Plot No],
	   case when InstallmentNo is not null and Charges =0  and ReceivableStatus in (1) then sum(r.AmountDue)
      when r.InstallmentNo is not null and r.Charges is  null  and ReceivableStatus in (2) then 
       sum(r.DifferenceAmount) else 0  end Blank2,
	   case when r.InstallmentNo is  null and r.Charges <>0  and r.ReceivableStatus in (1) then sum(r.AmountDue)
	   when r.InstallmentNo is  null and r.Charges is not null  and r.ReceivableStatus in (2) then sum(DifferenceAmount) else 0
	     end Blank3,
       
       case when b.PosessiononorBeforeDue is null then null else dbo.fCore_IntToDate(b.PosessiononorBeforeDue) end 'Blank 4'

	from   vCrm_Bookings b
left join 
       vCore_Account a on a.iMasterId=b.B1CustomerAccount
left join 
       vCrm_PMSUnits u on u.iMasterId=b.iUnitId
left join 
       vCore_Receivables r on r.Booking=b.iTransId
where b.iTransId>0
and b.iTransId=65
group by b.sName ,
	   a.sName ,
	   b.FathersorHusbandsName ,
	   b.sAddress,
	   b.sCity,
	   b.sState,
	   b.sPinCode,b.sMobile,
	   u.sName ,InstallmentNo,ReceivableStatus,Charges,PosessiononorBeforeDue

