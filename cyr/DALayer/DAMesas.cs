using System;
using System.Collections.Generic;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System.Data;

namespace DALayer
{
    public class DAMesas : DABase
    {
        public List<BEMesa> selectMesas(BEMesa oMesa)
        {
            List<BEMesa> oListaMesas = new List<BEMesa>();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_MESAS");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_LOCAL", DbType.Int32, oMesa.CodigoLocal);
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oMesa = new BEMesa(rdr);
                oMesa.CodigoMesa = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_MESA")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_MESA"));
                oMesa.NumeroMesa = rdr.IsDBNull(rdr.GetOrdinal("VC_NUMERO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NUMERO"));
                oMesa.Capacidad = rdr.IsDBNull(rdr.GetOrdinal("IN_CAPACIDAD")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CAPACIDAD"));
                oMesa.Estado = rdr.IsDBNull(rdr.GetOrdinal("CH_ESTADO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_ESTADO"));
                oMesa.CodigoLocal = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_LOCAL")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_LOCAL"));
                oListaMesas.Add(oMesa);
            }
            return oListaMesas;
        }
    }
}
