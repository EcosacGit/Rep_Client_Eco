USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormDataNotifier]    Script Date: 10/05/2024 14:31:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Form_GetFormDataNotifier]
AS
BEGIN
	SELECT
	*
	FROM FormDataNotifier
	where estado = 1
END
