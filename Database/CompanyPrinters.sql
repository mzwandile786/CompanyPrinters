USE [master]
GO
/****** Object:  Database [CompanyPrinters]    Script Date: 2026/03/05 09:17:19 ******/
CREATE DATABASE [CompanyPrinters]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CompanyPrinter', FILENAME = N'C:\Users\Xcallibre\CompanyPrinter.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CompanyPrinter_log', FILENAME = N'C:\Users\Xcallibre\CompanyPrinter_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CompanyPrinters] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CompanyPrinters].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CompanyPrinters] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CompanyPrinters] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CompanyPrinters] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CompanyPrinters] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CompanyPrinters] SET ARITHABORT OFF 
GO
ALTER DATABASE [CompanyPrinters] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CompanyPrinters] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CompanyPrinters] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CompanyPrinters] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CompanyPrinters] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CompanyPrinters] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CompanyPrinters] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CompanyPrinters] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CompanyPrinters] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CompanyPrinters] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CompanyPrinters] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CompanyPrinters] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CompanyPrinters] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CompanyPrinters] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CompanyPrinters] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CompanyPrinters] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CompanyPrinters] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CompanyPrinters] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CompanyPrinters] SET  MULTI_USER 
GO
ALTER DATABASE [CompanyPrinters] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CompanyPrinters] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CompanyPrinters] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CompanyPrinters] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CompanyPrinters] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CompanyPrinters] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CompanyPrinters] SET QUERY_STORE = OFF
GO
USE [CompanyPrinters]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[DesignationID] [int] IDENTITY(1,1) NOT NULL,
	[DesignationName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DesignationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DesignationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrinterMake]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrinterMake](
	[PrinterMakeID] [int] IDENTITY(1,1) NOT NULL,
	[PrinterMakeName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PrinterMakeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PrinterMakeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Printers]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Printers](
	[EngenPrintersID] [int] IDENTITY(1,1) NOT NULL,
	[PrinterName] [varchar](30) NOT NULL,
	[FolderToMonitor] [varchar](50) NOT NULL,
	[OutputType] [varchar](50) NOT NULL,
	[FileOutput] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
	[PrinterMakeID] [int] NOT NULL,
	[CreatedTimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK__Printers__0A4C21645447B3F7] PRIMARY KEY CLUSTERED 
(
	[EngenPrintersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[UserName] [varchar](30) NOT NULL,
	[Password] [varchar](30) NOT NULL,
	[DesignationID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Printers]  WITH CHECK ADD  CONSTRAINT [FK_Printers_PrinterMake] FOREIGN KEY([PrinterMakeID])
REFERENCES [dbo].[PrinterMake] ([PrinterMakeID])
GO
ALTER TABLE [dbo].[Printers] CHECK CONSTRAINT [FK_Printers_PrinterMake]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Designation] FOREIGN KEY([DesignationID])
REFERENCES [dbo].[Designation] ([DesignationID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Designation]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDesignation]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteDesignation]
    @DesignationID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Designation
    WHERE DesignationID = @DesignationID;
END
GO
/****** Object:  StoredProcedure [dbo].[DeletePrinter]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePrinter]
    @EngenPrintersID int
AS
BEGIN
    DELETE FROM [CompanyPrinters].[dbo].[Printers]
    WHERE EngenPrintersID = @EngenPrintersID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUser]
    @UserID INT
AS
BEGIN
    DELETE FROM Users
    WHERE UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[GetDesignations]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDesignations]
AS
BEGIN
    SELECT DesignationID, DesignationName
    FROM Designation
END
GO
/****** Object:  StoredProcedure [dbo].[GetPrinterMake]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPrinterMake]
AS
BEGIN
    SELECT PrinterMakeID, PrinterMakeName
    FROM PrinterMake
    ORDER BY PrinterMakeName;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPrinterName]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPrinterName]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT 
        PrinterName 
    FROM [dbo].[Printers]
    WHERE PrinterName IS NOT NULL AND PrinterName <> ''
    ORDER BY PrinterName ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetPrinters]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetPrinters]
AS
BEGIN
    SELECT 
        p.EngenPrintersID,
        p.PrinterName,
        p.FolderToMonitor,
        p.OutputType,
        p.FileOutput,
        p.Active,
        p.PrinterMakeID,
        pm.PrinterMakeName,
        p.CreatedTimeStamp
    FROM Printers p
    LEFT JOIN PrinterMake pm ON p.PrinterMakeID = pm.PrinterMakeID
    ORDER BY p.PrinterName;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUsers]
AS
BEGIN
    SELECT 
        u.UserID,
        u.FirstName,
        u.LastName,
        u.Email,
        u.UserName,
        u.Password,
        u.DesignationID,        -- needed for dropdown
        d.DesignationName       -- display in grid
    FROM Users u
    LEFT JOIN Designation d 
        ON u.DesignationID = d.DesignationID
    ORDER BY u.UserID
END
GO
/****** Object:  StoredProcedure [dbo].[InsertDesignation]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertDesignation]
    @DesignationName VARCHAR(50)
AS
BEGIN
    INSERT INTO Designation (DesignationName)
    VALUES (@DesignationName)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPrinter]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPrinter]
    @PrinterName        VARCHAR(30),
    @FolderToMonitor    VARCHAR(50),
    @OutputType         VARCHAR(50),
    @FileOutput         VARCHAR(50),
    @Active             BIT,
    @PrinterMakeID      INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Printers
    (
        PrinterName,
        FolderToMonitor,
        OutputType,
        FileOutput,
        Active,
        PrinterMakeID,
        CreatedTimeStamp
    )
    VALUES
    (
        @PrinterName,
        @FolderToMonitor,
        @OutputType,
        @FileOutput,
        @Active,
        @PrinterMakeID,
        GETDATE()
    );
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertUser]
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @UserName VARCHAR(50),
    @Password VARCHAR(100),
    @DesignationID INT
AS
BEGIN
    INSERT INTO Users
    (FirstName, LastName, Email, UserName, Password, DesignationID)
    VALUES
    (@FirstName, @LastName, @Email, @UserName, @Password, @DesignationID)
END
GO
/****** Object:  StoredProcedure [dbo].[SearchPrinters]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchPrinters]
    @PrinterMakeID INT = NULL,
    @FromDate DATETIME = NULL,
    @ToDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.EngenPrintersID,
        p.PrinterName,
        p.FolderToMonitor,
        p.OutputType,
        p.FileOutput,
        p.Active,
        p.PrinterMakeID,
        pm.PrinterMakeName,
        p.CreatedTimeStamp -- Make sure this matches the DataField in ASPX
    FROM Printers p
    LEFT JOIN PrinterMake pm ON p.PrinterMakeID = pm.PrinterMakeID
    WHERE 
        (@PrinterMakeID IS NULL OR p.PrinterMakeID = @PrinterMakeID)
        AND (@FromDate IS NULL OR p.CreatedTimeStamp >= @FromDate)
        AND (@ToDate IS NULL OR p.CreatedTimeStamp <= @ToDate)
    ORDER BY p.PrinterName;
END
GO
/****** Object:  StoredProcedure [dbo].[SearchUsersByDesignation]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchUsersByDesignation]
    @DesignationID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.UserID,
        u.FirstName,
        u.LastName,
        u.Email,
		u.UserName,
		u.Password,
        d.DesignationName
    FROM Users u
    INNER JOIN Designation d ON u.DesignationID = d.DesignationID
    WHERE
        (@DesignationID IS NULL OR @DesignationID = 0)
        OR u.DesignationID = @DesignationID
    ORDER BY u.FirstName, u.LastName;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckUsernameExists]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CheckUsernameExists]
    @UserName NVARCHAR(100),
    @UserID INT = NULL
AS
BEGIN
    SELECT COUNT(*)
    FROM Users
    WHERE UserName = @UserName
      AND (@UserID IS NULL OR UserID <> @UserID)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateDesignation]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateDesignation]
    @DesignationID INT,
    @DesignationName VARCHAR(50)
AS
BEGIN
    UPDATE Designation
    SET DesignationName = @DesignationName
    WHERE DesignationID = @DesignationID
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePrinter]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePrinter]
    @PrinterID INT,
    @PrinterName NVARCHAR(255),
    @FolderToMonitor NVARCHAR(255),
    @OutputType NVARCHAR(255),
    @FileOutput NVARCHAR(255),
    @Active BIT,
    @PrinterMakeID INT
AS
BEGIN
    UPDATE Printers
    SET 
        PrinterName = @PrinterName,
        FolderToMonitor = @FolderToMonitor,
        OutputType = @OutputType,
        FileOutput = @FileOutput,
        Active = @Active,
        PrinterMakeID = @PrinterMakeID
    WHERE 
        EngenPrintersID = @PrinterID; 
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUser]
    @UserID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @UserName VARCHAR(50),
    @Password VARCHAR(100),
    @DesignationID INT
AS
BEGIN
    UPDATE Users
    SET
        FirstName = @FirstName,
        LastName = @LastName,
        Email = @Email,
        UserName = @UserName,
        Password = @Password,
        DesignationID = @DesignationID
    WHERE UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[UserLogin]    Script Date: 2026/03/05 09:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UserLogin]
    @UserName VARCHAR(100),
    @Password VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.UserID,
        u.UserName,
        u.DesignationID,
        d.DesignationName  -- add this
    FROM Users u
    INNER JOIN Designation d
        ON u.DesignationID = d.DesignationID
    WHERE u.UserName = @UserName
      AND u.Password = @Password;
END

GO
USE [master]
GO
ALTER DATABASE [CompanyPrinters] SET  READ_WRITE 
GO

