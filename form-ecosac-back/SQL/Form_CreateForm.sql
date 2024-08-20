USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_CreateForm]    Script Date: 20/08/2024 15:04:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_CreateForm]
    @json VARCHAR(MAX)
AS
BEGIN
    SET XACT_ABORT ON
    SET NOCOUNT ON;
    DECLARE
        -- Variables para los parámetros
        @idClient varchar(100),
        @nameClient VARCHAR(200),
        @CountryName INT,
        @DestinationPort INT,
        @DestinationFinal INT,
        @BillName VARCHAR(120),
        @BillAddress VARCHAR(200),
        @BillInfoAdd VARCHAR(500),
        @FreightPayer VARCHAR(200),
        @PlacePayment VARCHAR(200),
        @emissionType VARCHAR(100),
        @FreightPayerInfoAdd VARCHAR(500),
        @BLDataInfoAdd VARCHAR(500),
        @IsAllowedPhyto TINYINT,
        @PhytoName VARCHAR(200),
        @PhytoAddress VARCHAR(200),
        @PhytoCountryPort VARCHAR(200),
        @PhytoInfoAdd VARCHAR(500),
        @PhytoTransitCountry VARCHAR(100),
        @PhytoExportSENASA varchar(500),
        @CertificateNameOrigin VARCHAR(200),
        @CertificateAddressOrigin VARCHAR(200),
        @CertificateInfoAdd VARCHAR(500),
        @isConsigneeSendDoc VARCHAR(200),
		@isNotifierSendDoc varchar(200),
        @EmailInfoAdd VARCHAR(500),
        @OriginalDocInfoAdd VARCHAR(500),

        @IsSendScanning TINYINT,
		@msg_error VARCHAR(200) = '',
        @FilasAfectadas INT;


    -- Parsear el JSON para extraer los valores
    SELECT
        @idClient = JSON_VALUE(@json, '$.idClient'),
        @nameClient = JSON_VALUE(@json, '$.nameClient'),
        @CountryName = JSON_VALUE(@json, '$.CountryName'),
        @DestinationPort = JSON_VALUE(@json, '$.DestinationPort'),
        @DestinationFinal = JSON_VALUE(@json, '$.DestinationFinal'),
        @BillName = JSON_VALUE(@json, '$.BillName'),
        @BillAddress = JSON_VALUE(@json, '$.BillAddress'),
        @BillInfoAdd = JSON_VALUE(@json, '$.BillInfoAdd'),
        @FreightPayer = JSON_VALUE(@json, '$.FreightPayer'),
        @PlacePayment = JSON_VALUE(@json, '$.PlacePayment'),
        @emissionType = JSON_VALUE(@json, '$.emissionType'),
        @FreightPayerInfoAdd = JSON_VALUE(@json, '$.FreightPayerInfoAdd'),
        @BLDataInfoAdd = JSON_VALUE(@json, '$.BLDataInfoAdd'),
        @IsAllowedPhyto = JSON_VALUE(@json, '$.IsAllowedPhyto'),
        @PhytoName = JSON_VALUE(@json, '$.PhytoName'),
        @PhytoAddress = JSON_VALUE(@json, '$.PhytoAddress'),
        @PhytoCountryPort = JSON_VALUE(@json, '$.PhytoCountryPort'),
        @PhytoInfoAdd = JSON_VALUE(@json, '$.PhytoInfoAdd'),
        @PhytoTransitCountry = JSON_VALUE(@json, '$.PhytoTransitCountry'),
        @PhytoExportSENASA = JSON_VALUE(@json, '$.PhytoExportSENASA'),
        @CertificateNameOrigin = JSON_VALUE(@json, '$.CertificateNameOrigin'),
        @CertificateAddressOrigin = JSON_VALUE(@json, '$.CertificateAddressOrigin'),
        @CertificateInfoAdd = JSON_VALUE(@json, '$.CertificateInfoAdd'),
        @isConsigneeSendDoc = JSON_VALUE(@json, '$.isConsigneeSendDoc'),
        @isNotifierSendDoc = JSON_VALUE(@json, '$.isNotifierSendDoc'),
        @IsSendScanning = JSON_VALUE(@json, '$.IsSendScanning'),
        @EmailInfoAdd = JSON_VALUE(@json, '$.EmailInfoAdd'),
        @OriginalDocInfoAdd = JSON_VALUE(@json, '$.OriginalDocInfoAdd');

    DECLARE @LastConsigneeId INT;
    DECLARE @LastNotifierId INT;
    DECLARE @LastDocReq INT;

    DECLARE @LastSendPhysicalDocument INT;
    DECLARE @LastSendOriginalDocument INT;




    -- Obtener el último idDataConsignee e idDataNotifier insertado
    SELECT TOP 1
        @LastConsigneeId = idDataConsignee
    FROM FormDataConsignee
    ORDER BY idDataConsignee DESC;

    select top 1
        @LastDocReq = idDocReq
    from FormRequiredDocuments
    order by idDocReq DESC;



    IF @CountryName IS NULL
	BEGIN
        SELECT TOP 1
            @CountryName = idCountry
        FROM FormCountry
        ORDER BY idCountry DESC
    END;

    IF @DestinationPort IS NULL
	BEGIN
        SELECT TOP 1
            @DestinationPort = idPort
        FROM FormPort
        ORDER BY idPort DESC
    END;

    IF @DestinationFinal IS NULL
	BEGIN
        SELECT TOP 1
            @DestinationFinal = idPort
        FROM FormPortDestination
        ORDER BY idPort DESC
    END;

    IF @IsSendScanning = 0
	BEGIN
        SELECT TOP 1
            @LastSendPhysicalDocument = idSendPhysicalDocument
        FROM FormSendPhysicalDocuments
        ORDER BY idSendPhysicalDocument DESC;
    END;
	ELSE
    BEGIN
        SET @LastSendPhysicalDocument = NULL;
    -- Si IsSendScanning es 1, idSendPhysicalDocument será NULL
    END;

    IF @isNotifierSendDoc IS NOT NULL
    BEGIN
        SET @isConsigneeSendDoc = NULL;
        SET @LastSendOriginalDocument = NULL;
    END;
	ELSE IF @isConsigneeSendDoc IS NULL and @isNotifierSendDoc IS NULL
	BEGIN
        SELECT TOP 1
            @LastSendOriginalDocument = idAddressOriginalsDoc
        FROM FormAddressOriginalsDoc
        WHERE secCreate >= DATEADD(mi, -1, GETDATE())
        ORDER BY idAddressOriginalsDoc DESC;

    END;
	ELSE
    BEGIN
        SET @LastSendOriginalDocument = NULL;
    -- Si @isConsigneeSendDoc es 1, idSendPhysicalDocument será NULL
    END;


    BEGIN TRY
        -- Inserta en la tabla Form
        INSERT INTO Form
        (
        idClient,
        nameClient,
        CountryName,
        DestinationPort,
        DestinationFinal,
        BillName,
        BillAddress,
        BillInfoAdd,
        FreightPayer,
        PlacePayment,
        emissionType,
        FreightPayerInfoAdd,
        idDataConsignee,

        BLDataInfoAdd,
        IsAllowedPhyto,
        PhytoName,
        PhytoAddress,
        PhytoCountryPort,
        PhytoInfoAdd,
        PhytoTransitCountry,
        PhytoExportSENASA,
        CertificateNameOrigin,
        CertificateAddressOrigin,
        CertificateInfoAdd,
        idDocReq,
        isConsigneeSendDoc,
        isNotifierSendDoc,
        idAddressOriginalsDoc,

        IsSendScanning,
        idSendPhysicalDocument,
        EmailInfoAdd,
        OriginalDocInfoAdd,
        estado,
        secCreate,
        secUpdate
        )
    VALUES
        (
            @idClient,
            @nameClient,
            @CountryName,
            @DestinationPort,
            @DestinationFinal,
            @BillName,
            @BillAddress,
            @BillInfoAdd,
            @FreightPayer,
            @PlacePayment,
            @emissionType,
            @FreightPayerInfoAdd,
            @LastConsigneeId,

            @BLDataInfoAdd,
            @IsAllowedPhyto,
            @PhytoName,
            @PhytoAddress,
            @PhytoCountryPort,
            @PhytoInfoAdd,
            @PhytoTransitCountry,
            @PhytoExportSENASA,
            @CertificateNameOrigin,
            @CertificateAddressOrigin,
            @CertificateInfoAdd,
            @LastDocReq,
            @isConsigneeSendDoc,
            @isNotifierSendDoc,

            @LastSendOriginalDocument,

            @IsSendScanning ,
            @LastSendPhysicalDocument,
            @EmailInfoAdd,
            @OriginalDocInfoAdd,
            1,
            GETDATE(),
            NULL
        );


		SET @FilasAfectadas = @@ROWCOUNT;

        IF @FilasAfectadas > 0
        BEGIN
        SET @msg_error = 'Registro exitoso';
    END
        ELSE
        BEGIN
        SET @msg_error = 'No se realizó el registro';
        THROW 50001, @msg_error, 1;
    END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
    SELECT @msg_error AS mensaje;
END



