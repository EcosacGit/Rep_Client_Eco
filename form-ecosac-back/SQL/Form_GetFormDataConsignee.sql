USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormDataNotifier]    Script Date: 10/05/2024 14:31:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Form_GetFormDataConsignee]
AS
BEGIN
	SELECT
	*
	FROM FormDataConsignee
	where estado = 1
END
