using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using ALM.BE.Entities.Almacen;
using AppAlmacen.Almacen;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using AVT.Framework.DataAccess;

namespace ALM.DL.DataAccess.Almacen
{
    public class DAInventarios : RepositoryBase
    {
        #region Fields
        protected static Database db = DConexion.Instancia().DataBase();
        #endregion

        #region Constructors
        public DAInventarios()
            : base(db)
        {

        }
        #endregion

        #region listNotaPedidoxCod
        public EInventarioCabecera ListarHojaInventariosxCod( Int32 codCabecera)
         {
             EInventarioCabecera obj = base.ExecuteGetObject<EInventarioCabecera>(getListarHojaInventarioxCod(db, codCabecera),
                                                                        getListarHojaInventarioxCod());


             return obj;
         }

        public DbCommand getListarHojaInventarioxCod(Database db, Int32 codCabecera)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("[ALM.ListarHojaInventarioxCod]");
            db.AddInParameter(dbCommand, "@codCabecera", DbType.String, codCabecera);
            return dbCommand;
        }
        public DomainObjectFactoryBase<EInventarioCabecera> getListarHojaInventarioxCod()
        {
            DomainObjectFactoryBase<EInventarioCabecera> domainFactory = new DomainObjectFactoryBase<EInventarioCabecera>(delegate(IDataReader myReader)
            {
                MapHelper helper = new MapHelper(myReader);
                return new EInventarioCabecera()
                {
                    
                    Codigo = Convert.ToInt32(helper.GetValue<Int32>("codigo")),
                    Fecha = helper.GetValue<String>("fecha").ToString(),
                    Referencia = helper.GetValue<String>("referencia").ToString(),
                    Responsable = helper.GetValue<String>("responsable").ToString(),
                    Estado = Convert.ToInt32(helper.GetValue<Int32>("estado"))
                };
            });

            return domainFactory;
        }


        public List<EInventarioDetalle> ListarHojaInventarioDetxCod(Int32 codCabecera)
        {
            List<EInventarioDetalle> obj = base.ExecuteGetList<EInventarioDetalle>(getListarHojaInventarioDetxCod(db, codCabecera),
                                                                       getListarHojaInventarioDetxCod());


            return obj;
        }

        public Int32 eliminar(Int32 codCabecera)
        {
            Int32 result = new Int32();
            base.ExecuteNonQueryOutput<Int32>(getEliminar(db, codCabecera),
                                                       getEliminar(result));
            return result;
        }

