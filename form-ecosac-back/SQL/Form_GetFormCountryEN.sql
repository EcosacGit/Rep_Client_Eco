USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormCountryEn]    Script Date: 15/05/2024 09:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_GetFormCountryEn]
AS
BEGIN
	SELECT distinct
	idCountry,
	descCountryUs
	FROM FormCountry
	where estado = 1
	order by descCountryUs
END



