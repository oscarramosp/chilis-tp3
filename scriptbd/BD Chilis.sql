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