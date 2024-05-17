alter PROCEDURE [dbo].[Form_GetForm]
	@idClient int
AS
BEGIN
	SET XACT_ABORT ON
	SET NOCOUNT ON;

	BEGIN TRY
		select * from Form
		where estado = 1 and idClient = @idClient
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
