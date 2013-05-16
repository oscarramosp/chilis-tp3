--FORMATO DE FECHAS
SET DATEFORMAT ymd
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

--Direcciones
INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (1,'Av. La Paz 4912 - San Borja','Cerca al ovalo, a dos cuadras de la avenida principal','4819201','1')

INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (2,'Jr. Yauli 481 - Miraflores','Por wong de Surquillo','2651201','1')

INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (3,'Av. Javier Prado 6142 - Surquillo','Avenida Principal','4711202','1')

INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (4,'Av. La Marina 391 - San Miguel','Cerca a la Botica BTL','2628102','1')

INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (5,'Av. Universitaria 3152 - San Miguel','Por el grifo PECSA','6524412','1')

INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (6,'Av. La Molina 4912 - La Molina','Cerca al edificio de 25 pisos','5273141','1')

INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (7,'Av. Las Américas 291 - La Victoria','Cerca a la vía expresa','7234711','1')

INSERT INTO TB_DIRECCION_CLIENTE(IN_CODIGO_CLIENTE,VC_DIRECCION,VC_REFERENCIA,VC_TELEFONO,CH_TIPO_DIRECCION)
VALUES (8,'Av. Arequipa 913 - Lince','Cruce con Risso','4724123','1')

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

-- Local

INSERT INTO TB_LOCAL (VC_NOMBRE, VC_DIRECCION, VC_TELEFONO, IN_CAPACIDAD)
VALUES ('Chili''s Jockey Plaza', 'Centro Comercial Jockey Plaza', '015475858', 50)

-- MESAS
INSERT INTO TB_MESA (VC_NUMERO, IN_CAPACIDAD, CH_ESTADO, IN_CODIGO_LOCAL)
VALUES ('01', 5, 'A', 1)

INSERT INTO TB_MESA (VC_NUMERO, IN_CAPACIDAD, CH_ESTADO, IN_CODIGO_LOCAL)
VALUES ('02', 4, 'A', 1)

INSERT INTO TB_MESA (VC_NUMERO, IN_CAPACIDAD, CH_ESTADO, IN_CODIGO_LOCAL)
VALUES ('03', 4, 'A', 1)

--Fechas Especiales
INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-01-01','Año nuevo')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-02-14','San Valentín')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-03-27','Jueves Santo')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-03-28','Viernes Santo')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-04-30','Día del trabajo')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-05-12','Día de la madre')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-06-16','Día del padre')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-07-28','Fiestas patrias')

INSERT INTO TB_FECHA_ESPECIAL (DT_FECHA,VC_MOTIVO)
VALUES ('2013-07-29','Fiestas patrias')