/*
TEST CASES:-

1. 
	If called from catch without any parameters
	EXEC Logging_Test
2.
	if called for info logging
	EXEC Logging 'Testing info'


*/
ALTER PROC Logging_Test
AS
BEGIN
	SET NOCOUNT ON;

	SElECT 1
	EXEC Logging 'Successfully selected 1'
END

