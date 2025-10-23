create or alter Procedure A_UpdateModule(@iTransId bigint,@iUserId int)
as 
begin
     declare @Remarks varchar(max)
	set @Remarks=(select top 1 sDescription from cCrm_Auth_Approvals order by iApprovalDate desc)
	select @iTransId = dbo.fCrm_IntToAPITransId(@iTransId,0)
	update b set b.sApprovalRemarks=@Remarks
	from  cCrm_Auth_Approvals a with (NOLOCK)
	join  vCrm_Calls b with (NOLOCK) on b.iTransId=a.iTransId
	where a.iModuleId=3840 and a.iTransId=@iTransId
end



