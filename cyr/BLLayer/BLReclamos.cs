using System;
using System.Collections.Generic;
using System.Text;
using BELayer;
using DALayer;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace BLLayer
{
    public class BLReclamos
    {
        public DataTable selectReporteReclamos(DateTime fechaInicio, DateTime fechaFin, string estado)
        {
            DataTable dtReclamo = new DataTable();

            try
            {
                DAReclamos oDAReclamos = new DAReclamos();
                dtReclamo = oDAReclamos.selectReporteReclamos(fechaInicio, fechaFin, estado);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return dtReclamo;
        }

        public List<BEReclamo> selectReclamos(BEReclamo oReclamo, String nombreRazon, DateTime fechaInicio, DateTime fechaFin)
        {
            List<BEReclamo> oListaReclamos = new List<BEReclamo>();

            try
            {
                DAReclamos oDAReclamos = new DAReclamos();
                oListaReclamos = oDAReclamos.selectReclamos(oReclamo, nombreRazon, fechaInicio, fechaFin);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaReclamos;
        }

        public int eliminarReclamo(BEReclamo oReclamo)
        {
            DAReclamos oDAReclamos = new DAReclamos();
            DARespuestaReclamo oDARespuestas = new DARespuestaReclamo();
            oDAReclamos.mIniciarTransaccion();
            int codigoRetorno = 0;

            try
            {
                oDARespuestas.eliminarRespuestasReclamo(oReclamo,oDAReclamos.mtransaction);
                oDAReclamos.eliminarReclamo(oReclamo, oDAReclamos.mtransaction);
                codigoRetorno = (int)BLLayer.Constantes.CodigoEliminacion.Eliminado;

                oDAReclamos.mCommitTransaccion();
            }
            catch (Exception ex)
            {
                oDAReclamos.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                codigoRetorno = (int)BLLayer.Constantes.CodigoEliminacion.Error;
            }
            return codigoRetorno;
        }

        public BEReclamo grabarReclamo(BEReclamo oReclamo)
        {
            DAReclamos oDAReclamos = new DAReclamos();
            DARespuestaReclamo oDARespuestas = new DARespuestaReclamo();

            oDAReclamos.mIniciarTransaccion();

            try
            {
                int codigoReclamo = oDAReclamos.grabarReclamo(oReclamo, oDAReclamos.mtransaction);
                oReclamo.CodigoReclamo = codigoReclamo;

                oDARespuestas.eliminarRespuestasReclamo(oReclamo, oDAReclamos.mtransaction);
                
                foreach (BERespuesta oRespuesta in oReclamo.Respuestas)
                {
                    oRespuesta.CodigoReclamo = codigoReclamo;
                    oRespuesta.CodigoReclamo = oDARespuestas.grabarRespuestaReclamo(oRespuesta, oDAReclamos.mtransaction);
                }                

                oDAReclamos.mCommitTransaccion();
                
                return oReclamo;
            }
            catch (Exception ex)
            {
                oDAReclamos.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                return null;
            }
        }

    }
}
