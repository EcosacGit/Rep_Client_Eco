ALTER PROCEDURE [dbo].[Form_CreateFormSendPhysicalDocuments]
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
        @bill tinyint,
        @originalCertificate tinyint,
        @packingList tinyint,
        @phytosanitaryCentificate tinyint,
        @Other varchar(200);

    -- Parsear los valores del JSON
    SELECT
        @bill = ISNULL(JSON_VALUE(@json, '$.bill'), 0), -- Ajustar el valor predeterminado según corresponda
        @originalCertificate = ISNULL(JSON_VALUE(@json, '$.originalCertificate'), 0),
        @packingList = ISNULL(JSON_VALUE(@json, '$.packingList'), 0),
        @phytosanitaryCentificate = ISNULL(JSON_VALUE(@json, '$.phytosanitaryCentificate'), 0),
        @Other = ISNULL(JSON_VALUE(@json, '$.Other'), '');

    BEGIN TRY
        INSERT INTO FormSendPhysicalDocuments(
            bill,
            originalCertificate,
            packingList,
            phytosanitaryCertificate, -- Corregido el nombre del campo
            Other,
            estado,
            secCreate,
            secUpdate
        )
        VALUES (
            @bill,
            @originalCertificate,
            @packingList,
            @phytosanitaryCentificate,
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
