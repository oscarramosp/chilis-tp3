CREATE DATABASE CHILIS
GO

USE CHILIS
GO
--============== INICIO  MODULO CLIENTES Y RESERVAS =============================================================================

CREATE TABLE TB_CLIENTE (
	IN_CODIGO_CLIENTE			INT IDENTITY (1,1) NOT NULL,
	VC_NOMBRES					VARCHAR(128),
	VC_APELLIDO_PATERNO			VARCHAR(128),
	VC_APELLIDO_MATERNO			VARCHAR(128),
	VC_RAZON_SOCIAL				VARCHAR(256),
	VC_NUMERO_DOCUMENTO			VARCHAR(64),
	DT_FECHA_NACIMIENTO			DATETIME,
	IN_CODIGO_TIPO_DOCUMENTO	INT NOT NULL,
	IN_CODIGO_CLASIFICACION		INT,
	VC_EMAIL					VARCHAR(64),
	CH_SEXO						CHAR(1),
	VC_TELEFONO_PRINCIPAL		VARCHAR(32),
	VC_CONTACTO					VARCHAR(256),
	CH_ESTADO_CLIENTE			CHAR(1),
	CH_TIPO_CLIENTE				CHAR(1)
)
GO

ALTER TABLE TB_CLIENTE
ADD CONSTRAINT PK_TB_CLIENTE_ID PRIMARY KEY(IN_CODIGO_CLIENTE)
GO

CREATE TABLE TB_TIPO_DOCUMENTO (
	IN_CODIGO_TIPO_DOCUMENTO	INT IDENTITY (1,1)  NOT NULL,
	VC_NOMBRE					VARCHAR(128),
	VC_ACRONIMO					VARCHAR(8)
)
GO

ALTER TABLE TB_TIPO_DOCUMENTO
ADD CONSTRAINT PK_TB_TIPO_DOCUMENTO_ID PRIMARY KEY(IN_CODIGO_TIPO_DOCUMENTO)
GO


ALTER TABLE TB_CLIENTE
ADD CONSTRAINT FK_TB_CLIENTE_TB_TIPO_DOCUMENTO FOREIGN KEY(IN_CODIGO_TIPO_DOCUMENTO)REFERENCES TB_TIPO_DOCUMENTO(IN_CODIGO_TIPO_DOCUMENTO)
GO

CREATE TABLE TB_DIRECCION_CLIENTE (
	IN_CODIGO_DIRECCION			INT IDENTITY (1,1)  NOT NULL,
	IN_CODIGO_CLIENTE			INT NOT NULL,
	VC_DIRECCION				VARCHAR(1024),
	VC_REFERENCIA				VARCHAR(1024),
	VC_TELEFONO					VARCHAR(32),
	CH_TIPO_DIRECCION			CHAR(1)
)
GO

ALTER TABLE TB_DIRECCION_CLIENTE
ADD CONSTRAINT PK_TB_DIRECCION_CLIENTE_ID PRIMARY KEY(IN_CODIGO_DIRECCION,IN_CODIGO_CLIENTE)
GO

ALTER TABLE TB_DIRECCION_CLIENTE
ADD CONSTRAINT FK_TB_DIRECCION_CLIENTE_TB_CLIENTE FOREIGN KEY(IN_CODIGO_CLIENTE)REFERENCES TB_CLIENTE(IN_CODIGO_CLIENTE)
GO

CREATE TABLE TB_CLASIFICACION_CLIENTE (
	IN_CODIGO_CLASIFICACION		INT IDENTITY (1,1)  NOT NULL,
	VC_NOMBRE					VARCHAR(128),
)
GO

ALTER TABLE TB_CLASIFICACION_CLIENTE
ADD CONSTRAINT PK_TB_CLASIFICACION_CLIENTE_ID PRIMARY KEY(IN_CODIGO_CLASIFICACION)
GO

ALTER TABLE TB_CLIENTE
ADD CONSTRAINT FK_TB_CLIENTE_TB_CLASIFICACION_CLIENTE FOREIGN KEY(IN_CODIGO_CLASIFICACION)REFERENCES TB_CLASIFICACION_CLIENTE(IN_CODIGO_CLASIFICACION)
GO

CREATE TABLE TB_PARAMETRO_CLASIFICACION (
	IN_CODIGO_PARAMETRO			INT IDENTITY (1,1)  NOT NULL,
	VC_NOMBRE					VARCHAR(128),
)
GO

ALTER TABLE TB_PARAMETRO_CLASIFICACION
ADD CONSTRAINT PK_TB_PARAMETRO_CLASIFICACION_ID PRIMARY KEY(IN_CODIGO_PARAMETRO)
GO

CREATE TABLE TB_VALOR_PARAMETRO_CLASIFICACION (
	IN_CODIGO_PARAMETRO			INT NOT NULL,
	IN_CODIGO_CLASIFICACION		INT NOT NULL,
	IN_VALOR					INT NOT NULL,
)
GO

ALTER TABLE TB_VALOR_PARAMETRO_CLASIFICACION
ADD CONSTRAINT PK_TB_VALOR_PARAMETRO_CLASIFICACION_ID PRIMARY KEY(IN_CODIGO_PARAMETRO,IN_CODIGO_CLASIFICACION)
GO

ALTER TABLE TB_VALOR_PARAMETRO_CLASIFICACION
ADD CONSTRAINT FK_TB_VALOR_PARAMETRO_CLASIFICACION_TB_CLASIFICACION_CLIENTE FOREIGN KEY(IN_CODIGO_CLASIFICACION)REFERENCES TB_CLASIFICACION_CLIENTE(IN_CODIGO_CLASIFICACION)
GO

ALTER TABLE TB_VALOR_PARAMETRO_CLASIFICACION
ADD CONSTRAINT FK_TB_VALOR_PARAMETRO_CLASIFICACION_TB_PARAMETRO_CLASIFICACION FOREIGN KEY(IN_CODIGO_PARAMETRO)REFERENCES TB_PARAMETRO_CLASIFICACION(IN_CODIGO_PARAMETRO)
GO

CREATE TABLE TB_RECLAMO (
	IN_CODIGO_RECLAMO			INT IDENTITY (1,1) NOT NULL,
	IN_CODIGO_CLIENTE			INT NOT NULL,	
	DT_FECHA_CREACION			DATETIME NOT NULL,
	DT_FECHA_CIERRE				DATETIME,
	VC_DETALLE					VARCHAR(2048),
	CH_ESTADO					CHAR(1)
)
GO

ALTER TABLE TB_RECLAMO
ADD CONSTRAINT FK_TB_RECLAMO_TB_CLIENTE FOREIGN KEY(IN_CODIGO_CLIENTE)REFERENCES TB_CLIENTE(IN_CODIGO_CLIENTE)
GO

-- 20130514: RESERVAS

CREATE TABLE TB_LOCAL (
	IN_CODIGO_LOCAL				INT IDENTITY (1,1) NOT NULL,
	VC_NOMBRE					VARCHAR(128),
	VC_DIRECCION				VARCHAR(256),
	VC_TELEFONO					VARCHAR(32),
	IN_CAPACIDAD				INT NOT NULL
)

ALTER TABLE TB_LOCAL
ADD CONSTRAINT PK_TB_LOCAL_ID PRIMARY KEY(IN_CODIGO_LOCAL)
GO

CREATE TABLE TB_MESA (
	IN_CODIGO_MESA				INT IDENTITY (1,1) NOT NULL,
	VC_NUMERO					VARCHAR(16),
	IN_CAPACIDAD				INT,
	CH_ESTADO					CHAR(1),
	IN_CODIGO_LOCAL				INT
)

ALTER TABLE TB_MESA
ADD CONSTRAINT PK_TB_MESA_ID PRIMARY KEY(IN_CODIGO_MESA)
GO

ALTER TABLE TB_MESA
ADD CONSTRAINT FK_TB_MESA_TB_LOCAL FOREIGN KEY(IN_CODIGO_LOCAL)REFERENCES TB_LOCAL(IN_CODIGO_LOCAL)
GO

CREATE TABLE TB_FECHA_ESPECIAL (
	IN_CODIGO_FECHA_ESP			INT IDENTITY(1,1) NOT NULL,
	DT_FECHA					DATETIME NOT NULL,
	VC_MOTIVO					VARCHAR(256)
)

ALTER TABLE TB_FECHA_ESPECIAL
ADD CONSTRAINT PK_TB_FECHA_ESPECIAL PRIMARY KEY(IN_CODIGO_FECHA_ESP)
GO

CREATE TABLE TB_RESERVA (
	IN_CODIGO_RESERVA			INT IDENTITY(1,1) NOT NULL,
	DT_FECHA_RESERVA			DATETIME,			
	VC_HORA_INICIO				VARCHAR(8),
	VC_HORA_FIN					VARCHAR(8),
	IN_CANTIDAD_PERSONAS		INT,
	VC_OBSERVACION				VARCHAR(256),
	CH_ESTADO					CHAR(1),
	IN_CODIGO_MESA				INT NOT NULL,
	IN_CODIGO_CLIENTE			INT NOT NULL
)

ALTER TABLE TB_RESERVA
ADD CONSTRAINT PK_TB_RESERVA PRIMARY KEY(IN_CODIGO_RESERVA)
GO

ALTER TABLE TB_RESERVA
ADD CONSTRAINT FK_TB_RESERVA_TB_MESA FOREIGN KEY(IN_CODIGO_MESA)REFERENCES TB_MESA(IN_CODIGO_MESA)
GO

ALTER TABLE TB_RESERVA
ADD CONSTRAINT FK_TB_RESERVA_TB_CLIENTE FOREIGN KEY(IN_CODIGO_CLIENTE)REFERENCES TB_CLIENTE(IN_CODIGO_CLIENTE)
GO

CREATE PROCEDURE SP_ACTUALIZAR_ESTADO_CLIENTE
@IN_CODIGO_CLIENTE INT,
@CH_ESTADO_CLIENTE CHAR(1)
AS
BEGIN

UPDATE	TB_CLIENTE
SET		CH_ESTADO_CLIENTE = @CH_ESTADO_CLIENTE
WHERE	IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

GO

CREATE PROCEDURE SP_ELIMINAR_CLIENTE
@IN_CODIGO_CLIENTE INT
AS
BEGIN

DELETE FROM TB_DIRECCION_CLIENTE
WHERE	IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

DELETE FROM TB_CLIENTE
WHERE	IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

GO

CREATE PROCEDURE SP_ELIMINAR_DIRECCIONES_CLIENTE
@IN_CODIGO_CLIENTE INT
AS

BEGIN

	DELETE FROM TB_DIRECCION_CLIENTE
	WHERE IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

GO

CREATE PROCEDURE SP_ELIMINAR_FECHA_ESPECIAL
@IN_CODIGO_FECHA_ESP INT
AS
BEGIN

DELETE FROM TB_FECHA_ESPECIAL
WHERE	IN_CODIGO_FECHA_ESP = @IN_CODIGO_FECHA_ESP

END

GO

CREATE PROCEDURE SP_ELIMINAR_RESERVA
@IN_CODIGO_RESERVA INT
AS
BEGIN

DELETE FROM TB_RESERVA
WHERE	IN_CODIGO_RESERVA = @IN_CODIGO_RESERVA

END

GO

CREATE PROCEDURE SP_GRABAR_CLIENTE
@IN_CODIGO_CLIENTE INT OUT,
@VC_NOMBRES VARCHAR(128),
@VC_APELLIDO_PATERNO VARCHAR(128),
@VC_APELLIDO_MATERNO VARCHAR(128),
@VC_RAZON_SOCIAL VARCHAR(256),
@VC_NUMERO_DOCUMENTO VARCHAR(64),
@DT_FECHA_NACIMIENTO DATETIME,
@IN_CODIGO_TIPO_DOCUMENTO INT,
@IN_CODIGO_CLASIFICACION INT,
@VC_EMAIL VARCHAR(64),
@CH_SEXO CHAR(1),
@VC_TELEFONO_PRINCIPAL VARCHAR(32),
@VC_CONTACTO VARCHAR(256),
@CH_ESTADO_CLIENTE CHAR(1),
@CH_TIPO_CLIENTE CHAR(1)
AS

BEGIN

--INSERT
IF (@IN_CODIGO_CLIENTE IS NULL OR @IN_CODIGO_CLIENTE = 0)
BEGIN
	INSERT INTO TB_CLIENTE (VC_NOMBRES,
						VC_APELLIDO_PATERNO,
						VC_APELLIDO_MATERNO,
						VC_RAZON_SOCIAL,
						VC_NUMERO_DOCUMENTO,
						DT_FECHA_NACIMIENTO,
						IN_CODIGO_TIPO_DOCUMENTO,
						IN_CODIGO_CLASIFICACION,
						VC_EMAIL,
						CH_SEXO,
						VC_TELEFONO_PRINCIPAL,
						VC_CONTACTO,
						CH_ESTADO_CLIENTE,
						CH_TIPO_CLIENTE)
	VALUES (@VC_NOMBRES,
						@VC_APELLIDO_PATERNO,
						@VC_APELLIDO_MATERNO,
						@VC_RAZON_SOCIAL,
						@VC_NUMERO_DOCUMENTO,
						@DT_FECHA_NACIMIENTO,
						@IN_CODIGO_TIPO_DOCUMENTO,
						@IN_CODIGO_CLASIFICACION,
						@VC_EMAIL,
						@CH_SEXO,
						@VC_TELEFONO_PRINCIPAL,
						@VC_CONTACTO,
						@CH_ESTADO_CLIENTE,
						@CH_TIPO_CLIENTE)
	
			
	SET @IN_CODIGO_CLIENTE = IDENT_CURRENT('TB_CLIENTE')
