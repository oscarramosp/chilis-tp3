using System;
using System.Collections.Generic;
using System.Text;
using BELayer;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace DALayer
{
    public class DALocales : DABase
    {
        public List<BELocal> selectLocales(BELocal oLocal)
        {
            List<BELocal> oListaLocales = new List<BELocal>();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_LOCALES");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_LOCAL", DbType.Int32, oLocal.CodigoLocal);
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oLocal = new BELocal(rdr);
                oLocal.CodigoLocal = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_LOCAL")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_LOCAL"));
                oLocal.Nombre = rdr.IsDBNull(rdr.GetOrdinal("VC_NOMBRE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NOMBRE"));
                oLocal.Direccion = rdr.IsDBNull(rdr.GetOrdinal("VC_DIRECCION")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_DIRECCION"));
                oLocal.Telefono = rdr.IsDBNull(rdr.GetOrdinal("VC_TELEFONO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_TELEFONO"));
                oLocal.Capacidad = rdr.IsDBNull(rdr.GetOrdinal("IN_CAPACIDAD")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CAPACIDAD"));
                oListaLocales.Add(oLocal);
            }
            return oListaLocales;
        }
    }
}
