using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ALM.BE.Entities;
using AppAlmacen.Almacen;
using ALM.DL.DataAccess.Almacen;
using System.Transactions;
using ALM.BE.Entities.Almacen;

namespace ALM.BL.BusinessLogic.Almacen
{
   public class BLProductos
    {
        #region Fields
       private readonly DAProductos da = null;
        #endregion

              
        public List<EProductos> ListarProductos(String nombre,String codigo)
        {
            DAProductos da = new DAProductos();
            return da.ListarProductos(nombre, codigo);
        }

        public BLProductos(DAProductos daProductos)
        {
            if (daProductos == null)
            {
                throw new ArgumentNullException("daProductos");
            }

            this.da = daProductos;
        }

         public BLProductos()
        {
            this.da = new DAProductos();
        }




    }
}
