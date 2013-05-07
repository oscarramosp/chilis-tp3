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
   public class BLInventario
    {
        #region Fields
         private readonly DAInventarios da = null;
        #endregion

         public List<EInventarioCabecera> ListarHojaInventarios(String fechaIni, String fechaFin, Int32 estado)
        {
            try
            {
                DAInventarios da = new DAInventarios();
                return da.ListarHojaInventarios(fechaIni, fechaFin, estado);
            }
            catch (Exception ex)
            {
                ExceptionManager.Publish(ex);
                throw new ALM.BusinessCommon.ALMBusinessException(ex);

            }
        }
         public EInventarioCabecera ListarHojaInventarioxCod(Int32 codCabecera)
        {
            try
            {
            DAInventarios da = new DAInventarios();
            return da.ListarHojaInventariosxCod(codCabecera);
            }
            catch (Exception ex)
            {
                ExceptionManager.Publish(ex);
                throw new ALM.BusinessCommon.ALMBusinessException(ex);

            }
        }
         public List<EInventarioDetalle> ListarHojaInventarioDetxCod(Int32 codCabecera)
         {
             try
             {
             DAInventarios da = new DAInventarios();
             return da.ListarHojaInventarioDetxCod(codCabecera);
            }
            catch (Exception ex)
            {
                ExceptionManager.Publish(ex);
                throw new ALM.BusinessCommon.ALMBusinessException(ex);

            }
         }
         public Int32 eliminar(Int32 codCabecera)
         {    try
             {
             DAInventarios da = new DAInventarios();
             return da.eliminar(codCabecera);
             }
         catch (Exception ex)
         {
             ExceptionManager.Publish(ex);
             throw new ALM.BusinessCommon.ALMBusinessException(ex);

         }
         }
       
         
        public List<EEstadoINV> ListarEstadoINV()
        {
            try{

            DAInventarios da = new DAInventarios();  
            return da.ListarEstadoINV();
               }
            catch (Exception ex)
            {
                ExceptionManager.Publish(ex);
                throw new ALM.BusinessCommon.ALMBusinessException(ex);

            }
        }

         public BLInventario(DAInventarios daNota)
        {
             try{
            if (daNota == null)
            {
                throw new ArgumentNullException("daNota");
            }

            this.da = daNota;
                }
            catch (Exception ex)
            {
                ExceptionManager.Publish(ex);
                throw new ALM.BusinessCommon.ALMBusinessException(ex);

            }
        }

         public BLInventario()
        {
            this.da = new DAInventarios();
        }



         public EInventarioCabecera Insertar(EInventarioCabecera objEInventario)
        {
             try{
            if (objEInventario == null)
            {
                throw new ArgumentNullException("objEInventario");
            }

            EInventarioCabecera resultado = null;

            using (TransactionScope xTrans = new TransactionScope())
            {
                resultado = da.InsertarInventario(objEInventario);

                foreach (EInventarioDetalle objDetalle in objEInventario.ListadDetalle)
                {
                    objDetalle.CodigoCabecera = resultado.Codigo;
                    int CorNota = da.InsertarInventarioDetalle(objDetalle);
                }

                                          
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
 

         public EInventarioCabecera Actualizar(EInventarioCabecera objEInventario)
        {
             try{
            if (objEInventario == null)
            {
                throw new ArgumentNullException("objEInventario");
            }

            EInventarioCabecera resultado = null;

            using (TransactionScope xTrans = new TransactionScope())
            {
                resultado = da.ActualizarInventario(objEInventario);
                foreach (EInventarioDetalle objDetalle in objEInventario.ListadDetalle)
                {
                    objDetalle.CodigoCabecera = resultado.Codigo;
                    int CorNota = da.InsertarInventarioDetalle(objDetalle);
                }


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
