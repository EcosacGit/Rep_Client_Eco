ALTER PROCEDURE [dbo].[Form_CreateFormRequiredDocument]
    @json varchar(max)
AS
BEGIN
    SET XACT_ABORT ON;
    SET NOCOUNT ON;

    DECLARE
        -- Variables para validaciones
        @msg_error VARCHAR(200) = '',
        @FilasAfectadas INT,

        -- Parámetros JSON
        @packingList tinyint,
        @plasticStatement tinyint,
        @INVIMA tinyint,
        @FDA tinyint,
        @PPQ tinyint,
        @ColdTreatment tinyint,
        @InspectionFormat tinyint,
        @MicrobioAnalysis tinyint,
        @InsuranceCertificate tinyint,
        @DAM tinyint,
        @QualityReport tinyint,
        @Other varchar(200);

    -- Parsear los valores del JSON
    SELECT
        @packingList = ISNULL(JSON_VALUE(@json, '$.packingList'), 0), -- Ajustar el valor predeterminado según corresponda
        @plasticStatement = ISNULL(JSON_VALUE(@json, '$.plasticStatement'), 0),
        @INVIMA = ISNULL(JSON_VALUE(@json, '$.INVIMA'), 0),
        @FDA = ISNULL(JSON_VALUE(@json, '$.FDA'), 0),
        @PPQ = ISNULL(JSON_VALUE(@json, '$.PPQ'), 0),
        @ColdTreatment = ISNULL(JSON_VALUE(@json, '$.ColdTreatment'), 0),
        @InspectionFormat = ISNULL(JSON_VALUE(@json, '$.InspectionFormat'), 0),
        @MicrobioAnalysis = ISNULL(JSON_VALUE(@json, '$.MicrobioAnalysis'), 0),
        @InsuranceCertificate = ISNULL(JSON_VALUE(@json, '$.InsuranceCertificate'), 0),
        @DAM = ISNULL(JSON_VALUE(@json, '$.DAM'), 0),
        @QualityReport = ISNULL(JSON_VALUE(@json, '$.QualityReport'), 0),
        @Other = ISNULL(JSON_VALUE(@json, '$.Other'), '');

    BEGIN TRY
        INSERT INTO FormRequiredDocuments(
            packingList,
            plasticStatement,
            INVIMA,
            FDA,
            PPQ,
            ColdTreatment,
            InspectionFormat,
            MicrobioAnalysis,
            InsuranceCertificate,
            DAM,
            QualityReport,
            Other,
            estado,
            secCreate,
            secUpdate
        )
        VALUES (
            @packingList,
            @plasticStatement,
            @INVIMA,
            @FDA,
            @PPQ,
            @ColdTreatment,
            @InspectionFormat,
            @MicrobioAnalysis,
            @InsuranceCertificate,
            @DAM,
            @QualityReport,
            @Other,
            1,
            GETDATE(),
            null
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
        END;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;

    SELECT @msg_error AS mensaje;
END;
