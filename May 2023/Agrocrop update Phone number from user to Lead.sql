CREATE or ALTER procedure udp_UpdatePhoneFromUsersToLeads (@iTransId bigint=0,@iUserId int=0)    
as    
begin        
    select @iTransId  =dbo.fCrm_IntToAPITransId(@iTransId,0)  
UPDATE l
SET l.UserNumber = u.sPhone
FROM vCrm_Leads l WITH(NOLOCK)
INNER JOIN tCrm_CampaignLeads cl WITH(NOLOCK) ON cl.iLeadId = l.iTransId
INNER JOIN vCrm_Users u WITH(NOLOCK) ON cl.iAssignedTo = u.iMasterId
WHERE cl.iLeadId = @iTransId;
end