END
--UPDATE
ELSE
BEGIN
	UPDATE	TB_CLIENTE
	SET		VC_NOMBRES = @VC_NOMBRES,
			VC_APELLIDO_PATERNO = @VC_APELLIDO_PATERNO,
			VC_APELLIDO_MATERNO = @VC_APELLIDO_MATERNO,
			VC_RAZON_SOCIAL = @VC_RAZON_SOCIAL,
			VC_NUMERO_DOCUMENTO = @VC_NUMERO_DOCUMENTO,
			DT_FECHA_NACIMIENTO = @DT_FECHA_NACIMIENTO,
			IN_CODIGO_TIPO_DOCUMENTO = @IN_CODIGO_TIPO_DOCUMENTO,
			IN_CODIGO_CLASIFICACION = @IN_CODIGO_CLASIFICACION,
			VC_EMAIL = @VC_EMAIL,
			CH_SEXO = @CH_SEXO,
			VC_TELEFONO_PRINCIPAL = @VC_TELEFONO_PRINCIPAL,
			VC_CONTACTO = @VC_CONTACTO,
			CH_ESTADO_CLIENTE = @CH_ESTADO_CLIENTE,
			CH_TIPO_CLIENTE = @CH_TIPO_CLIENTE
	WHERE	IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE
	
END

END

GO

CREATE PROCEDURE SP_GRABAR_DIRECCION_CLIENTE
@IN_CODIGO_DIRECCION INT OUT,
@IN_CODIGO_CLIENTE INT,
@VC_DIRECCION VARCHAR(1024),
@VC_REFERENCIA VARCHAR(1024),
@VC_TELEFONO VARCHAR(32),
@CH_TIPO_DIRECCION CHAR(1)
AS

BEGIN

--INSERT
IF (@IN_CODIGO_DIRECCION IS NULL OR @IN_CODIGO_DIRECCION = 0)
BEGIN
	INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,
									 VC_DIRECCION,
									 VC_REFERENCIA,
									 VC_TELEFONO,
									 CH_TIPO_DIRECCION)
	VALUES (@IN_CODIGO_CLIENTE,
			@VC_DIRECCION,
			@VC_REFERENCIA,
			@VC_TELEFONO,
			@CH_TIPO_DIRECCION)
			
	SET @IN_CODIGO_DIRECCION = IDENT_CURRENT('TB_DIRECCION_CLIENTE')
END
--UPDATE
ELSE
BEGIN
	UPDATE	TB_DIRECCION_CLIENTE
	SET		VC_DIRECCION = @VC_DIRECCION,
			VC_REFERENCIA = @VC_REFERENCIA,
			VC_TELEFONO = @VC_TELEFONO,
			CH_TIPO_DIRECCION = @CH_TIPO_DIRECCION
	WHERE	IN_CODIGO_DIRECCION = @IN_CODIGO_DIRECCION
	
END

END

GO

CREATE PROCEDURE SP_GRABAR_FECHA_ESPECIAL
@IN_CODIGO_FECHA_ESP INT OUT,
@DT_FECHA DATETIME,
@VC_MOTIVO VARCHAR(256)
AS

BEGIN

--INSERT
IF (@IN_CODIGO_FECHA_ESP IS NULL OR @IN_CODIGO_FECHA_ESP = 0)
BEGIN
	INSERT INTO TB_FECHA_ESPECIAL  (DT_FECHA,
									VC_MOTIVO)
	VALUES (@DT_FECHA,
			@VC_MOTIVO)
	
			
	SET @IN_CODIGO_FECHA_ESP = IDENT_CURRENT('TB_FECHA_ESPECIAL')
END
--UPDATE
ELSE
BEGIN
	UPDATE	TB_FECHA_ESPECIAL
	SET		DT_FECHA = @DT_FECHA,
			VC_MOTIVO = @VC_MOTIVO
	WHERE	IN_CODIGO_FECHA_ESP = @IN_CODIGO_FECHA_ESP
	
END

END

GO

CREATE PROCEDURE SP_GRABAR_RESERVA
@IN_CODIGO_RESERVA		INT OUT,
@DT_FECHA_RESERVA		DATETIME,
@VC_HORA_INICIO			VARCHAR(8),
@VC_HORA_FIN			VARCHAR(8),
@IN_CANTIDAD_PERSONAS	INT,
@VC_OBSERVACION			VARCHAR(256),
@CH_ESTADO				CHAR(1),
@IN_CODIGO_MESA			INT,
@IN_CODIGO_CLIENTE		INT
AS

BEGIN

--INSERT
IF (@IN_CODIGO_RESERVA IS NULL OR @IN_CODIGO_RESERVA = 0)
BEGIN
	INSERT INTO TB_RESERVA (DT_FECHA_RESERVA,
							VC_HORA_INICIO,
							VC_HORA_FIN,
							IN_CANTIDAD_PERSONAS,
							VC_OBSERVACION,
							CH_ESTADO,
							IN_CODIGO_MESA,
							IN_CODIGO_CLIENTE)
					VALUES (
							@DT_FECHA_RESERVA,
							@VC_HORA_INICIO,
							@VC_HORA_FIN,
							@IN_CANTIDAD_PERSONAS,
							@VC_OBSERVACION,
							@CH_ESTADO,
							@IN_CODIGO_MESA,
							@IN_CODIGO_CLIENTE
							)
	
			
	SET @IN_CODIGO_RESERVA = IDENT_CURRENT('TB_RESERVA')
END
--UPDATE
ELSE
BEGIN
	UPDATE	TB_RESERVA
	SET		DT_FECHA_RESERVA = @DT_FECHA_RESERVA,
			VC_HORA_INICIO = @VC_HORA_INICIO,
			VC_HORA_FIN = @VC_HORA_FIN,
			IN_CANTIDAD_PERSONAS = @IN_CANTIDAD_PERSONAS,
			VC_OBSERVACION = @VC_OBSERVACION,
			CH_ESTADO = @CH_ESTADO,
			IN_CODIGO_MESA = @IN_CODIGO_MESA,
			IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE
	WHERE	IN_CODIGO_RESERVA = @IN_CODIGO_RESERVA
	
END

END

GO

CREATE PROCEDURE SP_LISTAR_CLIENTES_BUSQUEDA
@CH_TIPO_CLIENTE CHAR(1),
@IN_CODIGO_TIPO_DOCUMENTO INT,
@VC_NUMERO_DOCUMENTO VARCHAR(64),
@VC_RAZON_SOCIAL VARCHAR(256),
@CH_SEXO CHAR(1)
AS
BEGIN

SELECT	IN_CODIGO_CLIENTE,
		VC_NOMBRES,
		VC_APELLIDO_PATERNO,
		VC_APELLIDO_MATERNO,
		CASE
			WHEN CH_TIPO_CLIENTE = 'J' THEN VC_RAZON_SOCIAL
			ELSE VC_NOMBRES + ' ' + VC_APELLIDO_PATERNO + ' ' + VC_APELLIDO_MATERNO
		END AS VC_RAZON_SOCIAL,
		VC_NUMERO_DOCUMENTO,
		DT_FECHA_NACIMIENTO,
		C.IN_CODIGO_TIPO_DOCUMENTO,
		TD.VC_ACRONIMO,
		IN_CODIGO_CLASIFICACION,
		VC_EMAIL,
		CH_SEXO,
		VC_TELEFONO_PRINCIPAL,
		VC_CONTACTO,
		CH_ESTADO_CLIENTE,
		CH_TIPO_CLIENTE
FROM	TB_CLIENTE C
INNER JOIN TB_TIPO_DOCUMENTO TD
ON		C.IN_CODIGO_TIPO_DOCUMENTO = TD.IN_CODIGO_TIPO_DOCUMENTO
WHERE	(C.IN_CODIGO_TIPO_DOCUMENTO = @IN_CODIGO_TIPO_DOCUMENTO OR @IN_CODIGO_TIPO_DOCUMENTO = 0 OR @IN_CODIGO_TIPO_DOCUMENTO IS NULL)
AND	(CH_TIPO_CLIENTE = @CH_TIPO_CLIENTE OR @CH_TIPO_CLIENTE IS NULL OR @CH_TIPO_CLIENTE = '')
AND	(VC_NUMERO_DOCUMENTO = @VC_NUMERO_DOCUMENTO OR @VC_NUMERO_DOCUMENTO IS NULL OR @VC_NUMERO_DOCUMENTO = '')
AND	((UPPER(VC_RAZON_SOCIAL) LIKE '%' + UPPER(@VC_RAZON_SOCIAL) + '%' OR UPPER(VC_NOMBRES) + ' ' + UPPER(VC_APELLIDO_PATERNO) + ' ' + UPPER(VC_APELLIDO_MATERNO) LIKE '%' + UPPER(@VC_RAZON_SOCIAL) + '%') 
		OR @VC_RAZON_SOCIAL IS NULL OR @VC_RAZON_SOCIAL = '')
AND	(CH_SEXO = @CH_SEXO OR @CH_SEXO IS NULL OR @CH_SEXO = '')

END

GO

CREATE PROCEDURE SP_LISTAR_DIRECCIONES_CLIENTE
@IN_CODIGO_CLIENTE INT
AS
BEGIN

SELECT	IN_CODIGO_DIRECCION,
		IN_CODIGO_CLIENTE,
		VC_DIRECCION,
		VC_REFERENCIA,
		VC_TELEFONO,
		CH_TIPO_DIRECCION
FROM	TB_DIRECCION_CLIENTE
WHERE	IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

GO

CREATE PROCEDURE SP_LISTAR_FECHAS_ESPECIALES_BUSQUEDA
@IN_ANHO INT,
@IN_MES INT,
@VC_MOTIVO VARCHAR(256)
AS
BEGIN

SELECT	IN_CODIGO_FECHA_ESP,
		DT_FECHA,
		VC_MOTIVO
FROM	TB_FECHA_ESPECIAL
WHERE	(YEAR(DT_FECHA) = @IN_ANHO OR @IN_ANHO = 0)
AND		(MONTH(DT_FECHA) = @IN_MES OR @IN_MES = 0)
AND		(UPPER(VC_MOTIVO) LIKE '%' + UPPER(@VC_MOTIVO) + '%' OR @VC_MOTIVO IS NULL OR @VC_MOTIVO = '') 
ORDER BY DT_FECHA DESC

END

GO

-- SP_LISTAR_MESAS 1
CREATE PROCEDURE SP_LISTAR_MESAS
@IN_CODIGO_LOCAL INT
AS
BEGIN

SELECT	IN_CODIGO_MESA,
		VC_NUMERO, 
		IN_CAPACIDAD, 
		CH_ESTADO, 
		IN_CODIGO_LOCAL
FROM	TB_MESA L
WHERE	L.IN_CODIGO_LOCAL = @IN_CODIGO_LOCAL

END

GO

CREATE PROCEDURE SP_LISTAR_RECLAMOS
@IN_CODIGO_RECLAMO INT,
@CH_ESTADO CHAR(1),
@IN_CODIGO_TIPO_DOCUMENTO INT,
@VC_NUMERO_DOCUMENTO VARCHAR(64),
@VC_NOMBRE_RAZON VARCHAR(256),
@FECHA_INICIO DATETIME,
@FECHA_FIN DATETIME
AS
BEGIN

DECLARE @sqlQuery AS NVARCHAR(3000)
DECLARE @param AS NVARCHAR(500)

SET @sqlQuery = N'SELECT
		R.IN_CODIGO_RECLAMO,
		R.IN_CODIGO_CLIENTE,
		R.DT_FECHA_CREACION,
		R.VC_DETALLE,
		CASE R.CH_ESTADO WHEN ''A'' THEN ''Atendido'' WHEN ''P'' THEN ''Pendiente'' END AS CH_ESTADO,
		C.VC_NUMERO_DOCUMENTO,
		C.VC_NOMBRES + '' '' + C.VC_APELLIDO_PATERNO AS NOMBRE_COMPLETO,
		C.VC_RAZON_SOCIAL
FROM TB_RECLAMO R
JOIN TB_CLIENTE C ON R.IN_CODIGO_CLIENTE = C.IN_CODIGO_CLIENTE
WHERE 1 = 1 '

IF (@IN_CODIGO_RECLAMO IS NOT NULL AND @IN_CODIGO_RECLAMO <> 0)
	SET @sqlQuery = @sqlQuery + ' AND R.IN_CODIGO_RECLAMO = @codigoReclamo'

IF (@CH_ESTADO IS NOT NULL AND LTRIM(RTRIM(@CH_ESTADO)) <> '')
	SET @sqlQuery = @sqlQuery + ' AND R.CH_ESTADO = @estado'

IF (@IN_CODIGO_TIPO_DOCUMENTO IS NOT NULL AND @IN_CODIGO_TIPO_DOCUMENTO <> 0)
	SET @sqlQuery = @sqlQuery + ' AND C.IN_CODIGO_TIPO_DOCUMENTO = @codigoTipoDocumento'
	
IF (@VC_NUMERO_DOCUMENTO IS NOT NULL AND LTRIM(RTRIM(@VC_NUMERO_DOCUMENTO)) <> '')
	SET @sqlQuery = @sqlQuery + ' AND C.VC_NUMERO_DOCUMENTO = @numeroDocumento'
	
IF (@VC_NOMBRE_RAZON IS NOT NULL AND LTRIM(RTRIM(@VC_NOMBRE_RAZON)) <> '')
	SET @sqlQuery = @sqlQuery + ' AND (UPPER(C.VC_NOMBRES + '' '' + C.VC_APELLIDO_PATERNO) LIKE ''%'' + UPPER(@nombreRazon) + ''%'' OR UPPER(C.VC_RAZON_SOCIAL) LIKE ''%'' + UPPER(@nombreRazon) + ''%'')'

IF (@FECHA_INICIO IS NOT NULL AND @FECHA_FIN IS NOT NULL)
	SET @sqlQuery = @sqlQuery + ' AND R.DT_FECHA_CREACION BETWEEN @fecIni AND @fecFin'
	
SET @param = '@codigoReclamo INT, @estado CHAR(1), @codigoTipoDocumento INT, @numeroDocumento VARCHAR(64), @nombreRazon VARCHAR(256), @fecIni DATETIME, @fecFin DATETIME'

EXECUTE sp_executesql @sqlQuery, @param, @IN_CODIGO_RECLAMO, @CH_ESTADO, @IN_CODIGO_TIPO_DOCUMENTO, @VC_NUMERO_DOCUMENTO, @VC_NOMBRE_RAZON, @FECHA_INICIO, @FECHA_FIN

END

GO

-- SP_LISTAR_RESERVAS 1, NULL, 0

