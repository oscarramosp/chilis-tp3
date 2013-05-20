create database DBALMACEN
go
use DBALMACEN

go
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


ALTER proc [dbo].[ALM.NotaPedido_Insertar](
@fechaEmision Date,
@almacenOrigen int,
@almacenDestino int,
@areaSolicitante varchar(100),
@PrecioPedido decimal(18,2),
@codigoPedido int output
  )
as
begin
  declare @correlativo varchar(20);
  declare @var int;
  select @var= COUNT(*) from  tb_NotaPedido;
  set @var=@var+1;
  set @correlativo=RIGHT('MI_NP_00' +CONVERT(VARCHAR(10),@var),10);
  
insert tb_NotaPedido
(fechaEmision,almacenOrigen, almacenDestino,areaSolicitante,TipoOperacion,registrador,
autorizador,estadoNota,fechaEstadoNota,PrecioPedido,correlativo)
values (@fechaEmision,@almacenOrigen,2,@areaSolicitante,'0','','','0',getdate(),@PrecioPedido,@correlativo)

set @codigoPedido= @@IDENTITY


select @codigoPedido as ultimo


end

go


delete from tb_notapedidodetalle where codigopedido in (select codigopedido from tb_notapedido where  correlativo = '')
go
delete from tb_notapedido where  correlativo = ''

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
 * f.precio) as total, k.codMarca, f.CodUN
from  
tb_FichaProducto f
inner join tb_Producto p
on f.codProducto = p.codigoPr
inner join tb_Marca k
on k.codmarca = p.marca
where p.codigoPr like '%'+ @codigoPr +'%'
and f.codUN = case when @UN = -1 then f.codUN else @UN end


go


ALTER procedure [dbo].[ALM.NotaPedido_Buscar]
@CodUN int
as
select Codigopedido,correlativo, fechaemision, 
areasolicitante, u1.desUN as AlmacenOrigen, u2.desUN as AlmacenDestino, PrecioPedido
from tb_notapedido p
inner join tb_unidadnegocio u1
on u1.codigo = p.almacenOrigen
inner join tb_unidadnegocio u2
on u2.codigo = p.almacenDestino
where almacenOrigen = @CodUN
and estadoNota = '0'
order by codigopedido desc

go



create procedure [ALM.NotaPedido_Actualizar]
@codigoPedido int,
@estado varchar(10)
as
update tb_NotaPedido set estadoNota = @estado
where codigoPedido = @codigoPedido

go



--- por la tarde

insert tb_unidadnegocio values ('Proveedor','Proveedor')

go

ALTER PROCEDURE [dbo].[ALM.Cargar_Unidad]
AS    
BEGIN  
Select  codigo as codigo,
	desUn as descripcion
	from dbo.tb_UnidadNegocio
	where desUN <> 'proveedor'
	order by desUN asc
END


go

CREATE PROCEDURE [dbo].[ALM.Cargar_Unidad_Prov]
AS    
BEGIN  
Select  codigo as codigo,
	desUn as descripcion
	from dbo.tb_UnidadNegocio
	order by desUN asc
END

go



--tarde

update tb_producto set codigoPr ='PR000' + convert(varchar,codigo)
go

CREATE TABLE [dbo].[tb_NotaIS_Ficha](
	[Codigo] [int] NOT NULL
) ON [PRIMARY]

GO



create procedure [ALM.Get_Ficha_NotaIS]
@Codigo int
as
select top 1 codigoDetIS, medida, precioUnitario 
from tb_notaingresosalidadetalle
where codigoIS in (select codigoIS from tb_notaingresosalida 
where codUnidadDestino = 2 and tipoDocumento ='NI')
and codItem = @Codigo
and codigoDetIS not in (select codigo from tb_NotaIS_Ficha)
order by codigoDetIS desc



go

create procedure [ALM.NotaIS_Ficha_Insertar] 
@Codigo int
as
insert tb_NotaIS_Ficha values (@Codigo)

go
go

ALTER procedure [dbo].[ALM.ListarNotaPedido] 
@NotaPedido int
AS    
BEGIN    
 SET NOCOUNT ON;   
   
 Select 
 dt.codigoPedido,
 RIGHT('000' +CONVERT(VARCHAR(3),dt.codigoPedido),3) as 'codPedido2', 
convert(int, (select tp.codigo from tb_producto tp where tp.codigoPr in (select fp.codProducto from tb_fichaproducto fp where fp.item = dt.Coditem))) as Coditem,
 convert(varchar,RIGHT('000' +CONVERT(VARCHAR(3),(select tp.codigo from tb_producto tp where tp.codigoPr in (select fp.codProducto from tb_fichaproducto fp where fp.item = dt.Coditem))),3)) as 'codItem2',
 dt.medida,
 marca.descripcion as 'marca',
 dt.fechaCaducidad,
 dt.cantActual,
 cast(dt.precioUnitario as decimal(18,2)) precioUnitario,
 cast(dt.PrecioTotal as decimal(18,2))PrecioTotal,
  convert(varchar(50),@NotaPedido) as correlativo
 from tb_NotaPedidoDetalle dt
 left join tb_Producto pro on pro.codigo=dt.Coditem
 left join tb_marca marca on marca.codMarca=dt.marca
 where dt.codigoPedido=@NotaPedido
 
 
 SET NOCOUNT OFF;    
 END   
 


