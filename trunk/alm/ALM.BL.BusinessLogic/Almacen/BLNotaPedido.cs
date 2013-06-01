using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ALM.BE.Entities;
using AppAlmacen.Almacen;
using ALM.DL.DataAccess.Almacen;
using System.Transactions;

namespace ALM.BL.BusinessLogic.Almacen
{
   public class BLNotaPedido
    {
        #region Fields
         private readonly DANotaPedido da = null;
        private DANotaPedidoDetalle daNotaISDetalle = null;
        #endregion

        public List<ENotaPedidoDetalle> ListarPorNotaPedido(int codigo)
        {
            DANotaPedido da = new DANotaPedido();           
            return da.ListarPorNotaPedido(codigo);
        }

        public ENotaPedido GetNP(int codigo)
        {
            DANotaPedido da = new DANotaPedido();
            return da.NP(codigo);
        }

        public List<ENotaPedido> ListarPorNotaPedidoP(int CodUN)
        {
            DANotaPedido da = new DANotaPedido();
            return da.ListarPorNotaPedidoP(CodUN);
        }

        public List<ENotaPedido> ActualizarNotaPedidoP(int CodigoPedido, string estado)
        {
            DANotaPedido da = new DANotaPedido();
            return da.ActualizarPorNotaPedidoP(CodigoPedido, estado);
        }

        public List<ENotaIngresoSalida> ListarPorNotaPedido_IS(int codigo)
        {
            DANotaPedido da = new DANotaPedido();
            return da.ListarNotaIS(codigo);
        }


        public List<EUnidadNegocio> ListarUnidadNegocio()
        {
            DANotaPedido da = new DANotaPedido();  
            return da.ListarUnidadNegocio();
        }

        public List<EUnidadNegocio> ListarUnidadNegocioP()
        {
            DANotaPedido da = new DANotaPedido();
            return da.ListarUnidadNegocioP();
        }

         public BLNotaPedido(DANotaPedido daNota)
        {
            if (daNota == null)
            {
                throw new ArgumentNullException("daNota");
            }

            this.da = daNota;
        }

         public BLNotaPedido()
        {
            this.da = new DANotaPedido();
        }

        public DANotaPedidoDetalle DANotaDetalle
        {
            get
            {
                if (daNotaISDetalle == null)
                    daNotaISDetalle = new DANotaPedidoDetalle();
                return daNotaISDetalle;
            }
            set { daNotaISDetalle = value; }
        }

        public ENotaIngresoSalida Insertar(ENotaIngresoSalida objENota)
        {

            if (objENota == null)
            {
                throw new ArgumentNullException("objENota");
            }

            ENotaIngresoSalida resultado = null;

            using (TransactionScope xTrans = new TransactionScope())
            {
                resultado = da.InsertarNota(objENota);
               
                
                List<ENotaIngresoSalidaDetalle> Lista_NotaDetalle = DANotaDetalle.ListarPorNotaIS(resultado.CodigoIS);
                List<ENotaIngresoSalidaDetalle> ListaModificar_NotaDetalle = new List<ENotaIngresoSalidaDetalle>();
                List<ENotaIngresoSalidaDetalle> ListaEliminar_NotaDetalle = new List<ENotaIngresoSalidaDetalle>();
                List<ENotaIngresoSalidaDetalle> ListaInsertar_NotaDetalle = objENota.NotaISDetalle;

                foreach (ENotaIngresoSalidaDetalle Nota_detalle in Lista_NotaDetalle)
                {
                    ENotaIngresoSalidaDetalle objENotaDetalle = objENota.NotaISDetalle.FirstOrDefault<ENotaIngresoSalidaDetalle>(x => x.CodigoDetIS == Nota_detalle.CodigoDetIS);
                    if (objENotaDetalle != null)
                    {
                        ListaModificar_NotaDetalle.Add(objENotaDetalle);
                        ListaInsertar_NotaDetalle.Remove(objENotaDetalle);
                    }
                    else
                    {
                        ENotaIngresoSalidaDetalle auxENotaPedido = Lista_NotaDetalle.First<ENotaIngresoSalidaDetalle>(x => x.CodigoDetIS == Nota_detalle.CodigoDetIS);
                        ListaEliminar_NotaDetalle.Add(auxENotaPedido);
                    }
                }

                foreach (ENotaIngresoSalidaDetalle objENotaDetalle in ListaInsertar_NotaDetalle)
                {
                    objENotaDetalle.CodigoIS = resultado.CodigoIS;
                    int CorNota = DANotaDetalle.Insertar(objENotaDetalle);
                }

                foreach (ENotaIngresoSalidaDetalle objENota_Detalle in ListaModificar_NotaDetalle)
                {
                    DANotaDetalle.Modificar(objENota_Detalle);
                }

                foreach (ENotaIngresoSalidaDetalle objENota_Detalle in ListaEliminar_NotaDetalle)
                {
                    DANotaDetalle.Eliminar(objENota_Detalle);
                }
               
               
                xTrans.Complete();
                return resultado;
            }
        }

