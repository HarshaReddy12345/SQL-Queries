		
		CREATE or alter function GetAttendenceInfo 
		(
		@STARTDATE int,
		@ENDDATE int
		)
		returns  @Return TABLE (
		  iAssignedTo int,
		  Employeeonduty nvarchar(200),
		  publicHoliday int,
		  weekoff int,
		  sdate varchar(10),
		  idate int,
		  [DaysinMonth] int,
		  TimeIn int,
		  TimeOut int,
		  attendance int
		)

		AS
		begin
		
		--DECLARE @STARTDATE int = dbo.fCore_DateToInt('2022-08-01')
		--DECLARE @ENDDATE int = dbo.fCore_DateToInt('2022-08-31')

		DECLARE @Employee TABLE (
		  SNO int,
		  Employeeonduty nvarchar(max),
		  iAssignedTo int
		)

		DECLARE @EmployeeCount int,
				@iAssignedTo int,
				@Employeeonduty nvarchar(200)
		DECLARE @i int
		DECLARE @MonthEndDate int
		DECLARE @j int
		DECLARE @Date int
		SET @MonthEndDate = dbo.fCrm_DATEDIFF(1,@STARTDATE,@ENDDATE)
		SET @i = 1
		SET @j = 1

		INSERT INTO @Employee (SNO, Employeeonduty, iAssignedTo)
		SELECT ROW_NUMBER() OVER (ORDER BY iMasterId), sName, iMasterId FROM vCrm_Users with(nolock) WHERE iMasterId <> 0 AND bAccountDisabled=0
		

		SET @EmployeeCount = (SELECT COUNT(Employeeonduty) [count] FROM @Employee)
		
		WHILE (@i <= @EmployeeCount)
		BEGIN
		SELECT @iAssignedTo = iAssignedTo, @Employeeonduty = Employeeonduty FROM @Employee where SNO = @i;
--		print @iAssignedTo
--		print @Employeeonduty
			WHILE (@j <= @MonthEndDate+1)
			BEGIN
				DECLARE @Weekoff int = dbo.WEEKEND_COUNT(@STARTDATE,@ENDDATE)
				DECLARE @publicholiday int = dbo.Holiday_COUNT(@STARTDATE,@ENDDATE)
				DECLARE @attendence int = 1
				Declare @InTime int
				Declare @OutTime int

				

				--select * from sys.all_objects where name like '%Holiday_COUN%'

				--SELECT 1 FROM vCore_EmployeeAttendance with(nolock) WHERE iAssignedTo = @iAssignedTo and[Date] = dbo.fCore_DateToInt(DATEADD(DD,@j-1,CONVERT(date,'2022-01-01')) )
				--select dbo.fCore_DateToInt(DATEADD(DD,1,CONVERT(date,'2022-01-01')))
				DECLARE @iAss int=0; 
				SELECT @iAss=1,@InTime=isnull(Timein,0),@OutTime=isnull(TimeOut,0) FROM vCore_EmployeeAttendance with(nolock) 
				WHERE iAssignedTo = @iAssignedTo and [Date] = dbo.fCrm_DATEADD(1,@STARTDATE,@j-1  )

				IF (isnull(@iAss,0)=0)
				BEGIN
--					print '1'
					INSERT INTO @Return (Employeeonduty, iAssignedTo, publicHoliday, weekoff, idate, attendance,DaysinMonth,TimeIn,TimeOut)
					VALUES (@Employeeonduty, @iAssignedTo, case @j when 1 then @publicholiday else 0 end,
					case @j when 1 then @Weekoff else 0 end , dbo.fCrm_DATEADD(1,@STARTDATE,@j-1), 0,case @j when 1 then @MonthEndDate+1 else 0 end,@InTime,@OutTime)
				END
				ELSE
				BEGIN
--					print '2'
					INSERT INTO @Return (Employeeonduty, iAssignedTo, publicHoliday, weekoff, idate, attendance,DaysinMonth,TimeIn,TimeOut)
					VALUES (@Employeeonduty, @iAssignedTo, case @j when 1 then @publicholiday else 0 end, 
					case @j when 1 then @Weekoff else 0 end, dbo.fCrm_DATEADD(1,@STARTDATE,@j-1), @attendence,case @j when 1 then @MonthEndDate+1 else 0 end,@InTime,@OutTime)
				END
				SET @j = @j + 1
--				print CONCAT('@j',@j)
			END
			
		  SET @i=@i+1
		  SET @j=1;
--		  print CONCAT('@i',@i)
		END

		Return;
	end


		--select * from vCore_EmployeeAttendance

		DECLARE @STARTDATE int = dbo.fCore_DateToInt('2022-09-01')
		DECLARE @ENDDATE int = dbo.fCore_DateToInt('2022-09-30')
		select *,idate [$Date$Datee],TimeIn [$Time$IN],TimeOut [$Time$OUT] from dbo.GetAttendenceInfo(@STARTDATE,@ENDDATE)

		select db.fCore_Da