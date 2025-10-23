alter view nCore_CustomerServed as
select a.iMasterId [CTDID],
       b.iMasterId [AccountId],
	   c.iMasterId [UserId],
	   e.iMasterId [WeekDayId],
	   a.sName [CTDName],
	   b.sName [Customer],
	   c.sName [SalesPerson],
	   e.sName [WeekDay]
from 
       vCore_CustomerTargetByDaysMaster a
left join 
       vCore_Account b on a.Customer=b.iMasterId
left join 
       vCrm_Users c on b.SalesPerson=c.iMasterId
left join 
       vCore_DaysofWeek e on a.DaysofWeek =e.iMasterId
where 
       b.iAccountType=5
	   ---------------------------------------------------
	   create function dbo.udf_GetWeekDaysByDates(@STARTDATE int,@ENDDATE int)
returns @tbl_WeekDays table (iRowId int identity(1,1), sWeekDay varchar(20),iDate int)
as
begin
	declare @dStartDate date = dbo.fCore_IntToDate(@STARTDATE)
	declare @dEndDate date = dbo.fCore_IntToDate(@ENDDATE)

	;with cte_week as (
		select DATENAME(DW,@dStartDate) [sWeekDay],@dStartDate [sDate]
		union all
		select DATENAME(DW,dateadd(DD,1,[sDate])) [sWeekDay],dateadd(DD,1,[sDate]) [sDate] from cte_week where sDate<@dEndDate
	)

	insert into @tbl_WeekDays (sWeekDay)
	select distinct sWeekDay from cte_week

	return
end
---------------------------------------------------------
	   
	   
	select SalesPerson,Customer,Served,case when count(Target)>1 then 1 else count(Target) end [NTarget] from
(
select *,1 [Target] from nCore_CustomerServed a with(nolock)
left join (select case when count(Customer)>1 then 1 else count(Customer) end [Served],
DateName(DW,dbo.fCore_IntToDate(Date)) _WeekDay,Customer cus 
from vCore_SalesInvoice where Date between @STARTDATE and @ENDDATE
group by Date,Customer
) b on b.cus=a.AccountId and
[_WeekDay]=a.[WeekDay]
inner join dbo.udf_GetWeekDaysByDates(@STARTDATE,@ENDDATE) c on c.sWeekDay=a.[WeekDay]
)aa
	   
	   group by SalesPerson,Customer,Served
	   
	   





