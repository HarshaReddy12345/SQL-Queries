ALTER VIEW  nCrm_QandQ as

select 1 num,a.iMasterId,b.sName [ROName],a.sCode,format(dbo.fCore_IntToDate(Date),'dd/MM/yyyy') [Date], SrNo1 [Sr No.],DUno1 [DU No], AfterPowerOnNozzleNo1 [Nozzle No],
AfterPowerOnElectromechTotalizerReading [Electromech Totaliser Reading],
AfterPowerOnElectronicTotalizerReading [Electronic. Totaliser Reading],
AfterPowerOnPresentKFactorLogCounter [Present K Factor ! Log Counter],
AfterPowerOnHologramStickerOnmeteringUnit [Hologram Sticker on Metering Unit],
BeforeOTPElectromechTotalizerReading [Electromech. Totaliser Reading Otp],
BeforeOTPElectronicTotalizerReading [Electronic. Totaliser Reading Otp],
BeforeOTPPresentKFactorLogCounter [Present K Factor ! Log Counter Otp],
BeforeOTPHologramStickeronMeteringUnit [Hologram Sticker on Metering Unit Otp]
from vuCore_QandQ_DispensingunitrecordsNo1_Details a WITH(NOLOCK)
left join vCore_Retailoutlet b WITH(NOLOCK) on a.ROName=b.iMasterId 
where a.iMasterId>0 order by num

union all

select 2 num,a.iMasterId,b.sName [ROName],a.sCode,format(dbo.fCore_IntToDate(Date),'dd/MM/yyyy') [Date],SrNo [Sr No.],DUNo [DU No], AfterPowerOnNozzleNo2 [Nozzle No],
AfterPowerOnElectromechTotalizerReading2 [Electromech Totaliser Reading],
AfterPowerOnElectronicTotalizerReading2 [Electronic. Totaliser Reading],
AfterPowerOnPresentKFactorLogCounter2 [Present K Factor ! Log Counter],
AfterPowerOnHologramStickerOnmeteringUnit2 [Hologram Sticker on Metering Unit],
BeforeOTPElectromechTotalizerReading2 [Electromech. Totaliser Reading Otp],
BeforeOTPElectronicTotalizerReading2 [Electronic. Totaliser Reading Otp],
BeforeOTPPresentKFactorLogCounter2 [Present K Factor ! Log Counter Otp],
BeforeOTPHologramStickeronMeteringUnit2 [Hologram Sticker on Metering Unit Otp]
from vuCore_QandQ_DispensingunitrecordsNo2_Details a WITH(NOLOCK)
left join vCore_Retailoutlet b WITH(NOLOCK) on a.ROName=b.iMasterId 
where a.iMasterId>0 order by num

union all

select 3 num,a.iMasterId,b.sName [ROName],a.sCode,format(dbo.fCore_IntToDate(Date),'dd/MM/yyyy') [Date],SrNo3 [Sr No.],DUNo3 [DU No], AfterPowerOnNozzleNo3 [Nozzle No],
AfterPowerOnElectromechtotalizerReading3 [Electromech Totaliser Reading],
AfterPowerOnElectronictotalizerReading3 [Electronic. Totaliser Reading],
AfterPowerOnPresentKFactorLogCounter3 [Present K Factor ! Log Counter],
AfterPowerOnHologramStickerOnmeteringUnit3 [Hologram Sticker on Metering Unit],
BeforeOTPElectromechTotalizerReading3 [Electromech. Totaliser Reading Otp],
BeforeOTPElectronicTotaliserReading3 [Electronic. Totaliser Reading Otp],
BeforeOTPPresentKFactorLogCounter3 [Present K Factor ! Log Counter Otp],
BeforeOTPHologramStickeronMeteringUnit3 [Hologram Sticker on Metering Unit Otp]
from vuCore_QandQ_DispensingunitrecordsNo3_Details a WITH(NOLOCK)
left join vCore_Retailoutlet b WITH(NOLOCK) on a.ROName=b.iMasterId 
where a.iMasterId>0 order by num

union all

select 4 num,a.iMasterId,b.sName [ROName],a.sCode,format(dbo.fCore_IntToDate(Date),'dd/MM/yyyy') [Date],SrNo4 [Sr No.],DUNo4 [DU No], AfterPowerOnNozzleNo4 [Nozzle No],
AfterPowerOnElectromechTotaliserReading4 [Electromech Totaliser Reading],
AfterPowerOnElectronicTotalizerReading4 [Electronic. Totaliser Reading],
AfterPowerOnPresentKFactorLogCounter4 [Present K Factor ! Log Counter],
AfterPowerOnHologramStickerOnmeteringUnit4 [Hologram Sticker on Metering Unit],
BeforeOTPElectromechTotalizerReading4 [Electromech. Totaliser Reading Otp],
BeforeOTPElectronicTotalizerReading4 [Electronic. Totaliser Reading Otp],
BeforeOTPPresentKFactorLogCounter4 [Present K Factor ! Log Counter Otp],
BeforeOTPHologramStickeronMeteringUnit4 [Hologram Sticker on Metering Unit Otp]
from vuCore_QandQ_DispensingunitrecordsNo4_Details a WITH(NOLOCK)
left join vCore_Retailoutlet b WITH(NOLOCK) on a.ROName=b.iMasterId 
where a.iMasterId>0 order by num




