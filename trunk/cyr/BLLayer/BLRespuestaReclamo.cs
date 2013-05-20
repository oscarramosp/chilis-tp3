using System;
using System.Collections.Generic;
using System.Text;
using BELayer;
using DALayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace BLLayer
{
    public class BLRespuestaReclamo
    {
        public List<BERespuesta> selectRespuestas(BEReclamo oReclamo)
        {
            List<BERespuesta> oListaRespuestas = new List<BERespuesta>();

            try
            {
                DARespuestaReclamo oDARespuestas = new DARespuestaReclamo();
                oListaRespuestas = oDARespuestas.selectRespuestaReclamo(oReclamo);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaRespuestas;
        }
    }
}
