USE [CHILIS]
GO
/*----------------------------------------------------------------------------------------------------------------------------------*/
/*-LIMPIAR--------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------------------*/
SET ANSI_PADDING OFF
GO
DELETE FROM [DBO].[InsumosPorReceta]
DELETE FROM [DBO].[TB_RESERVA]
DELETE FROM [DBO].[TB_PRODUCTO]
DELETE FROM [DBO].[Mesas]
DELETE FROM [DBO].[TB_MESA]
DELETE FROM [DBO].[Solicitudes]
DELETE FROM [DBO].[Insumos]
DELETE FROM [DBO].[Recetas] 
DELETE FROM [DBO].[TiposReceta]
DELETE FROM [DBO].[Anfitriones] 
DELETE FROM [DBO].[Prioridades] 
DELETE FROM [DBO].[EstadosSolicitud]
DELETE FROM [DBO].[TB_CLIENTE]
DELETE FROM [DBO].[TB_UNIDADMEDIDA]
DELETE FROM [DBO].[TB_LOCAL] 
DELETE FROM [DBO].[TB_TIPO_DOCUMENTO]
DELETE FROM [DBO].[TB_CLASIFICACION_CLIENTE]
/*----------------------------------------------------------------------------------------------------------------------------------*/
/*-INSERT---------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------------------*/

SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [DBO].[TIPOSRECETA] ON
INSERT INTO [DBO].[TIPOSRECETA] ([IdTipoReceta], [NombreTipoReceta]) VALUES (1, N'Bebida')
INSERT INTO [DBO].[TIPOSRECETA] ([IdTipoReceta], [NombreTipoReceta]) VALUES (2, N'Plato')
SET IDENTITY_INSERT [DBO].[TIPOSRECETA] OFF
SET IDENTITY_INSERT [DBO].[PRIORIDADES] ON
INSERT INTO [DBO].[PRIORIDADES] ([IdPrioridad], [NombrePrioridad]) VALUES (1, N'Baja')
INSERT INTO [DBO].[PRIORIDADES] ([IdPrioridad], [NombrePrioridad]) VALUES (2, N'Moderada')
INSERT INTO [DBO].[PRIORIDADES] ([IdPrioridad], [NombrePrioridad]) VALUES (3, N'Alta')
SET IDENTITY_INSERT [DBO].[PRIORIDADES] OFF
SET IDENTITY_INSERT [DBO].[TB_UNIDADMEDIDA] ON
INSERT INTO [DBO].[TB_UNIDADMEDIDA] ([codigo],[desMed]) VALUES(1,N'LITROS')
INSERT INTO [DBO].[TB_UNIDADMEDIDA] ([codigo],[desMed]) VALUES(2,N'KG')
INSERT INTO [DBO].[TB_UNIDADMEDIDA] ([codigo],[desMed]) VALUES(3,N'UNIDAD')
SET IDENTITY_INSERT [DBO].[TB_UNIDADMEDIDA] OFF
SET IDENTITY_INSERT [DBO].[EstadosSolicitud] ON
INSERT INTO [DBO].[EstadosSolicitud] ([IdEstadoSolicitud], [NombreEstadoSolicitud]) VALUES (1, N'Aprobado')
INSERT INTO [DBO].[EstadosSolicitud] ([IdEstadoSolicitud], [NombreEstadoSolicitud]) VALUES (2, N'Pendiente')
SET IDENTITY_INSERT [DBO].[EstadosSolicitud] OFF
SET IDENTITY_INSERT [DBO].TB_CLASIFICACION_CLIENTE ON
INSERT INTO [DBO].TB_CLASIFICACION_CLIENTE ([IN_CODIGO_CLASIFICACION],[VC_NOMBRE]) VALUES (1, N'NATURAL')
INSERT INTO [DBO].TB_CLASIFICACION_CLIENTE ([IN_CODIGO_CLASIFICACION],[VC_NOMBRE]) VALUES (2, N'JURIDICA')
SET IDENTITY_INSERT [DBO].TB_CLASIFICACION_CLIENTE OFF
SET IDENTITY_INSERT [DBO].[TB_TIPO_DOCUMENTO] ON
INSERT INTO [DBO].[TB_TIPO_DOCUMENTO] ([IN_CODIGO_TIPO_DOCUMENTO],[VC_NOMBRE],[VC_ACRONIMO]) VALUES (1, N'DNI', N'DNI')
INSERT INTO [DBO].[TB_TIPO_DOCUMENTO] ([IN_CODIGO_TIPO_DOCUMENTO],[VC_NOMBRE],[VC_ACRONIMO]) VALUES (2, N'OTROS', N'OTRO')
SET IDENTITY_INSERT [DBO].[TB_TIPO_DOCUMENTO] OFF
SET IDENTITY_INSERT [DBO].[TB_LOCAL] ON
INSERT INTO TB_LOCAL (IN_CODIGO_LOCAL,VC_NOMBRE,VC_DIRECCION,VC_TELEFONO,IN_CAPACIDAD) VALUES(1,'LOCAL CHILIS - UPC','PRIMAVERA','666-66666',223)
SET IDENTITY_INSERT [DBO].[TB_LOCAL] OFF
SET IDENTITY_INSERT [DBO].[TB_CLIENTE] ON
INSERT INTO [DBO].[TB_CLIENTE] ([IN_CODIGO_CLIENTE],[VC_NOMBRES],[VC_APELLIDO_PATERNO],[VC_APELLIDO_MATERNO],[VC_RAZON_SOCIAL],[VC_NUMERO_DOCUMENTO],[DT_FECHA_NACIMIENTO],[IN_CODIGO_TIPO_DOCUMENTO],[IN_CODIGO_CLASIFICACION],[VC_EMAIL],[CH_SEXO],[VC_TELEFONO_PRINCIPAL],[VC_CONTACTO],[CH_ESTADO_CLIENTE],[CH_TIPO_CLIENTE]) VALUES (1,'ROSMERY','GALARZA','VILLAREAL','GALARZA VILLAREAL ROSMERY','19196423','19870821',1,1,'ROSMERY.GALARZA@GMAIL.COM','F','478-8569','..','A','F')
INSERT INTO [DBO].[TB_CLIENTE] ([IN_CODIGO_CLIENTE],[VC_NOMBRES],[VC_APELLIDO_PATERNO],[VC_APELLIDO_MATERNO],[VC_RAZON_SOCIAL],[VC_NUMERO_DOCUMENTO],[DT_FECHA_NACIMIENTO],[IN_CODIGO_TIPO_DOCUMENTO],[IN_CODIGO_CLASIFICACION],[VC_EMAIL],[CH_SEXO],[VC_TELEFONO_PRINCIPAL],[VC_CONTACTO],[CH_ESTADO_CLIENTE],[CH_TIPO_CLIENTE]) VALUES (2,'ROXANA','MORALES','SOLORZANO','UPC - EPE','10124523412','19900101',2,2,'ATENCIONUPC@UPC.EDU.PE','','572-8569','..','A','F')
SET IDENTITY_INSERT [DBO].[TB_CLIENTE] OFF
SET IDENTITY_INSERT [DBO].[RECETAS] ON
INSERT INTO [DBO].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (2, N'Tallarines', 2, CAST(10 AS Numeric(18, 0)), CAST(12 AS Numeric(18, 0)), 20, 1000, N'Modo preparación: Cocinar a fuego lento')
INSERT INTO [DBO].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (3, N'Limonada', 1, CAST(2 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), 5, 200, N'Modo preparación: Echar bastante agua')
INSERT INTO [DBO].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (4, N'Pizza', 2, CAST(30 AS Numeric(18, 0)), CAST(45 AS Numeric(18, 0)), 20, 500, N'Modo preparación: Introducir al horno')
INSERT INTO [DBO].[Recetas] ([IdReceta], [NombreReceta], [IdTipoReceta], [Costo], [Precio], [TiempoPreparacion], [ValorNutricional], [ModoPreparacion]) VALUES (5, N'Gaseosa', 1, CAST(2 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), 1, 500, N'Modo preparación: Sacar de la refrigeradora')
SET IDENTITY_INSERT [DBO].[RECETAS] OFF
SET IDENTITY_INSERT [DBO].[ANFITRIONES] ON
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (1, N'A0001', N'Aracely',  N'Sandoval')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (2, N'A0002', N'Veronica', N'Zapata')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (3, N'A0003', N'Nathaly',  N'Carrera')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (4, N'A0004', N'Elizabeth',  N'Ramos')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (5, N'A0005', N'Monica',  N'Vargas')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (6, N'A0006', N'Sussy',  N'Garcia')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (7, N'A0007', N'Cecilia',  N'Zegarra')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (8, N'A0008', N'Rosa',  N'Carreño')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (9, N'A0009', N'Yesica',  N'Mulano')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (10, N'A0010', N'Carmen',  N'Villegas')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (11, N'A0011', N'Roxana',  N'Loayza')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (12, N'A0012', N'Angelica',  N'Barzola')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (13, N'A0013', N'Tania',  N'Delgado')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (14, N'A0014', N'Isabel',  N'Rios')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (15, N'A0015', N'Mariela',  N'Guevara')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (16, N'A0016', N'Pedro',  N'Rodriguez')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (17, N'A0017', N'Mario',  N'Solorzano')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (18, N'A0018', N'Alberto',  N'Tello')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (19, N'A0019', N'Cesar',  N'Rojas')
INSERT INTO [DBO].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (20, N'A0020', N'Raul',  N'Pariona')
SET IDENTITY_INSERT [DBO].[ANFITRIONES] OFF
SET IDENTITY_INSERT [DBO].[TB_MESA] ON
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(1,1,4,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(2,2,4,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(3,3,4,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(4,4,41,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(5,5,6,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(6,6,6,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(7,7,8,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(8,8,8,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(9,9,10,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(10,10,10,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(11,11,12,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(12,12,12,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(13,13,14,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(14,14,14,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(15,15,16,'A',1)
INSERT INTO [DBO].[TB_MESA] ([IN_CODIGO_MESA],[VC_NUMERO],[IN_CAPACIDAD],[CH_ESTADO],[IN_CODIGO_LOCAL]) VALUES(16,16,24,'A',1)
SET IDENTITY_INSERT [DBO].[TB_MESA] OFF
SET IDENTITY_INSERT [DBO].[Mesas] ON
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (1, N'', -2147483648, -2147483648, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (2, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (3, N'', -2147483648, -2147483648, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (4, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (5, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (6, N'', -2147483648, -2147483648, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (7, N'', -2147483648, -2147483648, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (8, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (9, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (10, N'', -2147483648, -2147483648, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (11, N'', -2147483648, -2147483648, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (12, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (13, N'', -2147483648, -2147483648, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (14, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (15, NULL, NULL, NULL, 0)
INSERT INTO [DBO].[Mesas] ([IdMesa], [Cliente], [IdAnfitrion], [Cantidad], [Estado]) VALUES (16, N'', -2147483648, -2147483648, 0)
SET IDENTITY_INSERT [DBO].[Mesas] OFF
SET IDENTITY_INSERT [DBO].[Insumos] ON
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (1, N'Limon', 1, 10, 8, 23, 4, 3, 10, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (2, N'Fideo', 1, 15, 10, 30, 5, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (3, N'Agua', 1, 5, 2, 5, 2, 3, 0, 0)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (4, N'Harina', 1, 10, 2, 10, 2, 2, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (5, N'Gaseosa', 1, 20, 20, 20, 20, 2, 0, 0)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (6, N'Arroz', 1, 100, 5, 100, 10, 2, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (7, N'Frejol', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (8, N'Aceite Vegetal', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (9, N'Aceite Oliva', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (10, N'Manteca', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (11, N'Azucar', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (12, N'Sal', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (13, N'Pimienta', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (14, N'Comino', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (15, N'Huevos', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (16, N'Aceituna', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (17, N'Carne Res', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (18, N'Carne de Pollo', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT INTO [DBO].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (19, N'Carne de Cerdo', 1, 50, 4, 60, 10, 1, 0, 1)
SET IDENTITY_INSERT [DBO].[Insumos] OFF
SET IDENTITY_INSERT [DBO].[Solicitudes] ON
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (1, CAST(0x18370B00 AS Date), 1, 1, 10, 5, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (2, CAST(0x18370B00 AS Date), 1, 2, 10, 5, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (3, CAST(0x18370B00 AS Date), 1, 1, 10, 1, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (4, CAST(0x18370B00 AS Date), 1, 1, 5, 2, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (5, CAST(0x18370B00 AS Date), 1, 1, 3, 3, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (6, CAST(0x18370B00 AS Date), 1, 2, 2, 5, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (7, CAST(0x1A370B00 AS Date), 1, 1, 1, 4, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (8, CAST(0x1A370B00 AS Date), 1, 2, 5, 5, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (9, CAST(0x1A370B00 AS Date), 2, 5, 5, 0, 0)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (10, CAST(0x1A370B00 AS Date), 1, 4, 3, 8, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (11, CAST(0x1A370B00 AS Date), 1, 3, 3, 3, 1)
INSERT INTO [DBO].[Solicitudes] ([IdSolicitud], [Fecha], [IdEstadoSolicitud], [IdInsumo], [CantidadSolicitada], [CantidadRecibida], [Estado]) VALUES (12, CAST(0x1B370B00 AS Date), 1, 7, 10, 10, 1)
SET IDENTITY_INSERT [DBO].[Solicitudes] OFF
SET IDENTITY_INSERT [DBO].TB_RESERVA ON
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (1,'20130517','14:30','16:30',9,'..','A',9,1)
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (2,'20130517','14:30','16:30',15,'..','A',15,2)
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (3,'20130518','15:30','18:30',7,'..','A',7,1)
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (4,'20130518','15:30','18:30',12,'..','A',12,2)
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (5,'20130519','13:30','15:30',5,'..','A',5,1)
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (6,'20130519','13:30','15:30',8,'..','A',8,2)
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (7,'20130520','16:30','19:30',14,'..','A',13,1)
INSERT INTO [DBO].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (8,'20130520','16:30','19:30',23,'..','A',16,2)
SET IDENTITY_INSERT [DBO].TB_RESERVA OFF
INSERT INTO [DBO].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (2, 2, CAST(1.00 AS Numeric(18, 2)))
INSERT INTO [DBO].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (2, 3, CAST(1.50 AS Numeric(18, 2)))
INSERT INTO [DBO].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (3, 1, CAST(0.50 AS Numeric(18, 2)))
INSERT INTO [DBO].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (3, 3, CAST(2.00 AS Numeric(18, 2)))
INSERT INTO [DBO].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (4, 3, CAST(1.00 AS Numeric(18, 2)))
INSERT INTO [DBO].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (4, 4, CAST(5.00 AS Numeric(18, 2)))
INSERT INTO [DBO].[InsumosPorReceta] ([IdReceta], [IdInsumo], [Cantidad]) VALUES (5, 5, CAST(1.00 AS Numeric(18, 2)))









