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
#endregion

      
    }
}
