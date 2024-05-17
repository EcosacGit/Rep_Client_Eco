USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormPort]    Script Date: 10/05/2024 14:54:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Form_GetFormAddressEmail]
AS
BEGIN
	SET XACT_ABORT ON
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT
			*
		FROM
			FormAddressEmail
		WHERE
		 estado = 1
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
