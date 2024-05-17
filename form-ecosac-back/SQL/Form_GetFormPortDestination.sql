USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormPort]    Script Date: 15/05/2024 15:22:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Form_GetFormPortDestination]
		@idCountry int
AS
BEGIN
	SET XACT_ABORT ON
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT idPort,
			descPort
		FROM
			FormPortDestination AS FM
		WHERE
			idCountry = @idCountry and estado = 1
		ORDER BY
			descPort DESC
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
