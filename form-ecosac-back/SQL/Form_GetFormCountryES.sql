USE [SINCRO_PCPNISIRA]
GO
/****** Object:  StoredProcedure [dbo].[Form_GetFormCountryES]    Script Date: 17/05/2024 15:37:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Form_GetFormCountryES]
AS
BEGIN
	SELECT idRegion, idCountry, descCountry
	FROM (
		SELECT idCountry, descCountry,idRegion,
			   ROW_NUMBER() OVER (PARTITION BY descCountry ORDER BY idCountry) AS rn
		FROM FormCountry
		WHERE estado = 1
	) AS sub
	WHERE rn = 1
	ORDER BY descCountry
END


[Form_GetFormCountryES]
