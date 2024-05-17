USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormAddressEmail]    Script Date: 10/05/2024 15:06:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Form_GetFormAddressOriginalsDoc]
AS
BEGIN
	SET XACT_ABORT ON
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT
			*
		FROM
			FormAddressOriginalsDoc
		WHERE
		 estado = 1
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
