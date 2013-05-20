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
                oCliente.Nombres = rdr.IsDBNull(rdr.GetOrdinal("VC_NOMBRES")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NOMBRES"));
                oCliente.ApellidoPaterno = rdr.IsDBNull(rdr.GetOrdinal("VC_APELLIDO_PATERNO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_APELLIDO_PATERNO"));
                oCliente.ApellidoMaterno = rdr.IsDBNull(rdr.GetOrdinal("VC_APELLIDO_MATERNO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_APELLIDO_MATERNO"));
                oCliente.TipoCliente = rdr.IsDBNull(rdr.GetOrdinal("CH_TIPO_CLIENTE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_TIPO_CLIENTE"));
                oCliente.TelefonoPrincipal = rdr.IsDBNull(rdr.GetOrdinal("VC_TELEFONO_PRINCIPAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_TELEFONO_PRINCIPAL"));
                
                oReclamo = new BEReclamo();
                oReclamo.CodigoReclamo = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_RECLAMO")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_RECLAMO"));                
                oReclamo.FechaCreacion = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_CREACION")) ? DateTime.MinValue : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA_CREACION"));
                oReclamo.FechaCierre = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_CIERRE")) ? (DateTime?)null : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA_CIERRE"));
                oReclamo.Detalle = rdr.IsDBNull(rdr.GetOrdinal("VC_DETALLE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_DETALLE"));
                oReclamo.Estado = rdr.IsDBNull(rdr.GetOrdinal("CH_ESTADO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_ESTADO"));
                oReclamo.CodigoLocal = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_LOCAL")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_LOCAL"));
                oReclamo.TipoReclamo = rdr.IsDBNull(rdr.GetOrdinal("CH_TIPO_RECLAMO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_TIPO_RECLAMO"));

                oReclamo.Cliente = oCliente;

                oListaReclamos.Add(oReclamo);
            }
            return oListaReclamos;
        }

        public int grabarReclamo(BEReclamo oReclamo, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_GRABAR_RECLAMO");

            IDbDataParameter myParam = dbCommandWrapper.Command.CreateParameter();
            myParam.DbType = DbType.Int32;
            myParam.ParameterName = "@IN_CODIGO_RECLAMO";
            myParam.Direction = ParameterDirection.InputOutput;
            myParam.Value = oReclamo.CodigoReclamo;
            dbCommandWrapper.Command.Parameters.Add(myParam);

            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oReclamo.Cliente.CodigoCliente);
            dbCommandWrapper.AddInParameter("@DT_FECHA_CREACION", DbType.DateTime, oReclamo.FechaCreacion);
            dbCommandWrapper.AddInParameter("@DT_FECHA_CIERRE", DbType.DateTime, oReclamo.FechaCierre);
            dbCommandWrapper.AddInParameter("@VC_DETALLE", DbType.String, oReclamo.Detalle);
            dbCommandWrapper.AddInParameter("@CH_TIPO_RECLAMO", DbType.String, oReclamo.TipoReclamo);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_LOCAL", DbType.Int32, oReclamo.CodigoLocal);
            dbCommandWrapper.AddInParameter("@CH_ESTADO", DbType.String, oReclamo.Estado);
            
            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);

            int codigoReclamo = Convert.ToInt32(myParam.Value);

            return codigoReclamo;
        }

        public void eliminarReclamo(BEReclamo oReclamo, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_ELIMINAR_RECLAMO");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_RECLAMO", DbType.Int32, oReclamo.CodigoReclamo);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }

    }
}
