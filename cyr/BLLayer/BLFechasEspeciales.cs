using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System.Linq;
using System.Text;
using BELayer;
using DALayer;

namespace BLLayer
{
    public class BLFechasEspeciales
    {
        public List<BEFechaEspecial> selectFechasEspeciales(int intAnho, int intMes, string strMotivo)
        {
            List<BEFechaEspecial> oListaFechasEspeciales = new List<BEFechaEspecial>();

            try
            {
                DAFechasEspeciales oDAFechasEspeciales = new DAFechasEspeciales();
                oListaFechasEspeciales = oDAFechasEspeciales.selectFechasEspeciales(intAnho, intMes, strMotivo);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaFechasEspeciales;
        }

        public DTOResultado grabarFechaEspecial(BEFechaEspecial oFechaEspecial)
        {
            DAFechasEspeciales oDAFechasEspeciales = new DAFechasEspeciales();
            DAReservas oDAReservas = new DAReservas();
            oDAFechasEspeciales.mIniciarTransaccion();
            DTOResultado oResultado = new DTOResultado();

            BEReserva oReserva = new BEReserva();
            oReserva.FechaReserva = oFechaEspecial.Fecha;
            oReserva.Mesa = new BEMesa();

            try
            {
                // Validar
                // 1. Si la fecha ingresada ya está registrada.
                int fechaEspecial = oDAFechasEspeciales.validarFechaEspecial(oFechaEspecial);

                if (fechaEspecial > 0)
                {
                    oResultado.Codigo = (int)Constantes.CodigoGrabarFechaEspecial.FechaExiste;
                    oResultado.Objeto = oFechaEspecial;
                    return oResultado;
                }

                //2. Si la fecha a registrar tiene reservas registradas
                if (oDAReservas.selectReserva(oReserva).Count > 0)
                {
                    oResultado.Codigo = (int)Constantes.CodigoGrabarFechaEspecial.ExisteReservaFechaEspecial;
                    oResultado.Objeto = oFechaEspecial;
                    return oResultado;
                }

                int codigoFecha = oDAFechasEspeciales.grabarFechaEspecial(oFechaEspecial, oDAFechasEspeciales.mtransaction);
                oDAFechasEspeciales.mCommitTransaccion();
                oFechaEspecial.Codigo = codigoFecha;

                oResultado.Codigo = (int)Constantes.CodigoGrabarFechaEspecial.Ok;
                oResultado.Objeto = oFechaEspecial;

                return oResultado;
            }
            catch (Exception ex)
            {
                oDAFechasEspeciales.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                oResultado.Codigo = (int)Constantes.CodigoGrabarFechaEspecial.Error;
                oResultado.Objeto = null;
                return oResultado;
            }
        }

        public int eliminarFechaEspecial(BEFechaEspecial oFechaEspecial)
        {
            DAFechasEspeciales oDAFechaEspecial = new DAFechasEspeciales();
            DAReservas oDAReservas = new DAReservas();
            oDAFechaEspecial.mIniciarTransaccion();
            int codigoRetorno = 0;

            BEReserva oReserva = new BEReserva();
            oReserva.FechaReserva = oFechaEspecial.Fecha;
            oReserva.Mesa = new BEMesa();

            try
            {
                if (oDAReservas.selectReserva(oReserva).Count > 0)
                {
                    codigoRetorno = (int)BLLayer.Constantes.CodigoEliminacion.Inactivado;
                }
                else
                {
                    oDAFechaEspecial.eliminarFechaEspecial(oFechaEspecial, oDAFechaEspecial.mtransaction);
                    codigoRetorno = (int)BLLayer.Constantes.CodigoEliminarFechaEspecial.Ok;
                }

                oDAFechaEspecial.mCommitTransaccion(); 
            }
            catch (Exception ex)
            {
                oDAFechaEspecial.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                codigoRetorno = (int)BLLayer.Constantes.CodigoEliminarFechaEspecial.Error;
            }
            return codigoRetorno;
        }
    }
}
