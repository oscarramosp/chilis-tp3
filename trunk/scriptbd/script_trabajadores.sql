USE [master]
GO
/****** Object:  Database [RESTAURANTE]    Script Date: 05/14/2013 22:54:34 ******/
CREATE DATABASE [RESTAURANTE] ON  PRIMARY 
( NAME = N'RESTAURANTE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\RESTAURANTE.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RESTAURANTE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\RESTAURANTE_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RESTAURANTE] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RESTAURANTE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RESTAURANTE] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [RESTAURANTE] SET ANSI_NULLS OFF
GO
ALTER DATABASE [RESTAURANTE] SET ANSI_PADDING OFF
GO
ALTER DATABASE [RESTAURANTE] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [RESTAURANTE] SET ARITHABORT OFF
GO
ALTER DATABASE [RESTAURANTE] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [RESTAURANTE] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [RESTAURANTE] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [RESTAURANTE] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [RESTAURANTE] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [RESTAURANTE] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [RESTAURANTE] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [RESTAURANTE] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [RESTAURANTE] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [RESTAURANTE] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [RESTAURANTE] SET  DISABLE_BROKER
GO
ALTER DATABASE [RESTAURANTE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [RESTAURANTE] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [RESTAURANTE] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [RESTAURANTE] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [RESTAURANTE] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [RESTAURANTE] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [RESTAURANTE] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [RESTAURANTE] SET  READ_WRITE
GO
ALTER DATABASE [RESTAURANTE] SET RECOVERY FULL
GO
ALTER DATABASE [RESTAURANTE] SET  MULTI_USER
GO
ALTER DATABASE [RESTAURANTE] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [RESTAURANTE] SET DB_CHAINING OFF
GO
USE [RESTAURANTE]
GO
/****** Object:  Table [dbo].[TR_PeriodoSemanal]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TR_PeriodoSemanal](
	[IdSemana] [int] IDENTITY(1,1) NOT NULL,
	[Inicio] [smalldatetime] NOT NULL,
	[Fin] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_PeriodoSemanal] PRIMARY KEY CLUSTERED 
(
	[IdSemana] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TR_PeriodoSemanal] ON
INSERT [dbo].[TR_PeriodoSemanal] ([IdSemana], [Inicio], [Fin]) VALUES (1, CAST(0xA1990000 AS SmallDateTime), CAST(0xA19F0000 AS SmallDateTime))
INSERT [dbo].[TR_PeriodoSemanal] ([IdSemana], [Inicio], [Fin]) VALUES (2, CAST(0xA1A00000 AS SmallDateTime), CAST(0xA1A60000 AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[TR_PeriodoSemanal] OFF
/****** Object:  Table [dbo].[TR_NivelFormacion]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_NivelFormacion](
	[IdNivelFormacion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_NivelFormacion] PRIMARY KEY CLUSTERED 
(
	[IdNivelFormacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_NivelFormacion] ON
INSERT [dbo].[TR_NivelFormacion] ([IdNivelFormacion], [Descripcion]) VALUES (1, N'Bachiller')
INSERT [dbo].[TR_NivelFormacion] ([IdNivelFormacion], [Descripcion]) VALUES (2, N'Titulado')
INSERT [dbo].[TR_NivelFormacion] ([IdNivelFormacion], [Descripcion]) VALUES (3, N'Maestria')
INSERT [dbo].[TR_NivelFormacion] ([IdNivelFormacion], [Descripcion]) VALUES (4, N'Doctorado')
SET IDENTITY_INSERT [dbo].[TR_NivelFormacion] OFF
/****** Object:  Table [dbo].[TR_Nacionalidad]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Nacionalidad](
	[IdNacionalidad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Nacionalidad] PRIMARY KEY CLUSTERED 
(
	[IdNacionalidad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_Nacionalidad] ON
INSERT [dbo].[TR_Nacionalidad] ([IdNacionalidad], [Descripcion]) VALUES (1, N'Peruano')
INSERT [dbo].[TR_Nacionalidad] ([IdNacionalidad], [Descripcion]) VALUES (2, N'Chileno')
INSERT [dbo].[TR_Nacionalidad] ([IdNacionalidad], [Descripcion]) VALUES (3, N'Argentino')
SET IDENTITY_INSERT [dbo].[TR_Nacionalidad] OFF
/****** Object:  Table [dbo].[TR_Idioma]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Idioma](
	[IdIdioma] [int] NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[IdIdioma] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[TR_Idioma] ([IdIdioma], [Descripcion]) VALUES (1, N'Ingles')
INSERT [dbo].[TR_Idioma] ([IdIdioma], [Descripcion]) VALUES (2, N'Frances')
INSERT [dbo].[TR_Idioma] ([IdIdioma], [Descripcion]) VALUES (3, N'Portugues')
/****** Object:  Table [dbo].[TR_Horas]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TR_Horas](
	[id] [int] NULL,
	[time] [time](7) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (0, CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (1, CAST(0x070068C461080000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (2, CAST(0x0700D088C3100000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (3, CAST(0x0700384D25190000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (4, CAST(0x0700A01187210000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (5, CAST(0x070008D6E8290000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (6, CAST(0x0700709A4A320000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (7, CAST(0x0700D85EAC3A0000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (8, CAST(0x070040230E430000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (9, CAST(0x0700A8E76F4B0000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (10, CAST(0x070010ACD1530000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (11, CAST(0x07007870335C0000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (12, CAST(0x0700E03495640000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (13, CAST(0x070048F9F66C0000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (14, CAST(0x0700B0BD58750000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (15, CAST(0x07001882BA7D0000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (16, CAST(0x070080461C860000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (17, CAST(0x0700E80A7E8E0000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (18, CAST(0x070050CFDF960000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (19, CAST(0x0700B893419F0000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (20, CAST(0x07002058A3A70000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (21, CAST(0x0700881C05B00000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (22, CAST(0x0700F0E066B80000 AS Time))
INSERT [dbo].[TR_Horas] ([id], [time]) VALUES (23, CAST(0x070058A5C8C00000 AS Time))
/****** Object:  Table [dbo].[TR_Disponibilidad]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Disponibilidad](
	[IdDisponibilidad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Disponibilidad] PRIMARY KEY CLUSTERED 
(
	[IdDisponibilidad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_Disponibilidad] ON
INSERT [dbo].[TR_Disponibilidad] ([IdDisponibilidad], [Descripcion]) VALUES (1, N'Full Time')
INSERT [dbo].[TR_Disponibilidad] ([IdDisponibilidad], [Descripcion]) VALUES (2, N'Part Time')
SET IDENTITY_INSERT [dbo].[TR_Disponibilidad] OFF
/****** Object:  Table [dbo].[TR_Cese]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Cese](
	[idTrabajador] [int] NOT NULL,
	[FechaCese] [date] NOT NULL,
	[IdMotivo] [char](1) NOT NULL,
	[Observacion] [varchar](200) NULL,
	[FechaCreacion] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[TR_Cese] ([idTrabajador], [FechaCese], [IdMotivo], [Observacion], [FechaCreacion]) VALUES (9, CAST(0x1D370B00 AS Date), N'1', N'Cambio de Trabajo', CAST(0x0000A1BE00000000 AS DateTime))
/****** Object:  Table [dbo].[TR_Cargo]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Cargo](
	[IdCargo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[IdCargo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_Cargo] ON
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (1, N'Administrador')
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (2, N'Mesero')
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (3, N'Cocinero')
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (4, N'Recepcionista')
SET IDENTITY_INSERT [dbo].[TR_Cargo] OFF
/****** Object:  Table [dbo].[TR_TipoTrabajador]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_TipoTrabajador](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcin] [varchar](50) NULL,
 CONSTRAINT [PK_TipoTrabajador] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_TipoTrabajador] ON
INSERT [dbo].[TR_TipoTrabajador] ([Id], [Descripcin]) VALUES (1, N'Full Time')
INSERT [dbo].[TR_TipoTrabajador] ([Id], [Descripcin]) VALUES (2, N'Parttime')
INSERT [dbo].[TR_TipoTrabajador] ([Id], [Descripcin]) VALUES (3, N'Normal')
INSERT [dbo].[TR_TipoTrabajador] ([Id], [Descripcin]) VALUES (4, N'Practicas')
SET IDENTITY_INSERT [dbo].[TR_TipoTrabajador] OFF
/****** Object:  Table [dbo].[TR_TipoRegistroHora]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_TipoRegistroHora](
	[IdTipoRegistroHora] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoRegistroHora] PRIMARY KEY CLUSTERED 
(
	[IdTipoRegistroHora] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_TipoRegistroHora] ON
INSERT [dbo].[TR_TipoRegistroHora] ([IdTipoRegistroHora], [Descripcion]) VALUES (1, N'Entrada')
INSERT [dbo].[TR_TipoRegistroHora] ([IdTipoRegistroHora], [Descripcion]) VALUES (2, N'Salida')
INSERT [dbo].[TR_TipoRegistroHora] ([IdTipoRegistroHora], [Descripcion]) VALUES (3, N'Hora Extra')
SET IDENTITY_INSERT [dbo].[TR_TipoRegistroHora] OFF
/****** Object:  Table [dbo].[TR_SituacionFormacion]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_SituacionFormacion](
	[IdSituacionFormacion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_SituacionFormacion] PRIMARY KEY CLUSTERED 
(
	[IdSituacionFormacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_SituacionFormacion] ON
INSERT [dbo].[TR_SituacionFormacion] ([IdSituacionFormacion], [Descripcion]) VALUES (1, N'Incompleta')
INSERT [dbo].[TR_SituacionFormacion] ([IdSituacionFormacion], [Descripcion]) VALUES (2, N'Completa')
SET IDENTITY_INSERT [dbo].[TR_SituacionFormacion] OFF
/****** Object:  Table [dbo].[TR_Postulante]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Postulante](
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[ApellidoPaterno] [varchar](50) NULL,
	[ApellidoMaterno] [varchar](50) NULL,
	[DNI] [varchar](8) NULL,
	[FechaNacimiento] [datetime] NULL,
	[Sexo] [char](1) NULL,
	[IdNacionalidad] [int] NULL,
	[Direccion] [varchar](50) NULL,
	[Telefono] [varchar](20) NULL,
	[Correo] [varchar](50) NULL,
	[IdCargo] [int] NULL,
	[IdDisponibilidad] [int] NULL,
 CONSTRAINT [PK_Postulante] PRIMARY KEY CLUSTERED 
(
	[IdPostulante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_Postulante] ON
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (1, N'Frank1', N'Castro1', N'Taya1', N'41331772', CAST(0x0000756100000000 AS DateTime), N'M', 1, N'111', N'4859544', N'111', 1, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (2, N'Frank', N'Castro', N'Taya', N'41331772', CAST(0x00008F0700000000 AS DateTime), N'M', 1, N'xxxx', N'4859544', N'frankcastro23@hotmail.com', 1, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (3, N'Frank', N'Castro', N'Taya', N'412222|', CAST(0x00008F1100000000 AS DateTime), N'M', 1, N'fffff', N'535453', N'frankcastro23@hotmail.com', 2, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (4, N'Jesus', N'Tovar', N'Trr', N'41353535', CAST(0x0000A1B600000000 AS DateTime), N'M', 1, N'Miraflores', N'5216458', N'jtovar@hotmail.com', 2, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (5, N'Jesus', N'Tovar', N'Samaiego', N'40534232', CAST(0x0000A1B700000000 AS DateTime), N'M', 1, N'', N'4858599', N'jtovar@upc.edu.pe', 2, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (6, N'rrrrrrr', N'rrrrrr', N'rrrr', N'rrrrrr', CAST(0x0000A1B700000000 AS DateTime), N'M', 1, N'rrrrrrr', N'rrr', N'rrrrr', 2, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (7, N'rrrrrrr', N'rrrrrr', N'rrrr', N'rrrrrr', CAST(0x0000A1B700000000 AS DateTime), N'M', 1, N'rrrrrrr', N'rrr', N'rrrrr', 2, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (8, N'SERGIO', N'MARCELO', N'TAYA', N'4123838', CAST(0x0000A1B900000000 AS DateTime), N'M', 1, N'Miraflores', N'4859544', N'stovar@upc.edu.pe', 2, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (9, N'FRANK', N'CASTRO', N'TAYA', N'41331772', CAST(0x0000A1B900000000 AS DateTime), N'M', 1, N'miraflroes', N'4859544', N'frankcastr@gmail.com', 2, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (10, N'XXXXX', N'CASTRO', N'TAYA', N'41331772', CAST(0x00009D6900000000 AS DateTime), N'M', 1, N'xxxxx', N'sss', N'ddd', 1, 1)
INSERT [dbo].[TR_Postulante] ([IdPostulante], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [DNI], [FechaNacimiento], [Sexo], [IdNacionalidad], [Direccion], [Telefono], [Correo], [IdCargo], [IdDisponibilidad]) VALUES (11, N'FLOR', N'AGREDA', N'CASAVERDE', N'40331773', CAST(0x00007F9100000000 AS DateTime), N'F', 1, N'Covida', N'4857654', N'fagreda@gmail.com', 4, 2)
SET IDENTITY_INSERT [dbo].[TR_Postulante] OFF
/****** Object:  Table [dbo].[TR_Trabajador]    Script Date: 05/14/2013 22:54:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Trabajador](
	[IdTrabajador] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[ApellidoMaterno] [varchar](50) NULL,
	[ApellidoPaterno] [varchar](50) NULL,
	[IdCargo] [int] NULL,
	[IdTipoTrabjador] [int] NULL,
	[HoraInicio] [time](7) NULL,
	[HoraFin] [time](7) NULL,
	[FechaNacimiento] [date] NULL,
	[TipoDocumento] [char](1) NULL,
	[NumeroDocumento] [varchar](20) NULL,
	[Direccion] [varchar](100) NULL,
	[Telefono] [varchar](20) NULL,
	[Activo] [char](1) NULL,
	[Sexo] [char](1) NULL,
	[Correo] [varchar](50) NULL,
 CONSTRAINT [PK_Trabajador] PRIMARY KEY CLUSTERED 
(
	[IdTrabajador] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_Trabajador] ON
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (1, N'Juan Perez', N'Velasco', N'Lopez', 1, 2, CAST(0x070040230E430000 AS Time), CAST(0x07001CEDAE920000 AS Time), CAST(0xB1140B00 AS Date), N'1', N'40144241', N'Los Olivos', N'4857643', N'0', N'M', N'jlopez@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (2, N'Daniel ', N'Balvis', N'Salcedo', 1, 1, CAST(0x0700448E02580000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0xA5150B00 AS Date), N'1', N'40144243', N'San Borja', N'949256575', N'0', N'M', N'dsalcedo@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (3, N'MIguel', N'Lopex', N'Castro', 4, 3, CAST(0x0700709A4A320000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x87150B00 AS Date), N'1', N'40144244', N'San Isidro', N'98373523', N'0', N'M', N'mcastro@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (4, N'Edgar ', N'Huarcaya', N'Chocce', 3, 2, NULL, NULL, CAST(0x68150B00 AS Date), N'1', N'40144245', N'San Borja', N'95965432', N'0', N'M', N'echooce@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (6, N'Henry', N'Lopez', N'Iparragauirre', 2, 1, NULL, NULL, CAST(0xCE140B00 AS Date), N'1', N'40144246', N'San Juan', N'48596453', N'0', N'M', N'hlopez@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (7, N'Frank', N'Taya', N'Castro', 3, 1, NULL, NULL, CAST(0xDC140B00 AS Date), N'1', N'41331777', N'Miraflores', N'4859544', N'0', N'M', N'fcastrot@hotmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (8, N'Jorge', N'Mendoza', N'Castro', 3, 1, NULL, NULL, CAST(0xE4140B00 AS Date), N'1', N'41331772', N'Miraflores', N'4859544', N'0', N'M', N'fcastrot@hotmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (9, N'111111', N'111', N'1', 1, 1, NULL, NULL, CAST(0xEC140B00 AS Date), N'1', N'xxx', N'xx', N'xxx', N'1', N'M', N'xxx')
SET IDENTITY_INSERT [dbo].[TR_Trabajador] OFF
/****** Object:  StoredProcedure [dbo].[ListarIdioma]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarIdioma] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_Idioma


END
GO
/****** Object:  StoredProcedure [dbo].[ListarDisponibilidad]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarDisponibilidad] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_Disponibilidad


END
GO
/****** Object:  StoredProcedure [dbo].[ListarCargo]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarCargo] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_Cargo


END
GO
/****** Object:  StoredProcedure [dbo].[ListarNivel]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarNivel] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_NivelFormacion


END
GO
/****** Object:  StoredProcedure [dbo].[ListarNacionalidad]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarNacionalidad] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_Nacionalidad


END
GO
/****** Object:  StoredProcedure [dbo].[ListarTipoTrabajador]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarTipoTrabajador] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_TipoTrabajador


END
GO
/****** Object:  StoredProcedure [dbo].[ListarSituacion]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarSituacion] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_SituacionFormacion


END
GO
/****** Object:  StoredProcedure [dbo].[ListarSemana]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarSemana] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_PeriodoSemanal


END
GO
/****** Object:  StoredProcedure [dbo].[ListarHoras]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHoras] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          *
FROM            TR_Horas


END
GO
/****** Object:  Table [dbo].[TR_HoraExtra]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TR_HoraExtra](
	[IdTrabajador] [int] NOT NULL,
	[IdSemana] [int] NOT NULL,
	[IdTipoRegistroHora] [int] NOT NULL,
	[Lunes] [time](7) NULL,
	[Martes] [time](7) NULL,
	[Miercoles] [time](7) NULL,
	[Jueves] [time](7) NULL,
	[Viernes] [time](7) NULL,
	[Sabado] [time](7) NULL,
	[Domingo] [time](7) NULL,
 CONSTRAINT [PK_HoraExtra] PRIMARY KEY CLUSTERED 
(
	[IdTrabajador] ASC,
	[IdSemana] ASC,
	[IdTipoRegistroHora] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (1, 1, 1, CAST(0x070010ACD1530000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (1, 1, 2, CAST(0x070048F9F66C0000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x07001882BA7D0000 AS Time), CAST(0x07002058A3A70000 AS Time), CAST(0x07002058A3A70000 AS Time), CAST(0x070050CFDF960000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (1, 1, 3, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (1, 2, 1, CAST(0x070010ACD1530000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (1, 2, 2, CAST(0x0700709A4A320000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x070010ACD1530000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (1, 2, 3, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (2, 1, 1, CAST(0x0700000000000000 AS Time), CAST(0x07007870335C0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (2, 1, 2, CAST(0x0700000000000000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (2, 1, 3, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (2, 2, 1, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (2, 2, 2, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700B0BD58750000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (2, 2, 3, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (3, 1, 1, CAST(0x070010ACD1530000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700709A4A320000 AS Time), CAST(0x0700709A4A320000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (3, 1, 2, CAST(0x0700E03495640000 AS Time), CAST(0x07001882BA7D0000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x070010ACD1530000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (3, 1, 3, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (6, 2, 1, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (6, 2, 2, CAST(0x07002058A3A70000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (7, 1, 1, CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070008D6E8290000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (7, 1, 2, CAST(0x070010ACD1530000 AS Time), CAST(0x0700B0BD58750000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (8, 2, 1, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (8, 2, 2, CAST(0x07001882BA7D0000 AS Time), CAST(0x07001882BA7D0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
/****** Object:  Table [dbo].[TR_HabilidadLinguistica]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_HabilidadLinguistica](
	[IdHabilidadLinguistica] [int] IDENTITY(1,1) NOT NULL,
	[IdPostulante] [int] NULL,
	[IdIdioma] [int] NULL,
	[Lectura] [char](1) NULL,
	[Escritura] [char](1) NULL,
	[Hablado] [char](1) NULL,
 CONSTRAINT [PK_HabilidadLinguistica] PRIMARY KEY CLUSTERED 
(
	[IdHabilidadLinguistica] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_HabilidadLinguistica] ON
INSERT [dbo].[TR_HabilidadLinguistica] ([IdHabilidadLinguistica], [IdPostulante], [IdIdioma], [Lectura], [Escritura], [Hablado]) VALUES (1, 1, 1, N'B', N'B', N'A')
INSERT [dbo].[TR_HabilidadLinguistica] ([IdHabilidadLinguistica], [IdPostulante], [IdIdioma], [Lectura], [Escritura], [Hablado]) VALUES (3, 4, 1, N'B', N'B', N'B')
INSERT [dbo].[TR_HabilidadLinguistica] ([IdHabilidadLinguistica], [IdPostulante], [IdIdioma], [Lectura], [Escritura], [Hablado]) VALUES (4, 5, 1, N'B', N'B', N'B')
INSERT [dbo].[TR_HabilidadLinguistica] ([IdHabilidadLinguistica], [IdPostulante], [IdIdioma], [Lectura], [Escritura], [Hablado]) VALUES (5, 9, 1, N'B', N'I', N'B')
SET IDENTITY_INSERT [dbo].[TR_HabilidadLinguistica] OFF
/****** Object:  Table [dbo].[TR_FormacionProfesional]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_FormacionProfesional](
	[IdFormacion] [int] IDENTITY(1,1) NOT NULL,
	[IdPostulante] [int] NULL,
	[IdNivelFormacion] [int] NULL,
	[Titulo] [varchar](50) NULL,
	[FechaTitulacion] [datetime] NULL,
	[IdSituacionFormacion] [int] NULL,
	[AnioFormado] [int] NULL,
 CONSTRAINT [PK_FormacionProfesional] PRIMARY KEY CLUSTERED 
(
	[IdFormacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_FormacionProfesional] ON
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (4, 1, 2, N'Ing Sistemas', CAST(0x0000A19500000000 AS DateTime), 1, 3)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (5, 1, 1, N'cCc', CAST(0x0000A19400000000 AS DateTime), 1, 3)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (6, 2, 2, N'Ing de Sistemas', CAST(0x0000A1A300000000 AS DateTime), 2, 4)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (8, 3, 1, N'ing sistemas', CAST(0x0000A19C00000000 AS DateTime), 2, 5)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (9, 4, 1, N'ing sistemas', CAST(0x0000A1B300000000 AS DateTime), 1, 5)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (10, 5, 1, N'Ing sistemas', CAST(0x0000A1B100000000 AS DateTime), 1, 5)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (11, 8, 1, N'Ing Sistemas', CAST(0x0000A19400000000 AS DateTime), 1, 5)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (12, 9, 1, N'ing sistemas', CAST(0x0000A1B100000000 AS DateTime), 1, 5)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (13, 10, 1, N'ig sistemas', CAST(0x0000A1B100000000 AS DateTime), 1, 5)
INSERT [dbo].[TR_FormacionProfesional] ([IdFormacion], [IdPostulante], [IdNivelFormacion], [Titulo], [FechaTitulacion], [IdSituacionFormacion], [AnioFormado]) VALUES (14, 11, 1, N'Contabilidad', CAST(0x0000A1B100000000 AS DateTime), 1, 5)
SET IDENTITY_INSERT [dbo].[TR_FormacionProfesional] OFF
/****** Object:  Table [dbo].[TR_Experiencia]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Experiencia](
	[IdExperiencia] [int] IDENTITY(1,1) NOT NULL,
	[IdPostulante] [int] NULL,
	[NombreEmpresa] [varchar](50) NULL,
	[FechaInicio] [datetime] NULL,
	[FechaFinal] [datetime] NULL,
	[IdCargo] [int] NULL,
	[Responsabilidad] [varchar](50) NULL,
 CONSTRAINT [PK_Experiencia] PRIMARY KEY CLUSTERED 
(
	[IdExperiencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_Experiencia] ON
INSERT [dbo].[TR_Experiencia] ([IdExperiencia], [IdPostulante], [NombreEmpresa], [FechaInicio], [FechaFinal], [IdCargo], [Responsabilidad]) VALUES (3, 1, N'Cnp', CAST(0x0000A19300000000 AS DateTime), CAST(0x0000A19500000000 AS DateTime), 1, N'jefe')
INSERT [dbo].[TR_Experiencia] ([IdExperiencia], [IdPostulante], [NombreEmpresa], [FechaInicio], [FechaFinal], [IdCargo], [Responsabilidad]) VALUES (4, 2, N'CNP', CAST(0x0000A19300000000 AS DateTime), CAST(0x0000A19500000000 AS DateTime), 1, N'Jefe')
INSERT [dbo].[TR_Experiencia] ([IdExperiencia], [IdPostulante], [NombreEmpresa], [FechaInicio], [FechaFinal], [IdCargo], [Responsabilidad]) VALUES (6, 3, N'cnp', CAST(0x0000A19500000000 AS DateTime), CAST(0x0000A19600000000 AS DateTime), 2, N'jefe')
INSERT [dbo].[TR_Experiencia] ([IdExperiencia], [IdPostulante], [NombreEmpresa], [FechaInicio], [FechaFinal], [IdCargo], [Responsabilidad]) VALUES (7, 4, N'cnp', CAST(0x0000A1B100000000 AS DateTime), CAST(0x0000A1B200000000 AS DateTime), 1, N'jefe')
INSERT [dbo].[TR_Experiencia] ([IdExperiencia], [IdPostulante], [NombreEmpresa], [FechaInicio], [FechaFinal], [IdCargo], [Responsabilidad]) VALUES (8, 5, N'Golder', CAST(0x00008F2500000000 AS DateTime), CAST(0x0000A1B200000000 AS DateTime), 1, N'Jefe')
INSERT [dbo].[TR_Experiencia] ([IdExperiencia], [IdPostulante], [NombreEmpresa], [FechaInicio], [FechaFinal], [IdCargo], [Responsabilidad]) VALUES (9, 9, N'cnp', CAST(0x0000A1B100000000 AS DateTime), CAST(0x0000A1BB00000000 AS DateTime), 1, N'jefe')
SET IDENTITY_INSERT [dbo].[TR_Experiencia] OFF
/****** Object:  StoredProcedure [dbo].[ActualizarTrabajador]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarTrabajador]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@idTrabajador as int,
	@Nombre as varchar(50),
	@ApellidoPaterno as varchar(50),
	@ApellidoMaterno as varchar(50),
	@idCargo as int,
	@IdTipoTrabjador as int,
	@FechaNacimiento as date,
	@TipoDocumento as char(1),
	@NumeroDocumento as varchar(20),
	@Direccion as varchar(100),
	@Telefono as varchar(20),
	@Activo as char(1),
	@Sexo as Char(1),
	@Correo as varchar(50)
	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

update TR_Trabajador set Nombre=@Nombre,ApellidoPaterno=@ApellidoPaterno,ApellidoMaterno=@ApellidoMaterno,idCargo=@idCargo
,IdTipoTrabjador=@IdTipoTrabjador,FechaNacimiento=@FechaNacimiento,TipoDocumento=@TipoDocumento,NumeroDocumento=@NumeroDocumento,
Direccion=@Direccion,Telefono=@Telefono,Activo=@Activo,Sexo=@Sexo,Correo=@Correo
where idtrabajador=@idtrabajador
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPostulante]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarPostulante]-- 23
	-- Add the parameters for the stored procedure here
	@idPostulante as int,
	@Nombre as varchar(50),
	@ApellidoPaterno as varchar(50),
	@ApellidoMaterno as varchar(50),
	@DNI as varchar(8),
	@FechaNacimiento as date,
	@Sexo as Char(1),
	@IdNacionalidad as int,
	@Direccion as varchar(50),
	@Telefono as varchar(20),
	@Correo as varchar(50),
	@idCargo as int,
	@IdDisponibilidad as int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

update TR_Postulante set Nombre=@Nombre,ApellidoPaterno=@ApellidoPaterno,ApellidoMaterno=@ApellidoMaterno,DNI=@DNI,
 FechaNacimiento=@FechaNacimiento,Sexo=@Sexo,IdNacionalidad=@IdNacionalidad,Direccion=@Direccion,Telefono=@Telefono,Correo=@Correo,
 idCargo=@idCargo,IdDisponibilidad=@IdDisponibilidad
where idpostulante=@idPostulante


END
GO
/****** Object:  StoredProcedure [dbo].[IngresarCese]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarCese]-- 23
	-- Add the parameters for the stored procedure here
	
	@idTrabajador as int,
	@FechaCese as date,
	@idMotivo as char(1),
	@Observacion as varchar(200),
	@FechaCreacion as date 


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into TR_Cese(idTrabajador,FechaCese,IdMotivo,Observacion,FechaCreacion)
values(
 	@idTrabajador,
	@FechaCese,
	@idMotivo,
	@Observacion,
	@FechaCreacion)

update TR_Trabajador set Activo='1' where IdTrabajador=@idTrabajador
END
GO
/****** Object:  StoredProcedure [dbo].[IngresarTrabajador]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarTrabajador]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@Nombre as varchar(50),
	@ApellidoPaterno as varchar(50),
	@ApellidoMaterno as varchar(50),
	@idCargo as int,
	@IdTipoTrabjador as int,
	@FechaNacimiento as date,
	@TipoDocumento as char(1),
	@NumeroDocumento as varchar(20),
	@Direccion as varchar(100),
	@Telefono as varchar(20),
	@Activo as char(1),
	@Sexo as Char(1),
	@Correo as varchar(50),
	@idTrabajador as int output


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into TR_Trabajador(Nombre,ApellidoPaterno,ApellidoMaterno,idCargo,IdTipoTrabjador,FechaNacimiento,TipoDocumento,NumeroDocumento,Direccion,Telefono,Activo,Sexo,Correo)
values(
 	@Nombre,
	@ApellidoPaterno,
	@ApellidoMaterno,
	@idCargo,
	@IdTipoTrabjador,
	@FechaNacimiento,
	@TipoDocumento,
	@NumeroDocumento,
	@Direccion,
	@Telefono,
	@Activo,
	@Sexo,
	@Correo)

SELECT @idTrabajador=@@IDENTITY 
END
GO
/****** Object:  StoredProcedure [dbo].[IngresarPostulante]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarPostulante]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@Nombre as varchar(50),
	@ApellidoPaterno as varchar(50),
	@ApellidoMaterno as varchar(50),
	@DNI as varchar(8),
	@FechaNacimiento as date,
	@Sexo as Char(1),
	@IdNacionalidad as int,
	@Direccion as varchar(50),
	@Telefono as varchar(20),
	@Correo as varchar(50),
	@idCargo as int,
	@IdDisponibilidad as int,
	@idPostulante as int output


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into TR_Postulante(Nombre,ApellidoPaterno,ApellidoMaterno,DNI,FechaNacimiento,Sexo,IdNacionalidad,Direccion,Telefono,Correo,idCargo,IdDisponibilidad)
values(
 @Nombre
,@ApellidoPaterno
,@ApellidoMaterno
,@DNI
,@FechaNacimiento
,@Sexo
,@IdNacionalidad
,@Direccion
,@Telefono
,@Correo
,@idCargo
,@IdDisponibilidad)

SELECT @idPostulante=@@IDENTITY 
END
GO
/****** Object:  StoredProcedure [dbo].[ListarPostulante]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarPostulante]
	-- Add the parameters for the stored procedure here
	@idPostulante as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        IdPostulante, Nombre, ApellidoPaterno, ApellidoMaterno, DNI, FechaNacimiento, Sexo, IdNacionalidad, Direccion, Telefono, Correo, IdCargo, 
                         IdDisponibilidad
FROM            TR_Postulante 
where idpostulante=@idPostulante

END
GO
/****** Object:  StoredProcedure [dbo].[ReporteTrabajadores]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ReporteTrabajadores]--0
	@activo as char(1)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          idtrabajador,Nombre,ApellidoPaterno,apellidoMaterno,(select descripcion from TR_Cargo C where C.Idcargo=T.IdCargo)as Cargo,
				(select Descripcin from TR_TipoTrabajador R where r.Id=T.idtipoTrabjador) as TipoTrabajador,
				CONVERT(VARCHAR(24),FechaNacimiento,103)as FechaNacimiento,
				CASE TipoDocumento 
				When '1' then 'DNI'
				When '2' Then 'CE'
				END as Documento, NumeroDocumento,Direccion,Telefono,Sexo,Correo

FROM            TR_Trabajador T where Activo=@activo
order by Nombre



END
GO
/****** Object:  Table [dbo].[TR_TrabajadorPuestos]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_TrabajadorPuestos](
	[idTrabajador] [int] NOT NULL,
	[idCargo] [int] NOT NULL,
	[idTipoTrabajador] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[Activo] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo]) VALUES (7, 3, 1, CAST(0x0C370B00 AS Date), CAST(0xDF3C0B00 AS Date), N'0')
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo]) VALUES (8, 3, 1, CAST(0x0C370B00 AS Date), CAST(0xB83F0B00 AS Date), N'0')
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo]) VALUES (9, 1, 1, CAST(0x0C370B00 AS Date), CAST(0x2A370B00 AS Date), N'1')
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo]) VALUES (9, 1, 1, CAST(0x10370B00 AS Date), CAST(0x2A370B00 AS Date), N'0')
/****** Object:  Table [dbo].[TR_ProgramacionHoraExtra]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TR_ProgramacionHoraExtra](
	[IdTrabajador] [int] NOT NULL,
	[IdSemana] [int] NOT NULL,
	[Lunes] [int] NULL,
	[Martes] [int] NULL,
	[Miercoles] [int] NULL,
	[Jueves] [int] NULL,
	[Viernes] [int] NULL,
	[Sabado] [int] NULL,
	[Domingo] [int] NULL,
 CONSTRAINT [PK_ProgramacionHoraExtra] PRIMARY KEY CLUSTERED 
(
	[IdTrabajador] ASC,
	[IdSemana] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[TR_ProgramacionHoraExtra] ([IdTrabajador], [IdSemana], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (1, 1, 0, 0, 0, 5, 0, 0, 0)
INSERT [dbo].[TR_ProgramacionHoraExtra] ([IdTrabajador], [IdSemana], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (2, 1, 1, 3, 0, 0, 0, 0, 0)
INSERT [dbo].[TR_ProgramacionHoraExtra] ([IdTrabajador], [IdSemana], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (3, 1, 0, 0, 0, 0, 5, 0, 3)
INSERT [dbo].[TR_ProgramacionHoraExtra] ([IdTrabajador], [IdSemana], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (7, 1, 1, 0, 0, 2, 0, 0, 0)
/****** Object:  StoredProcedure [dbo].[ListarTrabajadoresActivos]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarTrabajadoresActivos] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          idtrabajador,Nombre,ApellidoPaterno,apellidoMaterno,(select descripcion from TR_Cargo C where C.Idcargo=T.IdCargo)as Cargo,
				(select Descripcin from TR_TipoTrabajador R where r.Id=T.idtipoTrabjador) as TipoTrabajador
FROM            TR_Trabajador T where Activo=0
order by ApellidoPaterno


END
GO
/****** Object:  StoredProcedure [dbo].[ListarTrabajador]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarTrabajador]--9
	-- Add the parameters for the stored procedure here
	@IdTrabajador as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        IdTrabajador, Nombre, ApellidoMaterno, ApellidoPaterno, IdCargo, IdTipoTrabjador, HoraInicio, HoraFin, FechaNacimiento, TipoDocumento, 
              NumeroDocumento, Direccion, Telefono, Activo, Sexo, Correo,
              (select FechaInicio from TR_TrabajadorPuestos where IdTrabajador=@IdTrabajador and Activo=0) as FechaInicio,
              (select FechaFin from TR_TrabajadorPuestos where IdTrabajador=@IdTrabajador and Activo=0) as FechaFin           
FROM            TR_Trabajador 
where IdTrabajador=@IdTrabajador

END
GO
/****** Object:  StoredProcedure [dbo].[ListarTrabajadorPuestos]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarTrabajadorPuestos]
	-- Add the parameters for the stored procedure here
	@idTrabajador as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT      idtrabajador,
			(select descripcion from TR_Cargo C where C.idCargo=TP.idCargo) as Cargo,
			(select Descripcin from TR_TipoTrabajador T where T.id=TP.idCargo)as Tipo,
			FechaInicio,FechaFin

FROM            TR_TrabajadorPuestos TP
where idTrabajador=@idTrabajador
order by FechaInicio desc
END
GO
/****** Object:  StoredProcedure [dbo].[ListarLinguistica]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarLinguistica]
	-- Add the parameters for the stored procedure here
	@idPostulante as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT         IdHabilidadLinguistica, IdPostulante, IdIdioma, Lectura, Escritura, Hablado
FROM            TR_HabilidadLinguistica
where idpostulante=@idPostulante

END
GO
/****** Object:  StoredProcedure [dbo].[IngresarTrabajadorPuesto]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarTrabajadorPuesto]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@idTrabajador int,
	@idCargo as int,
	@IdTipoTrabajador as int,
	@FechaInicio as date,
	@FechaFin as date,
	@Activo as char(1)
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	


IF not EXISTS (SELECT * FROM TR_TrabajadorPuestos WHERE idTrabajador=@idTrabajador and idCargo=@idCargo and idTipoTrabajador=@IdTipoTrabajador and FechaInicio=@FechaInicio and FechaFin=@FechaFin) 
begin
  update TR_TrabajadorPuestos set Activo=1 where idTrabajador=@idTrabajador
  insert into TR_TrabajadorPuestos(idTrabajador,idCargo,IdTipoTrabajador,FechaInicio,FechaFin,Activo)
values(@idTrabajador,@idCargo,@IdTipoTrabajador,@FechaInicio,@FechaFin,@Activo)
  update TR_Trabajador set IdCargo=@idCargo, IdTipoTrabjador=@IdTipoTrabajador where IdTrabajador=@idTrabajador
end


END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaViernes]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorasxSemanaViernes]--1,'10:00:00'
 @idsemana as int,
 @hora as time
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select idTrabajador,
(select Nombre from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Nombre,
(select ApellidoPaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Paterno,
(select ApellidoMaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Materno,
(select Descripcion from TR_Cargo C, TR_Trabajador T where C.IdCargo=T.IdCargo and T.IdTrabajador=Todo.IdTrabajador) as cargo
		from
		(select distinct idtrabajador,
		(select Viernes from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=1 and IdSemana=@idsemana and Viernes <>'00:00:00') as Entrada,
		(select Viernes from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=2 and IdSemana=@idsemana and Viernes <>'00:00:00') as Salida
from TR_HoraExtra H where idsemana=@idsemana ) as Todo
Where @hora between entrada and salida
order by Nombre

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaSabado]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorasxSemanaSabado]--1,'10:00:00'
 @idsemana as int,
 @hora as time
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select idTrabajador,
(select Nombre from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Nombre,
(select ApellidoPaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Paterno,
(select ApellidoMaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Materno,
(select Descripcion from TR_Cargo C, TR_Trabajador T where C.IdCargo=T.IdCargo and T.IdTrabajador=Todo.IdTrabajador) as cargo
		from
		(select distinct idtrabajador,
		(select Sabado from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=1 and IdSemana=@idsemana and Sabado <>'00:00:00') as Entrada,
		(select Sabado from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=2 and IdSemana=@idsemana and Sabado <>'00:00:00') as Salida
from TR_HoraExtra H where idsemana=@idsemana ) as Todo
Where @hora between entrada and salida
order by Nombre

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaMiercoles]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorasxSemanaMiercoles]--1,'10:00:00'
 @idsemana as int,
 @hora as time
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select idTrabajador,
(select Nombre from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Nombre,
(select ApellidoPaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Paterno,
(select ApellidoMaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Materno,
(select Descripcion from TR_Cargo C, TR_Trabajador T where C.IdCargo=T.IdCargo and T.IdTrabajador=Todo.IdTrabajador) as cargo
		from
		(select distinct idtrabajador,
		(select Miercoles from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=1 and IdSemana=@idsemana and Miercoles <>'00:00:00') as Entrada,
		(select Miercoles from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=2 and IdSemana=@idsemana and Miercoles <>'00:00:00') as Salida
from TR_HoraExtra H where idsemana=@idsemana ) as Todo
Where @hora between entrada and salida
order by Nombre

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaMartes]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorasxSemanaMartes]--1,'10:00:00'
 @idsemana as int,
 @hora as time
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select idTrabajador,
(select Nombre from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Nombre,
(select ApellidoPaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Paterno,
(select ApellidoMaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Materno,
(select Descripcion from TR_Cargo C, TR_Trabajador T where C.IdCargo=T.IdCargo and T.IdTrabajador=Todo.IdTrabajador) as cargo
		from
		(select distinct idtrabajador,
		(select Martes from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=1 and IdSemana=@idsemana and Martes <>'00:00:00') as Entrada,
		(select Martes from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=2 and IdSemana=@idsemana and Martes <>'00:00:00') as Salida
from TR_HoraExtra H where idsemana=@idsemana ) as Todo
Where @hora between entrada and salida
order by Nombre

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaLunes]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorasxSemanaLunes]--1,'10:00:00'
 @idsemana as int,
 @hora as time
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select idTrabajador,
(select Nombre from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Nombre,
(select ApellidoPaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Paterno,
(select ApellidoMaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Materno,
(select Descripcion from TR_Cargo C, TR_Trabajador T where C.IdCargo=T.IdCargo and T.IdTrabajador=Todo.IdTrabajador) as cargo
		from
		(select distinct idtrabajador,
		(select Lunes from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=1 and IdSemana=@idsemana and Lunes <>'00:00:00') as Entrada,
		(select Lunes from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=2 and IdSemana=@idsemana and Lunes <>'00:00:00') as Salida
from TR_HoraExtra H where idsemana=@idsemana ) as Todo
Where @hora between entrada and salida
order by Nombre

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaJueves]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorasxSemanaJueves]--1,'10:00:00'
 @idsemana as int,
 @hora as time
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select idTrabajador,
(select Nombre from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Nombre,
(select ApellidoPaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Paterno,
(select ApellidoMaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Materno,
(select Descripcion from TR_Cargo C, TR_Trabajador T where C.IdCargo=T.IdCargo and T.IdTrabajador=Todo.IdTrabajador) as cargo
		from
		(select distinct idtrabajador,
		(select Jueves from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=1 and IdSemana=@idsemana and Jueves <>'00:00:00') as Entrada,
		(select Jueves from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=2 and IdSemana=@idsemana and Jueves <>'00:00:00') as Salida
from TR_HoraExtra H where idsemana=@idsemana ) as Todo
Where @hora between entrada and salida
order by Nombre

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaDomingo]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorasxSemanaDomingo]--1,'10:00:00'
 @idsemana as int,
 @hora as time
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select idTrabajador,
(select Nombre from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Nombre,
(select ApellidoPaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Paterno,
(select ApellidoMaterno from TR_Trabajador T where T.IdTrabajador=Todo.idTrabajador)as Materno,
(select Descripcion from TR_Cargo C, TR_Trabajador T where C.IdCargo=T.IdCargo and T.IdTrabajador=Todo.IdTrabajador) as cargo
		from
		(select distinct idtrabajador,
		(select Domingo from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=1 and IdSemana=@idsemana and Domingo <>'00:00:00') as Entrada,
		(select Domingo from TR_HoraExtra H1 where H1.IdTrabajador=H.idTrabajador and IdTipoRegistroHora=2 and IdSemana=@idsemana and Domingo <>'00:00:00') as Salida
from TR_HoraExtra H where idsemana=@idsemana ) as Todo
Where @hora between entrada and salida
order by Nombre

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHorarioxSemanaxTrabajador]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHorarioxSemanaxTrabajador]
	-- Add the parameters for the stored procedure here
	@idTrabajador as int,
	@idSemana as int,
	@idTipo as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        IdTrabajador, IdSemana, IdTipoRegistroHora, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo
FROM            TR_HoraExtra
where IdTrabajador=@idTrabajador and IdSemana=@idSemana and IdTipoRegistroHora=@idTipo

END
GO
/****** Object:  StoredProcedure [dbo].[ListarHoraExtrasxSemanaxTrabajador]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarHoraExtrasxSemanaxTrabajador]
	-- Add the parameters for the stored procedure here
	@idTrabajador as int,
	@idSemana as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        IdTrabajador, IdSemana, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo
FROM            TR_ProgramacionHoraExtra
where IdTrabajador=@idTrabajador and IdSemana=@idSemana

END
GO
/****** Object:  StoredProcedure [dbo].[ListarFormacion]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarFormacion] 
	-- Add the parameters for the stored procedure here
	@idPostulante as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT          IdFormacion, IdPostulante, IdNivelFormacion, Titulo, Convert(char(10), FechaTitulacion, 103) as FechaTitulacion, IdSituacionFormacion, AnioFormado
FROM            TR_FormacionProfesional
where IdPostulante=@idPostulante

END
GO
/****** Object:  StoredProcedure [dbo].[ListarExperiencia]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarExperiencia]-- 23
	-- Add the parameters for the stored procedure here
	@idPostulante as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT       IdExperiencia, IdPostulante, NombreEmpresa, Convert(char(10), FechaInicio, 103) as FechaInicio,Convert(char(10), FechaFinal, 103) as FechaFinal, IdCargo, Responsabilidad
FROM            TR_Experiencia
where idpostulante=@idPostulante


END
GO
/****** Object:  StoredProcedure [dbo].[IngresarHorario]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarHorario]-- 23
	@IdTrabajador as int, 
	@IdSemana as int, 
	@IdTipoRegistroHora as int,
	@Lunes as varchar(8), 
	@Martes as varchar(8), 
	@Miercoles as varchar(8), 
	@Jueves as varchar(8), 
	@Viernes as varchar(8), 
	@Sabado as varchar(8), 
	@Domingo as varchar(8)




AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


IF not EXISTS (select * FROM TR_HoraExtra where IdTrabajador=@IdTrabajador and IdSemana=@IdSemana and IdTipoRegistroHora=@IdTipoRegistroHora) 
BEGIN
	insert into TR_HoraExtra( IdTrabajador, IdSemana, IdTipoRegistroHora, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo)
	values(@IdTrabajador,@IdSemana,@IdTipoRegistroHora,@Lunes,@Martes,@Miercoles,@Jueves,@Viernes,@Sabado,@Domingo)
END
ELSE
BEGIN
	update TR_HoraExtra set Lunes=@Lunes,Martes=@Martes,Miercoles=@Miercoles,Jueves=@Jueves,Viernes=@Viernes,Sabado=@Sabado,Domingo=@Domingo
	where IdTrabajador=@IdTrabajador and IdSemana=@IdSemana and IdTipoRegistroHora=@IdTipoRegistroHora
	 
END

END
GO
/****** Object:  StoredProcedure [dbo].[IngresarHoraExtra]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarHoraExtra]-- 23
	@IdTrabajador as int, 
	@IdSemana as int, 
	@Lunes as int, 
	@Martes as int, 
	@Miercoles as int, 
	@Jueves as int, 
	@Viernes as int, 
	@Sabado as int, 
	@Domingo as int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


IF not EXISTS (select * FROM TR_ProgramacionHoraExtra where IdTrabajador=@IdTrabajador and IdSemana=@IdSemana) 
BEGIN
	insert into TR_ProgramacionHoraExtra(IdTrabajador, IdSemana,Lunes,Martes,Miercoles,Jueves,Viernes,Sabado,Domingo)
	values(@IdTrabajador,@IdSemana,@Lunes,@Martes,@Miercoles,@Jueves,@Viernes,@Sabado,@Domingo)
END
ELSE
BEGIN
	update TR_ProgramacionHoraExtra set Lunes=@Lunes,Martes=@Martes,Miercoles=@Miercoles,Jueves=@Jueves,Viernes=@Viernes,Sabado=@Sabado,Domingo=@Domingo
	where IdTrabajador=@IdTrabajador and IdSemana=@IdSemana

END

END
GO
/****** Object:  StoredProcedure [dbo].[IngresarHabilidad]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarHabilidad]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@IdPostulante as int,
	@IdIdioma as varchar(1),
	@Lectura as varchar(1),
	@Escritura as varchar(1),
	@Hablado as varchar(1)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into TR_HabilidadLinguistica(IdPostulante,IdIdioma,Lectura,Escritura,Hablado)
values(@IdPostulante,@IdIdioma,@Lectura,@Escritura,@Hablado)


END
GO
/****** Object:  StoredProcedure [dbo].[IngresarFormacion]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarFormacion]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@IdPostulante as int,
	@IdNivelFormacion as int,
	@Titulo as varchar(50),
	@FechaTitulacion as date,
	@IdSituacionFormacion as int,
	@AnioFormado as int
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into TR_FormacionProfesional(IdPostulante,IdNivelFormacion,Titulo,FechaTitulacion,IdSituacionFormacion,AnioFormado)
values(@IdPostulante,@IdNivelFormacion,@Titulo,@FechaTitulacion,@IdSituacionFormacion,@AnioFormado)


END
GO
/****** Object:  StoredProcedure [dbo].[IngresarExperiencia]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IngresarExperiencia]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@IdPostulante as int,
	@NombreEmpresa as varchar(50),
	@FechaInicio as date,
	@FechaFinal as date,
	@IdCargo as int,
	@Responsabilidad as varchar(50)
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into TR_Experiencia(IdPostulante,NombreEmpresa,FechaInicio,FechaFinal,IdCargo,Responsabilidad)
values(@IdPostulante,@NombreEmpresa,@FechaInicio,@FechaFinal,@IdCargo,@Responsabilidad)


END
GO
/****** Object:  StoredProcedure [dbo].[EliminarLinguistica]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EliminarLinguistica]-- 23
	-- Add the parameters for the stored procedure here
	@idPostulante as int,
	@IdHabilidadLinguistica as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
if @IdHabilidadLinguistica=0
begin
delete from TR_HabilidadLinguistica where idpostulante=@idPostulante
end
else
begin
delete from TR_HabilidadLinguistica where idpostulante=@idPostulante and IdHabilidadLinguistica=@IdHabilidadLinguistica
end

END
GO
/****** Object:  StoredProcedure [dbo].[EliminarFormacion]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EliminarFormacion] --28,0
	-- Add the parameters for the stored procedure here
	@idPostulante as int,
	@idFormacion as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
if @idFormacion = 0
begin
delete from TR_FormacionProfesional where idpostulante=@idPostulante
end
else
begin
delete from TR_FormacionProfesional where idpostulante=@idPostulante and IdFormacion=@idFormacion
end

END
GO
/****** Object:  StoredProcedure [dbo].[EliminarExperiencia]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EliminarExperiencia] --28,0
	-- Add the parameters for the stored procedure here
	@idPostulante as int,
	@IdExperiencia as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
if @IdExperiencia = 0
begin
delete from TR_Experiencia where idpostulante=@idPostulante
end
else
begin
delete from TR_Experiencia where idpostulante=@idPostulante and IdExperiencia=IdExperiencia
end

END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarLinguistica]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarLinguistica]-- 23
	-- Add the parameters for the stored procedure here
	@idPostulante as int,
	@IdIdioma as int,
	@Lectura as char(1),
	@Escritura as char(1),
	@Hablado as char(1)

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--delete from FormacionProfesional where idpostulante=@idPostulante
insert into TR_HabilidadLinguistica(idPostulante,IdIdioma,Lectura,Escritura,Hablado) values (@idPostulante,@IdIdioma,@Lectura,@Escritura,@Hablado)
--where idpostulante=@idPostulante


END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarFormacion]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarFormacion]-- 23
	-- Add the parameters for the stored procedure here
	@idPostulante as int,
	@IdNivelFormacion as int,
	@Titulo as varchar(50),
	@FechaTitulacion as Date,
	@IdSituacionFormacion as int,
	@AnioFormado as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--delete from FormacionProfesional where idpostulante=@idPostulante
insert into TR_FormacionProfesional(idPostulante,IdNivelFormacion,Titulo,FechaTitulacion,IdSituacionFormacion,AnioFormado) values (@idPostulante,@IdNivelFormacion,@Titulo,@FechaTitulacion,@IdSituacionFormacion,@AnioFormado)
--where idpostulante=@idPostulante


END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarExperiencia]    Script Date: 05/14/2013 22:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarExperiencia]-- 23
	-- Add the parameters for the stored procedure here
	@idPostulante as int,
	@NombreEmpresa as varchar(50),
	@FechaInicio as Date,
	@FechaFinal as Date,
	@IdCargo as int,
	@Responsabilidad as varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--delete from FormacionProfesional where idpostulante=@idPostulante
insert into TR_Experiencia(idPostulante,NombreEmpresa,FechaInicio,FechaFinal,IdCargo,Responsabilidad ) values (@idPostulante,@NombreEmpresa,@FechaInicio,@FechaFinal,@IdCargo,	@Responsabilidad)
--where idpostulante=@idPostulante


END
GO
/****** Object:  ForeignKey [FK_Postulante_Cargo]    Script Date: 05/14/2013 22:54:36 ******/
ALTER TABLE [dbo].[TR_Postulante]  WITH CHECK ADD  CONSTRAINT [FK_Postulante_Cargo] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_Postulante] CHECK CONSTRAINT [FK_Postulante_Cargo]
GO
/****** Object:  ForeignKey [FK_Postulante_Disponibilidad]    Script Date: 05/14/2013 22:54:36 ******/
ALTER TABLE [dbo].[TR_Postulante]  WITH CHECK ADD  CONSTRAINT [FK_Postulante_Disponibilidad] FOREIGN KEY([IdDisponibilidad])
REFERENCES [dbo].[TR_Disponibilidad] ([IdDisponibilidad])
GO
ALTER TABLE [dbo].[TR_Postulante] CHECK CONSTRAINT [FK_Postulante_Disponibilidad]
GO
/****** Object:  ForeignKey [FK_Postulante_Nacionalidad]    Script Date: 05/14/2013 22:54:36 ******/
ALTER TABLE [dbo].[TR_Postulante]  WITH CHECK ADD  CONSTRAINT [FK_Postulante_Nacionalidad] FOREIGN KEY([IdNacionalidad])
REFERENCES [dbo].[TR_Nacionalidad] ([IdNacionalidad])
GO
ALTER TABLE [dbo].[TR_Postulante] CHECK CONSTRAINT [FK_Postulante_Nacionalidad]
GO
/****** Object:  ForeignKey [FK_Trabajador_Cargo]    Script Date: 05/14/2013 22:54:36 ******/
ALTER TABLE [dbo].[TR_Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_Trabajador_Cargo] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_Trabajador] CHECK CONSTRAINT [FK_Trabajador_Cargo]
GO
/****** Object:  ForeignKey [FK_Trabajador_TipoTrabajador]    Script Date: 05/14/2013 22:54:36 ******/
ALTER TABLE [dbo].[TR_Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_Trabajador_TipoTrabajador] FOREIGN KEY([IdTipoTrabjador])
REFERENCES [dbo].[TR_TipoTrabajador] ([Id])
GO
ALTER TABLE [dbo].[TR_Trabajador] CHECK CONSTRAINT [FK_Trabajador_TipoTrabajador]
GO
/****** Object:  ForeignKey [FK_HoraExtra_PeriodoSemanal]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_HoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_HoraExtra_PeriodoSemanal] FOREIGN KEY([IdSemana])
REFERENCES [dbo].[TR_PeriodoSemanal] ([IdSemana])
GO
ALTER TABLE [dbo].[TR_HoraExtra] CHECK CONSTRAINT [FK_HoraExtra_PeriodoSemanal]
GO
/****** Object:  ForeignKey [FK_HoraExtra_TipoRegistroHora]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_HoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_HoraExtra_TipoRegistroHora] FOREIGN KEY([IdTipoRegistroHora])
REFERENCES [dbo].[TR_TipoRegistroHora] ([IdTipoRegistroHora])
GO
ALTER TABLE [dbo].[TR_HoraExtra] CHECK CONSTRAINT [FK_HoraExtra_TipoRegistroHora]
GO
/****** Object:  ForeignKey [FK_HoraExtra_Trabajador]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_HoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_HoraExtra_Trabajador] FOREIGN KEY([IdTrabajador])
REFERENCES [dbo].[TR_Trabajador] ([IdTrabajador])
GO
ALTER TABLE [dbo].[TR_HoraExtra] CHECK CONSTRAINT [FK_HoraExtra_Trabajador]
GO
/****** Object:  ForeignKey [FK_HabilidadLinguistica_Idioma]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_HabilidadLinguistica]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadLinguistica_Idioma] FOREIGN KEY([IdIdioma])
REFERENCES [dbo].[TR_Idioma] ([IdIdioma])
GO
ALTER TABLE [dbo].[TR_HabilidadLinguistica] CHECK CONSTRAINT [FK_HabilidadLinguistica_Idioma]
GO
/****** Object:  ForeignKey [FK_HabilidadLinguistica_Postulante]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_HabilidadLinguistica]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadLinguistica_Postulante] FOREIGN KEY([IdPostulante])
REFERENCES [dbo].[TR_Postulante] ([IdPostulante])
GO
ALTER TABLE [dbo].[TR_HabilidadLinguistica] CHECK CONSTRAINT [FK_HabilidadLinguistica_Postulante]
GO
/****** Object:  ForeignKey [FK_FormacionProfesional_NivelFormacion]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_FormacionProfesional]  WITH CHECK ADD  CONSTRAINT [FK_FormacionProfesional_NivelFormacion] FOREIGN KEY([IdNivelFormacion])
REFERENCES [dbo].[TR_NivelFormacion] ([IdNivelFormacion])
GO
ALTER TABLE [dbo].[TR_FormacionProfesional] CHECK CONSTRAINT [FK_FormacionProfesional_NivelFormacion]
GO
/****** Object:  ForeignKey [FK_FormacionProfesional_Postulante]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_FormacionProfesional]  WITH CHECK ADD  CONSTRAINT [FK_FormacionProfesional_Postulante] FOREIGN KEY([IdPostulante])
REFERENCES [dbo].[TR_Postulante] ([IdPostulante])
GO
ALTER TABLE [dbo].[TR_FormacionProfesional] CHECK CONSTRAINT [FK_FormacionProfesional_Postulante]
GO
/****** Object:  ForeignKey [FK_FormacionProfesional_SituacionFormacion]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_FormacionProfesional]  WITH CHECK ADD  CONSTRAINT [FK_FormacionProfesional_SituacionFormacion] FOREIGN KEY([IdSituacionFormacion])
REFERENCES [dbo].[TR_SituacionFormacion] ([IdSituacionFormacion])
GO
ALTER TABLE [dbo].[TR_FormacionProfesional] CHECK CONSTRAINT [FK_FormacionProfesional_SituacionFormacion]
GO
/****** Object:  ForeignKey [FK_Experiencia_Cargo]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_Experiencia]  WITH CHECK ADD  CONSTRAINT [FK_Experiencia_Cargo] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_Experiencia] CHECK CONSTRAINT [FK_Experiencia_Cargo]
GO
/****** Object:  ForeignKey [FK_Experiencia_Postulante]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_Experiencia]  WITH CHECK ADD  CONSTRAINT [FK_Experiencia_Postulante] FOREIGN KEY([IdPostulante])
REFERENCES [dbo].[TR_Postulante] ([IdPostulante])
GO
ALTER TABLE [dbo].[TR_Experiencia] CHECK CONSTRAINT [FK_Experiencia_Postulante]
GO
/****** Object:  ForeignKey [FK_TrabajadorPuestos_Cargo]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_TrabajadorPuestos]  WITH CHECK ADD  CONSTRAINT [FK_TrabajadorPuestos_Cargo] FOREIGN KEY([idCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_TrabajadorPuestos] CHECK CONSTRAINT [FK_TrabajadorPuestos_Cargo]
GO
/****** Object:  ForeignKey [FK_TrabajadorPuestos_TipoTrabajador]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_TrabajadorPuestos]  WITH CHECK ADD  CONSTRAINT [FK_TrabajadorPuestos_TipoTrabajador] FOREIGN KEY([idTipoTrabajador])
REFERENCES [dbo].[TR_TipoTrabajador] ([Id])
GO
ALTER TABLE [dbo].[TR_TrabajadorPuestos] CHECK CONSTRAINT [FK_TrabajadorPuestos_TipoTrabajador]
GO
/****** Object:  ForeignKey [FK_TrabajadorPuestos_Trabajador]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_TrabajadorPuestos]  WITH CHECK ADD  CONSTRAINT [FK_TrabajadorPuestos_Trabajador] FOREIGN KEY([idTrabajador])
REFERENCES [dbo].[TR_Trabajador] ([IdTrabajador])
GO
ALTER TABLE [dbo].[TR_TrabajadorPuestos] CHECK CONSTRAINT [FK_TrabajadorPuestos_Trabajador]
GO
/****** Object:  ForeignKey [FK_ProgramacionHoraExtra_PeriodoSemanal]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionHoraExtra_PeriodoSemanal] FOREIGN KEY([IdSemana])
REFERENCES [dbo].[TR_PeriodoSemanal] ([IdSemana])
GO
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra] CHECK CONSTRAINT [FK_ProgramacionHoraExtra_PeriodoSemanal]
GO
/****** Object:  ForeignKey [FK_ProgramacionHoraExtra_Trabajador]    Script Date: 05/14/2013 22:54:48 ******/
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionHoraExtra_Trabajador] FOREIGN KEY([IdTrabajador])
REFERENCES [dbo].[TR_Trabajador] ([IdTrabajador])
GO
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra] CHECK CONSTRAINT [FK_ProgramacionHoraExtra_Trabajador]
GO
