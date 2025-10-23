CREATE or ALTER PROCEDURE udp_UpdateAddressFromActivityStreamToSO(@iMasterId bigint=0,@iUserId int=0)
as
BEGIN
select @iMasterId=dbo.fCrm_IntToAPITransId(@iMasterId,0) 
 update so set so.Address=sAddress
 from (Select * from muCore_SO )so
 join tCore_MasterAuditLog au on so.iMasterId=au.iMasterId
 LEFT OUTER JOIN tCore_SO_AuditLogDetails flog
  ON au.iAuditId = flog.iAuditId
LEFT OUTER JOIN tCore_MasterLocAuditLog llog
  ON au.iAuditId = llog.iAuditId
LEFT OUTER JOIN tCrm_LatLngAddress tlla
  ON llog.iAddressId = tlla.iAddressId
 where iMasterTypeId=3002 and so.iMasterId>0 and so.iMasterId=@iMasterId
 END