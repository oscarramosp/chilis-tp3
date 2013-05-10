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

    }
}
