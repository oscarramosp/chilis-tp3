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
    public class DANotaPedidoDetalle : RepositoryBase
    {
        #region Fields
        protected static Database db = DConexion.Instancia().DataBase();
        #endregion

        #region Constructors
        public DANotaPedidoDetalle()
            : base(db)
        {

        }
        #endregion
               


         #region Insert NOTA IS

         public int Insertar(ENotaIngresoSalidaDetalle NotaISDetalle)
         {
             //CmdEdificioAscensor cmd = new CmdEdificioAscensor();
             ENotaIngresoSalidaDetalle result = new ENotaIngresoSalidaDetalle();
             base.ExecuteNonQueryOutput<ENotaIngresoSalidaDetalle>(GetInsertar(db, NotaISDetalle),
                                                        GetCorrelativoInsertado(result));
             return result.Correlativo;
         }

         public DbCommand GetInsertar(Database db, ENotaIngresoSalidaDetalle identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[AlM.NotaISDetalle_Insertar]");
             db.AddInParameter(dbCommand, "@codigoIS", DbType.Int32, identity.CodigoIS);
             db.AddInParameter(dbCommand, "@codItem", DbType.Int32, identity.CodItem);
             db.AddInParameter(dbCommand, "@descripcion", DbType.String, identity.descripcion);
             db.AddInParameter(dbCommand, "@cantActual", DbType.Int32, identity.cantActual);
             db.AddInParameter(dbCommand, "@medida", DbType.String, identity.medida);
             db.AddInParameter(dbCommand, "@lote", DbType.String, identity.lote);
             db.AddInParameter(dbCommand, "@serie", DbType.String, identity.serie);
             db.AddInParameter(dbCommand, "@fechaElaboracion", DbType.DateTime, identity.fechaElaboracion);
             db.AddInParameter(dbCommand, "@fechaCaducidad", DbType.DateTime, identity.fechaCaducidad);
             db.AddInParameter(dbCommand, "@precioUnitario", DbType.Decimal, identity.precioUnitario);
             db.AddInParameter(dbCommand, "@precioTotal", DbType.Decimal, identity.precioTotal);


               db.AddOutParameter(dbCommand, "@Correlativo", DbType.Int32, 8);

             return dbCommand;
         }

         public OutputObjectFactoryBase<ENotaIngresoSalidaDetalle> GetCorrelativoInsertado(ENotaIngresoSalidaDetalle outputObject)
         {
             OutputObjectFactoryBase<ENotaIngresoSalidaDetalle> outputObjectFactory = new OutputObjectFactoryBase<ENotaIngresoSalidaDetalle>(delegate(Database db, DbCommand command)
             {
                 outputObject.Correlativo = Convert.ToInt32(db.GetParameterValue(command, "@Correlativo"));
             });

             return outputObjectFactory;
         }

         #endregion

         #region Insert NOTA PEDIDO

         public int InsertarP(ENotaPedidoDetalle NotaPedidoDetalle)
         {
             //CmdEdificioAscensor cmd = new CmdEdificioAscensor();
             ENotaPedidoDetalle result = new ENotaPedidoDetalle();
             base.ExecuteNonQueryOutput<ENotaPedidoDetalle>(GetInsertarP(db, NotaPedidoDetalle),
                                                        GetCorrelativoInsertadoP(result));
             return result.Correlativo;
         }

         public DbCommand GetInsertarP(Database db, ENotaPedidoDetalle identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaPedidoDetalle_Insertar]");

             db.AddInParameter(dbCommand, "@codigoPedido", DbType.Int32, identity.CodigoPedido);
             db.AddInParameter(dbCommand, "@codItem", DbType.Int32, identity.CodItem);
             db.AddInParameter(dbCommand, "@descripcion", DbType.String, identity.descripcion);
             db.AddInParameter(dbCommand, "@cantActual", DbType.Int32, identity.cantModif);
             db.AddInParameter(dbCommand, "@medida", DbType.String, identity.medida);
             db.AddInParameter(dbCommand, "@marca", DbType.Int32, identity.marca);
             db.AddInParameter(dbCommand, "@fechaCaducidad", DbType.DateTime, identity.fechaCaducidad);
             db.AddInParameter(dbCommand, "@precioUnitario", DbType.Decimal, identity.precioUnitario);
             db.AddInParameter(dbCommand, "@precioTotal", DbType.Decimal, identity.precioTotal);

            return dbCommand;
         }

         public OutputObjectFactoryBase<ENotaPedidoDetalle> GetCorrelativoInsertadoP(ENotaPedidoDetalle outputObject)
         {
             OutputObjectFactoryBase<ENotaPedidoDetalle> outputObjectFactory = new OutputObjectFactoryBase<ENotaPedidoDetalle>(delegate(Database db, DbCommand command)
             {
                 outputObject.Correlativo = 0;//Convert.ToInt32(db.GetParameterValue(command, "@Correlativo"));
             });

             return outputObjectFactory;
         }

         #endregion
        
         #region Update Methods


         public void Modificar(ENotaIngresoSalidaDetalle NotaISDetalle)
         {
             //CmdEdificioAscensor cmd = new CmdEdificioAscensor();
             base.ExecuteNonQueryRowsAffected(GetModificar(db, NotaISDetalle));
         }


         public DbCommand GetModificar(Database db, ENotaIngresoSalidaDetalle identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaISDetalle_Actualizar]");

             db.AddInParameter(dbCommand, "@codigoDetIS", DbType.Int32, identity.CodigoDetIS);
             db.AddInParameter(dbCommand, "@codigoIS", DbType.Int32, identity.CodigoIS);
             db.AddInParameter(dbCommand, "@codItem", DbType.Int32, identity.CodItem);
             db.AddInParameter(dbCommand, "@descripcion", DbType.String, identity.descripcion);
             db.AddInParameter(dbCommand, "@cantActual", DbType.Int32, identity.cantActual);
             db.AddInParameter(dbCommand, "@medida", DbType.String, identity.medida);
             db.AddInParameter(dbCommand, "@lote", DbType.String, identity.lote);
             db.AddInParameter(dbCommand, "@serie", DbType.String, identity.serie);
             db.AddInParameter(dbCommand, "@fechaElaboracion", DbType.DateTime, identity.fechaElaboracion);
             db.AddInParameter(dbCommand, "@fechaCaducidad", DbType.DateTime, identity.fechaCaducidad);
             db.AddInParameter(dbCommand, "@precioUnitario", DbType.Decimal, identity.precioUnitario);
             db.AddInParameter(dbCommand, "@precioTotal", DbType.Decimal, identity.precioTotal);

             return dbCommand;
         }

         #endregion

         #region Delete Methods

         public void Eliminar(ENotaIngresoSalidaDetalle NotaISDetalle)
         {
            // CmdEdificioAscensor cmd = new CmdEdificioAscensor();
             base.ExecuteNonQueryRowsAffected(GetEliminar(db, NotaISDetalle));
         }


         public DbCommand GetEliminar(Database db, ENotaIngresoSalidaDetalle identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaISDetalle_Eliminar]");

             db.AddInParameter(dbCommand, "@codigoDetIS", DbType.Int32, identity.CodigoDetIS);
             db.AddInParameter(dbCommand, "@codigoIS", DbType.String, identity.CodigoIS);

             return dbCommand;
         }

        
         #endregion

         #region List Methods SI

         public DbCommand GetListarPorNotaIS(Database db, int codNotaIS)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaISDetalle_ListarPorNotaIS]");

             db.AddInParameter(dbCommand, "@CodNotaIS", DbType.Int32, codNotaIS);

             return dbCommand;
         }


         public List<ENotaIngresoSalidaDetalle> ListarPorNotaIS(int codNotaIS)
         {
             List<ENotaIngresoSalidaDetalle> lista = base.ExecuteGetList<ENotaIngresoSalidaDetalle>(GetListarPorNotaIS(db, codNotaIS),
                                                                        GetNotaISDetalle());


             return lista;
         }

         public DomainObjectFactoryBase<ENotaIngresoSalidaDetalle> GetNotaISDetalle()
         {
             DomainObjectFactoryBase<ENotaIngresoSalidaDetalle> domainFactory = new DomainObjectFactoryBase<ENotaIngresoSalidaDetalle>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new ENotaIngresoSalidaDetalle()
                 {
                     CodigoDetIS = Convert.ToInt32(helper.GetValue<Int32>("codigoDetIS")),
                     CodigoIS = Convert.ToInt32(helper.GetValue<Int32>("codigoIS")),
                     descripcion = helper.GetValue<String>("descripcion").ToUpper(),
                     cantActual = Convert.ToInt32(helper.GetValue<Int32>("cantActual")),
                     medida = helper.GetValue<String>("medida").ToUpper(),
                     lote = helper.GetValue<String>("lote").ToUpper(),
                     serie = helper.GetValue<String>("serie").ToUpper(),
                     fechaCaducidad = helper.GetValue<DateTime>("fechaCaducidad"),
                     fechaElaboracion = helper.GetValue<DateTime>("fechaElaboracion"),
                     precioUnitario = helper.GetValue<Decimal>("precioUnitario"),
                     precioTotal = helper.GetValue<Decimal>("PrecioTotal"),
                     CodItem = Convert.ToInt32(helper.GetValue<Int32>("codItem")),
                    
                 };
             });

             return domainFactory;
         }

         
         #endregion

         #region List Methods Nota Pedido

         public DbCommand GetListarPorNotaP(Database db, int codNotaP)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaPedidoDetalle_Buscar]");

             db.AddInParameter(dbCommand, "@codigopedido", DbType.Int32, codNotaP);

             return dbCommand;
         }


         public List<ENotaPedidoDetalle> ListarPorNotaP(int codNotaP)
         {
             List<ENotaPedidoDetalle> lista = base.ExecuteGetList<ENotaPedidoDetalle>(GetListarPorNotaP(db, codNotaP),
                                                                        GetNotaPDetalle());


             return lista;
         }

         public DomainObjectFactoryBase<ENotaPedidoDetalle> GetNotaPDetalle()
         {
             DomainObjectFactoryBase<ENotaPedidoDetalle> domainFactory = new DomainObjectFactoryBase<ENotaPedidoDetalle>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new ENotaPedidoDetalle()
                 {

                     CodItem = Convert.ToInt32(helper.GetValue<Int32>("codItem")),
                     medida = helper.GetValue<String>("medida"),
                     DesMarca = helper.GetValue<String>("marca"),
                     descripcion = helper.GetValue<String>("descripcion"),
                     fechaCaducidad = helper.GetValue<DateTime>("fechaCaducidad"),
                     cantActual = Convert.ToInt32(helper.GetValue<Int32>("cantActual")),
                     precioUnitario = helper.GetValue<Decimal>("precioUnitario"),
                     precioTotal = helper.GetValue<Decimal>("PrecioTotal"),
                     

                 };
             });

             return domainFactory;
         }


         #endregion


         #region Get Methods

         public DbCommand GetObtenerPorCorrelativo(Database db, int correlativo)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.NotaISDetalle_Obtener]");

             db.AddInParameter(dbCommand, "@CodNotaISDet", DbType.Int32, correlativo);

             return dbCommand;
         }



         public ENotaIngresoSalidaDetalle ObtenerPorCorrelativo(int correlativo)
         {
             //CmdEdificioAscensor cmd = new CmdEdificioAscensor();
             return base.ExecuteGetObject<ENotaIngresoSalidaDetalle>(GetObtenerPorCorrelativo(db, correlativo),
                 GetNotaISDetalle());
         }
         
         #endregion


    }
}
