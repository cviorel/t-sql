USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'DBA_operator', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'oradba@voz.ru'
GO
