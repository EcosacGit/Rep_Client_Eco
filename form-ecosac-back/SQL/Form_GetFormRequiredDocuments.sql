USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormDataNotifier]    Script Date: 10/05/2024 14:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Form_GetFormRequiredDocuments]
AS
BEGIN
	SELECT
	*
	FROM FormRequiredDocuments
	where estado = 1
END





