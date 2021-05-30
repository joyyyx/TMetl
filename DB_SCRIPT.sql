USE [ETL]
GO
/****** Object:  Table [dbo].[chanel_logs]    Script Date: 2021/5/14 18:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chanel_logs](
	[ID_BATCH] [int] NULL,
	[CHANNEL_ID] [varchar](255) NULL,
	[LOG_DATE] [datetime] NULL,
	[LOGGING_OBJECT_TYPE] [varchar](255) NULL,
	[OBJECT_NAME] [varchar](255) NULL,
	[OBJECT_COPY] [varchar](255) NULL,
	[REPOSITORY_DIRECTORY] [varchar](255) NULL,
	[FILENAME] [varchar](255) NULL,
	[OBJECT_ID] [varchar](255) NULL,
	[OBJECT_REVISION] [varchar](255) NULL,
	[PARENT_CHANNEL_ID] [varchar](255) NULL,
	[ROOT_CHANNEL_ID] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_logs]    Script Date: 2021/5/14 18:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_logs](
	[ID_JOB] [int] NULL,
	[CHANNEL_ID] [varchar](255) NULL,
	[JOBNAME] [varchar](255) NULL,
	[STATUS] [varchar](15) NULL,
	[LINES_READ] [bigint] NULL,
	[LINES_WRITTEN] [bigint] NULL,
	[LINES_UPDATED] [bigint] NULL,
	[LINES_INPUT] [bigint] NULL,
	[LINES_OUTPUT] [bigint] NULL,
	[LINES_REJECTED] [bigint] NULL,
	[ERRORS] [bigint] NULL,
	[STARTDATE] [datetime] NULL,
	[ENDDATE] [datetime] NULL,
	[LOGDATE] [datetime] NULL,
	[DEPDATE] [datetime] NULL,
	[REPLAYDATE] [datetime] NULL,
	[LOG_FIELD] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOURCE_INFO]    Script Date: 2021/5/14 18:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOURCE_INFO](
	[ID] [int] NOT NULL,
	[SOURCE_NAME] [nvarchar](100) NULL,
	[SOURCE_IP] [nvarchar](100) NULL,
	[SOURCE_PORT] [nvarchar](10) NULL,
	[SOURCE_DB] [nvarchar](100) NULL,
	[SOURCE_USER] [nvarchar](20) NULL,
	[SOURCE_PWD] [nvarchar](100) NULL,
	[USEDB_NAME] [nvarchar](100) NULL,
	[MARK] [int] NULL,
	[DB_TYPE] [nvarchar](100) NULL,
	[SOURCE_TYPE] [nvarchar](100) NULL,
	[cron] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TABLE_INFO]    Script Date: 2021/5/14 18:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLE_INFO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TABLE_NAME] [nvarchar](100) NULL,
	[TIME_FIELD] [nvarchar](max) NULL,
	[MARK] [int] NULL,
	[QSQL] [varchar](500) NULL,
	[FIELDS] [nvarchar](max) NULL,
	[START_TIME] [nvarchar](max) NULL,
	[END_TIME] [nvarchar](max) NULL,
	[TIME_MARK] [int] NULL,
	[SOURCE_ID] [int] NULL,
	[PL] [int] NULL,
	[MSSQL_TIMEFIELD] [nvarchar](max) NULL,
	[ODSTABLE_NAME] [nvarchar](100) NULL,
	[USEDB_NAME] [nvarchar](max) NULL,
	[UPDATE_TIME] [datetime] NULL,
 CONSTRAINT [PK__TABLE_IN__3214EC2714781F95] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trans_logs]    Script Date: 2021/5/14 18:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trans_logs](
	[ID_BATCH] [int] NULL,
	[CHANNEL_ID] [varchar](255) NULL,
	[LOG_DATE] [datetime] NULL,
	[TRANSNAME] [varchar](255) NULL,
	[STEPNAME] [varchar](255) NULL,
	[LINES_READ] [bigint] NULL,
	[LINES_WRITTEN] [bigint] NULL,
	[LINES_UPDATED] [bigint] NULL,
	[LINES_INPUT] [bigint] NULL,
	[LINES_OUTPUT] [bigint] NULL,
	[LINES_REJECTED] [bigint] NULL,
	[ERRORS] [bigint] NULL,
	[RESULT] [bit] NULL,
	[NR_RESULT_ROWS] [bigint] NULL,
	[NR_RESULT_FILES] [bigint] NULL,
	[LOG_FIELD] [text] NULL,
	[COPY_NR] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GET_FIELDS]    Script Date: 2021/5/14 18:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_FIELDS]
	
AS
BEGIN
	UPDATE   [ETL].[dbo].[TABLE_INFO] SET [dbo].[TABLE_INFO].FIELDS = A.FIELDS FROM (
	SELECT A.NAME,STUFF((SELECT ','+NAME FROM ods..SYSCOLUMNS T WHERE A.ID=T.ID AND T.NAME !='NEW_VISITNUMBER' FOR XML PATH('')),1,1,'') FIELDS FROM ods..SYSOBJECTS A 
	JOIN [ETL].[dbo].[TABLE_INFO] B ON A.NAME = B.ODSTABLE_NAME WHERE  A.XTYPE = 'U'
	) A WHERE [dbo].[TABLE_INFO].ODSTABLE_NAME = A.NAME
END
GO
