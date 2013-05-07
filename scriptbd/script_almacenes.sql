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
