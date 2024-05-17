USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_CreateFormAddressEmail]    Script Date: 16/05/2024 10:44:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_CreateFormAddressEmail]
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
        @email VARCHAR(50);

    -- Parsear los valores del JSON
    SELECT
        @email = ISNULL(JSON_VALUE(@json, '$.email'), '');

	DECLARE @LastConsigneeId INT;

	-- Obtener el último idDataConsignee e idDataNotifier insertado
    SELECT TOP 1 @LastConsigneeId = idDataConsignee
    FROM FormDataConsignee
    ORDER BY idDataConsignee DESC;

    BEGIN TRY
        INSERT INTO FormAddressEmail(email, idDataConsignee, estado, secCreate, secUpdate)
        VALUES (@email, @LastConsigneeId, 1, GETDATE(), NULL);

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