CREATE PROCEDURE SP_LISTAR_RESERVAS
@IN_CODIGO_RESERVA INT,
@DT_FECHA_RESERVA DATETIME = NULL,
@IN_CODIGO_MESA INT
AS
BEGIN

DECLARE @sqlQuery AS NVARCHAR(2000)
DECLARE @param AS NVARCHAR(500)

SET @sqlQuery = N'SELECT
		R.IN_CODIGO_RESERVA,
		R.DT_FECHA_RESERVA,
		R.VC_HORA_INICIO,
		R.VC_HORA_FIN,
		R.IN_CANTIDAD_PERSONAS,
		R.VC_OBSERVACION,
		R.CH_ESTADO,
		R.IN_CODIGO_MESA,
		R.IN_CODIGO_CLIENTE,
		C.VC_NOMBRES,
		C.VC_APELLIDO_PATERNO,
		C.VC_APELLIDO_MATERNO,
		C.VC_RAZON_SOCIAL,
		C.VC_NUMERO_DOCUMENTO,
		C.IN_CODIGO_TIPO_DOCUMENTO,
		C.VC_TELEFONO_PRINCIPAL,
		C.CH_TIPO_CLIENTE
FROM	TB_RESERVA R
INNER JOIN TB_CLIENTE C
ON R.IN_CODIGO_CLIENTE = C.IN_CODIGO_CLIENTE
WHERE 1 = 1 '

IF @IN_CODIGO_RESERVA <> 0
BEGIN
	SET @sqlQuery = @sqlQuery + ' AND R.IN_CODIGO_RESERVA = @codigoReserva'
END

IF @DT_FECHA_RESERVA IS NOT NULL
BEGIN
	SET @sqlQuery = @sqlQuery + ' AND R.DT_FECHA_RESERVA = @fechaReserva'
END

IF @IN_CODIGO_MESA <> 0
BEGIN
	SET @sqlQuery = @sqlQuery + ' AND R.IN_CODIGO_MESA = @codigoMesa'
END

SET @param = '@codigoReserva INT, @fechaReserva DATETIME, @codigoMesa INT'

EXECUTE sp_executesql @sqlQuery, @param, @IN_CODIGO_RESERVA, @DT_FECHA_RESERVA, @IN_CODIGO_MESA

END

GO

CREATE PROCEDURE SP_LISTAR_TIPOS_DOCUMENTO
@IN_CODIGO_TIPO_DOCUMENTO INT,
@VC_NOMBRE VARCHAR(128),
@VC_ACRONIMO VARCHAR(8)
AS
BEGIN

SELECT IN_CODIGO_TIPO_DOCUMENTO,
	VC_NOMBRE,
	VC_ACRONIMO
FROM	TB_TIPO_DOCUMENTO
WHERE	(IN_CODIGO_TIPO_DOCUMENTO = @IN_CODIGO_TIPO_DOCUMENTO OR @IN_CODIGO_TIPO_DOCUMENTO = 0)
AND	(UPPER(VC_NOMBRE) LIKE '%' + UPPER(@VC_NOMBRE) + '%' OR @VC_NOMBRE IS NULL OR @VC_NOMBRE = '')
AND	(UPPER(VC_ACRONIMO) LIKE '%' + UPPER(@VC_ACRONIMO) + '%' OR @VC_ACRONIMO IS NULL OR @VC_ACRONIMO = '')

END

GO

CREATE PROCEDURE SP_OBTENER_FECHA_ESPECIAL
@IN_CODIGO_FECHA_ESP INT,
@DT_FECHA DATETIME = NULL
AS
BEGIN

DECLARE @sqlQuery AS NVARCHAR(2000)
DECLARE @param AS NVARCHAR(500)

SET @sqlQuery = N'SELECT IN_CODIGO_FECHA_ESP,
					DT_FECHA,
					VC_MOTIVO
					FROM TB_FECHA_ESPECIAL WHERE 1=1 '

IF @IN_CODIGO_FECHA_ESP <> 0
BEGIN
	SET @sqlQuery = @sqlQuery + ' AND IN_CODIGO_FECHA_ESP = @codigoFecha'
END

IF @DT_FECHA IS NOT NULL
BEGIN
	SET @sqlQuery = @sqlQuery + ' AND DT_FECHA = @fechaEspecial'
END

SET @param = '@codigoFecha INT, @fechaEspecial DATETIME'

EXECUTE sp_executesql @sqlQuery, @param, @IN_CODIGO_FECHA_ESP, @DT_FECHA

END

GO

-- SP_REPORTE_RECLAMOS '2013-03-27 00:00:00','2013-04-02 23:59:59','A'

CREATE PROCEDURE SP_REPORTE_RECLAMOS
@FECHA_INICIO DATETIME,
@FECHA_FIN DATETIME,
@ESTADO CHAR(1)
AS
BEGIN

DECLARE @sqlQuery AS NVARCHAR(1000)
DECLARE @param AS NVARCHAR(500)

SET @sqlQuery = 'SELECT R.IN_CODIGO_RECLAMO, R.IN_CODIGO_CLIENTE, R.DT_FECHA_CREACION, R.DT_FECHA_CIERRE, R.VC_DETALLE, R.CH_ESTADO,
CASE R.CH_ESTADO WHEN ''A'' THEN ''Atendido'' WHEN ''P'' THEN ''Pendiente'' END AS VC_DESC_ESTADO,
C.VC_NOMBRES, C.VC_APELLIDO_PATERNO, C.VC_APELLIDO_MATERNO, C.VC_NUMERO_DOCUMENTO, TD.VC_ACRONIMO
FROM TB_RECLAMO R
INNER JOIN TB_CLIENTE C
ON R.IN_CODIGO_CLIENTE = C.IN_CODIGO_CLIENTE
INNER JOIN TB_TIPO_DOCUMENTO TD
ON C.IN_CODIGO_TIPO_DOCUMENTO = TD.IN_CODIGO_TIPO_DOCUMENTO
WHERE R.DT_FECHA_CREACION BETWEEN @fecIni AND @fecFin'

IF @ESTADO <> '%'
BEGIN
	SET @sqlQuery = @sqlQuery + ' AND R.CH_ESTADO = @est'
END

SET @param = '@fecIni DATETIME, @fecFin DATETIME, @est CHAR(1)'

EXECUTE sp_executesql @sqlQuery, @param, @FECHA_INICIO, @FECHA_FIN, @ESTADO

END

GO

CREATE PROCEDURE SP_VALIDAR_ELIMINAR_CLIENTE
@IN_CODIGO_CLIENTE INT
AS
BEGIN

SELECT SUM(F.IN_CNT_REGISTRO) IN_CNT_REGISTRO
FROM (
SELECT	COUNT(IN_CODIGO_CLIENTE) IN_CNT_REGISTRO
FROM	TB_RECLAMO
WHERE	IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE
/*UNION
SELECT	COUNT(IN_CODIGO_CLIENTE)
FROM	TB_RE
WHERE	IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE*/
) F

END

GO

CREATE PROCEDURE SP_VALIDAR_FECHA_ESPECIAL
@DT_FECHA DATETIME
AS
BEGIN

SELECT COUNT(1)
FROM TB_FECHA_ESPECIAL F
WHERE F.DT_FECHA = @DT_FECHA

END

GO

CREATE PROCEDURE SP_VALIDAR_FECHA_RESERVA
@DT_FECHA_RESERVA DATETIME,
@VC_HORA_INICIO VARCHAR(8),
@VC_HORA_FIN VARCHAR(8),
@IN_CODIGO_MESA INT
AS
BEGIN

SELECT COUNT(1)
FROM TB_RESERVA R
WHERE R.DT_FECHA_RESERVA = @DT_FECHA_RESERVA
AND R.IN_CODIGO_MESA = @IN_CODIGO_MESA
AND ((@VC_HORA_INICIO > R.VC_HORA_INICIO AND @VC_HORA_INICIO < R.VC_HORA_FIN)
OR (@VC_HORA_FIN > R.VC_HORA_INICIO AND @VC_HORA_FIN < R.VC_HORA_FIN))

END

GO

--===============================FIN MODULO CLIENTES Y RESERVAS =========================================================

--===============================INICIO MODULO GESTION GERENCIAL ========================================================

/****** Object:  User [ge]    Script Date: 05/08/2013 18:32:35 ******/
--CREATE USER [ge] FOR LOGIN [ge] WITH DEFAULT_SCHEMA=[dbo]
GO

