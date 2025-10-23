CREATE VIEW vw_LeadActivityReport as
select 
       'Task' Activity,
       L.Date [Datee],
       L.sFirstName,
       sCompany,
       FORMAT(dbo.fCore_IntToDate(L.Date), 'dd/MM/yyyy') [Date],
       C.sName [Campaign Name],
       U.sName [Owner],
       LS.sName [LeadState],
       ISNULL(LSO.sName, '') [Lead Source],
       ISNULL(IND.sName, '') [Industry],
       DES.sName [Designation],
       LC.sName [LeadsCategory],
       ISNULL(L.Mobile1, 0) [Mobile],
       CI.sName [City],
       ST.sName [State],
       ISNULL(T.sSubject, '') [Subject],
       ISNULL(TS.sName, '') [Status],
       ISNULL(M.sName, '') [Module],
       CASE
           WHEN iRelatedToType = 256 then
               ISNULL(L.sFirstName, '')
       end RelatedTo,
	   ISNULL(P.sName,'') [Priority],
	   CASE WHEN T.iDueDate<>0 then  FORMAT(dbo.fCore_IntToDate(T.iDueDate),'dd/MM/yyyy') end [DueDate],
	   '' ENDDATE,
	   ISNULL(CAM.sName,'') [Task Campaign],
	   ISNULL(CON.sName,'') [Contact],
	   CASE bRemind when 1 then 'None'
	   when 2 then 'No.Of Days Before'
	   when 3 then 'Reminder Time' end [Time Before Due Date],
	   CASE WHEN T.iReminderDateTime<>0 then FORMAT(dbo.fCore_IntToDateTime(T.iReminderDateTime),'dd/MM/yyyy hh:mm:ss') end [ReminderTime]
from vuCrm_Leads_ProductDetails_Details L WITH (NOLOCK)
    left join vCrm_Tasks T WITH (NOLOCK) 
	on L.iTransId = T.iRelatedTo and (iRelatedToType = 256)
    left join vCrm_ModuleTypes M WITH (NOLOCK)
        on T.iRelatedToType = M.iTypeId and (iRelatedToType = 256)
    left join vCrm_Campaigns C WITH (NOLOCK)
        on L.iCampaignId = C.iMasterId
    left join vCrm_LeadState LS WITH (NOLOCK)
        on L.iLeadState = LS.iTransId
    left join vCrm_LeadSource LSO WITH (NOLOCK)
        on L.iLeadSource = LSO.iTransId
    left join vCrm_Users U WITH (NOLOCK)
        on L.iAssignedTo = U.iMasterId
    left join vCrm_Industry IND WITH (NOLOCK)
        on L.iIndustry = IND.iTransId
    left join mPay_Designation DES WITH (NOLOCK)
        on L.Designation = DES.iMasterId
    left join vCore_LeadsCategory LC WITH (NOLOCK)
        on L.LeadsCategory = LC.iMasterId
    left join vCore_City CI WITH (NOLOCK)
        on L.City1 = CI.iMasterId
    left join vCore_State ST WITH (NOLOCK)
        on L.State1 = ST.iMasterId
    left join vCrm_TaskStatus TS WITH (NOLOCK) 
        on T.iStatus = TS.iTransId
	left join vCrm_Priority P WITH (NOLOCK) 
	    on T.iPriority=P.iTransId
	left join vCrm_Campaigns CAM WITH (NOLOCK)
	    on T.iCampaignId=CAM.iMasterId
	left join vCrm_Contacts CON WITH (NOLOCK)
	    on T.iContactId=CON.iMasterId
where L.iTransId > 0

UNION ALL

select 
       CASE iAppointmentType when 1 then 'Appointment' when 3 then 'Meeting' else ''end Activity,
       L.Date [Datee],
       L.sFirstName,
       sCompany,
       FORMAT(dbo.fCore_IntToDate(L.Date), 'dd/MM/yyyy') [Date],
       C.sName [Campaign Name],
       U.sName [Owner],
       LS.sName [LeadState],
       ISNULL(LSO.sName, '') [Lead Source],
       ISNULL(IND.sName, '') [Industry],
       DES.sName [Designation],
       LC.sName [LeadsCategory],
       ISNULL(L.Mobile1, 0) [Mobile],
       CI.sName [City],
       ST.sName [State],
       ISNULL(T.sSubject, '') [Subject],
       ISNULL(TS.sName, '') [Status],
       ISNULL(M.sName, '') [Module],
       CASE
           WHEN iRelatedToType = 256 then
               ISNULL(L.sFirstName, '')
       end RelatedTo,
	   ISNULL(P.sName,'') [Priority],
	   CASE WHEN T.iStartDatetime<>0 then  FORMAT(dbo.fCore_IntToDateTime(T.iStartDatetime),'dd/MM/yyyy hh:mm:ss') end [StartDate],
	   CASE WHEN T.iEndDatetime<>0 then  FORMAT(dbo.fCore_IntToDateTime(T.iEndDatetime),'dd/MM/yyyy hh:mm:ss') end [EndDate],
	   ISNULL(CAM.sName,'') [Task Campaign],
	   ISNULL(CON.sName,'') [Contact],
	   CASE bRemind when 1 then 'None'
	   when 2 then 'No.Of Days Before'
	   when 3 then 'Reminder Time' end [Time Before Due Date],
	   CASE WHEN T.iReminderDateTime<>0 then FORMAT(dbo.fCore_IntToDateTime(T.iReminderDateTime),'dd/MM/yyyy hh:mm:ss') end [ReminderTime]
from vuCrm_Leads_ProductDetails_Details L WITH (NOLOCK)
    left join vCrm_Appointments T WITH (NOLOCK) 
	on L.iTransId = T.iRelatedTo and (iRelatedToType = 256)
    left join vCrm_ModuleTypes M WITH (NOLOCK)
        on T.iRelatedToType = M.iTypeId and (iRelatedToType = 256)
    left join vCrm_Campaigns C WITH (NOLOCK)
        on L.iCampaignId = C.iMasterId
    left join vCrm_LeadState LS WITH (NOLOCK)
        on L.iLeadState = LS.iTransId
    left join vCrm_LeadSource LSO WITH (NOLOCK)
        on L.iLeadSource = LSO.iTransId
    left join vCrm_Users U WITH (NOLOCK)
        on L.iAssignedTo = U.iMasterId
    left join vCrm_Industry IND WITH (NOLOCK)
        on L.iIndustry = IND.iTransId
    left join mPay_Designation DES WITH (NOLOCK)
        on L.Designation = DES.iMasterId
    left join vCore_LeadsCategory LC WITH (NOLOCK)
        on L.LeadsCategory = LC.iMasterId
    left join vCore_City CI WITH (NOLOCK)
        on L.City1 = CI.iMasterId
    left join vCore_State ST WITH (NOLOCK)
        on L.State1 = ST.iMasterId
    left join vCrm_TaskStatus TS WITH (NOLOCK) 
        on T.iStatus = TS.iTransId
	left join vCrm_Priority P WITH (NOLOCK) 
	    on T.iPriority=P.iTransId
	left join vCrm_Campaigns CAM WITH (NOLOCK)
	    on T.iCampaignId=CAM.iMasterId
	left join vCrm_Contacts CON WITH (NOLOCK)
	    on T.iContactId=CON.iMasterId
where L.iTransId > 0