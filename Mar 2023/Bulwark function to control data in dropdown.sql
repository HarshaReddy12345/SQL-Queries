Create function dbo.fCore_Var9002(@s xml)
returns varchar(max)
as
begin
    
    declare @iOpportunityType int,@Division int,@sRet varchar(max);
    
    set @iOpportunityType = @s.value('(Fields/Header/iOpportunityType)[1]','int');

	if(@iOpportunityType=1)
	begin
    select @sRet = coalesce(@sRet+',','')+CONCAT(b.sName,'|',b.iMasterId)
   from vCore_Division b with(nolock) 
	where b.iMasterId in(2,4,8)
    end
	else if (@iOpportunityType=2)
	begin 
  select @sRet = coalesce(@sRet+',','')+CONCAT(b.sName,'|',b.iMasterId)
    from vCore_Division b with(nolock) 
	where b.iMasterId in(1,3,5,6,7)
end
    return @sRet;
end



