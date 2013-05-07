using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ALM.BE.Entities;
using AppAlmacen.Almacen;
using ALM.DL.DataAccess.Almacen; 


namespace ALM.BL.BusinessLogic.Almacen
{
    public class BLNotaPedidoDetalle
    {
        
        #region Fields
        private readonly DANotaPedidoDetalle da = null;
        #endregion

        

         #region Constructors
        public BLNotaPedidoDetalle(DANotaPedidoDetalle daNotaISDetalle)
        {
            if (daNotaISDetalle == null)
            {
                throw new ArgumentNullException("daNotaISDetalle");
            }
            this.da = daNotaISDetalle;
        }

        public BLNotaPedidoDetalle()
        {
            this.da = new DANotaPedidoDetalle();
        }
        #endregion

        #region  Members


        public int Insertar(ENotaIngresoSalidaDetalle notaISDet)
        {
            if (notaISDet == null)
            {
                throw new ArgumentNullException("notaISDet");
            }
            return da.Insertar(notaISDet);
        }

        public void Modificar(ENotaIngresoSalidaDetalle notaISDet)
        {
            if (notaISDet == null)
            {
                throw new ArgumentNullException("notaISDet");
            }
            da.Modificar(notaISDet);
        }

        public void Eliminar(ENotaIngresoSalidaDetalle notaISDet)
        {
            if (notaISDet == null)
            {
                throw new ArgumentNullException("notaISDet");
            }
            da.Eliminar(notaISDet);
        }


        public List<ENotaIngresoSalidaDetalle> ListarPorNotaIS(int codNotaIS)
        {
            if (codNotaIS == null)
            {
                throw new ArgumentNullException("codNotaIS");
            }
            return da.ListarPorNotaIS(codNotaIS);
        }

        public ENotaIngresoSalidaDetalle ObtenerPorCorrelativo(int correlativo)
        {
            if (correlativo == null)
            {
                throw new ArgumentNullException("correlativo");
            }
            return da.ObtenerPorCorrelativo(correlativo);
        }
        #endregion


    }
}
