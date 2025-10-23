


ALTER  PROCEDURE [dbo].[udp_UpdateEnquiryStage]  
(  
    @iTransId BIGINT,  
    @iUserId INT  
)  
AS  
BEGIN  
    DECLARE @MobileNo INT  
    DECLARE @Stage INT  
    DECLARE @ParentLead INT  
    DECLARE @iAssignedTo INT  
  
    SET @iTransId = dbo.fCrm_IntToAPITransId(@iTransId, 0)  
	select @iTransId =iTransId from vaCrm_Leads where iMasterId=@iTransId
    IF EXISTS   
    (  
        SELECT 1  
        FROM vaCrm_Leads a WITH (NOLOCK)  
        WHERE iTransId <> @iTransId AND Number = (SELECT  Number FROM vaCrm_Leads WITH (NOLOCK) WHERE iTransId = @iTransId  )
    )  
    BEGIN  
	--print '1'
        SELECT TOP 1 @ParentLead = iTransId  
        FROM vaCrm_Leads a WITH (NOLOCK)  
        WHERE iTransId <> @iTransId AND Number = (SELECT Number FROM vaCrm_Leads WITH (NOLOCK) WHERE iTransId = @iTransId)  
        ORDER BY iCreatedDate ASC  
  
		SELECT TOP 1 @iAssignedTo = iAssignedTo  
        FROM tCrm_CampaignLeads a WITH (NOLOCK)   
        WHERE a.iMemberId <> @iTransId AND a.iMemberId = @ParentLead  
		--print @ParentLead
  
        SET @Stage = 2  
    END  
    ELSE  
    BEGIN  
		--print '2'
        SET @Stage = 1  
    END  
		--print '3'
		--print '@stage'+cast(@Stage as varchar)
		UPDATE vaCrm_Leads   
		SET StatusOfLead = @Stage  
		WHERE iTransId = @iTransId 	
		
		

	IF(ISNULL(@ParentLead,0)>0)
	BEGIN
		--print '@ParentLead'+cast(@ParentLead as varchar)
		--print '@iAssignedTo'+cast(@iAssignedTo as varchar)
		UPDATE vaCrm_Leads   
		SET ParentLead = @ParentLead  
		WHERE iTransId = @iTransId 

		UPDATE tCrm_CampaignLeads   
		SET iAssignedTo = @iAssignedTo    
		WHERE iMemberId = @iTransId 
	END
END 





