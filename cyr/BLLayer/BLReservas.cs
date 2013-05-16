using System;
using System.Collections.Generic;
using BELayer;
using DALayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace BLLayer
{
    public class BLReservas
    {
        public List<BEMesa> selectMesas(BEMesa oMesa)
        {
            List<BEMesa> oListaMesas = new List<BEMesa>();

            try
            {
                DAMesas oDATiposDocumento = new DAMesas();
                oListaMesas = oDATiposDocumento.selectMesas(oMesa);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaMesas;
        }

        public List<BEReserva> selectReserva(BEReserva oReserva)
        {
            List<BEReserva> oListaReservas = new List<BEReserva>();

            try
            {
                DAReservas oDATiposDocumento = new DAReservas();
                oListaReservas = oDATiposDocumento.selectReserva(oReserva);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaReservas;
        }

        public DTOResultado grabarReserva(BEReserva oReserva)
        {
            DAReservas oDAReservas = new DAReservas();
            oDAReservas.mIniciarTransaccion();
            DTOResultado oResultado = new DTOResultado();

            try
            {
                // Validar
                // 1. Si la fecha ingresada no transpone otra fecha para la misma mesa.
                int reservaRealizada = oDAReservas.validarFechaReserva(oReserva);

                if (reservaRealizada > 0)
                {
                    oResultado.Codigo = (int)Constantes.CodigoGrabarReserva.FechaNoValida;
                    oResultado.Objeto = oReserva;
                    return oResultado;
                }

                // 2. Es fecha especial, si es así colocar otro estado.
                DAFechasEspeciales oDAFechasEspeciales = new DAFechasEspeciales();
                BEFechaEspecial oFechaEspecial = new BEFechaEspecial();
                oFechaEspecial.Fecha = oReserva.FechaReserva;

                oFechaEspecial = oDAFechasEspeciales.obtenerFechaEspecial(oFechaEspecial);

                if (oFechaEspecial != null)
                    oReserva.Estado = "P"; // Pendiente de aprobación.

                int codigoReserva = oDAReservas.grabarReserva(oReserva, oDAReservas.mtransaction);
                
                oReserva.CodigoReserva = codigoReserva;
                oResultado.Codigo = oFechaEspecial != null ? (int)Constantes.CodigoGrabarReserva.ReservaPendienteFechaEspecial : (int)Constantes.CodigoGrabarReserva.Ok;
                oResultado.Objeto = oReserva;

                oDAReservas.mCommitTransaccion();

                return oResultado;
            }
            catch (Exception ex)
            {
                oDAReservas.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                oResultado.Codigo = (int)Constantes.CodigoGrabarReserva.Error;
                oResultado.Objeto = null;
                return oResultado;
            }
        }

        public DTOResultado eliminarReserva(BEReserva oReserva)
        {
            DAReservas oDAReserva = new DAReservas();
            oDAReserva.mIniciarTransaccion();
            DTOResultado oResultado = new DTOResultado();

            try
            {
                // 1. Validar reserva en curso.

                oDAReserva.eliminarReserva(oReserva, oDAReserva.mtransaction);
                oDAReserva.mCommitTransaccion();
                oResultado.Codigo = (int)Constantes.CodigoEliminarReserva.Ok;
            }
            catch (Exception ex)
            {
                oDAReserva.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                oResultado.Codigo = (int)Constantes.CodigoEliminarReserva.Error;
            }
            return oResultado;
        }
    }
}
