using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace DALayer
{
    public class DAReclamos : DABase
    {       
        public DataTable selectReporteReclamos(DateTime fechaInicio, DateTime fechaFin, string estado)
        {
            DataSet ds = new DataSet(); 
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_REPORTE_RECLAMOS");
            dbCommandWrapper.AddInParameter("@FECHA_INICIO", DbType.Date, fechaInicio);
            dbCommandWrapper.AddInParameter("@FECHA_FIN", DbType.Date, fechaFin);
            dbCommandWrapper.AddInParameter("@ESTADO", DbType.String, estado);
            ds = db.ExecuteDataSet(dbCommandWrapper);
            return ds.Tables[0];
        }
    }
}
