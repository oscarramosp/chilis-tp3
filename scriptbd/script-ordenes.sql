USE [Sisres]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[IdUsuario] [int] NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UnidadesMedida]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UnidadesMedida](
	[IdUnidadMedida] [int] IDENTITY(1,1) NOT NULL,
	[NombreUnidadMedida] [varchar](50) NOT NULL,
	[Abreviatura] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UnidadesMedida] PRIMARY KEY CLUSTERED 
(
	[IdUnidadMedida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[UnidadesMedida] ON
INSERT [dbo].[UnidadesMedida] ([IdUnidadMedida], [NombreUnidadMedida], [Abreviatura]) VALUES (1, N'Kilogramo', N'kg')
INSERT [dbo].[UnidadesMedida] ([IdUnidadMedida], [NombreUnidadMedida], [Abreviatura]) VALUES (2, N'Litro', N'lt')
INSERT [dbo].[UnidadesMedida] ([IdUnidadMedida], [NombreUnidadMedida], [Abreviatura]) VALUES (3, N'Unidad', N'uni')
SET IDENTITY_INSERT [dbo].[UnidadesMedida] OFF
/****** Object:  Table [dbo].[TiposReceta]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TiposReceta](
	[IdTipoReceta] [int] IDENTITY(1,1) NOT NULL,
	[NombreTipoReceta] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TiposReceta] PRIMARY KEY CLUSTERED 
(
	[IdTipoReceta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TiposReceta] ON
INSERT [dbo].[TiposReceta] ([IdTipoReceta], [NombreTipoReceta]) VALUES (1, N'Bebida')
INSERT [dbo].[TiposReceta] ([IdTipoReceta], [NombreTipoReceta]) VALUES (2, N'Plato')
SET IDENTITY_INSERT [dbo].[TiposReceta] OFF
/****** Object:  Table [dbo].[Anfitriones]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Anfitriones](
	[IdAnfitrion] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [nchar](5) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[Apellidos] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Anfitriones] PRIMARY KEY CLUSTERED 
(
	[IdAnfitrion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Anfitriones] ON
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (1, N'A0001', N'Juan', N'Sandoval  ')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (2, N'A0002', N'Maria del Rosario', N'Zapata    ')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (3, N'A0003', N'Diego', N'Carrera   ')
SET IDENTITY_INSERT [dbo].[Anfitriones] OFF
/****** Object:  Table [dbo].[Prioridades]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Prioridades](
	[IdPrioridad] [int] IDENTITY(1,1) NOT NULL,
	[NombrePrioridad] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Prioridades] PRIMARY KEY CLUSTERED 
(
	[IdPrioridad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Prioridades] ON
INSERT [dbo].[Prioridades] ([IdPrioridad], [NombrePrioridad]) VALUES (1, N'Baja')
INSERT [dbo].[Prioridades] ([IdPrioridad], [NombrePrioridad]) VALUES (2, N'Moderada')
INSERT [dbo].[Prioridades] ([IdPrioridad], [NombrePrioridad]) VALUES (3, N'Alta')
SET IDENTITY_INSERT [dbo].[Prioridades] OFF
/****** Object:  Table [dbo].[Pedidos]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[IdPedido] [int] NOT NULL,
	[IdMesa] [int] NOT NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[IdPedido] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mesas]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mesas](
	[IdMesa] [int] IDENTITY(1,1) NOT NULL,
	[Cliente] [varchar](50) NULL,
	[IdAnfitrion] [int] NULL,
	[Cantidad] [int] NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Mesas] PRIMARY KEY CLUSTERED 
(
	[IdMesa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Mesas] ON
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (1, N'', -2147483648, -2147483648, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (2, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (3, N'', -2147483648, -2147483648, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (4, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (5, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (6, N'', -2147483648, -2147483648, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (7, N'', -2147483648, -2147483648, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (8, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (9, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (10, N'', -2147483648, -2147483648, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (11, N'', -2147483648, -2147483648, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (12, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (13, N'', -2147483648, -2147483648, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (14, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (15, NULL, NULL, NULL, 0)
INSERT [dbo].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (16, N'', -2147483648, -2147483648, 0)
SET IDENTITY_INSERT [dbo].[Mesas] OFF
/****** Object:  Table [dbo].[EstadosSolicitud]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EstadosSolicitud](
	[IdEstadoSolicitud] [int] IDENTITY(1,1) NOT NULL,
	[NombreEstadoSolicitud] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EstadosSolicitud] PRIMARY KEY CLUSTERED 
(
	[IdEstadoSolicitud] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[EstadosSolicitud] ON
INSERT [dbo].[EstadosSolicitud] ([IdEstadoSolicitud], [NombreEstadoSolicitud]) VALUES (1, N'Aprobado')
INSERT [dbo].[EstadosSolicitud] ([IdEstadoSolicitud], [NombreEstadoSolicitud]) VALUES (2, N'Pendiente')
SET IDENTITY_INSERT [dbo].[EstadosSolicitud] OFF
/****** Object:  Table [dbo].[Insumos]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Insumos](
	[IdInsumo] [int] IDENTITY(1,1) NOT NULL,
	[NombreInsumo] [varchar](50) NOT NULL,
	[IdUnidadMedida] [int] NOT NULL,
	[StockNormal] [int] NOT NULL,
	[CantidadRequerida] [int] NULL,
	[StockActual] [int] NULL,
	[StockMinimo] [int] NOT NULL,
	[IdPrioridad] [int] NOT NULL,
	[CantidadSolicitada] [int] NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Insumos] PRIMARY KEY CLUSTERED 
(
	[IdInsumo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Insumos] ON
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], [IdUnidadMedida], [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (1, N'Limon', 1, 10, 8, 23, 4, 3, 10, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], [IdUnidadMedida], [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (2, N'Tallarin', 1, 15, 10, 30, 5, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], [IdUnidadMedida], [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (3, N'Agua', 1, 5, 2, 5, 2, 3, 0, 0)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], [IdUnidadMedida], [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (4, N'Harina', 1, 10, 2, 10, 2, 2, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], [IdUnidadMedida], [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (5, N'Gaseosa', 1, 20, 20, 20, 20, 2, 0, 0)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], [IdUnidadMedida], [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (6, N'arroz', 1, 100, 5, 100, 10, 2, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], [IdUnidadMedida], [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (7, N'menestra', 1, 50, 4, 60, 10, 1, 0, 1)
SET IDENTITY_INSERT [dbo].[Insumos] OFF
/****** Object:  Table [dbo].[Recetas]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Recetas](
	[IdReceta] [int] IDENTITY(1,1) NOT NULL,
	[NombreReceta] [varchar](50) NOT NULL,
	[IdTipoReceta] [int] NOT NULL,
	[Costo] [numeric](18, 0) NOT NULL,
	[Precio] [numeric](18, 0) NOT NULL,
	[TiempoPreparacion] [int] NOT NULL,
	[ValorNutricional] [int] NOT NULL,
	[ModoPreparacion] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Recetas] PRIMARY KEY CLUSTERED 
(
	[IdReceta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Recetas] ON
INSERT [dbo].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (2, N'Tallarines', 2, CAST(10 AS Numeric(18, 0)), CAST(12 AS Numeric(18, 0)), 20, 1000, N'Modo preparación: Cocinar a fuego lento')
INSERT [dbo].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (3, N'Limonada', 1, CAST(2 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), 5, 200, N'Modo preparación: Echar bastante agua')
INSERT [dbo].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (4, N'Pizza', 2, CAST(30 AS Numeric(18, 0)), CAST(45 AS Numeric(18, 0)), 20, 500, N'Modo preparación: Introducir al horno')
INSERT [dbo].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (5, N'Gaseosa', 1, CAST(2 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), 1, 500, N'Modo preparación: Sacar de la refrigeradora')
SET IDENTITY_INSERT [dbo].[Recetas] OFF
/****** Object:  Table [dbo].[Solicitudes]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitudes](
	[IdSolicitud] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[IdEstadoSolicitud] [int] NOT NULL,
	[IdInsumo] [int] NOT NULL,
	[CantidadSolicitada] [int] NOT NULL,
	[CantidadRecibida] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Solicitudes] PRIMARY KEY CLUSTERED 
(
	[IdSolicitud] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Solicitudes] ON
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (1, CAST(0x18370B00 AS Date), 1, 1, 10, 5, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (2, CAST(0x18370B00 AS Date), 1, 2, 10, 5, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (3, CAST(0x18370B00 AS Date), 1, 1, 10, 1, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (4, CAST(0x18370B00 AS Date), 1, 1, 5, 2, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (5, CAST(0x18370B00 AS Date), 1, 1, 3, 3, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (6, CAST(0x18370B00 AS Date), 1, 2, 2, 5, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (7, CAST(0x1A370B00 AS Date), 1, 1, 1, 4, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (8, CAST(0x1A370B00 AS Date), 1, 2, 5, 5, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (9, CAST(0x1A370B00 AS Date), 2, 5, 5, 0, 0)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (10, CAST(0x1A370B00 AS Date), 1, 4, 3, 8, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (11, CAST(0x1A370B00 AS Date), 1, 3, 3, 3, 1)
INSERT [dbo].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (12, CAST(0x1B370B00 AS Date), 1, 7, 10, 10, 1)
SET IDENTITY_INSERT [dbo].[Solicitudes] OFF
/****** Object:  Table [dbo].[InsumosPorReceta]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InsumosPorReceta](
	[IdReceta] [int] NOT NULL,
	[IdInsumo] [int] NOT NULL,
	[Cantidad] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_InsumosPorReceta] PRIMARY KEY CLUSTERED 
(
	[IdReceta] ASC,
	[IdInsumo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (2, 2, CAST(1.00 AS Numeric(18, 2)))
INSERT [dbo].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (2, 3, CAST(1.50 AS Numeric(18, 2)))
INSERT [dbo].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (3, 1, CAST(0.50 AS Numeric(18, 2)))
INSERT [dbo].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (3, 3, CAST(2.00 AS Numeric(18, 2)))
INSERT [dbo].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (4, 3, CAST(1.00 AS Numeric(18, 2)))
INSERT [dbo].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (4, 4, CAST(5.00 AS Numeric(18, 2)))
INSERT [dbo].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (5, 5, CAST(1.00 AS Numeric(18, 2)))
/****** Object:  Table [dbo].[Carta]    Script Date: 05/16/2013 15:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carta](
	[IdCarta] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[IdReceta] [int] NOT NULL,
	[IsOferta] [bit] NOT NULL,
	[PrecioOferta] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Carta] PRIMARY KEY CLUSTERED 
(
	[IdCarta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_Carta_Recetas]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[Carta]  WITH CHECK ADD  CONSTRAINT [FK_Carta_Recetas] FOREIGN KEY([IdReceta])
REFERENCES [dbo].[Recetas] ([IdReceta])
GO
ALTER TABLE [dbo].[Carta] CHECK CONSTRAINT [FK_Carta_Recetas]
GO
/****** Object:  ForeignKey [FK_Insumos_Prioridades]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[Insumos]  WITH CHECK ADD  CONSTRAINT [FK_Insumos_Prioridades] FOREIGN KEY([IdPrioridad])
REFERENCES [dbo].[Prioridades] ([IdPrioridad])
GO
ALTER TABLE [dbo].[Insumos] CHECK CONSTRAINT [FK_Insumos_Prioridades]
GO
/****** Object:  ForeignKey [FK_Insumos_UnidadesMedida]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[Insumos]  WITH CHECK ADD  CONSTRAINT [FK_Insumos_UnidadesMedida] FOREIGN KEY([IdUnidadMedida])
REFERENCES [dbo].[UnidadesMedida] ([IdUnidadMedida])
GO
ALTER TABLE [dbo].[Insumos] CHECK CONSTRAINT [FK_Insumos_UnidadesMedida]
GO
/****** Object:  ForeignKey [FK_InsumosPorReceta_Insumos]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[InsumosPorReceta]  WITH CHECK ADD  CONSTRAINT [FK_InsumosPorReceta_Insumos] FOREIGN KEY([IdInsumo])
REFERENCES [dbo].[Insumos] ([IdInsumo])
GO
ALTER TABLE [dbo].[InsumosPorReceta] CHECK CONSTRAINT [FK_InsumosPorReceta_Insumos]
GO
/****** Object:  ForeignKey [FK_InsumosPorReceta_Recetas]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[InsumosPorReceta]  WITH CHECK ADD  CONSTRAINT [FK_InsumosPorReceta_Recetas] FOREIGN KEY([IdReceta])
REFERENCES [dbo].[Recetas] ([IdReceta])
GO
ALTER TABLE [dbo].[InsumosPorReceta] CHECK CONSTRAINT [FK_InsumosPorReceta_Recetas]
GO
/****** Object:  ForeignKey [FK_Recetas_TiposReceta]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[Recetas]  WITH CHECK ADD  CONSTRAINT [FK_Recetas_TiposReceta] FOREIGN KEY([IdTipoReceta])
REFERENCES [dbo].[TiposReceta] ([IdTipoReceta])
GO
ALTER TABLE [dbo].[Recetas] CHECK CONSTRAINT [FK_Recetas_TiposReceta]
GO
/****** Object:  ForeignKey [FK_Solicitudes_EstadosSolicitud]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[Solicitudes]  WITH CHECK ADD  CONSTRAINT [FK_Solicitudes_EstadosSolicitud] FOREIGN KEY([IdEstadoSolicitud])
REFERENCES [dbo].[EstadosSolicitud] ([IdEstadoSolicitud])
GO
ALTER TABLE [dbo].[Solicitudes] CHECK CONSTRAINT [FK_Solicitudes_EstadosSolicitud]
GO
/****** Object:  ForeignKey [FK_Solicitudes_Insumos]    Script Date: 05/16/2013 15:52:42 ******/
ALTER TABLE [dbo].[Solicitudes]  WITH CHECK ADD  CONSTRAINT [FK_Solicitudes_Insumos] FOREIGN KEY([IdInsumo])
REFERENCES [dbo].[Insumos] ([IdInsumo])
GO
ALTER TABLE [dbo].[Solicitudes] CHECK CONSTRAINT [FK_Solicitudes_Insumos]
GO
