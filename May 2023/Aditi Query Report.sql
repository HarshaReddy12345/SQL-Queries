ALTER VIEW nCore_DailyActivity AS  
select   
        ISNULL(a.sDescription,'') [Description],  
  c.sName [Location],  
  --dbo.fCore_IntToDateTime(a.iCreatedDate) [CreatedDate],
  a.iCreatedDate,
        d.sName [Module] ,  
        e.sName [Activity],  
  a.iAssignedTo,  
  f.sName [Owner],ISNULL(b.sCompany,'') [Account]  
from tCrm_Tasks a WITH(NOLOCK)  
left join    
      tuCrm_Tasks WITH(NOLOCK) on a.iTransId=tuCrm_Tasks.iTransId  
left join   
      vCrm_Leads b WITH(NOLOCK) on a.iRelatedTo=b.iTransId  
left join   
      vCore_LocationCust c WITH(NOLOCK) on tuCrm_Tasks.Location=c.iMasterId  
left join   
      vCrm_ModuleTypes d WITH(NOLOCK) on a.iRelatedToType=d.iMasterId   
left join   
      vCrm_ModuleTypes e WITH(NOLOCK) on a.iTypeId=e.iMasterId   
left join  
   vCrm_Users f WITH(NOLOCK) on a.iAssignedTo=f.iMasterId  
where  a.iRelatedToType=256  
  
union all  
  
select   
         distinct  
   ISNULL(a.sDescription,'') [Description],  
   c.sName [Location],  
  -- dbo.fCore_IntToDateTime(a.iCreatedDate) [CreatedDate], 
    a.iCreatedDate,
   d.sName [Module],  
   case when a.iAppointmentType in (1)then 'Appointment'    
   when a.iAppointmentType in (3) then 'Meeting' end [Activity],  
   a.iAssignedTo,  
   f.sName [Owner] ,ISNULL(b.sCompany,'') [Account]   
from tCrm_Appointments a WITH(NOLOCK)  
left join    
      tuCrm_Appointments WITH(NOLOCK) on a.iTransId=tuCrm_Appointments.iTransId  
left join   
      vCrm_Leads b WITH(NOLOCK) on a.iRelatedTo=b.iTransId  
left join   
      vCore_LocationCust c WITH(NOLOCK) on tuCrm_Appointments.Location1=c.iMasterId  
left join   
      vCrm_ModuleTypes d WITH(NOLOCK) on a.iRelatedToType=d.iMasterId   
left join   
      vCrm_ModuleTypes e WITH(NOLOCK) on a.iTypeId=e.iMasterId   
left join  
   vCrm_Users f WITH(NOLOCK) on a.iAssignedTo=f.iMasterId  
  
where  a.iRelatedToType=256  
  
union all  
  
select   
       ISNULL(a.sDescription,'') [Description],   
    c.sName [Location],--dbo.fCore_IntToDateTime(a.iCreatedDate) [CreatedDate], 
	 a.iCreatedDate,
       d.sName [Module] ,  
       e.sName [Activity],  
    a.iAssignedTo,  
  f.sName [Owner],ISNULL(g.sName,'') [Account]  
from tCrm_Tasks a WITH(NOLOCK)  
left join    
      tuCrm_Tasks WITH(NOLOCK) on a.iTransId=tuCrm_Tasks.iTransId  
left join   
      vCrm_Opportunities b WITH(NOLOCK) on a.iRelatedTo=b.iTransId  
left join   
      vCore_LocationCust c WITH(NOLOCK) on tuCrm_Tasks.Location=c.iMasterId  
left join   
      vCrm_ModuleTypes d WITH(NOLOCK) on a.iRelatedToType=d.iMasterId   
left join   
      vCrm_ModuleTypes e WITH(NOLOCK) on a.iTypeId=e.iMasterId   
left join  
   vCrm_Users f WITH(NOLOCK) on a.iAssignedTo=f.iMasterId  
left join
   vCore_Account g WITH(NOLOCK) on b.iAccount=g.iMasterId
where  a.iRelatedToType=1792  
  
union all  
  
select   
         distinct  
   ISNULL(a.sDescription,'') [Description],  
   c.sName [Location],  
   --dbo.fCore_IntToDateTime(a.iCreatedDate) [CreatedDate],
    a.iCreatedDate,
   d.sName [Module],  
         case when a.iAppointmentType in (1)then 'Appointment'    
         when a.iAppointmentType in (3) then 'Meeting' end [Activity],  
   a.iAssignedTo,  
  f.sName [Owner],ISNULL(g.sName,'') [Account]    
from tCrm_Appointments a WITH(NOLOCK)  
left join    
      tuCrm_Appointments WITH(NOLOCK) on a.iTransId=tuCrm_Appointments.iTransId  
left join   
      vCrm_Opportunities b WITH(NOLOCK) on a.iRelatedTo=b.iTransId  
left join   
      vCore_LocationCust c WITH(NOLOCK) on tuCrm_Appointments.Location1=c.iMasterId  
left join   
      vCrm_ModuleTypes d WITH(NOLOCK) on a.iRelatedToType=d.iMasterId   
left join   
      vCrm_ModuleTypes e WITH(NOLOCK) on a.iTypeId=e.iMasterId   
left join  
   vCrm_Users f WITH(NOLOCK) on a.iAssignedTo=f.iMasterId  
left join
   vCore_Account g WITH(NOLOCK) on b.iAccount=g.iMasterId
where  a.iRelatedToType=1792  
  
  
  
  