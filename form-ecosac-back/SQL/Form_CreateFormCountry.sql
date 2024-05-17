USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_CreateFormCountry]    Script Date: 13/05/2024 09:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_CreateFormCountry]    Script Date: 13/05/2024 09:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_CreateFormCountry]
    @json varchar(max)
AS
BEGIN
    SET XACT_ABORT ON
    SET NOCOUNT ON;

    DECLARE
        -- Variables para validaciones
        @msg_error VARCHAR(200) = '',
        @FilasAfectadas INT,

        -- Parámetros JSON Inicio
        @descCountry varchar(100)

    SELECT
        @descCountry = isnull(JSON_VALUE(@json, '$.descCountry'), '')

    BEGIN TRY
        BEGIN
            BEGIN TRANSACTION
                BEGIN
                    INSERT INTO FormCountry(
                        idRegion,
                        descCountry,
                        estado,
                        descCountryUs
                    )
                    VALUES (
                        18,
                        @descCountry,
                        0,
                        @descCountry
                    )
                    SET @FilasAfectadas = @@ROWCOUNT;
                    IF @FilasAfectadas > 0
                    BEGIN
                        -- Mensaje de Salida en caso sea exitoso
                        SET @msg_error = 'Registro exitoso';
                    END
                    ELSE
                    BEGIN
                        -- Mensaje de Salida en caso de que no se haya encontrado ninguna fila para actualizar
                        SET @msg_error = 'No se realizó el registro';
                        THROW 50001, @msg_error, 1;
                    END
                END
            COMMIT
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
        ROLLBACK
    END CATCH
    SELECT @msg_error AS mensaje
END