        public DbCommand getEliminar(Database db, Int32 codCabecera)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("[AlM.Inventario_Eliminar]");
            db.AddInParameter(dbCommand, "@codCabecera", DbType.String, codCabecera);
            db.AddOutParameter(dbCommand, "@correlativo", DbType.Int32, 8);
            return dbCommand;
        }

        public OutputObjectFactoryBase<Int32> getEliminar(Int32 outputObject)
        {
            OutputObjectFactoryBase<Int32> outputObjectFactory = new OutputObjectFactoryBase<Int32>(delegate(Database db, DbCommand command)
            {
                outputObject = Convert.ToInt32(db.GetParameterValue(command, "@Correlativo"));
            });

            return outputObjectFactory;
        }

        public DbCommand getListarHojaInventarioDetxCod(Database db, Int32 codCabecera)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("[ALM.ListarHojaInventarioDetxCod]");
            db.AddInParameter(dbCommand, "@codCabecera", DbType.String, codCabecera);
            return dbCommand;
        }
        public DomainObjectFactoryBase<EInventarioDetalle> getListarHojaInventarioDetxCod()
        {
            DomainObjectFactoryBase<EInventarioDetalle> domainFactory = new DomainObjectFactoryBase<EInventarioDetalle>(delegate(IDataReader myReader)
            {
                MapHelper helper = new MapHelper(myReader);
                return new EInventarioDetalle()
                {


                    Codigo = Convert.ToInt32(helper.GetValue<Int32>("codigo")),
                    codProducto = Convert.ToInt32(helper.GetValue<Int32>("codProducto")),
                    nombreProducto = helper.GetValue<String>("Producto").ToString(),
                    codigoPr = helper.GetValue<String>("codigoPr").ToString(),
                    Item =  Convert.ToInt32(helper.GetValue<Int32>("item")),
                    Descripcion = helper.GetValue<String>("descripcion").ToString(),
                    CantidadActual = Convert.ToDecimal(helper.GetValue<Decimal>("cantidadActual")),
                    Medida = helper.GetValue<String>("medida").ToString()

                };
            });

            return domainFactory;
        }
        #endregion 

        #region Inventario
        public List<EInventarioCabecera> ListarHojaInventarios(String fechaIni, String fechaFin, Int32 estado)
         {
             List<EInventarioCabecera> lista = base.ExecuteGetList<EInventarioCabecera>(getListarHojaInventarios(db, fechaIni, fechaFin,  estado),
                                                                        getListarHojaInventario());


             return lista;
         }
        
        public DbCommand getListarHojaInventarios(Database db, String fechaIni, String fechaFin, Int32 estado)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.ListarHojaInventario]");
             db.AddInParameter(dbCommand, "@fechaIni", DbType.String, fechaIni);
             db.AddInParameter(dbCommand, "@fechaFin", DbType.String, fechaFin);
             db.AddInParameter(dbCommand, "@estado", DbType.Int32, estado);
             return dbCommand;
         }
        public DomainObjectFactoryBase<EInventarioCabecera> getListarHojaInventario()
         {
             DomainObjectFactoryBase<EInventarioCabecera> domainFactory = new DomainObjectFactoryBase<EInventarioCabecera>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EInventarioCabecera()
                 {

                     codigoPr = helper.GetValue<String>("Correlativo"),
                     Codigo = Convert.ToInt32(helper.GetValue<Int32>("codigo")),
                     Fecha = helper.GetValue<String>("fecha").ToString(),
                     Referencia = helper.GetValue<String>("referencia").ToString(),
                     Responsable = helper.GetValue<String>("responsable").ToString(),
                     NombreEstado = helper.GetValue<String>("estado").ToString()                    
                    };
             });

             return domainFactory;
         }


        #endregion 


         #region EstadoINV
         //obtener unidades..
        public DbCommand GetListarEstadoINV(Database db)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Cargar_EstadoINV]");

             return dbCommand;
         }

         public List<EEstadoINV> ListarEstadoINV()
         {
             List<EEstadoINV> lista = base.ExecuteGetList<EEstadoINV>(GetListarEstadoINV(db),
                                                                            GetEstadoINV());
             return lista;
         }

         public DomainObjectFactoryBase<EEstadoINV> GetEstadoINV()
         {
             DomainObjectFactoryBase<EEstadoINV> domainFactory = new DomainObjectFactoryBase<EEstadoINV>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EEstadoINV()
                 {

                     Codigo = helper.GetValue<Int32>("codigo"),
                     Nombre = helper.GetValue<String>("descripcion"),


                 };

             });

             return domainFactory;
         }
