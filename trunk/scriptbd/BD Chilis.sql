CREATE DATABASE CHILIS
GO

USE CHILIS
GO

--============== INICIO  MODULO CLIENTES Y RESERVAS =============================================================================

CREATE TABLE TB_CLIENTE (
        IN_CODIGO_CLIENTE                       INT IDENTITY (1,1) NOT NULL,
        VC_NOMBRES                                      VARCHAR(128),
        VC_APELLIDO_PATERNO                     VARCHAR(128),
        VC_APELLIDO_MATERNO                     VARCHAR(128),
        VC_RAZON_SOCIAL                         VARCHAR(256),
        VC_NUMERO_DOCUMENTO                     VARCHAR(64),
        DT_FECHA_NACIMIENTO                     DATETIME,
        IN_CODIGO_TIPO_DOCUMENTO        INT NOT NULL,
        IN_CODIGO_CLASIFICACION         INT,
        VC_EMAIL                                        VARCHAR(64),
        CH_SEXO                                         CHAR(1),
        VC_TELEFONO_PRINCIPAL           VARCHAR(32),
        VC_CONTACTO                                     VARCHAR(256),
        CH_ESTADO_CLIENTE                       CHAR(1),
        CH_TIPO_CLIENTE                         CHAR(1)
)
GO

ALTER TABLE TB_CLIENTE
ADD CONSTRAINT PK_TB_CLIENTE_ID PRIMARY KEY(IN_CODIGO_CLIENTE)
GO

CREATE TABLE TB_TIPO_DOCUMENTO (
        IN_CODIGO_TIPO_DOCUMENTO        INT IDENTITY (1,1)  NOT NULL,
        VC_NOMBRE                                       VARCHAR(128),
        VC_ACRONIMO                                     VARCHAR(8)
)
GO

ALTER TABLE TB_TIPO_DOCUMENTO
ADD CONSTRAINT PK_TB_TIPO_DOCUMENTO_ID PRIMARY KEY(IN_CODIGO_TIPO_DOCUMENTO)
GO


ALTER TABLE TB_CLIENTE
ADD CONSTRAINT FK_TB_CLIENTE_TB_TIPO_DOCUMENTO FOREIGN KEY(IN_CODIGO_TIPO_DOCUMENTO)REFERENCES TB_TIPO_DOCUMENTO(IN_CODIGO_TIPO_DOCUMENTO)
GO

CREATE TABLE TB_DIRECCION_CLIENTE (
        IN_CODIGO_DIRECCION                     INT IDENTITY (1,1)  NOT NULL,
        IN_CODIGO_CLIENTE                       INT NOT NULL,
        VC_DIRECCION                            VARCHAR(1024),
        VC_REFERENCIA                           VARCHAR(1024),
        VC_TELEFONO                                     VARCHAR(32),
        CH_TIPO_DIRECCION                       CHAR(1)
)
GO

ALTER TABLE TB_DIRECCION_CLIENTE
ADD CONSTRAINT PK_TB_DIRECCION_CLIENTE_ID PRIMARY KEY(IN_CODIGO_DIRECCION,IN_CODIGO_CLIENTE)
GO

ALTER TABLE TB_DIRECCION_CLIENTE
ADD CONSTRAINT FK_TB_DIRECCION_CLIENTE_TB_CLIENTE FOREIGN KEY(IN_CODIGO_CLIENTE)REFERENCES TB_CLIENTE(IN_CODIGO_CLIENTE)
GO

CREATE TABLE TB_CLASIFICACION_CLIENTE (
        IN_CODIGO_CLASIFICACION         INT IDENTITY (1,1)  NOT NULL,
        VC_NOMBRE                                       VARCHAR(128),
)
GO

ALTER TABLE TB_CLASIFICACION_CLIENTE
ADD CONSTRAINT PK_TB_CLASIFICACION_CLIENTE_ID PRIMARY KEY(IN_CODIGO_CLASIFICACION)
GO

ALTER TABLE TB_CLIENTE
ADD CONSTRAINT FK_TB_CLIENTE_TB_CLASIFICACION_CLIENTE FOREIGN KEY(IN_CODIGO_CLASIFICACION)REFERENCES TB_CLASIFICACION_CLIENTE(IN_CODIGO_CLASIFICACION)
GO

