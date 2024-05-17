USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormCountryES]    Script Date: 15/05/2024 09:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_GetFormCountryES]
AS
BEGIN
	SELECT DISTINCT
	idCountry,
	descCountry
	FROM FormCountry
	where estado = 1
	order by descCountry
END