#endregion

         #region insert cabecera

         //registro cabecera 

         public Int32 InsertarInventarioDetalle(EInventarioDetalle detalle)
         {
             EInventarioDetalle result = new EInventarioDetalle();
             base.ExecuteNonQueryOutput<EInventarioDetalle>(GetInsertarDetalle(db, detalle),
                                                        GetDetalleInsertado(result));
             return result.Codigo;
         }
         public DbCommand GetInsertarDetalle(Database db, EInventarioDetalle identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[AlM.InventarioDetalle_Insertar]");
             db.AddInParameter(dbCommand, "@codCabecera", DbType.Int32, identity.CodigoCabecera);
             db.AddInParameter(dbCommand, "@codProducto", DbType.Int32, identity.codProducto);
             db.AddInParameter(dbCommand, "@item", DbType.Int32, identity.Item);
             db.AddInParameter(dbCommand, "@descripcion", DbType.String, identity.Descripcion);
             db.AddInParameter(dbCommand, "@cantidadActual", DbType.Decimal, identity.CantidadActual);
             db.AddInParameter(dbCommand, "@medida", DbType.String, identity.Medida);
             db.AddInParameter(dbCommand, "@codigo", DbType.Int32, identity.Codigo);

             db.AddOutParameter(dbCommand, "@correlativo", DbType.Int32, 8);

             return dbCommand;
         }

         public OutputObjectFactoryBase<EInventarioDetalle> GetDetalleInsertado(EInventarioDetalle outputObject)
         {
             OutputObjectFactoryBase<EInventarioDetalle> outputObjectFactory = new OutputObjectFactoryBase<EInventarioDetalle>(delegate(Database db, DbCommand command)
             {
                 outputObject.Codigo = Convert.ToInt32(db.GetParameterValue(command, "@Correlativo"));
             });

             return outputObjectFactory;
         }

         public EInventarioCabecera InsertarInventario(EInventarioCabecera inventario)
         {
             //CmdEdificio cmd = new CmdEdificio();
             EInventarioCabecera result = new EInventarioCabecera();
             base.ExecuteNonQueryOutput<EInventarioCabecera>(GetInsertarInventario(db, inventario),
                                                         GetInvetarioInsertado(result));
             return result;
         }


         public DbCommand GetInsertarInventario(Database db, EInventarioCabecera identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Inventario_Insertar]");

             db.AddInParameter(dbCommand, "@referencia", DbType.String, identity.Referencia);
             db.AddInParameter(dbCommand, "@fecha", DbType.DateTime, identity.Fecha);
             db.AddInParameter(dbCommand, "@responsable", DbType.String, identity.Responsable);
             db.AddInParameter(dbCommand, "@aprobado", DbType.String, identity.Aprobado);
             db.AddInParameter(dbCommand, "@estado", DbType.Int32, identity.Estado);
             db.AddInParameter(dbCommand, "@usuCre", DbType.Int32, identity.UsuarioRegistra);
             db.AddInParameter(dbCommand, "@FecCre", DbType.DateTime, identity.FechaRegistro);
           
            db.AddOutParameter(dbCommand, "@Codigo", DbType.Int32, 14);



             return dbCommand;
         }

         public OutputObjectFactoryBase<EInventarioCabecera> GetInvetarioInsertado(EInventarioCabecera outputObject)
         {
             OutputObjectFactoryBase<EInventarioCabecera> outputObjectFactory = new OutputObjectFactoryBase<EInventarioCabecera>(delegate(Database db, DbCommand command)
             {
                    outputObject.Codigo= Convert.ToInt32(db.GetParameterValue(command, "@Codigo"));

             });

             return outputObjectFactory;
         }


        #endregion 

       

        #region Update cabecera

        //modificacion cabecera

         public DbCommand GetActualizarInventario(Database db, EInventarioCabecera identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Inventario_Actualizar]");

             db.AddInParameter(dbCommand, "@codCabecera", DbType.String, identity.Codigo);
           
             db.AddInParameter(dbCommand, "@referencia", DbType.String, identity.Referencia);
             db.AddInParameter(dbCommand, "@fecha", DbType.Date, identity.Fecha);
             db.AddInParameter(dbCommand, "@responsable", DbType.String, identity.Responsable);
             db.AddInParameter(dbCommand, "@aprobado", DbType.String, identity.Aprobado);
             db.AddInParameter(dbCommand, "@estado", DbType.Int32, identity.Estado);
             db.AddInParameter(dbCommand, "@usuMod", DbType.Int32, identity.UsuarioModifica);
             db.AddInParameter(dbCommand, "@FecMod", DbType.Date, identity.FechaModifica);
             db.AddOutParameter(dbCommand,"@Actualizado", DbType.Int32, 18);

             return dbCommand;
         }

         public OutputObjectFactoryBase<EInventarioCabecera> GetInventarioActualizado(EInventarioCabecera outputObject)
         {
             OutputObjectFactoryBase<EInventarioCabecera> outputObjectFactory = new OutputObjectFactoryBase<EInventarioCabecera>(delegate(Database db, DbCommand command)
             {
                 outputObject.Codigo = Convert.ToInt32(db.GetParameterValue(command, "@Actualizado"));
             });

             return outputObjectFactory;
         }

         public EInventarioCabecera ActualizarInventario(EInventarioCabecera nota)
         {
             EInventarioCabecera result = new EInventarioCabecera();
             base.ExecuteNonQueryOutput<EInventarioCabecera>(GetActualizarInventario(db, nota),
                                                         GetInventarioActualizado(result));
             return result;
         }

        
        #endregion

    }
}
