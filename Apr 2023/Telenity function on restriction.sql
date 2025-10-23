CREATE function [dbo].[fCore_Var100](@s xml)
returns bit
as
begin
	declare @AccountName int

	select @AccountName=@s.value('(/Fields/Header/AccountName)[1]','int')
	if exists (select 1 from vCore_Account with(nolock) 
	           where ISNULL(AgreementAttachmentName,'')<>''
			   and 
			   ISNULL(NDAAttachmentName,'')<>'' 
			   and 
			   iMasterId=@AccountName)
	begin
		return 0;
	end
	        return 1;
end
