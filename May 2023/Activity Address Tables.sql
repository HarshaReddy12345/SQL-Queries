select sAddress,* from tCrm_LatLngAddress
select * from tCore_MasterLocAuditLog
select * from tCore_SO_AuditLogDetails
select * from (select * from tCore_MasterAuditLog where iMasterTypeId=3002 ) au 
join vCore_SO so on au.iMasterId=so.iMasterId

SELECT name, referenced_object_id
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('tCore_MasterAuditLog');



select * from vCrm_ModuleTypes where iERPModuleId=3002