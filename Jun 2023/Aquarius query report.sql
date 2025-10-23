ALTER view nCore_LeadreportbySalesEnvironment as  
select   
       opp.sName [Opportunity Name],  
    reg.sName [Region],  
  case iOpportunityType when 1 then 'New Business'  
  when 2 then 'Existing Business'   
  when 3 then 'Competition'  
  when 4 then 'Partner Sale' else '' end [Opportunity Type],  
  ss.sName [Stage],  
  prod.sName [Product],  
  leads.LeadNo,  
  leads.iCreatedDate [$Datetime$LeadCreatedDate],  
  ISNULL(div.sName,'') [Divison],  
  users.sName [Owner],  
  us.sName [CreatedBy],  
  camp.sName [campaign Name],  
  ls.sName [Lead Source],  
  lstat.sName [Lead Status],  
  leads.sCompany,  
  leads.sFirstName,  
  leads.sCity [City],  
  leads.sPhone [Phone],  
  leads.ProductRequirement,  
  lstate.sName [LeadState],  
  leads.DetailedReasonforDisqualified,  
  (leads.Date) [$Date$Date],  
  reg.iMasterId,  
  leads.Division [Division],  
  lstate.iTransId,  
  ss.iMasterId [ssMaster]  
  
from   
             vaCrm_Leads leads WITH(NOLOCK)  
   left join vuCrm_Opportunities_General_Details opp WITH(NOLOCK)  
     on opp.iAccount=leads.iAccountId  
 left join  
     vCrm_SalesStages ss WITH(NOLOCK) on opp.iStage=ss.iMasterId  
left join   
     vCore_Product prod WITH(NOLOCK) on opp.iProductId=prod.iMasterId  
  
left join   
     vCore_Division div WITH(NOLOCK) on leads.Division=div.iMasterId  
left join   
     vCore_Region reg WITH(NOLOCK) on opp.Region=reg.iMasterId  
left join   
     vCrm_Users users WITH(NOLOCK) on users.iMasterId=leads.iAssignedTo  
left join   
     vCrm_Users us WITH(NOLOCK) on us.iMasterId=leads.iCreatedBy  
left join   
     vCrm_Campaigns camp WITH(NOLOCK) on camp.iMasterId=leads.iCampaignId  
left join   
     vCrm_LeadSource ls WITH(NOLOCK) on ls.iTransId=leads.iLeadSource  
left join   
     vCrm_LeadStatus lstat WITH(NOLOCK) on lstat.iTransId=leads.iLeadStatus  
left join   
     vCrm_LeadState lstate WITH(NOLOCK) on lstate.iTransId=leads.iLeadState  
where   
     leads.iTransId>0 