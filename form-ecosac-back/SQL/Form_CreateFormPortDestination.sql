USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_CreateFormPort]    Script Date: 15/05/2024 15:20:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Form_CreateFormPortDestination]
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
        @idCountry INT,
        @descPort VARCHAR(100);

    -- Parsear los valores del JSON
    SELECT
        @idCountry = ISNULL(JSON_VALUE(@json, '$.idCountry'), 0), -- Ajustar el valor predeterminado según corresponda
        @descPort = ISNULL(JSON_VALUE(@json, '$.descPort'), '');

    -- Si el idCountry es 0 o nulo, obtener el último idCountry
    IF @idCountry = 0 OR @idCountry IS NULL
    BEGIN
        SELECT TOP 1 @idCountry = idCountry
        FROM FormCountry
        ORDER BY idCountry DESC;
    END

    BEGIN TRY
        INSERT INTO FormPortDestination(
            idCountry,
            descPort,
            estado
        )
        VALUES (
            @idCountry,
            @descPort,
            0  -- Estado por defecto, ajustar según lo necesario
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