/****** Object:  Table [dbo].[Cargo]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cargo](
	[codigo_cargo] [int] IDENTITY(1,1) NOT NULL,
	[nombre_cargo] [varchar](50) NULL,
	[descripcion_cargo] [varchar](50) NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[codigo_cargo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Cargo] ON
INSERT [dbo].[Cargo] ([codigo_cargo], [nombre_cargo], [descripcion_cargo]) VALUES (1, N'responsableArea', N'Responsable de aprobaciones de un area')
INSERT [dbo].[Cargo] ([codigo_cargo], [nombre_cargo], [descripcion_cargo]) VALUES (2, N'gerenteGeneral', N'Gerente General Chili`s Peru')
SET IDENTITY_INSERT [dbo].[Cargo] OFF

/****** Object:  Table [dbo].[Area]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Area](
	[codigo_area] [int] IDENTITY(1,1) NOT NULL,
	[nombre_area] [varchar](50) NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[codigo_area] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Area] ON
INSERT [dbo].[Area] ([codigo_area], [nombre_area]) VALUES (1, N'ventas')
INSERT [dbo].[Area] ([codigo_area], [nombre_area]) VALUES (2, N'finanzas')
INSERT [dbo].[Area] ([codigo_area], [nombre_area]) VALUES (3, N'logistica')
INSERT [dbo].[Area] ([codigo_area], [nombre_area]) VALUES (4, N'marketing')
INSERT [dbo].[Area] ([codigo_area], [nombre_area]) VALUES (5, N'gerencia')
SET IDENTITY_INSERT [dbo].[Area] OFF

/****** Object:  Table [dbo].[Objetivo]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Objetivo](
	[codigo_objetivo] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_objetivo] [varchar](100) NULL,
	[fechaRegistro_objetivo] [datetime] NULL,
	[comentarios_objetivo] [varchar](250) NULL,
	[estado_objetivo] [varchar](15) NULL,
	[tipo_objetivo] [varchar](15) NULL,
 CONSTRAINT [PK_Objetivo] PRIMARY KEY CLUSTERED 
(
	[codigo_objetivo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Mapa_Estrategico]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mapa_Estrategico](
	[codigo_mapa_estrategico] [int] IDENTITY(1,1) NOT NULL,
	[descripcion_mapa_estrategico] [varchar](50) NULL,
	[resumen_mapa_estrategico] [varchar](50) NULL,
	[fecha_inicio_mapa_estrategico] [datetime] NULL,
	[fecha_fin_mapa_estrategico] [datetime] NULL,
	[fechaRegistro_mapa_estrategico] [datetime] NULL,
	[estado_mapa_estrategico] [varchar](15) NULL,
	[comentarios_mapa_estrategico] [varchar](250) NULL,
	[tipo_genera_mapa_estrategico] [varchar](50) NULL,
 CONSTRAINT [PK_Mapa_Estrategico] PRIMARY KEY CLUSTERED 
(
	[codigo_mapa_estrategico] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Indicador]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Indicador](
	[codigo_Indicador] [int] IDENTITY(1,1) NOT NULL,
	[nombre_Indicador] [varchar](50) NULL,
	[descripcion_Indicador] [varchar](50) NULL,
	[fechaRegistro_Indicador] [datetime] NULL,
	[formula_Indicador] [varchar](50) NULL,
	[meta_Indicador] [varchar](50) NULL,
	[comentarios_Indicador] [varchar](250) NULL,
	[estado_Indicador] [varchar](15) NULL,
	[objetivo_Indicador] [int] NOT NULL,
 CONSTRAINT [PK_Indicador] PRIMARY KEY CLUSTERED 
(
	[codigo_Indicador] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Empleado]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[codigo_empleado] [int] IDENTITY(1,1) NOT NULL,
	[nombre_empleado] [varchar](50) NOT NULL,
	[apellido_empleado] [varchar](50) NOT NULL,
	[email_empleado] [varchar](50) NOT NULL,
	[area_empleado] [int] NOT NULL,
	[cargo_empleado] [int] NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[codigo_empleado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Empleado] ON
INSERT [dbo].[Empleado] ([codigo_empleado], [nombre_empleado], [apellido_empleado], [email_empleado], [area_empleado], [cargo_empleado]) VALUES (1, N'Miguel', N'Merino', N'mmerinovega@gmail.com', 1, 1)
INSERT [dbo].[Empleado] ([codigo_empleado], [nombre_empleado], [apellido_empleado], [email_empleado], [area_empleado], [cargo_empleado]) VALUES (4, N'Elena', N'Alva', N'elena.alva@gmail.com', 5, 2)
INSERT [dbo].[Empleado] ([codigo_empleado], [nombre_empleado], [apellido_empleado], [email_empleado], [area_empleado], [cargo_empleado]) VALUES (5, N'Johnny', N'Rodriguez', N'jrodriguezm@gmail.com.pe', 2, 1)
INSERT [dbo].[Empleado] ([codigo_empleado], [nombre_empleado], [apellido_empleado], [email_empleado], [area_empleado], [cargo_empleado]) VALUES (6, N'Franz', N'Westreicher', N'franzwf@gmail.com', 3, 1)
SET IDENTITY_INSERT [dbo].[Empleado] OFF

/****** Object:  Table [dbo].[Objetivo_General]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Objetivo_General](
	[codigo_og] [int] NOT NULL,
	[objetivo_efecto] [int] NULL,
 CONSTRAINT [PK_Objetivo_General] PRIMARY KEY CLUSTERED 
(
	[codigo_og] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Plan_Accion]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Plan_Accion](
	[codigo_Plan_Accion] [int] IDENTITY(1,1) NOT NULL,
	[nombre_Plan_Accion] [varchar](50) NULL,
	[descripcion_Plan_Accion] [datetime] NULL,
	[fechaRegistro_Plan_Accion] [datetime] NULL,
	[comentarios_Plan_Accion] [varchar](250) NULL,
	[estado_Plan_Accion] [varchar](15) NULL,
	[indicador_Plan_Accion] [int] NOT NULL,
 CONSTRAINT [PK_Plan_Accion] PRIMARY KEY CLUSTERED 
(
	[codigo_Plan_Accion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Objetivo_Funcional]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Objetivo_Funcional](
	[codigo_of] [int] NOT NULL,
	[og_vinculado] [int] NOT NULL,
	[objetivo_efecto] [int] NULL,
	[area_of] [int] NOT NULL,
 CONSTRAINT [PK_Objetivo_Funcional] PRIMARY KEY CLUSTERED 
(
	[codigo_of] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Estrategia]    Script Date: 05/08/2013 18:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estrategia](
	[codigo_estrategia] [int] IDENTITY(1,1) NOT NULL,
	[nombre_estrategia] [varchar](50) NOT NULL,
	[descripcion_estrategia] [varchar](50) NULL,
	[fechaRegistro_estrategia] [datetime] NULL,
	[comentarios_estrategia] [varchar](50) NULL,
	[estado_estrategia] [varchar](15) NULL,
	[fecha_inicio_estrategia] [datetime] NULL,
	[fecha_fin_estrategia] [datetime] NULL,
	[responsable_estrategia] [int] NULL,
	[objetivo_estrategia] [int] NOT NULL,
 CONSTRAINT [PK_Estrategia] PRIMARY KEY CLUSTERED 
(
	[codigo_estrategia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  ForeignKey [fk_area_empleado]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [fk_area_empleado] FOREIGN KEY([area_empleado])
REFERENCES [dbo].[Area] ([codigo_area])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [fk_area_empleado]
GO

/****** Object:  ForeignKey [fk_cargo_empleado]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [fk_cargo_empleado] FOREIGN KEY([cargo_empleado])
REFERENCES [dbo].[Cargo] ([codigo_cargo])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [fk_cargo_empleado]
GO

/****** Object:  ForeignKey [fk_estrategia_empleado]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Estrategia]  WITH CHECK ADD  CONSTRAINT [fk_estrategia_empleado] FOREIGN KEY([responsable_estrategia])
REFERENCES [dbo].[Empleado] ([codigo_empleado])
GO
ALTER TABLE [dbo].[Estrategia] CHECK CONSTRAINT [fk_estrategia_empleado]
GO

/****** Object:  ForeignKey [fk_estrategia_objetivo]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Estrategia]  WITH CHECK ADD  CONSTRAINT [fk_estrategia_objetivo] FOREIGN KEY([objetivo_estrategia])
REFERENCES [dbo].[Objetivo] ([codigo_objetivo])
GO
ALTER TABLE [dbo].[Estrategia] CHECK CONSTRAINT [fk_estrategia_objetivo]
GO

/****** Object:  ForeignKey [fk_indicador_objetivo]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Indicador]  WITH CHECK ADD  CONSTRAINT [fk_indicador_objetivo] FOREIGN KEY([objetivo_Indicador])
REFERENCES [dbo].[Objetivo] ([codigo_objetivo])
GO
ALTER TABLE [dbo].[Indicador] CHECK CONSTRAINT [fk_indicador_objetivo]
GO

/****** Object:  ForeignKey [FK_Objetivo_Funcional]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Objetivo_Funcional]  WITH CHECK ADD  CONSTRAINT [FK_Objetivo_Funcional] FOREIGN KEY([codigo_of])
REFERENCES [dbo].[Objetivo] ([codigo_objetivo])
GO
ALTER TABLE [dbo].[Objetivo_Funcional] CHECK CONSTRAINT [FK_Objetivo_Funcional]
GO

/****** Object:  ForeignKey [fk_objetivo_funcional_area]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Objetivo_Funcional]  WITH CHECK ADD  CONSTRAINT [fk_objetivo_funcional_area] FOREIGN KEY([area_of])
REFERENCES [dbo].[Area] ([codigo_area])
GO
ALTER TABLE [dbo].[Objetivo_Funcional] CHECK CONSTRAINT [fk_objetivo_funcional_area]
GO

/****** Object:  ForeignKey [fk_objetivo_funcional_efecto]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Objetivo_Funcional]  WITH CHECK ADD  CONSTRAINT [fk_objetivo_funcional_efecto] FOREIGN KEY([objetivo_efecto])
REFERENCES [dbo].[Objetivo_Funcional] ([codigo_of])
GO
ALTER TABLE [dbo].[Objetivo_Funcional] CHECK CONSTRAINT [fk_objetivo_funcional_efecto]
GO

/****** Object:  ForeignKey [FK_Objetivo_General_Vinculado]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Objetivo_Funcional]  WITH CHECK ADD  CONSTRAINT [FK_Objetivo_General_Vinculado] FOREIGN KEY([og_vinculado])
REFERENCES [dbo].[Objetivo_General] ([codigo_og])
GO
ALTER TABLE [dbo].[Objetivo_Funcional] CHECK CONSTRAINT [FK_Objetivo_General_Vinculado]
GO

/****** Object:  ForeignKey [FK_Objetivo_General]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Objetivo_General]  WITH CHECK ADD  CONSTRAINT [FK_Objetivo_General] FOREIGN KEY([codigo_og])
REFERENCES [dbo].[Objetivo] ([codigo_objetivo])
GO
ALTER TABLE [dbo].[Objetivo_General] CHECK CONSTRAINT [FK_Objetivo_General]
GO

/****** Object:  ForeignKey [FK_OBJETIVO_general_EFECTO]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Objetivo_General]  WITH CHECK ADD  CONSTRAINT [FK_OBJETIVO_general_EFECTO] FOREIGN KEY([objetivo_efecto])
REFERENCES [dbo].[Objetivo_General] ([codigo_og])
GO
ALTER TABLE [dbo].[Objetivo_General] CHECK CONSTRAINT [FK_OBJETIVO_general_EFECTO]
GO

/****** Object:  ForeignKey [fk_plan_accion_indicador]    Script Date: 05/08/2013 18:32:35 ******/
ALTER TABLE [dbo].[Plan_Accion]  WITH CHECK ADD  CONSTRAINT [fk_plan_accion_indicador] FOREIGN KEY([indicador_Plan_Accion])
REFERENCES [dbo].[Indicador] ([codigo_Indicador])
GO
ALTER TABLE [dbo].[Plan_Accion] CHECK CONSTRAINT [fk_plan_accion_indicador]
GO

--===============================FIN MODULO GESTION GERENCIAL ========================================================


--===============================INICIO MODULO ALMACEN ========================================================

CREATE TABLE tb_UnidadNegocio(
codigo int identity(1,1) primary key,
desUn varchar(600),
direcUn varchar(800)
)
GO
CREATE TABLE tb_UnidadMedida(
codigo int identity(1,1) primary key,
desMed varchar(600)
)
GO
CREATE TABLE tb_InventarioCabecera(
codigo int identity(1,1) primary key,
correlativo varchar(20),
referencia varchar(150),
fecha datetime,
responsable varchar(150),
aprobado varchar(250),
estado INT,
codUNeg int references tb_UnidadNegocio(codigo),
UsuarioRegistra int,
FechaRegistro datetime,
UsuarioElimina int,
FechaElimina datetime,
UsuarioModifica int,
FechaModifica datetime
)
go
CREATE TABLE tb_Producto(
codigo int identity(1,1) primary key,
nombre varchar(800),
codigoPr varchar(100),
descripcion varchar(800),
familia varchar(800),
subFamilia varchar(800),
cantidadMinima decimal(16,2),
cantidadMaxima decimal(16,2),
medida int references tb_UnidadMedida(codigo))


go
CREATE TABLE tb_InventarioDetalle(
codigo int identity(1,1) primary key,
codCabecera int references tb_InventarioCabecera(codigo),
codProducto int references tb_Producto(codigo),
item int,
descripcion varchar(800),
cantidadActual decimal(16,2),
medida int references tb_UnidadMedida(codigo))

go
CREATE PROC [ALM.Inventario_Eliminar]
@codCabecera int,
@Correlativo int output
as
begin

update dbo.tb_InventarioCabecera
set estado = 3
where codigo =@codCabecera

SET @Correlativo= @codCabecera

end
go
create proc [ALM.Inventario_Insertar](
@referencia VarChar(150),
@fecha Date,
@responsable VarChar(150),
@aprobado VarChar( 250),
@estado int,
@usuCre Int,
@FecCre Date,
@Codigo int output
  )
as
begin

declare @correlativo varchar(15)
set @fecha = convert(varchar(10),GETDATE(),101)                      
Select @correlativo= isnull(MAX(ISNULL(SUBSTRING(isnull(correlativo,0),3,4),0)),0)+1 FROM tb_InventarioCabecera                        
Select @correlativo = cast('IN' + REPLICATE('0',4 - LEN(ISNULL(@correlativo,1)))as varchar(10))+@correlativo                      
Select @correlativo =@correlativo + REPLICATE('0',2 - LEN(DATEPART(mm,(@fecha))))+cast(DATEPART(mm,(@fecha)) as varchar(10))                      
+ SUBSTRING(cast(year(@fecha) as varchar(10)),3,2)    

insert dbo.tb_InventarioCabecera(correlativo,referencia,fecha,estado,responsable) values(@correlativo,@referencia,@fecha,@estado,@responsable)

set @codigo= @@IDENTITY


select @codigo


end

go
create proc [ALM.Inventario_Actualizar](
@codCabecera int,
@referencia VarChar(150),
@fecha Date,
@responsable VarChar(150),
@aprobado VarChar( 250),
@estado int,
@usuMod Int,
@FecMod Date,
@Actualizado int output
  )
as
begin

update dbo.tb_InventarioCabecera
set referencia =@referencia,fecha =@fecha,responsable =@responsable, estado=@estado
where codigo =@codCabecera

delete from tb_inventariodetalle where codCabecera=@codCabecera
set @Actualizado= @codCabecera
select @Actualizado


end

go
create proc [ALM.ListarHojaInventario] 
@fechaIni varchar(10) = null,
@fechaFin varchar(10) = null,
@estado int =null
as
begin
select codigo ,convert(varchar(10),fecha,102)fecha, cab.referencia, isnull(cab.responsable,'')responsable, ISNULL(descripcion,'')estado,correlativo,est.estado
from dbo.tb_InventarioCabecera cab
INNER JOIN dbo.tb_estadoInv EST ON est.codEstadoInv=cab.estado
where  CAB.estado <> 3 and
(isnull(@fechaIni,'')='' OR cab.fecha >= @fechaIni)   
  AND (isnull(@fechaFin,'')='' OR cab.fecha <= @fechaFin)  
  AND (isnull(@estado,-1)=-1 OR cab.estado = @estado)   
end

go

create proc [AlM.InventarioDetalle_Insertar]
@codCabecera int,
@codProducto int,
@item int,
@descripcion varchar(8000),
@cantidadActual decimal(16,2),
@medida varchar(60),
@codigo int = null,
@correlativo int output
as
begin

SET NOCOUNT ON ;   


	   
	  INSERT INTO    
	   dbo.tb_InventarioDetalle  
	   (codCabecera,
		codProducto,
		item,
		descripcion,
		cantidadActual,
		medida	)    

	  VALUES    
	   (@codCabecera,
		@codProducto,
		@item,
		@descripcion,
		@cantidadActual,
		(select medida from tb_Producto where codigo =@codProducto)	)   
	 
		SET @Correlativo = SCOPE_IDENTITY(); 
	
     
 SET NOCOUNT OFF ;    
       
END  

go

create proc [ALM.ListarHojaInventarioxCod] 
@codCabecera int
as
begin
select codigo ,convert(varchar(10),fecha,103)fecha, cab.referencia, isnull(cab.responsable,'')responsable, estado
from dbo.tb_InventarioCabecera cab
where codigo = @codCabecera 
end
go


create proc [ALM.ListarHojaInventarioDetxCod]
@codCabecera int
as
begin
select cab.codigo,
isnull(cab.codProducto,0) codProducto,
isnull(pr.nombre,0) Producto,
isnull(item,0) item,
isnull(cab.descripcion,'') descripcion,
isnull(cantidadActual,0)cantidadActual,
isnull(tu.desMed,'')medida,
isnull(pr.codigoPr,'')codigoPr
from dbo.tb_InventarioDetalle cab
inner join tb_producto pr on pr.codigo= cab.codProducto
inner join tb_UnidadMedida tu on tu.CODIGO= cab.medida
where cab.codCabecera = @codCabecera 
end



go
----tb anelt----



CREATE TABLE tb_NotaIngresoSalida(
codigoIS int identity(1,1) primary key,
codNotaPedido int,
tipoDocumento varchar(50),
fecha date,
periodo varchar(20),
transfTipo varchar(50),
referTipo varchar(50),
referNumDoc varchar(20),
codUnidadOrigen int,
codUnidadDestino int,
empleado varchar(200),
correlativo varchar(20)
)

go

CREATE TABLE tb_NotaIngresoSalidaDetalle(
codigoDetIS int identity(1,1) primary key,
codigoIS int,
codItem int,
descripcion varchar(200),
cantActual int,
medida varchar(100),
lote varchar(100),
serie varchar(200),
fechaElaboracion date,
fechaCaducidad date,
precioUnitario decimal(18,2),
precioTotal decimal(18,2)

)
go
CREATE TABLE tb_NotaPedido(
codigoPedido int identity(1,1) primary key,
fechaEmision date,
almacenOrigen int,
almacenDestino int,
areaSolicitante varchar(100),
TipoOperacion varchar(100),
registrador varchar(100),
autorizador varchar(100),
estadoNota varchar(50), 
fechaEstadoNota date,
PrecioPedido decimal(18,2),
correlativo varchar(20)

)
go
CREATE TABLE tb_NotaPedidoDetalle(
codigoPedidoDet int identity(1,1) primary key,
codigoPedido int,
Coditem int,
descripcion varchar(200),
cantActual int, 
medida varchar(200),
marca int,
fechaCaducidad date,
precioUnitario decimal(18,2),
PrecioTotal decimal(18,2)
)
go


create table tb_estadoInv(
codEstadoInv int identity(1,1) primary key,
descripcion varchar(200), 
estado int
)
go