        public ENotaPedido InsertarP(ENotaPedido objENota)
        {

            if (objENota == null)
            {
                throw new ArgumentNullException("objENota");
            }

            ENotaPedido resultado = null;

            using (TransactionScope xTrans = new TransactionScope())
            {
                resultado = da.InsertarNotaP(objENota);


                List<ENotaPedidoDetalle> ListaInsertar_NotaDetalle = objENota.NotaPedido;

                foreach (ENotaPedidoDetalle objENotaDetalle in ListaInsertar_NotaDetalle)
                {
                    objENotaDetalle.CodigoPedido = resultado.Codigo;
                    int CorNota = DANotaDetalle.InsertarP(objENotaDetalle);
                }

             
                xTrans.Complete();
                return resultado;
            }
        }

        public ENotaIngresoSalida Actualizar(ENotaIngresoSalida objENota)
        {

            if (objENota == null)
            {
                throw new ArgumentNullException("objENota");
            }

            ENotaIngresoSalida resultado = null;

            using (TransactionScope xTrans = new TransactionScope())
            {
                resultado = da.ActualizarNota(objENota);

               
                List<ENotaIngresoSalidaDetalle> Lista_NotaDetalle = DANotaDetalle.ListarPorNotaIS(objENota.CodigoIS);
                List<ENotaIngresoSalidaDetalle> ListaModificar_NotaDetalle = new List<ENotaIngresoSalidaDetalle>();
                List<ENotaIngresoSalidaDetalle> ListaEliminar_NotaDetalle = new List<ENotaIngresoSalidaDetalle>();
                List<ENotaIngresoSalidaDetalle> ListaInsertar_NotaDetalle = objENota.NotaISDetalle;

                foreach (ENotaIngresoSalidaDetalle Nota_detalle in Lista_NotaDetalle)
                {
                    ENotaIngresoSalidaDetalle objENotaDetalle = objENota.NotaISDetalle.FirstOrDefault<ENotaIngresoSalidaDetalle>(x => x.CodigoDetIS == Nota_detalle.CodigoDetIS);
                    if (objENotaDetalle != null)
                    {
                        ListaModificar_NotaDetalle.Add(objENotaDetalle);
                        ListaInsertar_NotaDetalle.Remove(objENotaDetalle);
                    }
                    else
                    {
                        ENotaIngresoSalidaDetalle auxENotaPedido = Lista_NotaDetalle.First<ENotaIngresoSalidaDetalle>(x => x.CodigoDetIS == Nota_detalle.CodigoDetIS);
                        ListaEliminar_NotaDetalle.Add(auxENotaPedido);
                    }
                }

                foreach (ENotaIngresoSalidaDetalle objENotaDetalle in ListaInsertar_NotaDetalle)
                {
                    objENotaDetalle.CodigoIS = objENota.CodigoIS;
                    int CorNota = DANotaDetalle.Insertar(objENotaDetalle);
                }

                foreach (ENotaIngresoSalidaDetalle objENota_Detalle in ListaModificar_NotaDetalle)
                {
                    objENota_Detalle.CodigoIS = objENota.CodigoIS;
                    DANotaDetalle.Modificar(objENota_Detalle);
                }

                foreach (ENotaIngresoSalidaDetalle objENota_Detalle in ListaEliminar_NotaDetalle)
                {
                    DANotaDetalle.Eliminar(objENota_Detalle);
                }
                
                xTrans.Complete();
                return resultado;
            }
        }



    }
}
