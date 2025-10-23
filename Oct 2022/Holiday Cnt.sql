Declare @year int = 2022,-- @month int = 8;
WITH numbers
as
(
    Select 1 as value
    UNion ALL
    Select value + 1 from numbers
    where value + 1 <= Day(EOMONTH(datefromparts(@year,@month,1)))
)
SELECT datefromparts(@year,@month,numbers.value) Datum FROM numbers


 select dbo.WEEKEND_COUNT('2022/09/01','2022/09/30') [leave days],* from vrCore_EmployeeAttendance
 select dbo.Holiday_COUNT('01/01/2022','31/12/2022') [Ph],* from vrCore_EmployeeAttendance

 create function dbo.Holiday_COUNT
(
@Start_Date1 int,
@End_Date1 int
)
RETURNS int   
AS   
BEGIN
    Declare @count int = 0;
	declare @Start_Date date=dbo.fCore_IntToDate(@Start_Date1);
	declare @End_Date date=dbo.fCore_IntToDate(@End_Date1)
    select @count=count(*) from vCore_CalendarHoliday where iMasterId>0 and HolidayDate between @Start_Date1 and @End_Date1  
return @count 
END


select dbo.fCore_IntToDateTime(iCreatedDate)[Created Date],dbo.WEEKEND_COUNT('2022/09/01','2022/09/30') [leave days],* from vrCore_EmployeeAttendance with(nolock)
union all
Declare @year int = 2022, @month int = 8;
WITH numbers
as
(
    Select 1 as value
    UNion ALL
    Select value + 1 from numbers
    where value + 1 <= Day(EOMONTH(datefromparts(@year,@month,1)))
)
SELECT datefromparts(@year,@month,numbers.value) Datum FROM numbers

select dbo.fCore_IntToDate(HolidayDate)[publicHoliday] from vrCore_CalendarHoliday






select *,dbo.WEEKEND_COUNT(@STARTDATE,@ENDDATE), count of phs from (
select * from (select 'In Time' [Type], Employeeonduty,
       EmployeeCode,Date [$Date$Date],
	  Timein [$Time$time],Site,  ROW_NUMBER() OVER (
      PARTITION BY EmployeeCode,Date
      ORDER BY Timein) [Count],1 sortorder from vrCore_EmployeeAttendance  with(nolock)) as b where b.Count=1
	 
union all
select * from (select 'Out Time' [Type], Employeeonduty,
       EmployeeCode,Date [$Date$Date],
	  TimeOut [$Time$time],Site,  ROW_NUMBER() OVER (
      PARTITION BY EmployeeCode,Date
      ORDER BY Timein desc) [Count],2 sortorder from vrCore_EmployeeAttendance  with(nolock))a where a.Count=1)
	  aaa 
	  union all
	  
select dbo.fCore_IntToDate(HolidayDate)[publicHoliday],* from vrCore_CalendarHoliday

select from dbo.PublicHoliday_count [public holidays] from vrCore_CalendarHoliday
create function dbo.PublicHoliday_Count
 (
@Start_Date datetime,
@End_Date datetime
)
RETURNS int   
AS   
BEGIN
declare @Count int=0
 while @Start_Date<=@End_Date
 begin
 select DATEDIFF(DAY,'')

 case when WHEN DATEPART(Month, '2022-09-27') IN (1, 31)
 then 'PublicHoliday'
 
 
 
 select * from 
 
 
 (
 
 select [month],Count(publicHoliday) cpount from (
 select dbo.fCore_IntToDate(HolidayDate)[publicHoliday],datepart(MONTH,dbo.fCore_IntToDate(HolidayDate)) [month]
      from vrCore_CalendarHoliday  with(nolock)) aa group by month) aaa
 --where HolidayDate between @Startdate and @Enddate

order by HolidayDate desc