create table tb_marca(
codMarca int identity(1,1) primary key,
descripcion varchar(200), 
estado int
)
go

insert into tb_marca values('capri',1);
insert into tb_marca values('Bolivar',1);
insert into tb_marca values('Primor',1);
go



GO
--listar nota de pedido
create procedure [ALM.ListarNotaPedido]
@NotaPedido int
AS    
BEGIN    
 SET NOCOUNT ON;   
   
 Select 
 dt.codigoPedido,
 RIGHT('000' +CONVERT(VARCHAR(3),dt.codigoPedido),3) as 'codPedido2', 
 dt.Coditem,
 RIGHT('000' +CONVERT(VARCHAR(3),dt.Coditem),3) as 'codItem2',
 dt.medida,
 marca.descripcion as 'marca',
 dt.fechaCaducidad,
 dt.cantActual,
 cast(dt.precioUnitario as decimal(18,2)) precioUnitario,
 cast(dt.PrecioTotal as decimal(18,2))PrecioTotal,
  'MI_NP_001' as correlativo

 from tb_NotaPedidoDetalle dt
 left join tb_Producto pro on pro.codigo=dt.Coditem
 left join tb_marca marca on marca.codMarca=dt.marca
 where dt.codigoPedido=@NotaPedido
 
 
 SET NOCOUNT OFF;    
    
 END   
 
go
--listar nota de ingreso y salida
create procedure [ALM.ListarNotaIngresoSalida]
@NotaPedido int
AS    
BEGIN    
 SET NOCOUNT ON;   
   
 Select 
 n.codigoIS,
 RIGHT('000' +CONVERT(VARCHAR(3),n.codigoIS),3) as 'codnotaIS2', 
 case when n.tipoDocumento='NI' then 'Nota Ingreso' else 'Nota Salida' END as 'desTipoDoc',
 n.tipoDocumento as 'codTipodoc',
 n.fecha,
 n.periodo,
 n.transfTipo as 'codTransTipo',
 case when transfTipo='IP' then 'Ingreso de proveedor'
		 when transfTipo='IT' then 'Ingreso por terceros'
		  when transfTipo='ID' then 'Ingreso por devolución'
		   when transfTipo='IR' then 'Ingreso por regularización'
		    when transfTipo='ST' then 'Salida a terceros'
		    when transfTipo='SD' then 'Salida por devolución'
			when transfTipo='SR' then 'Salida por regularización' END AS 'destransTipo',
n.referTipo as 'codRefTipo',
case when referTipo='GR' then 'Guía de remisión'
when referTipo='NI' then 'Nota de Ingreso'
when referTipo='NS' then 'Nota de Salida'
end as 'desrefTipo',
n.referNumDoc,
n.codUnidadOrigen,
n.codUnidadDestino,
uDestino.desUn as 'UniDes',
uOrigen.desUn as 'UniOrig',
n.empleado,
n.codNotaPedido,
RIGHT('000' +CONVERT(VARCHAR(3),n.codNotaPedido),3) as 'codnotapedido2' ,
n.correlativo

 from  tb_NotaIngresoSalida n
 left join tb_UnidadNegocio uOrigen on uOrigen.codigo=n.codUnidadOrigen
 left join tb_UnidadNegocio uDestino on uDestino.codigo=n.codUnidadDestino
 
 where n.codNotaPedido=@NotaPedido 
 
 SET NOCOUNT OFF;    
    
 END   
 
 go
 ---registro detalle ----
  
create PROC [AlM.NotaISDetalle_Insertar]   
@codigoIS int,
@codItem int,
@descripcion varchar(200),
@cantActual int,
@medida varchar(100),
@lote varchar(100),
@serie varchar(200),
@fechaElaboracion date,
@fechaCaducidad date,
@precioUnitario decimal(18,2),
@precioTotal decimal(18,2),
@Correlativo  INT OUTPUT  
  
AS      
BEGIN      
      
 SET NOCOUNT ON ;    
   
  INSERT INTO    
   dbo.tb_NotaIngresoSalidaDetalle  
   (codigoIS,
	codItem,
	descripcion,
	cantActual,
	medida,
	lote,
	serie,
	fechaElaboracion,
	fechaCaducidad,
	precioUnitario,
	precioTotal 
	)    

  VALUES    
   (@codigoIS,
	@codItem,
	@descripcion,
	@cantActual,
	@medida,
	@lote,
	@serie,
	@fechaElaboracion,
	@fechaCaducidad,
	@precioUnitario,
	@precioTotal)   
 
    SET @Correlativo = SCOPE_IDENTITY(); 
     
 SET NOCOUNT OFF ;    
       
END  

go
create PROC [ALM.NotaISDetalle_Actualizar]   
@codigoDetIS int,
@codigoIS int,
@codItem int,
@descripcion varchar(200),
@cantActual int,
@medida varchar(100),
@lote varchar(100),
@serie varchar(200),
@fechaElaboracion date,
@fechaCaducidad date,
@precioUnitario decimal(18,2),
@precioTotal decimal(18,2)
  
AS      
BEGIN      
      
 SET NOCOUNT ON ;
Update dbo.tb_NotaIngresoSalidaDetalle
set 
 	codItem=@codItem,
	descripcion=@descripcion,
	cantActual=@cantActual,
	medida=@medida,
	lote=@lote,
	serie=@serie,
	fechaElaboracion=@fechaElaboracion,
	fechaCaducidad=@fechaCaducidad,
	precioUnitario=@precioUnitario,
	precioTotal=@precioTotal
 
where codigoDetIS=@codigoDetIS
and codigoIS=@codigoIS
 SET NOCOUNT OFF ;    
       
END  
--eleimnar: 
go

create procedure [ALM.NotaISDetalle_Eliminar]
@codigoDetIS int,
@codigoIS int
as
BEGIN 
 SET NOCOUNT ON ;
delete from dbo.tb_NotaIngresoSalidaDetalle
where 
codigoDetIS=@codigoDetIS
and codigoIS=@codigoIS
 SET NOCOUNT OFF ;  
end


---listar por cabecera 
go
create PROCEDURE [ALM.NotaISDetalle_ListarPorNotaIS]  
 @CodNotaIS  int 
AS  
BEGIN   
 SET NOCOUNT ON;     

 SELECT  
 codigoDetIS,
 codigoIS,
 descripcion,
 cantActual,
 medida,
 lote,
 serie,
 fechaElaboracion,
 fechaCaducidad,
 cast(precioUnitario as decimal(18,2)) precioUnitario,
 cast(PrecioTotal as decimal(18,2))PrecioTotal,
  codItem     
FROM dbo.tb_NotaIngresoSalidaDetalle

 WHERE  codigoIS = @CodNotaIS  
   
      
 SET NOCOUNT OFF;     
END  

go
--obtener un detalle 
create PROCEDURE [ALM.NotaISDetalle_Obtener]  
 @CodNotaISDet  int 
AS  
BEGIN   
 SET NOCOUNT ON;     

 SELECT  
 codigoDetIS,
 codigoIS,
 descripcion,
 cantActual,
 medida,
 lote,
 serie,
 fechaElaboracion,
 fechaCaducidad,
 cast(precioUnitario as decimal(18,2)) precioUnitario,
 cast(PrecioTotal as decimal(18,2))PrecioTotal
   ,codItem      
FROM dbo.tb_NotaIngresoSalidaDetalle

 WHERE  codigoDetIS = @CodNotaISDet  
   
      
 SET NOCOUNT OFF;     
END  

go

--cargar combo unidad 
 
CREATE PROCEDURE [ALM.Cargar_Unidad]
AS    
BEGIN  
Select  codigo as codigo,
	desUn as descripcion
	from dbo.tb_UnidadNegocio
END

GO

CREATE PROCEDURE [ALM.Cargar_EstadoINV]
AS    
BEGIN  
Select  codEstadoInv as codigo,
	descripcion as descripcion
	from dbo.tb_estadoINV
	where codEstadoInv<>3
END

GO

go

--insertar cabecera---
create PROC [ALM.NotaIS_Insertar]   

@codNotaPedido int,
@tipoDocumento varchar(50),
@fecha date,
@periodo varchar(20),
@transfTipo varchar(50),
@referTipo varchar(50),
@referNumDoc varchar(20),
@codUnidadOrigen int,
@codUnidadDestino int,
@empleado varchar(200),
@Codigo   VARCHAR(14) OUTPUT  
  
AS      
BEGIN      
      
 SET NOCOUNT ON ;   
  declare @correlativo varchar(20);
  declare @var int;
  select @var= COUNT(*) from  tb_NotaIngresoSalida;
  set @var=@var+1;
  set @correlativo=RIGHT('MI_NIS_00' +CONVERT(VARCHAR(10),@var),10);
 
  
 BEGIN    
 if(@tipoDocumento='NI')
 Begin 
 INSERT INTO    
     dbo.tb_NotaIngresoSalida
   (codNotaPedido,
	tipoDocumento,
	fecha,
	periodo,
	transfTipo,
	referTipo,
	referNumDoc,
	codUnidadOrigen,
	codUnidadDestino,
	empleado,correlativo 
   )    

  VALUES    
  (0,
	@tipoDocumento,
	@fecha,
	@periodo,
	@transfTipo,
	@referTipo,
	'0',
	@codUnidadOrigen,
	@codUnidadDestino,
	@empleado,@correlativo)    
end
   else
  begin
  INSERT INTO    
     dbo.tb_NotaIngresoSalida
   (codNotaPedido,
	tipoDocumento,
	fecha,
	periodo,
	transfTipo,
	referTipo,
	referNumDoc,
	codUnidadOrigen,
	codUnidadDestino,
	empleado,correlativo
   )    

  VALUES    
  (@codNotaPedido,
	@tipoDocumento,
	@fecha,
	@periodo,
	@transfTipo,
	@referTipo,
	@referNumDoc,
	@codUnidadOrigen,
	@codUnidadDestino,
	@empleado,@correlativo)    
   
 end

   
 END     
   SET @Codigo = SCOPE_IDENTITY();
      
 SET NOCOUNT OFF ;    
       
END


go
--modificar cabecera --

create PROCEDURE [ALM.NotaIS_Actualizar]     
@codigoIS  int,  
@tipoDocumento varchar(50),
@fecha date,
@periodo varchar(20),
@transfTipo varchar(50),
@referTipo varchar(50),
@referNumDoc varchar(20),
@codUnidadOrigen int,
@codUnidadDestino int,
@empleado varchar(200),
@Actualizado  INT OUT 

AS  
BEGIN    

  UPDATE  dbo.tb_NotaIngresoSalida   
  SET  
		tipoDocumento=@tipoDocumento,
		fecha=@fecha,
		periodo=@periodo,
		transfTipo=@transfTipo,
		referTipo=@referTipo,
		referNumDoc=@referNumDoc,
		codUnidadOrigen=@codUnidadOrigen,
		codUnidadDestino=@codUnidadDestino,
		empleado=@empleado 
  	
  WHERE   
  codigoIS = @codigoIS
     
   SET @Actualizado=@codigoIS
 
END  


go

CREATE proc [ALM.Cargar_Productos] 
@nombre as varchar(500)=null,
@codigoPr as varchar(500)=null
as
begin

select tb_producto.codigo,CodigoPr,nombre,descripcion,tb_UnidadMedida.desMed medida
from tb_producto
INNER JOIN tb_UnidadMedida  on tb_UnidadMedida.codigo= tb_producto.medida
where (ISNULL(@nombre,'')='' or nombre  like '%' +@nombre + '%')
AND (ISNULL(@codigoPr,'')='' or CodigoPr  like '%' +@codigoPr + '%')
end

go

insert into tb_UnidadMedida values('LITROS')
insert into tb_UnidadMedida values('KG')

insert into tb_estadoInv values('PARCIAL',1)
insert into tb_estadoInv values('COMPLETO',1)
insert into tb_estadoInv values('ELIMINADO',1)
INSERT INTO tb_Producto VALUES('Cebollas','PR0001','Cebollas','asdasd','asdasd',3,10,2)
INSERT INTO tb_Producto VALUES('Zanahoria','PR0002','Zanahoria','asdasd','asdasd',3,10,2)
INSERT INTO tb_Producto VALUES('Aceite','PR0003','Aceite','asdasd','asdasd',3,10,1)
INSERT INTO tb_Producto VALUES('Leche','PR00054','Leche','asdasd','asdasd',3,10,1)

insert into tb_UnidadNegocio values('cocina','Miraflores')
insert into tb_UnidadNegocio values('almacen 2','San Isidro')

INSERT INTO tb_NotaPedido 
VALUES('01/01/2012',1,2,'Area 1','0','Juan Carlos Perez','Ricardo Seigas','1','01/02/2012',434.12,'MI_NP_001')
go

INSERT INTO tb_NotaPedidoDetalle 
VALUES(1,1,'Aceite Oliva',100,'1/2 litro',1,'03/03/2013',7.60,760);
INSERT INTO tb_NotaPedidoDetalle 
VALUES(1,3,'Aceite primor',80,'1/2 litro',3,'03/03/2013',6.60,528);
INSERT INTO tb_NotaPedidoDetalle 
VALUES(1,2,'Jabon en Barra Bolivar',80,'1 barra',2,'03/03/2013',2.30,184);



GO


