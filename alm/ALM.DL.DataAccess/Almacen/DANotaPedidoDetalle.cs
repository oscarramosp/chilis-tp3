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
               


         #region Insert Methods

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

         #region List Methods

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
                     descripcion = helper.GetValue<String>("descripcion"),
                     cantActual = Convert.ToInt32(helper.GetValue<Int32>("cantActual")),
                     medida = helper.GetValue<String>("medida"),
                     lote = helper.GetValue<String>("lote"),
                     serie = helper.GetValue<String>("serie"),
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
