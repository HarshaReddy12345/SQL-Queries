CREATE TABLE Dummy_Contract
(
    Contract varchar (50),
    Frequency nVarchar(MAX),
    WEEK INT,
	RequestCount int,
	MonthYear nvarchar(MAX)
 
)


select * from Dummy_Contract



INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Jan-2022','Contract-1','Weekly',1,1)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Feb-2022','Contract-1','Weekly',2,0)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Mar-2022','Contract-1','Weekly',3,1)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Apr-2022','Contract-1','Monthly',1,0)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('May-2022','Contract-1','Monthly',2,1)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Jun-2022','Contract-1','Monthly',3,1)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Jul-2022','Contract-1','Quaterly',1,0)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Aug-2022','Contract-1','Quaterly',2,0)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Sep-2022','Contract-1','Quaterly',3,1)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Oct-2022','Contract-1','Yearly',1,1)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Nov-2022','Contract-1','Yearly',2,1)
INSERT INTO Dummy_Contract (MonthYear,Contract,Frequency,WEEK,RequestCount)
values('Dec-2022','Contract-1','Yearly',3,1)

