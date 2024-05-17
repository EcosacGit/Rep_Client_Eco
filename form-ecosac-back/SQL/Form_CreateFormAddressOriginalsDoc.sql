USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_CreateFormAddressOriginalsDoc]    Script Date: 10/05/2024 15:06:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_CreateFormAddressOriginalsDoc]
    @json VARCHAR(MAX)
AS
BEGIN
    SET XACT_ABORT ON
    SET NOCOUNT ON;

    DECLARE
        -- Variables para validaciones
        @msg_error VARCHAR(200) = '',
        @FilasAfectadas INT,
        -- Parámetros JSON
        @nameCompany VARCHAR(150),
        @addressCompany VARCHAR(150),
        @telef VARCHAR(25),
        @contactPerson VARCHAR(100),
        @taxID VARCHAR(120),
        @emailAddress VARCHAR(70),
        @country VARCHAR(70),
        @city VARCHAR(70),
        @state_city VARCHAR(120),
        @postalCode VARCHAR(50);

    -- Parsear los valores del JSON
    SELECT
        @nameCompany = ISNULL(JSON_VALUE(@json, '$.nameCompany'), ''),
        @addressCompany = ISNULL(JSON_VALUE(@json, '$.addressCompany'), ''),
        @telef = ISNULL(JSON_VALUE(@json, '$.telef'), ''),
        @contactPerson = ISNULL(JSON_VALUE(@json, '$.contactPerson'), ''),
        @taxID = ISNULL(JSON_VALUE(@json, '$.taxID'), ''),
        @emailAddress = ISNULL(JSON_VALUE(@json, '$.emailAddress'), ''),
        @country = ISNULL(JSON_VALUE(@json, '$.country'), ''),
        @city = ISNULL(JSON_VALUE(@json, '$.city'), ''),
        @state_city = ISNULL(JSON_VALUE(@json, '$.state_city'), ''),
        @postalCode = ISNULL(JSON_VALUE(@json, '$.postalCode'), '');

    BEGIN TRY
        INSERT INTO FormAddressOriginalsDoc (
            nameCompany,
            addressCompany,
            telef,
            contactPerson,
            taxID,
            emailAddress,
            country,
            city,
            state_city,
            postalCode,
            estado,
            secCreate,
            secUpdate
        )
        VALUES (
            @nameCompany,
            @addressCompany,
            @telef,
            @contactPerson,
            @taxID,
            @emailAddress,
            @country,
            @city,
            @state_city,
            @postalCode,
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
    END CATCH;

    SELECT @msg_error AS mensaje;
END
