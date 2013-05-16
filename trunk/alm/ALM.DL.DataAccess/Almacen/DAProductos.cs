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
    public class DAProductos : RepositoryBase
    {
        #region Fields
        protected static Database db = DConexion.Instancia().DataBase();
        #endregion

        #region Constructors
        public DAProductos()
            : base(db)
        {

        }
        #endregion

        #region Productos
         //obtener unidades..
        public DbCommand GetListarProductos(Database db, String nombre, String codigo)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Cargar_Productos]");
             db.AddInParameter(dbCommand, "@nombre", DbType.String, nombre);
             db.AddInParameter(dbCommand, "@codigoPr", DbType.String, codigo);

             return dbCommand;
         }

        public List<EProductos> ListarProductos(String nombre, String codigo)
         {
             List<EProductos> lista = base.ExecuteGetList<EProductos>(GetListarProductos(db, nombre,codigo),
                                                                            GetProductos());
             return lista;
         }

         public DomainObjectFactoryBase<EProductos> GetProductos()
         {
             DomainObjectFactoryBase<EProductos> domainFactory = new DomainObjectFactoryBase<EProductos>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EProductos()
                 {

                     Codigo = helper.GetValue<Int32>("codigo"),
                     CodigoPr = helper.GetValue<String>("codigoPr"),
                     Nombre = helper.GetValue<String>("nombre"),
                     Descripcion = helper.GetValue<String>("descripcion"),
                     Medida = helper.GetValue<String>("medida")


                 };

             });

             return domainFactory;
         }



        //busqueda de productos por UN
        public DbCommand GetBuscarProductosUN(Database db, String codigo, String nombre,int UN)
         {
            DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Buscar_Productos_UN]");
            db.AddInParameter(dbCommand, "@codigoPr", DbType.String, codigo);
            db.AddInParameter(dbCommand, "@nombre", DbType.String, nombre);
            db.AddInParameter(dbCommand, "@UN", DbType.Int32, UN);

            return dbCommand;
         }

        public List<EProductos> BuscarProductosUN(String codigo, String nombre, int UN)
         {
             List<EProductos> lista = base.ExecuteGetList<EProductos>(GetBuscarProductosUN(db,codigo,nombre, UN),
                                                                            GetBuscarUN());
             return lista;
         }

         public DomainObjectFactoryBase<EProductos> GetBuscarUN()
         {
             DomainObjectFactoryBase<EProductos> domainFactory = new DomainObjectFactoryBase<EProductos>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EProductos()
                 {

                     Codigo = helper.GetValue<Int32>("codigo"),
                     CodigoPr = helper.GetValue<String>("codigoPr"),
                     Nombre = helper.GetValue<String>("nombre"),
                     Descripcion = helper.GetValue<String>("descripcion"),
                     Familia = helper.GetValue<String>("familia"),
                     Marca = helper.GetValue<String>("Marca"),
                     UN = helper.GetValue<String>("UN"),
                     CodUN = helper.GetValue<Int32>("CodUN"),
                     CodMarca = helper.GetValue<Int32>("CodMarca"),
                     
                 };

             });

             return domainFactory;
         }


         //busqueda de productos
         public DbCommand GetBuscarProductos(Database db, String codigo, String descripcion, String familia, String SubFamilia, int Marca)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Buscar_Productos]");
             db.AddInParameter(dbCommand, "@codigoPr", DbType.String, codigo);
             db.AddInParameter(dbCommand, "@nombre", DbType.String, descripcion);
             db.AddInParameter(dbCommand, "@familia", DbType.String, familia);
             db.AddInParameter(dbCommand, "@subfamilia", DbType.String, SubFamilia);
             db.AddInParameter(dbCommand, "@marca", DbType.Int32, Marca);

             return dbCommand;
         }

         public List<EProductos> BuscarProductos(String codigo, String descripcion, String familia, String SubFamilia, int Marca)
         {
             List<EProductos> lista = base.ExecuteGetList<EProductos>(GetBuscarProductos(db, codigo, descripcion, familia, SubFamilia, Marca),
                                                                            GetBuscar());
             return lista;
         }

         public DomainObjectFactoryBase<EProductos> GetBuscar()
         {
             DomainObjectFactoryBase<EProductos> domainFactory = new DomainObjectFactoryBase<EProductos>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EProductos()
                 {

                     Codigo = helper.GetValue<Int32>("codigo"),
                     CodigoPr = helper.GetValue<String>("codigoPr"),
                     Nombre = helper.GetValue<String>("nombre"),
                     Descripcion = helper.GetValue<String>("descripcion"),
                     Familia = helper.GetValue<String>("familia"),
                     SubFamilia = helper.GetValue<String>("Subfamilia"),
                     Medida = helper.GetValue<String>("Medida"),
                     Marca = helper.GetValue<String>("Marca")

                 };

             });

             return domainFactory;
         }

         //busqueda de marcas
         public DbCommand GetListarMarcas(Database db)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Cargar_Marcas]");
             return dbCommand;
         }

         public List<EMarca> ListarMarcas()
         {
             List<EMarca> lista = base.ExecuteGetList<EMarca>(GetListarMarcas(db),
                                                                            GetMarcas());
             return lista;
         }

         public DomainObjectFactoryBase<EMarca> GetMarcas()
         {
             DomainObjectFactoryBase<EMarca> domainFactory = new DomainObjectFactoryBase<EMarca>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EMarca()
                 {

                     codMarca = helper.GetValue<Int32>("codMarca"),
                     Descripcion = helper.GetValue<String>("Descripcion"),
                     
                 };

             });

             return domainFactory;
         }


         //obtiene el ultimo Item
         public DbCommand GetUltimoItem(Database db)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Ficha_GetUltimoItem]");
             return dbCommand;
         }

         public EUltimoItem Ultimo()
         {
             EUltimoItem obj = base.ExecuteGetObject<EUltimoItem>(GetUltimoItem(db),
                                                                            GetUltimo());
             return obj;
         }

         public DomainObjectFactoryBase<EUltimoItem> GetUltimo()
         {
             DomainObjectFactoryBase<EUltimoItem> domainFactory = new DomainObjectFactoryBase<EUltimoItem>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EUltimoItem()
                 {

                     UltimoItem = helper.GetValue<Int32>("ultimo"),
                 };
             });

             return domainFactory;
         }


        //Inserta Ficha Producto
         public EFichaProducto InsertarFichaProducto(EFichaProducto FichaProducto)
         {
             EFichaProducto result = new EFichaProducto();
             base.ExecuteNonQueryOutput<EFichaProducto>(GetInsertarFichaProducto(db, FichaProducto),
                                                         GetFichaProductoInsertado(result));
             return result;
         }

         public DbCommand GetInsertarFichaProducto(Database db, EFichaProducto identity)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.FichaProducto_Insertar]");

             db.AddInParameter(dbCommand, "@item", DbType.Int32, identity.Item);
             db.AddInParameter(dbCommand, "@codProducto", DbType.String, identity.codProducto);
             db.AddInParameter(dbCommand, "@lote", DbType.String, identity.Lote);
             db.AddInParameter(dbCommand, "@serie", DbType.String, identity.Serie);
             db.AddInParameter(dbCommand, "@tipo", DbType.String, identity.Tipo);
             db.AddInParameter(dbCommand, "@cantidad", DbType.Decimal, identity.Cantidad);
             db.AddInParameter(dbCommand, "@precio", DbType.Decimal, identity.Precio);
             db.AddInParameter(dbCommand, "@medida", DbType.String, identity.Medida);
             db.AddInParameter(dbCommand, "@fecha_recepcion", DbType.Date, identity.Fecha_Recepcion);
             db.AddInParameter(dbCommand, "@fecha_elaboracion", DbType.Date, identity.Fecha_Elaboracion);
             db.AddInParameter(dbCommand, "@fecha_vencimiento", DbType.Date, identity.Fecha_Vencimiento);
             db.AddInParameter(dbCommand, "@CodUN", DbType.Int32, identity.CodUN);

             db.AddOutParameter(dbCommand, "@Codigo", DbType.Int32, 14);

            return dbCommand;
         }

         public OutputObjectFactoryBase<EFichaProducto> GetFichaProductoInsertado(EFichaProducto outputObject)
         {
             OutputObjectFactoryBase<EFichaProducto> outputObjectFactory = new OutputObjectFactoryBase<EFichaProducto>(delegate(Database db, DbCommand command)
             {
                 outputObject.Codigo = Convert.ToInt32(db.GetParameterValue(command, "@Codigo"));

             });

             return outputObjectFactory;
         }


         //busqueda de ficha producto
         public DbCommand GetBuscarFicha(Database db, String codigo, int UN)
         {
             DbCommand dbCommand = db.GetStoredProcCommand("[ALM.Buscar_FichaProducto]");
             db.AddInParameter(dbCommand, "@codigoPr", DbType.String, codigo);
             db.AddInParameter(dbCommand, "@UN", DbType.Int32, UN);

             return dbCommand;
         }

         public List<EFichaProducto> BuscarFicha(String codigo, int UN)
         {
             List<EFichaProducto> lista = base.ExecuteGetList<EFichaProducto>(GetBuscarFicha(db, codigo, UN),
                                                                            GetBuscarFicha());
             return lista;
         }

         public DomainObjectFactoryBase<EFichaProducto> GetBuscarFicha()
         {
             DomainObjectFactoryBase<EFichaProducto> domainFactory = new DomainObjectFactoryBase<EFichaProducto>(delegate(IDataReader myReader)
             {
                 MapHelper helper = new MapHelper(myReader);
                 return new EFichaProducto()
                 {

                     Item = helper.GetValue<Int32>("item"),
                     Medida = helper.GetValue<String>("medida"),
                     Marca = helper.GetValue<String>("marca"),
                     Fecha_Vencimiento = helper.GetValue<DateTime>("fecha_vencimiento"),
                     Cantidad =helper.GetValue<Decimal>("Cantidad"),
                     Precio=helper.GetValue<Decimal>("Precio"),
                     Total =helper.GetValue<Decimal>("Total"),
                     CodMarca = helper.GetValue<Int32>("CodMarca"),
                 };

             });

             return domainFactory;
         }

#endregion

      
    }
}
