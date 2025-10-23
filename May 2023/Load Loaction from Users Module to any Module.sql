CREATE OR ALTER function [dbo].[fCore_Var2002](@s xml)  
returns int  
as  
begin  
declare @iOwner int
declare @result int  
select @iOwner=@s.value('(/Fields/Header/iAssignedTo)[1]','int') 
select top 1 @result= iLocation from vCrm_Users with(nolock) where iMasterId=@iOwner;
return @result
end


select iLocation from vCrm_Users with(nolock) where iMasterId=20