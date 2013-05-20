using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using BELayer;

namespace DALayer
{
    public class DARespuestaReclamo : DABase
    {
        public List<BERespuesta> selectRespuestaReclamo(BEReclamo oReclamo)
        {
            List<BERespuesta> oListaRespuesta = new List<BERespuesta>();
            BERespuesta oRespuesta = new BERespuesta();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_RESPUESTAS_RECLAMO");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_RECLAMO", DbType.Int32, oReclamo.CodigoReclamo);
            
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oRespuesta = new BERespuesta(rdr);

                oRespuesta.CodigoRespuesta = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_RESPUESTA")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_RESPUESTA"));
                oRespuesta.Respuesta = rdr.IsDBNull(rdr.GetOrdinal("VC_RESPUESTA")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_RESPUESTA"));
                oRespuesta.FechaRespuesta = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_RESPUESTA")) ? (DateTime?)null : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA_RESPUESTA"));
                oRespuesta.CodigoReclamo = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_RECLAMO")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_RECLAMO"));

                oListaRespuesta.Add(oRespuesta);
            }
            return oListaRespuesta;
        }

        public int grabarRespuestaReclamo(BERespuesta oRespuesta, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_GRABAR_RESPUESTA_RECLAMO");

            IDbDataParameter myParam = dbCommandWrapper.Command.CreateParameter();
            myParam.DbType = DbType.Int32;
            myParam.ParameterName = "@IN_CODIGO_RESPUESTA";
            myParam.Direction = ParameterDirection.InputOutput;
            myParam.Value = oRespuesta.CodigoRespuesta;
            dbCommandWrapper.Command.Parameters.Add(myParam);

            dbCommandWrapper.AddInParameter("@VC_RESPUESTA", DbType.String, oRespuesta.Respuesta);
            dbCommandWrapper.AddInParameter("@DT_FECHA_RESPUESTA", DbType.DateTime, oRespuesta.FechaRespuesta);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_RECLAMO", DbType.Int32, oRespuesta.CodigoReclamo);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);

            int codigoRespuesta = Convert.ToInt32(myParam.Value);

            return codigoRespuesta;
        }

        public void eliminarRespuestasReclamo(BEReclamo oReclamo, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_ELIMINAR_RESPUESTAS_RECLAMO");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_RECLAMO", DbType.Int32, oReclamo.CodigoReclamo);
            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }

    }
}
