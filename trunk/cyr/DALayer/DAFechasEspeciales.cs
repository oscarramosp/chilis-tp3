using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace DALayer
{
    public class DAFechasEspeciales : DABase
    {
        public List<BEFechaEspecial> selectFechasEspeciales(int intAnho, int intMes, string strMotivo)
        {
            List<BEFechaEspecial> oListaFechasEspeciales = new List<BEFechaEspecial>();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_FECHAS_ESPECIALES_BUSQUEDA");
            dbCommandWrapper.AddInParameter("@IN_ANHO", DbType.Int32, intAnho);
            dbCommandWrapper.AddInParameter("@IN_MES", DbType.Int32, intMes);
            dbCommandWrapper.AddInParameter("@VC_MOTIVO", DbType.String, strMotivo);
            rdr = db.ExecuteReader(dbCommandWrapper);
            BEFechaEspecial oFechaEspecial;
            while (rdr.Read())
            {
                oFechaEspecial = new BEFechaEspecial(rdr);
                oFechaEspecial.Codigo = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_FECHA_ESP")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_FECHA_ESP"));
                oFechaEspecial.Fecha = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA")) ? new DateTime() : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA"));
                oFechaEspecial.Motivo = rdr.IsDBNull(rdr.GetOrdinal("VC_MOTIVO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_MOTIVO"));
                oListaFechasEspeciales.Add(oFechaEspecial);
            }
            return oListaFechasEspeciales;
        }

        public BEFechaEspecial obtenerFechaEspecial(BEFechaEspecial oFechaEspecial)
        {
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();

            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_OBTENER_FECHA_ESPECIAL");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_FECHA_ESP", DbType.Int32, oFechaEspecial.Codigo);
            dbCommandWrapper.AddInParameter("@DT_FECHA", DbType.DateTime, oFechaEspecial.Fecha);
            rdr = db.ExecuteReader(dbCommandWrapper);

            oFechaEspecial = null;

            while (rdr.Read())
            {
                oFechaEspecial = new BEFechaEspecial(rdr);
                oFechaEspecial.Codigo = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_FECHA_ESP")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_FECHA_ESP"));
                oFechaEspecial.Fecha = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA")) ? new DateTime() : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA"));
                oFechaEspecial.Motivo = rdr.IsDBNull(rdr.GetOrdinal("VC_MOTIVO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_MOTIVO"));
            }
            return oFechaEspecial;
        }

        public int grabarFechaEspecial(BEFechaEspecial oFechaEspecial, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_GRABAR_FECHA_ESPECIAL");

            IDbDataParameter myParam = dbCommandWrapper.Command.CreateParameter();
            myParam.DbType = DbType.Int32;
            myParam.ParameterName = "@IN_CODIGO_FECHA_ESP";
            myParam.Direction = ParameterDirection.InputOutput;
            myParam.Value = oFechaEspecial.Codigo;
            dbCommandWrapper.Command.Parameters.Add(myParam);

            dbCommandWrapper.AddInParameter("@DT_FECHA", DbType.DateTime, oFechaEspecial.Fecha);
            dbCommandWrapper.AddInParameter("@VC_MOTIVO", DbType.String, oFechaEspecial.Motivo);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);

            int codigoFechaEsp = Convert.ToInt32(myParam.Value);

            return codigoFechaEsp;
        }

        public Int32 validarFechaEspecial(BEFechaEspecial oFechaEspecial)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_VALIDAR_FECHA_ESPECIAL");
            dbCommandWrapper.AddInParameter("@DT_FECHA", DbType.DateTime, oFechaEspecial.Fecha);

            return Convert.ToInt32(db.ExecuteScalar(dbCommandWrapper));
        }

        public void eliminarFechaEspecial(BEFechaEspecial oFechaEspecial, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_ELIMINAR_FECHA_ESPECIAL");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_FECHA_ESP", DbType.Int32, oFechaEspecial.Codigo);
            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }
    }
}
