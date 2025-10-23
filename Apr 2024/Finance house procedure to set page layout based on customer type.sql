
CREATE PROC udp_CustFromEntity (@iMasterId bigint,@iUserId int=0)
as 

begin
select @iMasterId=dbo.fCrm_IntToAPITransId(@iMasterId,0)
declare @CustomerType int

select @CustomerType=CustomerType from vCore_Account with(nolock) where iMasterId=@iMasterId
 
 if(@CustomerType=4)
 begin 
 Update a set  a.iSubTypeId=b.IndividualSubType from vCore_Account a with(nolock)
 join vCore_Entity b with(nolock) on a.Entity=b.iMasterId 
 where a.iMasterId=@iMasterId and ISNULL(a.DontUpdateSubType,0)=0
 end 
 else 
 begin 
  Update a set  a.iSubTypeId=b.CorporateSubType from vCore_Account a with(nolock)
 join vCore_Entity b with(nolock) on a.Entity=b.iMasterId 
 where a.iMasterId=@iMasterId and ISNULL(a.DontUpdateSubType,0)=0
 end 
end 

