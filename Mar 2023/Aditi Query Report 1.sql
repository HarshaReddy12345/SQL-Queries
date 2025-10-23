


select b.sSubject [Task Subject],c.sSubject [Appointment/Meeting Subject],
case  when  c.iAppointmentType in (1) then 'Appointment'
when c.iAppointmentType in (3) then 'Meeting' else 'Task' end  [Activity],
d.sName [Module],e.sName,f.sName [Location], b.sDescription [Task Description],c.sDescription [Appointment/Meeting Description],
case when b.iCreatedDate is null then null else dbo.fCore_IntToDateTime (b.iCreatedDate) end [Task CreatedDate],
 case when c.iCreatedDate is null then Null else dbo.fCore_IntToDateTime (c.iCreatedDate)end [Appointment CreatedDate] 
from vCrm_Leads a WITH(NOLOCK)
INNER JOIN vCrm_Tasks b WITH(NOLOCK) on a.iTransId=b.iRelatedTo and b.iRelatedToType=256
LEFT JOIN vCrm_Appointments c WITH(NOLOCK) on a.iTransId=c.iRelatedTo and c.iRelatedToType=256
INNER JOIN vCrm_ModuleTypes d WITH(NOLOCK) on (b.iTypeId=d.iMasterId or c.iTypeId=d.iMasterId) 
INNER JOIN vCrm_ModuleTypes e WITH(NOLOCK) on (b.iRelatedToType=e.iMasterId or c.iRelatedToType=e.iMasterId) 
INNER JOIN vCore_LocationCust f WITH(NOLOCK) on c.Location1=f.iMasterId or b.iLocationId=f.iMasterId
where a.iTransId>0 and c.iAppointmentType<>2

union all 

select b.sSubject [Task Subject],c.sSubject [Appointment/Meeting Subject],
case  when  c.iAppointmentType in (1) then 'Appointment'
when c.iAppointmentType in (3) then 'Meeting' else 'Task' end  [Activity],
d.sName [Module],e.sName,f.sName [Location], b.sDescription [Task Description],c.sDescription [Appointment/Meeting Description],
case when b.iCreatedDate is null then null else dbo.fCore_IntToDateTime (b.iCreatedDate) end [Task CreatedDate],
 case when c.iCreatedDate is null then Null else dbo.fCore_IntToDateTime (c.iCreatedDate)end [Appointment CreatedDate] 
from vCrm_Opportunities a WITH(NOLOCK)
INNER JOIN vCrm_Tasks b WITH(NOLOCK) on a.iTransId=b.iRelatedTo and b.iRelatedToType=1792
LEFT JOIN vCrm_Appointments c WITH(NOLOCK) on a.iTransId=c.iRelatedTo and c.iRelatedToType=1792
INNER JOIN vCrm_ModuleTypes d WITH(NOLOCK) on (b.iTypeId=d.iMasterId or c.iTypeId=d.iMasterId) 
INNER JOIN vCrm_ModuleTypes e WITH(NOLOCK) on (b.iRelatedToType=e.iMasterId or c.iRelatedToType=e.iMasterId) 
INNER JOIN vCore_LocationCust f WITH(NOLOCK) on c.Location1=f.iMasterId or b.iLocationId=f.iMasterId
where a.iTransId>0
and c.iAppointmentType<>2
