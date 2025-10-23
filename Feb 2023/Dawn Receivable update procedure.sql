create or alter Procedure A_UpdateModule(@iTransId bigint,@iUserId int)
as 
begin
     Declare @BookingNo int
	select @iTransId = dbo.fCrm_IntToAPITransId(@iTransId,0)
	select @BookingNo=iBookingId  from vCrm_BookingCancellation WITH(NOLOCK) where iTransId=@iTransId
	update vCore_Receivables  set ReceivableStatus=4 where @BookingNo=Booking and ReceivableStatus=1
end




