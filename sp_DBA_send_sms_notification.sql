USE [msdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_DBA_send_sms_notification]    Script Date: 05.04.2018 16:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_DBA_send_sms_notification]
(
 
		@subjectText VARCHAR(200) = 'SQL SERVER ALERT SYSTEM',
		@profileName VARCHAR(50) = 'DBA_Profile',
		@smsgate VARCHAR(500) = 'post@websms.ru',
		@gateuser VARCHAR(128) = 'autodoc_sms',
		@gatepass VARCHAR(128) = 'qwe12asd',
		@messagebody VARCHAR(500),
		@recipients VARCHAR(40) --79161234567, 70951234567, 79031234567
)
AS
BEGIN
DECLARE @servername sysname
SELECT @servername = CAST(SERVERPROPERTY('MachineName') AS sysname) 
SET @messagebody = 
'user='+@gateuser+
'pass='+@gatepass+
'tels='+@recipients+
'mess=' + @servername + ': ' + @messagebody;

EXEC msdb.dbo.sp_send_dbmail 
  @profile_name = @profileName,
  @recipients = @smsgate,
  @body = @messagebody,
  @subject = @subjectText, 
  @body_format = 'TEXT';
END