go

ALTER proc [dbo].[ALM.Inventario_Insertar](
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
Select @correlativo= isnull(MAX(ISNULL(SUBSTRING(isnull(correlativo,0),3,4),0)),0)+1 FROM tb_InventarioCabecera                        
Select @correlativo = cast('IN' + REPLICATE('0',4 - LEN(ISNULL(@correlativo,1)))as varchar(10))+@correlativo                      
Select @correlativo =@correlativo + 
right('00' + convert(varchar,month(getdate())),2) + substring(convert(varchar,year(getdate())) ,3,2)


insert tb_InventarioCabecera(correlativo,referencia,fecha,estado,responsable) values(@correlativo,@referencia,@fecha,@estado,@responsable)

set @codigo= @@IDENTITY


select @codigo


end

go


create procedure [ALM.NotaISDetalle_ListarPorNotaP]
@codigoPedido int
as
select p.descripcion,
p.cantActual,p.medida,
(select f1.lote from tb_fichaproducto f1 where f1.item = p.codItem)as Lote,
(select f2.serie from tb_fichaproducto f2 where f2.item = p.codItem)as Serie,
p.fechaCaducidad,
(select f3.fecha_elaboracion from tb_fichaproducto f3 where f3.item = p.codItem)as FechaElaboracion,
preciounitario, precioTotal,
(select codigo from tb_producto where codigoPr in (select codProducto from tb_fichaproducto f3 where f3.item = p.codItem)) as codItem
from tb_notapedidodetalle p
where p.codigopedido = @codigoPedido
and codigoPedido in (select codigoPedido from tb_notapedido where estadoNota = '1')

go


ALTER procedure [dbo].[ALM.Get_Ficha_NotaIS]
@Codigo int,
@CodUN int
as
select top 1 codigoDetIS, medida, precioUnitario ,
cantActual,lote, serie,fechaElaboracion,fechaCaducidad, preciototal
from tb_notaingresosalidadetalle
where codigoIS in (select codigoIS from tb_notaingresosalida 
where codUnidadDestino = @CodUN and tipoDocumento ='NI')
and codItem = @Codigo
and codigoDetIS not in (select codigo from tb_NotaIS_Ficha)
order by codigoDetIS desc

go


ALTER procedure [dbo].[ALM.ListarNotaPedido] 
@NotaPedido int
AS    
BEGIN    
 SET NOCOUNT ON;   
   
 Select 
 dt.codigoPedido,
 RIGHT('000' +CONVERT(VARCHAR(3),dt.codigoPedido),3) as 'codPedido2', 
convert(int, (select tp.codigo from tb_producto tp where tp.codigoPr in (select fp.codProducto from tb_fichaproducto fp where fp.item = dt.Coditem))) as Coditem,
 convert(varchar,RIGHT('000' +CONVERT(VARCHAR(3),(select tp.codigo from tb_producto tp where tp.codigoPr in (select fp.codProducto from tb_fichaproducto fp where fp.item = dt.Coditem))),3)) as 'codItem2',
 dt.medida,
 marca.descripcion as 'marca',
 dt.fechaCaducidad,
 dt.cantActual,
 cast(dt.precioUnitario as decimal(18,2)) precioUnitario,
 cast(dt.PrecioTotal as decimal(18,2))PrecioTotal,
  convert(varchar(50),@NotaPedido) as correlativo
 from tb_NotaPedidoDetalle dt
 left join tb_Producto pro on pro.codigo=dt.Coditem
 left join tb_marca marca on marca.codMarca=dt.marca
 where dt.codigoPedido=@NotaPedido
 and dt.codigoPedido in (select codigoPedido from tb_notapedido where estadoNota = '1')
 
 
 SET NOCOUNT OFF;    
 END   
 



go


ALTER procedure [dbo].[ALM.Buscar_FichaProducto]
@codigoPr varchar(100),
@UN int
as
select f.item, f.medida, k.descripcion as Marca, f.fecha_vencimiento, 
f.cantidad as cantidad, 
f.precio,  
convert(decimal(18,2), f.cantidad* f.precio) as total, 
k.codMarca, f.CodUN, u.desUN, p.descripcion as desProducto
from  
tb_FichaProducto f
inner join tb_Producto p
on f.codProducto = p.codigoPr
inner join tb_Marca k
on k.codmarca = p.marca
inner join tb_unidadnegocio u
on u.codigo = f.codUN
where p.codigoPr like '%'+ @codigoPr +'%'
and f.codUN = case when @UN = -1 then f.codUN else @UN end



go

