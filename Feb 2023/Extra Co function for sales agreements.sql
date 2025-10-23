create or alter function dbo.fCore_Var1002(@s xml)
returns varchar(max)
as
begin
	declare @iMasterId int;
	set @iMasterId= @s.value('(Fields/Header/MainAgreement)[1]','int');
	declare @sret varchar(max);
	select  @sret = coalesce(@sret+',','')+concat(sName,'|',iMasterId)  from
	(select iMasterId,sName from vCore_SalesAgreements where iMasterId=@iMasterId
	union all
	select iMasterId,sName from vCore_SalesAgreements where MainAgreement=@iMasterId) A
	return @sret;
end
