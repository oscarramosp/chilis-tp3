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
        public DataTable selectReporteReclamos(DateTime fechaInicio, DateTime fechaFin, String estado)
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

        public List<BEReclamo> selectReclamos(BEReclamo oReclamo, String nombreRazon, DateTime fechaInicio, DateTime fechaFin)
        {
            List<BEReclamo> oListaReclamos = new List<BEReclamo>();
            BECliente oCliente;
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_RECLAMOS");

            dbCommandWrapper.AddInParameter("@IN_CODIGO_RECLAMO", DbType.Int32, oReclamo.CodigoReclamo);
            dbCommandWrapper.AddInParameter("@CH_ESTADO", DbType.String, oReclamo.Estado);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_TIPO_DOCUMENTO", DbType.Int32, oReclamo.Cliente.TipoDocumento.CodigoTipoDocumento);
            dbCommandWrapper.AddInParameter("@VC_NUMERO_DOCUMENTO", DbType.String, oReclamo.Cliente.NumeroDocumento);
            dbCommandWrapper.AddInParameter("@VC_NOMBRE_RAZON", DbType.String, nombreRazon);
            dbCommandWrapper.AddInParameter("@FECHA_INICIO", DbType.DateTime, fechaInicio);
            dbCommandWrapper.AddInParameter("@FECHA_FIN", DbType.DateTime, fechaFin);
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {   
                oCliente = new BECliente(rdr);
                oCliente.NumeroDocumento = rdr.IsDBNull(rdr.GetOrdinal("VC_NUMERO_DOCUMENTO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NUMERO_DOCUMENTO"));
                oCliente.NombreCompleto = rdr.IsDBNull(rdr.GetOrdinal("NOMBRE_COMPLETO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("NOMBRE_COMPLETO"));
                oCliente.RazonSocial = rdr.IsDBNull(rdr.GetOrdinal("VC_RAZON_SOCIAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_RAZON_SOCIAL"));
                oCliente.CodigoCliente = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_CLIENTE")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_CLIENTE"));

                oReclamo = new BEReclamo();
                oReclamo.CodigoReclamo = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_RECLAMO")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_RECLAMO"));                
                oReclamo.FechaCreacion = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_CREACION")) ? DateTime.MinValue : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA_CREACION"));
                oReclamo.Detalle = rdr.IsDBNull(rdr.GetOrdinal("VC_DETALLE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_DETALLE"));
                oReclamo.Estado = rdr.IsDBNull(rdr.GetOrdinal("CH_ESTADO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_ESTADO"));

                oReclamo.Cliente = oCliente;

                oListaReclamos.Add(oReclamo);
            }
            return oListaReclamos;
        }
    }
}