CREATE TABLE TB_PARAMETRO_CLASIFICACION (
        IN_CODIGO_PARAMETRO                     INT IDENTITY (1,1)  NOT NULL,
        VC_NOMBRE                                       VARCHAR(128),
)
GO

ALTER TABLE TB_PARAMETRO_CLASIFICACION
ADD CONSTRAINT PK_TB_PARAMETRO_CLASIFICACION_ID PRIMARY KEY(IN_CODIGO_PARAMETRO)
GO

CREATE TABLE TB_VALOR_PARAMETRO_CLASIFICACION (
        IN_CODIGO_PARAMETRO                     INT NOT NULL,
        IN_CODIGO_CLASIFICACION         INT NOT NULL,
        IN_VALOR                                        INT NOT NULL,
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
        IN_CODIGO_RECLAMO                       INT IDENTITY (1,1) NOT NULL,
        IN_CODIGO_CLIENTE                       INT NOT NULL,   
        DT_FECHA_CREACION                       DATETIME NOT NULL,
        DT_FECHA_CIERRE                         DATETIME,
        VC_DETALLE                                      VARCHAR(2048),
        CH_ESTADO                                       CHAR(1)
)
GO

ALTER TABLE TB_RECLAMO
ADD CONSTRAINT FK_TB_RECLAMO_TB_CLIENTE FOREIGN KEY(IN_CODIGO_CLIENTE)REFERENCES TB_CLIENTE(IN_CODIGO_CLIENTE)
GO

-- Tipo de documento

INSERT INTO TB_TIPO_DOCUMENTO (VC_NOMBRE, VC_ACRONIMO)
VALUES ('Documento Nacional de Identidad','DNI')

INSERT INTO TB_TIPO_DOCUMENTO (VC_NOMBRE, VC_ACRONIMO)
VALUES ('Registro Unico del Contribuyente','RUC')

-- Clientes

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('Juan', 'Pérez', 'Gómez', '25478585', 1, 'jperez@mail.com', 'M', '7458525', '1985-12-05', 'A', 'N')

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('María', 'González', 'Rodríguez', '36521458', 1, 'mgonzalez@mail.com', 'F', '965874587', '1982-10-18', 'A', 'N')

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('José', 'Quispe', 'García', '24145878', 1, 'jquispe@mail.com', 'M', '95147858', '1981-07-21', 'A', 'N')

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('Carlos', 'Ramírez', 'Torres', '36974125', 1, 'cramirez@mail.com', 'M', '3697458', '1970-04-03', 'A', 'N')

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('Rosa', 'Casas', 'Rojas', '36501252', 1, 'rcasas@mail.com', 'F', '97854785', '1984-11-26', 'A', 'N')

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('Ana Lisa', 'Cruzado', 'Guerrero', '01785412', 1, 'acruzado@mail.com', 'F', '3674140', '1975-06-10', 'A', 'N')

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('Claudio', 'Paredes', 'García', '12547858', 1, 'cparedes@mail.com', 'M', '910210214', '1989-07-12', 'A', 'N')

INSERT INTO TB_CLIENTE (VC_NOMBRES, VC_APELLIDO_PATERNO, VC_APELLIDO_MATERNO, VC_NUMERO_DOCUMENTO, IN_CODIGO_TIPO_DOCUMENTO, VC_EMAIL, CH_SEXO, VC_TELEFONO_PRINCIPAL, DT_FECHA_NACIMIENTO, CH_ESTADO_CLIENTE, CH_TIPO_CLIENTE)
VALUES ('Vanessa', 'Peredo', 'Casas', '01236547', 1, 'vperedo@mail.com', 'F', '3698714', '1987-06-12', 'A', 'N')

-- Reclamos
INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (1, '2013-04-03 15:23:00', NULL, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'P')

INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (2, '2013-03-29 14:36:00', '2013-03-30 17:24:00', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum', 'A')

INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (3, '2013-04-01 09:14:00', NULL, 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus', 'P')

INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (4, '2013-04-02 21:03:00', '2013-04-03 13:24:00', 'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?', 'A')

INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (5, '2013-03-28 19:32:00', NULL, 'Ad vel epicurei convenire, ea soluta aliquid deserunt ius, pri in errem putant feugiat. Sed iusto nihil populo an, ex pro novum homero cotidieque. Te utamur civibus eleifend qui, nam ei brute doming concludaturque, modo aliquam facilisi nec no. Vidisse maiestatis constituam eu his, esse pertinacia intellegam ius cu. Eos ei odio veniam, eu sumo altera adipisci eam, mea audiam prodesset persequeris ea. Ad vitae dictas vituperata sed, eum posse labore postulant id', 'P')

INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (6, '2013-03-31 17:10:00', '2013-04-02 12:48:00', 'Te eligendi principes dignissim sit, te vel dicant officiis repudiandae. Id vel sensibus honestatis omittantur, vel cu nobis commune patrioque. In accusata definiebas qui, id tale malorum dolorem sed, solum clita phaedrum ne his. Eos mutat ullum forensibus ex, wisi perfecto urbanitas cu eam, no vis dicunt impetus. Assum novum in pri, vix an suavitate moderatius, id has reformidans referrentur. Elit inciderint omittantur duo ut, dicit democritum signiferumque eu est, ad suscipit delectus mandamus duo. An harum equidem maiestatis nec', 'A')

INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (7, '2013-04-03 18:26:00', NULL, 'Ei populo graeci consulatu mei, has ea stet modus phaedrum. Inani oblique ne has, duo et veritus detraxit. Tota ludus oratio ea mel, offendit persequeris ei vim. Eos dicat oratio partem ut, id cum ignota senserit intellegat. Sit inani ubique graecis ad, quando graecis liberavisse et cum, dicit option eruditi at duo', 'P')

INSERT INTO TB_RECLAMO (IN_CODIGO_CLIENTE, DT_FECHA_CREACION, DT_FECHA_CIERRE, VC_DETALLE, CH_ESTADO)
VALUES (8, '2013-03-27 15:48:00', '2013-03-29 17:32:00', ' Legere expetenda pertinacia ne pro, et pro impetus persius assueverit. Ea mei nullam facete, omnis oratio offendit ius cu. Doming takimata repudiandae usu an, mei dicant takimata id, pri eleifend inimicus euripidis at. His vero singulis ea, quem euripidis abhorreant mei ut, et populo iriure vix. Usu ludus affert voluptaria ei, vix ea error definitiones, movet fastidii signiferumque in qui', 'A')

go

CREATE PROCEDURE SP_ACTUALIZAR_ESTADO_CLIENTE
@IN_CODIGO_CLIENTE INT,
@CH_ESTADO_CLIENTE CHAR(1)
AS
BEGIN

UPDATE  TB_CLIENTE
SET             CH_ESTADO_CLIENTE = @CH_ESTADO_CLIENTE
WHERE   IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

go

CREATE PROCEDURE SP_ELIMINAR_CLIENTE
@IN_CODIGO_CLIENTE INT
AS
BEGIN

DELETE FROM TB_DIRECCION_CLIENTE
WHERE   IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

DELETE FROM TB_CLIENTE
WHERE   IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

go

CREATE PROCEDURE SP_ELIMINAR_DIRECCIONES_CLIENTE
@IN_CODIGO_CLIENTE INT
AS

BEGIN

        DELETE FROM TB_DIRECCION_CLIENTE
        WHERE IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

go

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
        UPDATE  TB_CLIENTE
        SET             VC_NOMBRES = @VC_NOMBRES,
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
        WHERE   IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE
        
END

END
go

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
        UPDATE  TB_DIRECCION_CLIENTE
        SET             VC_DIRECCION = @VC_DIRECCION,
                        VC_REFERENCIA = @VC_REFERENCIA,
                        VC_TELEFONO = @VC_TELEFONO,
                        CH_TIPO_DIRECCION = @CH_TIPO_DIRECCION
        WHERE   IN_CODIGO_DIRECCION = @IN_CODIGO_DIRECCION
        
END

END
go

CREATE PROCEDURE SP_LISTAR_CLIENTES_BUSQUEDA
@CH_TIPO_CLIENTE CHAR(1),
@IN_CODIGO_TIPO_DOCUMENTO INT,
@VC_NUMERO_DOCUMENTO VARCHAR(64),
@VC_RAZON_SOCIAL VARCHAR(256),
@CH_SEXO CHAR(1)
AS
BEGIN

SELECT  IN_CODIGO_CLIENTE,
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
FROM    TB_CLIENTE C
INNER JOIN TB_TIPO_DOCUMENTO TD
ON              C.IN_CODIGO_TIPO_DOCUMENTO = TD.IN_CODIGO_TIPO_DOCUMENTO
WHERE   (C.IN_CODIGO_TIPO_DOCUMENTO = @IN_CODIGO_TIPO_DOCUMENTO OR @IN_CODIGO_TIPO_DOCUMENTO = 0 OR @IN_CODIGO_TIPO_DOCUMENTO IS NULL)
AND     (CH_TIPO_CLIENTE = @CH_TIPO_CLIENTE OR @CH_TIPO_CLIENTE IS NULL OR @CH_TIPO_CLIENTE = '')
AND     (VC_NUMERO_DOCUMENTO = @VC_NUMERO_DOCUMENTO OR @VC_NUMERO_DOCUMENTO IS NULL OR @VC_NUMERO_DOCUMENTO = '')
AND     ((UPPER(VC_RAZON_SOCIAL) LIKE '%' + UPPER(@VC_RAZON_SOCIAL) + '%' OR UPPER(VC_NOMBRES) + ' ' + UPPER(VC_APELLIDO_PATERNO) + ' ' + UPPER(VC_APELLIDO_MATERNO) LIKE '%' + UPPER(@VC_RAZON_SOCIAL) + '%') 
                OR @VC_RAZON_SOCIAL IS NULL OR @VC_RAZON_SOCIAL = '')
AND     (CH_SEXO = @CH_SEXO OR @CH_SEXO IS NULL OR @CH_SEXO = '')

END
go

CREATE PROCEDURE SP_LISTAR_DIRECCIONES_CLIENTE
@IN_CODIGO_CLIENTE INT
AS
BEGIN

SELECT  IN_CODIGO_DIRECCION,
                IN_CODIGO_CLIENTE,
                VC_DIRECCION,
                VC_REFERENCIA,
                VC_TELEFONO,
                CH_TIPO_DIRECCION
FROM    TB_DIRECCION_CLIENTE
WHERE   IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE

END

go

CREATE PROCEDURE SP_LISTAR_TIPOS_DOCUMENTO
@IN_CODIGO_TIPO_DOCUMENTO INT,
@VC_NOMBRE VARCHAR(128),
@VC_ACRONIMO VARCHAR(8)
AS
BEGIN

SELECT IN_CODIGO_TIPO_DOCUMENTO,
        VC_NOMBRE,
        VC_ACRONIMO
FROM    TB_TIPO_DOCUMENTO
WHERE   (IN_CODIGO_TIPO_DOCUMENTO = @IN_CODIGO_TIPO_DOCUMENTO OR @IN_CODIGO_TIPO_DOCUMENTO = 0)
AND     (UPPER(VC_NOMBRE) LIKE '%' + UPPER(@VC_NOMBRE) + '%' OR @VC_NOMBRE IS NULL OR @VC_NOMBRE = '')
AND     (UPPER(VC_ACRONIMO) LIKE '%' + UPPER(@VC_ACRONIMO) + '%' OR @VC_ACRONIMO IS NULL OR @VC_ACRONIMO = '')

END

go

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
go

CREATE PROCEDURE SP_VALIDAR_ELIMINAR_CLIENTE
@IN_CODIGO_CLIENTE INT
AS
BEGIN

SELECT SUM(F.IN_CNT_REGISTRO) IN_CNT_REGISTRO
FROM (
SELECT  COUNT(IN_CODIGO_CLIENTE) IN_CNT_REGISTRO
FROM    TB_RECLAMO
WHERE   IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE
/*UNION
SELECT  COUNT(IN_CODIGO_CLIENTE)
FROM    TB_RE
WHERE   IN_CODIGO_CLIENTE = @IN_CODIGO_CLIENTE*/
) F

END

go

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

--===============================FIN MODULO ALMACEN ========================================================