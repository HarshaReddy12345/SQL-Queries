CREATE PROCEDURE A_UpdateAssetBasedOnDates (@iMasterId bigint, @iUserId int)
AS
BEGIN
  DECLARE @ExpOn int
  DECLARE @WarrantyfromSupplyDate int,
          @WarrantyfromInvoiceDate int,
          @WarrantyfromInstallationDate int
  SELECT
    @iMasterId = dbo.fCrm_IntToAPITransId(@iMasterId, 0)
  SELECT
    @ExpOn = WarrantyOn
  FROM vCrm_CustAssets WITH (NOLOCK)
  WHERE iTransId = @iMasterId
  SELECT
    @WarrantyfromSupplyDate = WarrantyfromSupplyDate
  FROM vCrm_CustAssets WITH (NOLOCK)
  WHERE iTransId = @iMasterId
  SELECT
    @WarrantyfromInvoiceDate = WarrantyfromInvoiceDate
  FROM vCrm_CustAssets WITH (NOLOCK)
  WHERE iTransId = @iMasterId
  SELECT
    @WarrantyfromInstallationDate = WarrantyfromInstallationDate
  FROM vCrm_CustAssets WITH (NOLOCK)
  WHERE iTransId = @iMasterId
  IF (@ExpOn = 6)
  BEGIN
    UPDATE vCrm_CustAssets
    SET iWarrantyExpiry = (CASE
      WHEN DATEDIFF(DAY, GETDATE(), dbo.fCore_IntToDate(WarrantyfromSupplyDate)) < 180 THEN WarrantyfromInstallationDate
      ELSE WarrantyfromSupplyDate
    END)
    WHERE iTransId = @iMasterId
  END
  IF (@ExpOn = 7)
  BEGIN
    UPDATE vCrm_CustAssets
    SET iWarrantyExpiry =
    (CASE
      WHEN WarrantyfromInvoiceDate > WarrantyfromSupplyDate THEN WarrantyfromInvoiceDate
      ELSE WarrantyfromSupplyDate
    END)
    WHERE iTransId = @iMasterId
  END
  IF (@ExpOn = 4)
  BEGIN
    IF (@WarrantyfromSupplyDate <= @WarrantyfromInvoiceDate
      AND @WarrantyfromSupplyDate <= @WarrantyfromInstallationDate)
      UPDATE vCrm_CustAssets
      SET iWarrantyExpiry = @WarrantyfromSupplyDate
      WHERE iTransId = @iMasterId
    ELSE
    IF @WarrantyfromInvoiceDate <= @WarrantyfromSupplyDate
      AND @WarrantyfromInvoiceDate <= @WarrantyfromInstallationDate
      UPDATE vCrm_CustAssets
      SET iWarrantyExpiry = @WarrantyfromInvoiceDate
      WHERE iTransId = @iMasterId
    ELSE
      UPDATE vCrm_CustAssets
      SET iWarrantyExpiry = WarrantyfromInstallationDate
      WHERE iTransId = @iMasterId
  END
  IF (@ExpOn = 5)
  BEGIN
    IF @WarrantyfromSupplyDate >= @WarrantyfromInvoiceDate
      AND @WarrantyfromSupplyDate >= @WarrantyfromInstallationDate
      UPDATE vCrm_CustAssets
      SET iWarrantyExpiry = @WarrantyfromSupplyDate
      WHERE iTransId = @iMasterId
    ELSE
    IF @WarrantyfromInvoiceDate >= @WarrantyfromSupplyDate
      AND @WarrantyfromInvoiceDate >= @WarrantyfromInstallationDate
      UPDATE vCrm_CustAssets
      SET iWarrantyExpiry = @WarrantyfromInvoiceDate
      WHERE iTransId = @iMasterId
    ELSE
      UPDATE vCrm_CustAssets
      SET iWarrantyExpiry = @WarrantyfromInstallationDate
  END
END