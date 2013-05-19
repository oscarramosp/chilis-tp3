using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using ALM.BE.Entities.Almacen;
using AppAlmacen.Almacen;
using System.Data.Common;
using ALM.DBUtility;
using Microsoft.Practices.EnterpriseLibrary.Data;
using AVT.Framework.DataAccess;

namespace ALM.DL.DataAccess.Almacen
{
    public class DANotaPedido : RepositoryBase
    {
        #region Fields
        protected static Database db = DConexion.Instancia().DataBase();
        #endregion

        #region Constructors
        public DANotaPedido()
            : base(db)
        {

        }
        #endregion

        #region listNotaPedido
        public List<ENotaPedidoDetalle> ListarPorNotaPedido(int codigo)
         {
             List<ENotaPedidoDetalle> lista = base.ExecuteGetList<ENotaPedidoDetalle>(GetListarPorNotaPedido(db, codigo),
                                                                        GetNotaPedido());


             return lista;
         }

         public DbCommand GetListarPorNotaPedido(Database db, int codNotaPedido)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.ListarNotaPedido]");
             db.AddInParameter(dbCommand, "@NotaPedido", DbType.String, codNotaPedido);
             return dbCommand;
         }
         public DomainObjectFactoryBase<ENotaPedidoDetalle> GetNotaPedido()
         {
             DomainObjectFactoryBase<ENotaPedidoDetalle> domainFactory = new DomainObjectFactoryBase<ENotaPedidoDetalle>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new ENotaPedidoDetalle()
                 {


                     CodigoDetalle = Convert.ToInt32(helper.GetValue<Int32>("codigoPedido")),
                     CodigoDetalle2 = helper.GetValue<String>("codPedido2").ToString(),
                     CodItem = Convert.ToInt32(helper.GetValue<Int32>("Coditem")),
                     CodItem2 = helper.GetValue<String>("codItem2").ToString(),
                     medida = helper.GetValue<String>("medida").ToString(),
                     DesMarca = helper.GetValue<String>("marca").ToString(),
                     fechaCaducidad = Convert.ToDateTime(helper.GetValue<DateTime>("fechaCaducidad")),
                     cantActual = Convert.ToInt32(helper.GetValue<Int32>("cantActual")),
                     precioUnitario = helper.GetValue<Decimal>("precioUnitario"),
                     precioTotal = helper.GetValue<Decimal>("PrecioTotal"),
                     serie = helper.GetValue<String>("correlativo"),
                   
                                     };
             });

             return domainFactory;
         }


        #endregion 


         #region listNotaPedidoP
         public List<ENotaPedido> ListarPorNotaPedidoP(int CodUN)
         {
             List<ENotaPedido> lista = base.ExecuteGetList<ENotaPedido>(GetListarNotaPedidoP(db,CodUN),
                                                                        GetNotaPedidoP());


             return lista;
         }

         public DbCommand GetListarNotaPedidoP(Database db, int CodUN)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaPedido_Buscar]");
             db.AddInParameter(dbCommand, "@CodUN", DbType.String, CodUN);
             return dbCommand;
         }

         public DomainObjectFactoryBase<ENotaPedido> GetNotaPedidoP()
         {
             DomainObjectFactoryBase<ENotaPedido> domainFactory = new DomainObjectFactoryBase<ENotaPedido>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new ENotaPedido()
                 {

                     Codigo = Convert.ToInt32(helper.GetValue<Int32>("codigoPedido")),
                     Correlativo = Convert.ToString(helper.GetValue<String>("correlativo")),
                     fechaEmision = Convert.ToDateTime(helper.GetValue<DateTime>("fechaemision")),
                     desalmacenOrigen = Convert.ToString(helper.GetValue<String>("AlmacenOrigen")),
                     desalmacenDestino = Convert.ToString(helper.GetValue<String>("AlmacenDestino")),
                     areaSoliciante = Convert.ToString(helper.GetValue<String>("areasolicitante")),
                     precioPedido = Convert.ToDecimal(helper.GetValue<Decimal>("PrecioPedido")),
                 };
             });

             return domainFactory;
         }


         #endregion 

         #region ActualizarNotaPedidoP
         public List<ENotaPedido> ActualizarPorNotaPedidoP(int CodigoPedido, string estado)
         {
             List<ENotaPedido> lista = base.ExecuteGetList<ENotaPedido>(GetActualizarNotaPedidoP(db,CodigoPedido,estado),
                                                                        GetActualizarPedidoP());


             return lista;
         }

         public DbCommand GetActualizarNotaPedidoP(Database db, int CodigoPedido, string estado)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaPedido_Actualizar]");
             db.AddInParameter(dbCommand, "@CodigoPedido", DbType.Int32, CodigoPedido);
             db.AddInParameter(dbCommand, "@estado", DbType.String, estado);
             return dbCommand;
         }

         public DomainObjectFactoryBase<ENotaPedido> GetActualizarPedidoP()
         {
             DomainObjectFactoryBase<ENotaPedido> domainFactory = new DomainObjectFactoryBase<ENotaPedido>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new ENotaPedido()
                 {

                     Codigo = 0,
                 };
             });

             return domainFactory;
         }


         #endregion 

         #region listNotaIS
         public List<ENotaIngresoSalida> ListarNotaIS(int codigo)
         {
             List<ENotaIngresoSalida> lista = base.ExecuteGetList<ENotaIngresoSalida>(GetListarPorNotaPedido_IS(db, codigo),
                                                                        GetNotaPedido_IS());


             return lista;
         }

         public DbCommand GetListarPorNotaPedido_IS(Database db, int codNotaPedido)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.ListarNotaIngresoSalida]");
             db.AddInParameter(dbCommand, "@NotaPedido", DbType.String, codNotaPedido);
             return dbCommand;
         }
         public DomainObjectFactoryBase<ENotaIngresoSalida> GetNotaPedido_IS()
         {
             DomainObjectFactoryBase<ENotaIngresoSalida> domainFactory = new DomainObjectFactoryBase<ENotaIngresoSalida>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new ENotaIngresoSalida()
                 {

                     CodigoIS = Convert.ToInt32(helper.GetValue<Int32>("codigoIS")),
                     CodigoIS2 = helper.GetValue<String>("codnotaIS2").ToString(),
                     tipoDocumento = helper.GetValue<String>("codTipodoc").ToString(),
                     DestipoDocumento = helper.GetValue<String>("desTipoDoc").ToString(),
                     fecha = helper.GetValue<DateTime>("fecha"),
                     periodo = helper.GetValue<String>("periodo").ToString(),
                     transTipo = helper.GetValue<String>("codTransTipo").ToString(),
                     DestransTipo = helper.GetValue<String>("destransTipo").ToString(),
                     referTipo = helper.GetValue<String>("codRefTipo").ToString(),
                     DesreferTipo = helper.GetValue<String>("desrefTipo").ToString(),
                     referNumDoc = helper.GetValue<String>("referNumDoc").ToString(),
                     CodunidOrigen = helper.GetValue<Int32>("codUnidadOrigen"),
                     CodunidDestino = helper.GetValue<Int32>("codUnidadDestino"),
                     unidDestino = helper.GetValue<String>("UniDes").ToString(),
                     unidOrigen = helper.GetValue<String>("UniOrig").ToString(),
                     empleado = helper.GetValue<String>("empleado").ToString(),
                     CodPedido = helper.GetValue<Int32>("codNotaPedido"),
                     CodPedido2 = helper.GetValue<String>("codnotapedido2"),
                     correlativo = helper.GetValue<String>("correlativo"),

                 };
             });

             return domainFactory;
         }


         #endregion 



         #region UnidadNegocio
         //obtener unidades..
         public DbCommand GetListarUnidad(Database db)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Cargar_Unidad]");

             return dbCommand;
         }

         public List<EUnidadNegocio> ListarUnidadNegocio()
         {
             List<EUnidadNegocio> lista = base.ExecuteGetList<EUnidadNegocio>(GetListarUnidad(db),
                                                                            GetUnidadNegocio());
             return lista;
         }

         public DomainObjectFactoryBase<EUnidadNegocio> GetUnidadNegocio()
         {
             DomainObjectFactoryBase<EUnidadNegocio> domainFactory = new DomainObjectFactoryBase<EUnidadNegocio>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EUnidadNegocio()
                 {

                     Codigo = helper.GetValue<Int32>("codigo"),
                     Nombre = helper.GetValue<String>("descripcion"),


                 };

             });

             return domainFactory;
         }
