USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_CreateFormDataConsignee]    Script Date: 16/05/2024 07:47:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_CreateFormDataConsignee]
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
        @nameConsignee varchar(100),
		@addressConsignee varchar(100),
        @telef1 varchar(25),
        @telef2 varchar(25),
        @EORI varchar(100),
        @Fax varchar(55),
        @contactPerson varchar(100),
        @taxID varchar(120),
        @email varchar(40),
        @website varchar(70),

        @descCountry varchar(100);

    -- Parsear los valores del JSON
    SELECT
        @nameConsignee = ISNULL(JSON_VALUE(@json, '$.nameConsignee'), ''),
        @telef1 = ISNULL(JSON_VALUE(@json, '$.telef1'), ''),
        @telef2 = ISNULL(JSON_VALUE(@json, '$.telef2'), ''),
        @EORI = ISNULL(JSON_VALUE(@json, '$.EORI'), ''),
        @Fax = ISNULL(JSON_VALUE(@json, '$.Fax'), ''),
        @contactPerson = ISNULL(JSON_VALUE(@json, '$.contactPerson'), ''),
        @taxID = ISNULL(JSON_VALUE(@json, '$.taxID'), ''),
        @email = ISNULL(JSON_VALUE(@json, '$.email'), ''),
        @website = ISNULL(JSON_VALUE(@json, '$.website'), ''),

        @descCountry = ISNULL(JSON_VALUE(@json, '$.descCountry'), '');

    DECLARE @idRegion INT;

    -- Obtener el idRegion del país seleccionado
    SELECT @idRegion = idRegion
    FROM FormCountry
    WHERE descCountry = @descCountry OR descCountryUs = @descCountry;

    IF @idRegion IS NULL
    BEGIN
        SELECT 'El país especificado no existe en la base de datos.' AS ErrorMessage;
        RETURN;
    END;

    -- Verificar si el país pertenece a la región EUROPA
    IF EXISTS (SELECT 1 FROM FormRegion WHERE idRegion = @idRegion AND descRegion = 'EUROPA' )
    BEGIN
        -- Si el país pertenece a EUROPA y no se proporcionó EORI, devolver un mensaje de error
        IF @EORI IS NULL OR @EORI = ''
        BEGIN
            SELECT 'You must complete the EORI field' AS ErrorMessage;
            RETURN;
        END;
    END;

    -- Insertar los datos en la tabla FormDataConsignee
    INSERT INTO FormDataConsignee(
        nameConsignee,
        telef1,
        telef2,
        EORI,
        Fax,
        contactPerson,
        taxID,
        email,
        website,
        estado,
        secCreate,
        secUpdate,
		addressConsignee
	)
    VALUES (
        @nameConsignee,

        @telef1,
        @telef2,
        @EORI,
        @Fax,
        @contactPerson,
        @taxID,
        @email,
        @website,
        1,
        GETDATE(),
        null,
		@addressConsignee
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

    SELECT @msg_error AS mensaje;
END;