create TABLE [dbo].[tb_FichaProducto](
	[codigo] [int] IDENTITY(1,1) NOT NULL,
	[item] [int] NOT NULL,
	[codProducto] [varchar](50) NOT NULL,
	[lote] [varchar](50) NULL,
	[serie] [varchar](50) NULL,
	[tipo] [varchar](50) NULL,
	[cantidad] [decimal](18, 2) NULL,
	[precio] [decimal](18, 2) NULL,
	[medida] [varchar](50) NULL,
	[fecha_recepcion] [date] NULL,
	[fecha_elaboracion] [date] NULL,
	[fecha_vencimiento] [date] NULL,
	[codUN] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


alter table tb_producto add marca int null
go
update tb_producto set marca = 1

go

create procedure [ALM.Buscar_Productos]
@codigoPr varchar(100),
@nombre varchar(100),
@familia varchar(100),
@subfamilia varchar(100),
@marca int
as
select p.codigo, p.codigoPr, p.nombre, p.descripcion, p.familia, 
p.subfamilia, m.desMed as Medida, k.descripcion as Marca
from tb_producto p
inner join  Tb_UnidadMedida m
on m.codigo = p.medida
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and p.nombre like '%'+ @nombre +'%'
and p.familia like '%'+ @familia +'%'
and p.subfamilia like '%'+ @subfamilia +'%'
and p.marca = case when @marca = -1 then p.marca else @marca end
 
 
go


CREATE procedure [dbo].[ALM.FichaProducto_Insertar]
@item int,
@codProducto varchar(50),
@lote varchar(50),
@serie varchar(50),
@tipo varchar(50),
@cantidad decimal(18,2),
@precio decimal(18,2),
@medida varchar(50),
@fecha_recepcion date,
@fecha_elaboracion date,
@fecha_vencimiento date,
@codUN int,
@Codigo int output
as
insert tb_Fichaproducto (item,codProducto,
lote,serie,tipo,cantidad,precio,medida,fecha_recepcion,fecha_elaboracion,fecha_vencimiento,codUN )
values (@item,@codProducto,
@lote,@serie,@tipo,@cantidad,@precio,@medida,@fecha_recepcion,@fecha_elaboracion,@fecha_vencimiento,@codUN )


set @codigo= @@IDENTITY


select @codigo

go

create procedure [ALM.Ficha_GetUltimoItem]
as
declare @penultimo int
declare @ultimo int

select top 1  @penultimo = isnull(substring(convert(varchar,item),7,2),0) 
from tb_FichaProducto 
where substring(convert(varchar,item),1,2) = substring(convert(varchar,year(getdate())),3,2) 
and convert(int,substring(convert(varchar,item),3,2)) = month(getdate())
and convert(int,substring(convert(varchar,item),5,2)) = day(getdate())
order by item desc

set @ultimo = substring(convert(varchar,year(getdate())),3,2) + 
right('00'+ convert(varchar,month(getdate())),2) +
right('00'+ convert(varchar,day(getdate())),2)+
right('00' + convert(varchar,isnull(@penultimo,0) + 1),2)

select @ultimo as ultimo



go

create procedure [ALM.Cargar_Marcas]
as
select codMarca, descripcion 
from tb_marca
order by descripcion asc

go


create procedure [dbo].[ALM.Buscar_Productos_UN]
@codigoPr varchar(100),
@nombre varchar(100),
@UN int
as
select p.codigo, p.codigoPr, u.desUn as UN, p.nombre, p.descripcion, p.familia, 
p.subfamilia, k.descripcion as Marca
from tb_producto p
inner join tb_FichaProducto f
on f.codProducto = p.codigoPr
inner join  tb_UnidadNegocio u
on u.codigo = f.codUN
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and p.nombre like '%'+ @nombre +'%'
and u.codigo = case when @UN = -1 then u.codigo else @UN end
 
go

create procedure [dbo].[ALM.Buscar_FichaProducto]
@codigoPr varchar(100),
@UN int
as
select f.item, f.medida, k.descripcion as Marca, f.fecha_vencimiento, f.cantidad, f.precio,  
convert(decimal(18,2),f.cantidad * f.precio) as total
from  
tb_FichaProducto f
inner join tb_Producto p
on f.codProducto = p.codigoPr
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and f.codUN = case when @UN = -1 then f.codUN else @UN end

go


create proc [dbo].[ALM.NotaPedido_Insertar](
@fechaEmision Date,
@almacenOrigen int,
@almacenDestino int,
@areaSolicitante varchar(100),
@codigoPedido int output
  )
as
begin

insert tb_NotaPedido
(fechaEmision,almacenOrigen, almacenDestino,areaSolicitante,TipoOperacion,registrador,
autorizador,estadoNota,fechaEstadoNota,PrecioPedido,correlativo)
values (@fechaEmision,@almacenOrigen,@almacenDestino,@areaSolicitante,'','','','',getdate(),0,'')

set @codigoPedido= @@IDENTITY


select @codigoPedido as ultimo


end

go

create proc [dbo].[ALM.NotaPedidoDetalle_Insertar](
@codigoPedido int,
@Coditem int,
@descripcion varchar(200),
@cantActual int,
@medida varchar(200),
@marca int,
@fechaCaducidad date,
@precioUnitario decimal(18,2),
@precioTotal decimal(18,2)
  )
as
begin

insert tb_NotaPedidoDetalle
(codigoPedido,CodItem,descripcion,cantActual,medida,marca,fechaCaducidad, preciounitario, preciototal)
values (@codigoPedido,@CodItem,@descripcion,@cantActual,@medida,@marca,@fechaCaducidad, @preciounitario, @preciototal)

end

go


ALTER procedure [dbo].[ALM.Buscar_Productos_UN]
@codigoPr varchar(100),
@nombre varchar(100),
@UN int
as
select p.codigo, p.codigoPr, u.desUn as UN, p.nombre, p.descripcion, p.familia, 
p.subfamilia, k.descripcion as Marca, u.codigo as CodUN
from tb_producto p
inner join tb_FichaProducto f
on f.codProducto = p.codigoPr
inner join  tb_UnidadNegocio u
on u.codigo = f.codUN
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and p.nombre like '%'+ @nombre +'%'
and u.codigo = case when @UN = -1 then u.codigo else @UN end

go

ALTER procedure [dbo].[ALM.Buscar_Productos_UN]
@codigoPr varchar(100),
@nombre varchar(100),
@UN int
as
select p.codigo, p.codigoPr, u.desUn as UN, p.nombre, p.descripcion, p.familia, 
p.subfamilia, k.descripcion as Marca, u.codigo as CodUN, k.codMarca as CodMarca
from tb_producto p
inner join tb_FichaProducto f
on f.codProducto = p.codigoPr
inner join  tb_UnidadNegocio u
on u.codigo = f.codUN
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and p.nombre like '%'+ @nombre +'%'
and u.codigo = case when @UN = -1 then u.codigo else @UN end

go

ALTER procedure [dbo].[ALM.Buscar_FichaProducto]
@codigoPr varchar(100),
@UN int
as
select f.item, f.medida, k.descripcion as Marca, f.fecha_vencimiento, f.cantidad, f.precio,  
convert(decimal(18,2),f.cantidad * f.precio) as total, k.codMarca
from  
tb_FichaProducto f
inner join tb_Producto p
on f.codProducto = p.codigoPr
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and f.codUN = case when @UN = -1 then f.codUN else @UN end
 
go

ALTER proc [dbo].[ALM.NotaPedidoDetalle_Insertar](
@codigoPedido int,
@Coditem int,
@descripcion varchar(200),
@cantActual int,
@medida varchar(200),
@marca int,
@fechaCaducidad date,
@precioUnitario decimal(18,2),
@precioTotal decimal(18,2)
  )
as
begin

insert tb_NotaPedidoDetalle
(codigoPedido,CodItem,descripcion,cantActual,medida,marca,fechaCaducidad, preciounitario, preciototal)
values (@codigoPedido,@CodItem,@descripcion,@cantActual,@medida,@marca,@fechaCaducidad, @preciounitario, convert(decimal(18,2),@preciounitario*@cantActual))

end

go

create procedure [ALM.NotaPedido_Buscar]
as
select Codigopedido, fechaemision, u.desUn,
areasolicitante
from tb_notapedido p
inner join tb_unidadnegocio u
on u.codigo = p.almacenorigen
order by codigopedido desc

go

create procedure [ALM.NotaPedidoDetalle_Buscar]
@codigoPedido int
as
select codItem, medida,p.descripcion, m.descripcion as marca,fechacaducidad, cantactual,
preciounitario, preciototal
from tb_notapedidodetalle p
inner join tb_marca m
on m.codMarca = p.marca
where codigopedido =@codigopedido
order by codigopedidodet asc 

go

update tb_unidadnegocio set desun = direcun  

go

insert tb_unidadnegocio values ('Surco','Surco')
insert tb_unidadnegocio values ('San Borja','San Borja')
insert tb_unidadnegocio values ('Surquillo','Surquillo')
insert tb_unidadnegocio values ('Jesus Maria','Jesus Maria')
insert tb_unidadnegocio values ('Lince','Lince')
insert tb_unidadnegocio values ('Pueblo Libre','Pueblo Libre')
insert tb_unidadnegocio values ('La Molina','La Molina')

go



ALTER PROCEDURE [dbo].[ALM.Cargar_Unidad]
AS    
BEGIN  
Select  codigo as codigo,
	desUn as descripcion
	from dbo.tb_UnidadNegocio
	order by desUN asc
END


go



insert tb_marca values ('San Fernando',1)
insert tb_marca values ('Razzeto',1)
insert tb_marca values ('Segoviana',1)
insert tb_marca values ('Otto kunz',1)

go



update tb_producto set familia = 'Alimentos', subfamilia = 'Verduras' where codigo = 1
update tb_producto set familia = 'Alimentos', subfamilia = 'Verduras' where codigo = 2
update tb_producto set familia = 'Ingredientes', subfamilia = 'Condimentos' where codigo = 3
update tb_producto set familia = 'Alimentos', subfamilia = 'Lacteos' where codigo = 4

go


ALTER procedure [dbo].[ALM.Buscar_Productos_UN]
@codigoPr varchar(100),
@nombre varchar(100),
@UN int
as
select distinct p.codigo, p.codigoPr, u.desUn as UN, p.nombre, p.descripcion, p.familia, 
p.subfamilia, k.descripcion as Marca, u.codigo as CodUN, k.codMarca as CodMarca
from tb_producto p
inner join tb_FichaProducto f
on f.codProducto = p.codigoPr
inner join  tb_UnidadNegocio u
on u.codigo = f.codUN
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and p.nombre like '%'+ @nombre +'%'
and u.codigo = case when @UN = -1 then u.codigo else @UN end



go

ALTER proc [dbo].[ALM.ListarHojaInventarioxCod] 
@codCabecera int
as
begin
select codigo ,fecha, cab.referencia, isnull(cab.responsable,'')responsable, estado
from dbo.tb_InventarioCabecera cab
where codigo = @codCabecera 
end

go

ALTER proc [dbo].[ALM.ListarHojaInventario] 
@fechaIni varchar(10) = null,
@fechaFin varchar(10) = null,
@estado int =null
as
begin
select codigo ,fecha, cab.referencia, isnull(cab.responsable,'')responsable, ISNULL(descripcion,'')estado,correlativo,est.estado
from dbo.tb_InventarioCabecera cab
INNER JOIN dbo.tb_estadoInv EST ON est.codEstadoInv=cab.estado
where  CAB.estado <> 3 and
(isnull(@fechaIni,'')='' OR cab.fecha >= @fechaIni)   
  AND (isnull(@fechaFin,'')='' OR cab.fecha <= @fechaFin)  
  AND (isnull(@estado,-1)=-1 OR cab.estado = @estado)   
end


go


alter procedure [ALM.NotaPedido_Buscar]
as
select Codigopedido, fechaemision, 
areasolicitante
from tb_notapedido p
order by codigopedido desc

go

ALTER procedure [dbo].[ALM.Buscar_FichaProducto]
@codigoPr varchar(100),
@UN int
as
select f.item, f.medida, k.descripcion as Marca, f.fecha_vencimiento, 
case when (f.cantidad - (select isnull(sum(d.cantActual),0) from tb_notapedidodetalle d where d.coditem = f.item)) < 0 
then 0 else (f.cantidad - (select isnull(sum(d.cantActual),0) from tb_notapedidodetalle d where d.coditem = f.item)) end as cantidad, 
f.precio,  
convert(decimal(18,2),
case when (f.cantidad - (select isnull(sum(d.cantActual),0) from tb_notapedidodetalle d where d.coditem = f.item)) < 0 
then 0 else (f.cantidad - (select isnull(sum(d.cantActual),0) from tb_notapedidodetalle d where d.coditem = f.item)) end
 * f.precio) as total, k.codMarca
from  
tb_FichaProducto f
inner join tb_Producto p
on f.codProducto = p.codigoPr
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and f.codUN = case when @UN = -1 then f.codUN else @UN end

go

ALTER proc [dbo].[ALM.ListarHojaInventario] 
@fechaIni datetime = null,
@fechaFin datetime = null,
@estado int =null
as
begin
select codigo ,fecha, cab.referencia, isnull(cab.responsable,'')responsable, ISNULL(descripcion,'')estado,correlativo,est.estado
from dbo.tb_InventarioCabecera cab
INNER JOIN dbo.tb_estadoInv EST ON est.codEstadoInv=cab.estado
where  CAB.estado <> 3 and
(isnull(@fechaIni,'01/01/2000')='01/01/2000' OR cab.fecha >= convert(datetime,@fechaIni))   
  AND (isnull(@fechaFin,'01/01/2500')='01/01/2500' OR cab.fecha <= convert(datetime,@fechaFin))  
  AND (isnull(@estado,-1)=-1 OR cab.estado = @estado)   
end


go




--===============================FIN MODULO ALMACEN ========================================================

--============== INICIO  MODULO TRABAJADORES =============================================================================

/****** Object:  Table [dbo].[TR_PeriodoSemanal]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TR_PeriodoSemanal](
	[IdSemana] [int] IDENTITY(1,1) NOT NULL,
	[Inicio] [smalldatetime] NOT NULL,
	[Fin] [smalldatetime] NOT NULL,
 CONSTRAINT [TR_PK_PeriodoSemanal] PRIMARY KEY CLUSTERED 
(
	[IdSemana] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TR_PeriodoSemanal] ON
INSERT [dbo].[TR_PeriodoSemanal] ([IdSemana], [Inicio], [Fin]) VALUES (1, CAST(0xA1990000 AS SmallDateTime), CAST(0xA19F0000 AS SmallDateTime))
INSERT [dbo].[TR_PeriodoSemanal] ([IdSemana], [Inicio], [Fin]) VALUES (2, CAST(0xA1A00000 AS SmallDateTime), CAST(0xA1A60000 AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[TR_PeriodoSemanal] OFF
/****** Object:  Table [dbo].[TR_NivelFormacion]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_NivelFormacion](
	[IdNivelFormacion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [TR_PK_NivelFormacion] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_Nacionalidad]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Nacionalidad](
	[IdNacionalidad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [TR_PK_Nacionalidad] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_Idioma]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Idioma](
	[IdIdioma] [int] NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [TR_PK_Idioma] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_Horas]    Script Date: 05/15/2013 19:11:04 ******/
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
/****** Object:  Table [dbo].[TR_Disponibilidad]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Disponibilidad](
	[IdDisponibilidad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [TR_PK_Disponibilidad] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_Cese]    Script Date: 05/15/2013 19:11:04 ******/
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
/****** Object:  Table [dbo].[TR_Cargo]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_Cargo](
	[IdCargo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [TR_PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[IdCargo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_Cargo] ON
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (1, N'Administrador')
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (2, N'Asistente')
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (3, N'Entrenador')
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (4, N'Produccion ')
INSERT [dbo].[TR_Cargo] ([IdCargo], [Descripcion]) VALUES (5, N'Servicios')
SET IDENTITY_INSERT [dbo].[TR_Cargo] OFF
/****** Object:  Table [dbo].[TR_TipoTrabajador]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_TipoTrabajador](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcin] [varchar](50) NULL,
 CONSTRAINT [TR_PK_TipoTrabajador] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_TipoTrabajador] ON
INSERT [dbo].[TR_TipoTrabajador] ([Id], [Descripcin]) VALUES (1, N'Full Time')
INSERT [dbo].[TR_TipoTrabajador] ([Id], [Descripcin]) VALUES (2, N'Part Time')
SET IDENTITY_INSERT [dbo].[TR_TipoTrabajador] OFF
/****** Object:  Table [dbo].[TR_TipoRegistroHora]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_TipoRegistroHora](
	[IdTipoRegistroHora] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [TR_PK_TipoRegistroHora] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_SituacionFormacion]    Script Date: 05/15/2013 19:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TR_SituacionFormacion](
	[IdSituacionFormacion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [TR_PK_SituacionFormacion] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_Postulante]    Script Date: 05/15/2013 19:11:04 ******/
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
 CONSTRAINT [TR_PK_Postulante] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_Trabajador]    Script Date: 05/15/2013 19:11:04 ******/
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
 CONSTRAINT [TR_PK_Trabajador] PRIMARY KEY CLUSTERED 
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
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (3, N'MIguel', N'Lopex', N'Castro', 4, 2, CAST(0x0700709A4A320000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x87150B00 AS Date), N'1', N'40144244', N'San Isidro', N'98373523', N'0', N'M', N'mcastro@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (4, N'Edgar ', N'Huarcaya', N'Chocce', 3, 2, NULL, NULL, CAST(0x68150B00 AS Date), N'1', N'40144245', N'San Borja', N'95965432', N'0', N'M', N'echooce@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (6, N'Henry', N'Lopez', N'Iparragauirre', 2, 1, NULL, NULL, CAST(0xCE140B00 AS Date), N'1', N'40144246', N'San Juan', N'48596453', N'0', N'M', N'hlopez@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (7, N'Frank', N'Taya', N'Castro', 3, 1, NULL, NULL, CAST(0xDC140B00 AS Date), N'1', N'41331777', N'Miraflores', N'4859544', N'0', N'M', N'fcastrot@hotmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (8, N'Jorge', N'Mendoza', N'Castro', 3, 1, NULL, NULL, CAST(0xE4140B00 AS Date), N'1', N'41331772', N'Miraflores', N'4859544', N'0', N'M', N'fcastrot@hotmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (9, N'111111', N'111', N'1', 1, 1, NULL, NULL, CAST(0xEC140B00 AS Date), N'1', N'xxx', N'xx', N'xxx', N'1', N'M', N'xxx')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (10, N'William', N'Llanos', N'Rodriguez', 1, 1, NULL, NULL, CAST(0xD10A0B00 AS Date), N'1', N'40434266', N'Miraflores', N'46575453', N'0', N'M', N'wrodriguez@gmail.com')
INSERT [dbo].[TR_Trabajador] ([IdTrabajador], [Nombre], [ApellidoMaterno], [ApellidoPaterno], [IdCargo], [IdTipoTrabjador], [HoraInicio], [HoraFin], [FechaNacimiento], [TipoDocumento], [NumeroDocumento], [Direccion], [Telefono], [Activo], [Sexo], [Correo]) VALUES (11, N'Sergio', N'Tovar', N'Marcelo', 5, 1, NULL, NULL, CAST(0xD10A0B00 AS Date), N'1', N'41331642', N'San Borja', N'48576755', N'0', N'M', N'smarcelo@gmail.com')
SET IDENTITY_INSERT [dbo].[TR_Trabajador] OFF
/****** Object:  StoredProcedure [dbo].[ListarIdioma]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarDisponibilidad]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarCargo]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarNivel]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarNacionalidad]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarTipoTrabajador]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarSituacion]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarSemana]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHoras]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  Table [dbo].[TR_HoraExtra]    Script Date: 05/15/2013 19:11:06 ******/
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
 CONSTRAINT [TR_PK_HoraExtra] PRIMARY KEY CLUSTERED 
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
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (3, 1, 1, CAST(0x070010ACD1530000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700709A4A320000 AS Time), CAST(0x0700709A4A320000 AS Time), CAST(0x070048F9F66C0000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (3, 1, 2, CAST(0x0700E03495640000 AS Time), CAST(0x07001882BA7D0000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700B0BD58750000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (3, 1, 3, CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (6, 2, 1, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (6, 2, 2, CAST(0x07002058A3A70000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (7, 1, 1, CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070008D6E8290000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (7, 1, 2, CAST(0x070010ACD1530000 AS Time), CAST(0x0700B0BD58750000 AS Time), CAST(0x070048F9F66C0000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x07001882BA7D0000 AS Time), CAST(0x07007870335C0000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (8, 1, 1, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (8, 1, 2, CAST(0x0700E80A7E8E0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (8, 2, 1, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[TR_HoraExtra] ([IdTrabajador], [IdSemana], [IdTipoRegistroHora], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (8, 2, 2, CAST(0x07001882BA7D0000 AS Time), CAST(0x07001882BA7D0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time))
/****** Object:  Table [dbo].[TR_HabilidadLinguistica]    Script Date: 05/15/2013 19:11:06 ******/
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
 CONSTRAINT [TR_PK_HabilidadLinguistica] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_FormacionProfesional]    Script Date: 05/15/2013 19:11:06 ******/
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
 CONSTRAINT [TR_PK_FormacionProfesional] PRIMARY KEY CLUSTERED 
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
/****** Object:  Table [dbo].[TR_Experiencia]    Script Date: 05/15/2013 19:11:06 ******/
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
 CONSTRAINT [TR_PK_Experiencia] PRIMARY KEY CLUSTERED 
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
/****** Object:  StoredProcedure [dbo].[ActualizarTrabajador]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarPostulante]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarCese]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarTrabajador]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarPostulante]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarPostulante]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ReporteTrabajadores]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  Table [dbo].[TR_TrabajadorPuestos]    Script Date: 05/15/2013 19:11:06 ******/
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
	[Activo] [char](1) NULL,
	[codigo] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TR_TrabajadorPuestos] ON
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (7, 3, 1, CAST(0x0C370B00 AS Date), CAST(0xDF3C0B00 AS Date), N'0', 1)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (8, 3, 1, CAST(0x0C370B00 AS Date), CAST(0xB83F0B00 AS Date), N'0', 2)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (9, 1, 1, CAST(0x10370B00 AS Date), CAST(0x2A370B00 AS Date), N'0', 4)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (2, 1, 1, CAST(0xA3350B00 AS Date), CAST(0x10370B00 AS Date), N'0', 5)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (1, 1, 2, CAST(0xA3350B00 AS Date), CAST(0x10370B00 AS Date), N'0', 6)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (11, 5, 1, CAST(0x7A380B00 AS Date), CAST(0x043A0B00 AS Date), N'0', 8)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (10, 1, 1, CAST(0x9F350B00 AS Date), CAST(0x613B0B00 AS Date), N'0', 9)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (3, 4, 2, CAST(0xA3350B00 AS Date), CAST(0x10370B00 AS Date), N'0', 10)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (4, 3, 2, CAST(0xA3350B00 AS Date), CAST(0x10370B00 AS Date), N'0', 11)
INSERT [dbo].[TR_TrabajadorPuestos] ([idTrabajador], [idCargo], [idTipoTrabajador], [FechaInicio], [FechaFin], [Activo], [codigo]) VALUES (6, 2, 1, CAST(0xA3350B00 AS Date), CAST(0x10370B00 AS Date), N'0', 12)
SET IDENTITY_INSERT [dbo].[TR_TrabajadorPuestos] OFF
/****** Object:  Table [dbo].[TR_ProgramacionHoraExtra]    Script Date: 05/15/2013 19:11:06 ******/
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
 CONSTRAINT [TR_PK_ProgramacionHoraExtra] PRIMARY KEY CLUSTERED 
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
INSERT [dbo].[TR_ProgramacionHoraExtra] ([IdTrabajador], [IdSemana], [Lunes], [Martes], [Miercoles], [Jueves], [Viernes], [Sabado], [Domingo]) VALUES (8, 1, 1, 0, 0, 0, 0, 0, 0)
/****** Object:  StoredProcedure [dbo].[ListarTrabajadoresActivos]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarTrabajador]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarTrabajadorPuestos]    Script Date: 05/15/2013 19:11:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ListarTrabajadorPuestos]--3
	-- Add the parameters for the stored procedure here
	@idTrabajador as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT      codigo,idtrabajador,
			(select descripcion from TR_Cargo C where C.idCargo=TP.idCargo) as Cargo,
			(select Descripcin from TR_TipoTrabajador T where T.id=TP.idTipoTrabajador)as Tipo,
			CONVERT(VARCHAR(24),FechaInicio,103)as FechaInicio,CONVERT(VARCHAR(24),FechaFin,103)as FechaFin
			

FROM            TR_TrabajadorPuestos TP
where idTrabajador=@idTrabajador
order by codigo desc
END
GO
/****** Object:  StoredProcedure [dbo].[ListarLinguistica]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarTrabajadorPuesto]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaViernes]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaSabado]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaMiercoles]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaMartes]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaLunes]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaJueves]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorasxSemanaDomingo]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHorarioxSemanaxTrabajador]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarHoraExtrasxSemanaxTrabajador]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarFormacion]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarExperiencia]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarHorario]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarHoraExtra]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarHabilidad]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarFormacion]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IngresarExperiencia]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarLinguistica]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarFormacion]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[EliminarExperiencia]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarLinguistica]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarFormacion]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  StoredProcedure [dbo].[ActualizarFechasTrabajadorPuesto]    Script Date: 05/15/2013 19:11:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[ActualizarFechasTrabajadorPuesto]-- 23
	-- Add the parameters for the stored procedure here
	--@idPostulante as int,
	@Codigo int,
	@FechaInicio as date,
	@FechaFin as date
	
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
  update TR_TrabajadorPuestos set FechaInicio=@FechaInicio, FechaFin=@FechaFin where codigo=@Codigo
 

END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarExperiencia]    Script Date: 05/15/2013 19:11:06 ******/
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
/****** Object:  ForeignKey [FK_Postulante_Cargo]    Script Date: 05/15/2013 19:11:04 ******/
ALTER TABLE [dbo].[TR_Postulante]  WITH CHECK ADD  CONSTRAINT [FK_Postulante_Cargo] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_Postulante] CHECK CONSTRAINT [FK_Postulante_Cargo]
GO
/****** Object:  ForeignKey [FK_Postulante_Disponibilidad]    Script Date: 05/15/2013 19:11:04 ******/
ALTER TABLE [dbo].[TR_Postulante]  WITH CHECK ADD  CONSTRAINT [FK_Postulante_Disponibilidad] FOREIGN KEY([IdDisponibilidad])
REFERENCES [dbo].[TR_Disponibilidad] ([IdDisponibilidad])
GO
ALTER TABLE [dbo].[TR_Postulante] CHECK CONSTRAINT [FK_Postulante_Disponibilidad]
GO
/****** Object:  ForeignKey [FK_Postulante_Nacionalidad]    Script Date: 05/15/2013 19:11:04 ******/
ALTER TABLE [dbo].[TR_Postulante]  WITH CHECK ADD  CONSTRAINT [FK_Postulante_Nacionalidad] FOREIGN KEY([IdNacionalidad])
REFERENCES [dbo].[TR_Nacionalidad] ([IdNacionalidad])
GO
ALTER TABLE [dbo].[TR_Postulante] CHECK CONSTRAINT [FK_Postulante_Nacionalidad]
GO
/****** Object:  ForeignKey [FK_Trabajador_Cargo]    Script Date: 05/15/2013 19:11:04 ******/
ALTER TABLE [dbo].[TR_Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_Trabajador_Cargo] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_Trabajador] CHECK CONSTRAINT [FK_Trabajador_Cargo]
GO
/****** Object:  ForeignKey [FK_Trabajador_TipoTrabajador]    Script Date: 05/15/2013 19:11:04 ******/
ALTER TABLE [dbo].[TR_Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_Trabajador_TipoTrabajador] FOREIGN KEY([IdTipoTrabjador])
REFERENCES [dbo].[TR_TipoTrabajador] ([Id])
GO
ALTER TABLE [dbo].[TR_Trabajador] CHECK CONSTRAINT [FK_Trabajador_TipoTrabajador]
GO
/****** Object:  ForeignKey [FK_HoraExtra_PeriodoSemanal]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_HoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_HoraExtra_PeriodoSemanal] FOREIGN KEY([IdSemana])
REFERENCES [dbo].[TR_PeriodoSemanal] ([IdSemana])
GO
ALTER TABLE [dbo].[TR_HoraExtra] CHECK CONSTRAINT [FK_HoraExtra_PeriodoSemanal]
GO
/****** Object:  ForeignKey [FK_HoraExtra_TipoRegistroHora]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_HoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_HoraExtra_TipoRegistroHora] FOREIGN KEY([IdTipoRegistroHora])
REFERENCES [dbo].[TR_TipoRegistroHora] ([IdTipoRegistroHora])
GO
ALTER TABLE [dbo].[TR_HoraExtra] CHECK CONSTRAINT [FK_HoraExtra_TipoRegistroHora]
GO
/****** Object:  ForeignKey [FK_HoraExtra_Trabajador]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_HoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_HoraExtra_Trabajador] FOREIGN KEY([IdTrabajador])
REFERENCES [dbo].[TR_Trabajador] ([IdTrabajador])
GO
ALTER TABLE [dbo].[TR_HoraExtra] CHECK CONSTRAINT [FK_HoraExtra_Trabajador]
GO
/****** Object:  ForeignKey [FK_HabilidadLinguistica_Idioma]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_HabilidadLinguistica]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadLinguistica_Idioma] FOREIGN KEY([IdIdioma])
REFERENCES [dbo].[TR_Idioma] ([IdIdioma])
GO
ALTER TABLE [dbo].[TR_HabilidadLinguistica] CHECK CONSTRAINT [FK_HabilidadLinguistica_Idioma]
GO
/****** Object:  ForeignKey [FK_HabilidadLinguistica_Postulante]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_HabilidadLinguistica]  WITH CHECK ADD  CONSTRAINT [FK_HabilidadLinguistica_Postulante] FOREIGN KEY([IdPostulante])
REFERENCES [dbo].[TR_Postulante] ([IdPostulante])
GO
ALTER TABLE [dbo].[TR_HabilidadLinguistica] CHECK CONSTRAINT [FK_HabilidadLinguistica_Postulante]
GO
/****** Object:  ForeignKey [FK_FormacionProfesional_NivelFormacion]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_FormacionProfesional]  WITH CHECK ADD  CONSTRAINT [FK_FormacionProfesional_NivelFormacion] FOREIGN KEY([IdNivelFormacion])
REFERENCES [dbo].[TR_NivelFormacion] ([IdNivelFormacion])
GO
ALTER TABLE [dbo].[TR_FormacionProfesional] CHECK CONSTRAINT [FK_FormacionProfesional_NivelFormacion]
GO
/****** Object:  ForeignKey [FK_FormacionProfesional_Postulante]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_FormacionProfesional]  WITH CHECK ADD  CONSTRAINT [FK_FormacionProfesional_Postulante] FOREIGN KEY([IdPostulante])
REFERENCES [dbo].[TR_Postulante] ([IdPostulante])
GO
ALTER TABLE [dbo].[TR_FormacionProfesional] CHECK CONSTRAINT [FK_FormacionProfesional_Postulante]
GO
/****** Object:  ForeignKey [FK_FormacionProfesional_SituacionFormacion]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_FormacionProfesional]  WITH CHECK ADD  CONSTRAINT [FK_FormacionProfesional_SituacionFormacion] FOREIGN KEY([IdSituacionFormacion])
REFERENCES [dbo].[TR_SituacionFormacion] ([IdSituacionFormacion])
GO
ALTER TABLE [dbo].[TR_FormacionProfesional] CHECK CONSTRAINT [FK_FormacionProfesional_SituacionFormacion]
GO
/****** Object:  ForeignKey [FK_Experiencia_Cargo]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_Experiencia]  WITH CHECK ADD  CONSTRAINT [FK_Experiencia_Cargo] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_Experiencia] CHECK CONSTRAINT [FK_Experiencia_Cargo]
GO
/****** Object:  ForeignKey [FK_Experiencia_Postulante]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_Experiencia]  WITH CHECK ADD  CONSTRAINT [FK_Experiencia_Postulante] FOREIGN KEY([IdPostulante])
REFERENCES [dbo].[TR_Postulante] ([IdPostulante])
GO
ALTER TABLE [dbo].[TR_Experiencia] CHECK CONSTRAINT [FK_Experiencia_Postulante]
GO
/****** Object:  ForeignKey [FK_TrabajadorPuestos_Cargo]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_TrabajadorPuestos]  WITH CHECK ADD  CONSTRAINT [FK_TrabajadorPuestos_Cargo] FOREIGN KEY([idCargo])
REFERENCES [dbo].[TR_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[TR_TrabajadorPuestos] CHECK CONSTRAINT [FK_TrabajadorPuestos_Cargo]
GO
/****** Object:  ForeignKey [FK_TrabajadorPuestos_TipoTrabajador]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_TrabajadorPuestos]  WITH CHECK ADD  CONSTRAINT [FK_TrabajadorPuestos_TipoTrabajador] FOREIGN KEY([idTipoTrabajador])
REFERENCES [dbo].[TR_TipoTrabajador] ([Id])
GO
ALTER TABLE [dbo].[TR_TrabajadorPuestos] CHECK CONSTRAINT [FK_TrabajadorPuestos_TipoTrabajador]
GO
/****** Object:  ForeignKey [FK_TrabajadorPuestos_Trabajador]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_TrabajadorPuestos]  WITH CHECK ADD  CONSTRAINT [FK_TrabajadorPuestos_Trabajador] FOREIGN KEY([idTrabajador])
REFERENCES [dbo].[TR_Trabajador] ([IdTrabajador])
GO
ALTER TABLE [dbo].[TR_TrabajadorPuestos] CHECK CONSTRAINT [FK_TrabajadorPuestos_Trabajador]
GO
/****** Object:  ForeignKey [FK_ProgramacionHoraExtra_PeriodoSemanal]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionHoraExtra_PeriodoSemanal] FOREIGN KEY([IdSemana])
REFERENCES [dbo].[TR_PeriodoSemanal] ([IdSemana])
GO
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra] CHECK CONSTRAINT [FK_ProgramacionHoraExtra_PeriodoSemanal]
GO
/****** Object:  ForeignKey [FK_ProgramacionHoraExtra_Trabajador]    Script Date: 05/15/2013 19:11:06 ******/
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra]  WITH CHECK ADD  CONSTRAINT [FK_ProgramacionHoraExtra_Trabajador] FOREIGN KEY([IdTrabajador])
REFERENCES [dbo].[TR_Trabajador] ([IdTrabajador])
GO
ALTER TABLE [dbo].[TR_ProgramacionHoraExtra] CHECK CONSTRAINT [FK_ProgramacionHoraExtra_Trabajador]
GO

--===============================FIN TRABAJADORES ========================================================

--============== INICIO  MODULO ORDENES =============================================================================

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
/*
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
*/
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
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (1, N'A0001', N'Aracely',  N'Sandoval')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (2, N'A0002', N'Veronica', N'Zapata')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (3, N'A0003', N'Nathaly',  N'Carrera')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (4, N'A0004', N'Elizabeth',  N'Ramos')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (5, N'A0005', N'Monica',  N'Vargas')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (6, N'A0006', N'Sussy',  N'Garcia')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (7, N'A0007', N'Cecilia',  N'Zegarra')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (8, N'A0008', N'Rosa',  N'Carreño')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (9, N'A0009', N'Yesica',  N'Mulano')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (10, N'A0010', N'Carmen',  N'Villegas')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (11, N'A0011', N'Roxana',  N'Loayza')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (12, N'A0012', N'Angelica',  N'Barzola')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (13, N'A0013', N'Tania',  N'Delgado')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (14, N'A0014', N'Isabel',  N'Rios')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (15, N'A0015', N'Mariela',  N'Guevara')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (16, N'A0016', N'Pedro',  N'Rodriguez')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (17, N'A0017', N'Mario',  N'Solorzano')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (18, N'A0018', N'Alberto',  N'Tello')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (19, N'A0019', N'Cesar',  N'Rojas')
INSERT [dbo].[Anfitriones] ([IdAnfitrion], [Codigo], [Nombres], [Apellidos]) VALUES (20, N'A0020', N'Raul',  N'Pariona')

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
	[CODIGO] [int] NOT NULL,
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
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (1, N'Limon', 1, 10, 8, 23, 4, 3, 10, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (2, N'Fideo', 1, 15, 10, 30, 5, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (3, N'Agua', 1, 5, 2, 5, 2, 3, 0, 0)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (4, N'Harina', 1, 10, 2, 10, 2, 2, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (5, N'Gaseosa', 1, 20, 20, 20, 20, 2, 0, 0)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (6, N'Arroz', 1, 100, 5, 100, 10, 2, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (7, N'Frejol', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (8, N'Aceite Vegetal', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (9, N'Aceite Oliva', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (10, N'Manteca', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (11, N'Azucar', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (12, N'Sal', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (13, N'Pimienta', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (14, N'Comino', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (15, N'Huevos', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (16, N'Aceituna', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (17, N'Carne Res', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (18, N'Carne de Pollo', 1, 50, 4, 60, 10, 1, 0, 1)
INSERT [dbo].[Insumos] ([IdInsumo], [NombreInsumo], CODIGO, [StockNormal], [CantidadRequerida], [StockActual], [StockMinimo], [IdPrioridad], [CantidadSolicitada], [Estado]) VALUES (19, N'Carne de Cerdo', 1, 50, 4, 60, 10, 1, 0, 1)

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
ALTER TABLE [dbo].[Insumos]  WITH CHECK ADD  CONSTRAINT [FK_Insumos_UnidadesMedida] FOREIGN KEY([CODIGO])
REFERENCES [dbo].TB_UnidadMedida ([CODIGO])
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

INSERT INTO TB_LOCAL (VC_NOMBRE,VC_DIRECCION,VC_TELEFONO,IN_CAPACIDAD) VALUES('LOCAL CHILIS - UPC','PRIMAVERA','666-66666',223)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(1,4,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(2,4,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(3,4,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(4,4,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(5,6,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(6,6,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(7,8,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(8,8,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(9,10,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(10,10,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(11,12,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(12,12,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(13,14,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(14,14,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(15,16,'A',1)
INSERT INTO TB_MESA (VC_NUMERO,IN_CAPACIDAD,CH_ESTADO,IN_CODIGO_LOCAL) VALUES(16,24,'A',1)
INSERT INTO TB_UNIDADMEDIDA(DESMED) VALUES('UNIDAD')

SET IDENTITY_INSERT [dbo].TB_CLASIFICACION_CLIENTE ON
INSERT [dbo].TB_CLASIFICACION_CLIENTE ([IN_CODIGO_CLASIFICACION],[VC_NOMBRE]) VALUES (1, N'NATURAL')
INSERT [dbo].TB_CLASIFICACION_CLIENTE ([IN_CODIGO_CLASIFICACION],[VC_NOMBRE]) VALUES (2, N'JURIDICA')
SET IDENTITY_INSERT [dbo].TB_CLASIFICACION_CLIENTE OFF

SET IDENTITY_INSERT [dbo].[TB_TIPO_DOCUMENTO] ON
INSERT [dbo].[TB_TIPO_DOCUMENTO] ([IN_CODIGO_TIPO_DOCUMENTO],[VC_NOMBRE],[VC_ACRONIMO]) VALUES (1, N'DNI', N'DNI')
INSERT [dbo].[TB_TIPO_DOCUMENTO] ([IN_CODIGO_TIPO_DOCUMENTO],[VC_NOMBRE],[VC_ACRONIMO]) VALUES (2, N'OTROS', N'OTRO')
SET IDENTITY_INSERT [dbo].[TB_TIPO_DOCUMENTO] OFF

SET IDENTITY_INSERT [dbo].[TB_CLIENTE] ON
INSERT [dbo].[TB_CLIENTE] ([IN_CODIGO_CLIENTE],[VC_NOMBRES],[VC_APELLIDO_PATERNO],[VC_APELLIDO_MATERNO],[VC_RAZON_SOCIAL],[VC_NUMERO_DOCUMENTO],[DT_FECHA_NACIMIENTO],[IN_CODIGO_TIPO_DOCUMENTO],[IN_CODIGO_CLASIFICACION],[VC_EMAIL],[CH_SEXO],[VC_TELEFONO_PRINCIPAL],[VC_CONTACTO],[CH_ESTADO_CLIENTE],[CH_TIPO_CLIENTE]) VALUES (1,'ROSMERY','GALARZA','VILLAREAL','GALARZA VILLAREAL ROSMERY','19196423','19870821',1,1,'ROSMERY.GALARZA@GMAIL.COM','F','478-8569','..','A','F')
INSERT [dbo].[TB_CLIENTE] ([IN_CODIGO_CLIENTE],[VC_NOMBRES],[VC_APELLIDO_PATERNO],[VC_APELLIDO_MATERNO],[VC_RAZON_SOCIAL],[VC_NUMERO_DOCUMENTO],[DT_FECHA_NACIMIENTO],[IN_CODIGO_TIPO_DOCUMENTO],[IN_CODIGO_CLASIFICACION],[VC_EMAIL],[CH_SEXO],[VC_TELEFONO_PRINCIPAL],[VC_CONTACTO],[CH_ESTADO_CLIENTE],[CH_TIPO_CLIENTE]) VALUES (2,'ROXANA','MORALES','SOLORZANO','UPC - EPE','10124523412','19900101',2,2,'ATENCIONUPC@UPC.EDU.PE','','572-8569','..','A','F')
SET IDENTITY_INSERT [dbo].[TB_CLIENTE] OFF


SET IDENTITY_INSERT [dbo].TB_RESERVA ON
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (1,'20130517','14:30','16:30',9,'..','A',9,1)
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (2,'20130517','14:30','16:30',15,'..','A',15,2)
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (3,'20130518','15:30','18:30',7,'..','A',7,1)
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (4,'20130518','15:30','18:30',12,'..','A',12,2)
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (5,'20130519','13:30','15:30',5,'..','A',5,1)
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (6,'20130519','13:30','15:30',8,'..','A',8,2)
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (7,'20130520','16:30','19:30',14,'..','A',13,1)
INSERT [dbo].TB_RESERVA ([IN_CODIGO_RESERVA],[DT_FECHA_RESERVA],[VC_HORA_INICIO],[VC_HORA_FIN],[IN_CANTIDAD_PERSONAS],[VC_OBSERVACION],[CH_ESTADO],[IN_CODIGO_MESA],[IN_CODIGO_CLIENTE]) VALUES (8,'20130520','16:30','19:30',23,'..','A',16,2)
SET IDENTITY_INSERT [dbo].TB_RESERVA OFF

--===============================FIN MODULO ORDENES ========================================================






