Use master
GO
/*
TEST CASES:-

1. 
	If called from catch without any parameters
	EXEC Logging_Test
2.
	if called for info logging
	EXEC Logging 'Testing info'


*/
ALTER PROCEDURE Logging
	@Message VARCHAR(3000) = NULL,
	@Source VARCHAR(300) = NULL,
	@Parameters VARCHAR(300) = NULL,
	@Exception VARCHAR(3000) = NULL,
	@Level VARCHAR(10) = NULL,
	@ErrorSeverity INT = NULL,
	@ErrorNumber INT = NULL,
	@ErrorState INT = NULL,
	@RetryCount INT = 0
AS
BEGIN
	SET @ErrorSeverity=ISNULL(@ErrorSeverity,ERROR_SEVERITY());
	IF NULLIF(@ErrorSeverity,0) IS NULL --If Logs is INFO, Called me explicitly for error before throwing
	BEGIN	
		IF NULLIF(@Message,'') IS NULL
		BEGIN		
			PRINT 'InSufficient Argumnets. @Message is mandatory if error is not thrown from system.'
			RETURN;
		END
		SET @Level=ISNULL(@Level,'INFO');
	END

	-- IF handled in catch/called explicitly before throwing to Next level(e.g. UI/ caller).
	SET @Message=ISNULL(@Message,'Unhandled Error');
	SET @Source=ISNULL(@Source,ERROR_PROCEDURE());
	--SET @Parameters=ISNULL(@Parameters,NULL);
	SET @Exception=ISNULL(@Exception,ERROR_MESSAGE());
	SET @ErrorState=ISNULL(@ErrorState,ERROR_STATE());
	SET @ErrorNumber=ISNULL(@ErrorNumber,ERROR_NUMBER());
	SET @Level=ISNULL(@Level,'Error');

	INSERT INTO Logs(Message,Source,Parameters,ErrorSeverity,Exception,ErrorState,Level,ErrorNumber)
	VALUES(@Message,@Source,@Parameters,@ErrorSeverity,@Exception,@ErrorState,@Level,@ErrorNumber)
END