#endregion


         #region UnidadNegocioP
         //obtener unidades..
         public DbCommand GetListarUnidadP(Database db)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Cargar_Unidad_Prov]");

             return dbCommand;
         }

         public List<EUnidadNegocio> ListarUnidadNegocioP()
         {
             List<EUnidadNegocio> lista = base.ExecuteGetList<EUnidadNegocio>(GetListarUnidadP(db),
                                                                            GetUnidadNegocioP());
             return lista;
         }

         public DomainObjectFactoryBase<EUnidadNegocio> GetUnidadNegocioP()
         {
             DomainObjectFactoryBase<EUnidadNegocio> domainFactory = new DomainObjectFactoryBase<EUnidadNegocio>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EUnidadNegocio()
                 {

                     Codigo = helper.GetValue<Int32>("codigo"),
                     Nombre = helper.GetValue<String>("descripcion"),


                 };

             });

             return domainFactory;
         }
         #endregion

         #region insert cabecera Ingreso Salida

         //registro cabecera 

         public ENotaIngresoSalida InsertarNota(ENotaIngresoSalida nota)
         {
             //CmdEdificio cmd = new CmdEdificio();
             ENotaIngresoSalida result = new ENotaIngresoSalida();
             base.ExecuteNonQueryOutput<ENotaIngresoSalida>(GetInsertarNota(db, nota),
                                                         GetNotaInsertada(result));
             return result;
         }


         public DbCommand GetInsertarNota(Database db, ENotaIngresoSalida identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaIS_Insertar]");

             db.AddInParameter(dbCommand, "@codNotaPedido", DbType.Int32, identity.CodPedido);
             db.AddInParameter(dbCommand, "@tipoDocumento", DbType.String, identity.tipoDocumento);
             db.AddInParameter(dbCommand, "@fecha", DbType.Date, identity.fecha);
             db.AddInParameter(dbCommand, "@periodo", DbType.String, identity.periodo);
             db.AddInParameter(dbCommand, "@transfTipo", DbType.String, identity.transTipo);
             db.AddInParameter(dbCommand, "@referTipo", DbType.String, identity.referTipo);
             db.AddInParameter(dbCommand, "@referNumDoc", DbType.String, identity.referNumDoc);
             db.AddInParameter(dbCommand, "@codUnidadOrigen", DbType.Int32, identity.CodunidOrigen);
             db.AddInParameter(dbCommand, "@codUnidadDestino", DbType.Int32, identity.CodunidDestino);
             db.AddInParameter(dbCommand, "@empleado", DbType.String, identity.empleado);

            db.AddOutParameter(dbCommand, "@Codigo", DbType.String, 14);

             return dbCommand;
         }

         public OutputObjectFactoryBase<ENotaIngresoSalida> GetNotaInsertada(ENotaIngresoSalida outputObject)
         {
             OutputObjectFactoryBase<ENotaIngresoSalida> outputObjectFactory = new OutputObjectFactoryBase<ENotaIngresoSalida>(delegate(Database db, DbCommand command)
             {
                    outputObject.CodigoIS= Convert.ToInt32(db.GetParameterValue(command, "@Codigo"));

             });

             return outputObjectFactory;
         }


        #endregion 

         #region insert cabecera Pedido

         //registro cabecera 

         public ENotaPedido InsertarNotaP(ENotaPedido nota)
         {
             //CmdEdificio cmd = new CmdEdificio();
             ENotaPedido result = new ENotaPedido();
             base.ExecuteNonQueryOutput<ENotaPedido>(GetInsertarNotaP(db, nota),
                                                         GetNotaInsertadaP(result));
             return result;
         }


         public DbCommand GetInsertarNotaP(Database db, ENotaPedido identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaPedido_Insertar]");

             
             db.AddInParameter(dbCommand, "@fechaEmision", DbType.Date, identity.fechaEmision);
             db.AddInParameter(dbCommand, "@almacenOrigen", DbType.Int32, identity.almacenOrigen);
             db.AddInParameter(dbCommand, "@almacenDestino", DbType.Int32, identity.almacenDestino);
             db.AddInParameter(dbCommand, "@areaSolicitante", DbType.String, identity.areaSoliciante);
             db.AddInParameter(dbCommand, "@precioPedido", DbType.Decimal, identity.precioPedido);

             db.AddOutParameter(dbCommand, "@codigoPedido", DbType.String, 14);

             return dbCommand;
         }

         public OutputObjectFactoryBase<ENotaPedido> GetNotaInsertadaP(ENotaPedido outputObject)
         {
             OutputObjectFactoryBase<ENotaPedido> outputObjectFactory = new OutputObjectFactoryBase<ENotaPedido>(delegate(Database db, DbCommand command)
             {
                 outputObject.Codigo = Convert.ToInt32(db.GetParameterValue(command, "@codigoPedido"));

             });

             return outputObjectFactory;
         }


         #endregion 

        #region Update cabecera

        //modificacion cabecera

         public DbCommand GetActualizarNota(Database db, ENotaIngresoSalida identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaIS_Actualizar]");

             db.AddInParameter(dbCommand, "@codigoIS", DbType.String, identity.CodigoIS);
             db.AddInParameter(dbCommand, "@tipoDocumento", DbType.String, identity.tipoDocumento);
             db.AddInParameter(dbCommand, "@fecha", DbType.Date, identity.fecha);
             db.AddInParameter(dbCommand, "@periodo", DbType.String, identity.periodo);
             db.AddInParameter(dbCommand, "@transfTipo", DbType.String, identity.transTipo);
             db.AddInParameter(dbCommand, "@referTipo", DbType.String, identity.referTipo);
             db.AddInParameter(dbCommand, "@referNumDoc", DbType.String, identity.referNumDoc);
             db.AddInParameter(dbCommand, "@codUnidadOrigen", DbType.Int32, identity.CodunidOrigen);
             db.AddInParameter(dbCommand, "@codUnidadDestino", DbType.Int32, identity.CodunidDestino);
             db.AddInParameter(dbCommand, "@empleado", DbType.String, identity.empleado);
             db.AddOutParameter(dbCommand, "@Actualizado", DbType.Int32, 18);

             return dbCommand;
         }

         public OutputObjectFactoryBase<ENotaIngresoSalida> GetNotaActualizado(ENotaIngresoSalida outputObject)
         {
             OutputObjectFactoryBase<ENotaIngresoSalida> outputObjectFactory = new OutputObjectFactoryBase<ENotaIngresoSalida>(delegate(Database db, DbCommand command)
             {
                 outputObject.Correlativo = Convert.ToInt32(db.GetParameterValue(command, "@Actualizado"));
             });

             return outputObjectFactory;
         }

         public ENotaIngresoSalida ActualizarNota(ENotaIngresoSalida nota)
         {
             ENotaIngresoSalida result = new ENotaIngresoSalida();
             base.ExecuteNonQueryOutput<ENotaIngresoSalida>(GetActualizarNota(db, nota),
                                                         GetNotaActualizado(result));
             return result;
         }

        
        #endregion

    }
}
