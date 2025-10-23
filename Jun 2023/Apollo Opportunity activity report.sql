CREATE OR ALTER VIEW vw_OpportunityActivityReport
as
select 'Task' Activity,
       b.sName [Account],
       c.sName [Owner],
       a.sName [Opportunity],
       d.sName [Stage],
       ISNULL(e.sName, '') [Product],
       ISNULL(a.fSalesPrice, 0) [Year 1],
       ISNULL(a.Year2value, 0) [Year2value],
       f.sName [Contact],
       g.sName [Designation],
       ISNULL(a.sDescription, '') [Description],
       ISNULL(T.sSubject, '') sSubject,
       ISNULL(T.sDescription, '') sDescription,
       a.Date
from vuCrm_Opportunities_General_Details a WITH (NOLOCK)
    left join vCore_Account b WITH (NOLOCK)
        on a.iAccount = b.iMasterId
    left join vCrm_Users c WITH (NOLOCK)
        on a.iAssignedTo = c.iMasterId
    left join vCrm_SalesStages d WITH (NOLOCK)
        on a.iStage = d.iMasterId
    left join vCore_Product e WITH (NOLOCK)
        on a.iProductId = e.iMasterId
    left join vCrm_Contacts f WITH (NOLOCK)
        on a.iContactId = f.iMasterId
    left join mPay_Designation g WITH (NOLOCK)
        on f.Designation = g.iMasterId
    left join vCrm_Tasks T WITH (NOLOCK)
        on a.iTransId = T.iRelatedTo
           and (iRelatedToType = 1792)
    left join vCrm_ModuleTypes M WITH (NOLOCK)
        on T.iRelatedToType = M.iTypeId
           and (iRelatedToType = 1792)
WHERE a.iTransId > 0
UNION ALL
select CASE iAppointmentType
           when 1 then
               'Appointment'
           when 3 then
               'Meeting'
           else
               ''
       end Activity,
       b.sName [Account],
       c.sName [Owner],
       a.sName [Opportunity],
       d.sName [Stage],
       ISNULL(e.sName, '') [Product],
       ISNULL(a.fSalesPrice, 0) [Year 1],
       ISNULL(a.Year2value, 0) [Year2value],
       f.sName [Contact],
       g.sName [Designation],
       ISNULL(a.sDescription, '') [Description],
       ISNULL(T.sSubject, '') sSubject,
       ISNULL(T.sDescription, '') sDescription,
       a.Date
from vuCrm_Opportunities_General_Details a WITH (NOLOCK)
    left join vCore_Account b WITH (NOLOCK)
        on a.iAccount = b.iMasterId
    left join vCrm_Users c WITH (NOLOCK)
        on a.iAssignedTo = c.iMasterId
    left join vCrm_SalesStages d WITH (NOLOCK)
        on a.iStage = d.iMasterId
    left join vCore_Product e WITH (NOLOCK)
        on a.iProductId = e.iMasterId
    left join vCrm_Contacts f WITH (NOLOCK)
        on a.iContactId = f.iMasterId
    left join mPay_Designation g WITH (NOLOCK)
        on f.Designation = g.iMasterId
    left join vCrm_Appointments T WITH (NOLOCK)
        on a.iTransId = T.iRelatedTo
           and (iRelatedToType = 1792)
    left join vCrm_ModuleTypes M WITH (NOLOCK)
        on T.iRelatedToType = M.iTypeId
           and (iRelatedToType = 1792)
WHERE a.iTransId > 0

select * from vw_OpportunityActivityReport
where Date between @STARTDATE and @ENDDATE