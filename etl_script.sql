USE [ETL]
GO
/****** Object:  Table [dbo].[SOURCE_INFO]    Script Date: 2021/5/8 16:25:59 ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TABLE_INFO]    Script Date: 2021/5/8 16:25:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLE_INFO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TABLE_NAME] [nvarchar](100) NULL,
	[TIME_FIELD] [nvarchar](100) NULL,
	[MARK] [int] NULL,
	[QSQL] [varchar](500) NULL,
	[FIELDS] [nvarchar](max) NULL,
	[START_TIME] [nvarchar](max) NULL,
	[END_TIME] [nvarchar](max) NULL,
	[TIME_MARK] [int] NULL,
	[SOURCE_ID] [int] NULL,
	[PL] [int] NULL,
	[MSSQL_TIMEFIELD] [nvarchar](100) NULL,
	[ODSTABLE_NAME] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GET_FIELDS]    Script Date: 2021/5/8 16:25:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_FIELDS]
	
AS
BEGIN
	UPDATE   [ETL].[dbo].[TABLE_INFO] SET [dbo].[TABLE_INFO].FIELDS = A.FIELDS FROM (
	SELECT A.NAME,STUFF((SELECT ','+NAME FROM ODS..SYSCOLUMNS T WHERE A.ID=T.ID FOR XML PATH('')),1,1,'') FIELDS FROM ODS..SYSOBJECTS A 
	JOIN [ETL].[dbo].[TABLE_INFO] B ON A.NAME = B.ODSTABLE_NAME WHERE  A.XTYPE = 'U'
	) A WHERE [dbo].[TABLE_INFO].ODSTABLE_NAME = A.NAME
END
GO
