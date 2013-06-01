using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ALM.BE.Entities;
using AppAlmacen.Almacen;
using ALM.DL.DataAccess.Almacen;
using System.Transactions;
using ALM.BE.Entities.Almacen;
using ALM.ExceptionManagement;
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

        public List<EProductos> BuscarProductos(String codigo, String descripcion, String familia, String SubFamilia, int Marca)
        {
            DAProductos da = new DAProductos();
            return da.BuscarProductos(codigo, descripcion, familia,SubFamilia,Marca);
        }

        public List<EProductos> BuscarProductos2(Int32 codigo)
        {
            DAProductos da = new DAProductos();
            return da.BuscarProductos2(codigo);
        }

        public List<EProductos> BuscarProductosUN(String codigo, String nombre, int UN)
        {
            DAProductos da = new DAProductos();
            return da.BuscarProductosUN(codigo, nombre, UN);
        }

        public List<EFichaProducto> ListarFichas(String codigo, int UN)
        {
            DAProductos da = new DAProductos();
            return da.BuscarFicha(codigo,UN);
        }

        public List<EMarca> ListarMarcas()
        {
            DAProductos da = new DAProductos();
            return da.ListarMarcas();
        }

        public EUltimoItem GetUltimo()
        {
            DAProductos da = new DAProductos();
            return da.Ultimo();
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

         public EFichaProducto Insertar(EFichaProducto objEFichaProducto)
         {
             try
             {
                 if (objEFichaProducto == null)
                 {
                     throw new ArgumentNullException("objEFichaProducto");
                 }

                 EFichaProducto resultado = null;

                 using (TransactionScope xTrans = new TransactionScope())
                 {
                     resultado = da.InsertarFichaProducto(objEFichaProducto);
                                      
                         //objDetalle.CodigoCabecera = resultado.Codigo;
                    

                     xTrans.Complete();
                     return resultado;
                 }
             }
             catch (Exception ex)
             {
                 ExceptionManager.Publish(ex);
                 throw new ALM.BusinessCommon.ALMBusinessException(ex);

             }
         }

         public EFichaProducto InsertarNI(int codigo)
         {
             try
             {
                 EFichaProducto resultado = null;

                 using (TransactionScope xTrans = new TransactionScope())
                 {
                     resultado = da.InsertarFichaProductoNI(codigo);
                     
                     xTrans.Complete();
                     return resultado;
                 }
             }
             catch (Exception ex)
             {
                 ExceptionManager.Publish(ex);
                 throw new ALM.BusinessCommon.ALMBusinessException(ex);

             }
         }


    }
}
