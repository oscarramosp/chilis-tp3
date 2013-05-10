using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;


namespace DALayer
{
    public class DATiposDocumento : DABase
    {
        public List<BETipoDocumento> selectTiposDocumento(BETipoDocumento oTipoDocumento)
        {
            List<BETipoDocumento> oListaTiposDoc = new List<BETipoDocumento>();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_TIPOS_DOCUMENTO");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_TIPO_DOCUMENTO", DbType.Int32, oTipoDocumento.CodigoTipoDocumento);
            dbCommandWrapper.AddInParameter("@VC_NOMBRE", DbType.String, oTipoDocumento.Nombre);
            dbCommandWrapper.AddInParameter("@VC_ACRONIMO", DbType.String, oTipoDocumento.Acronimo);
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oTipoDocumento = new BETipoDocumento(rdr);
                oTipoDocumento.CodigoTipoDocumento = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_TIPO_DOCUMENTO")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_TIPO_DOCUMENTO"));
                oTipoDocumento.Nombre = rdr.IsDBNull(rdr.GetOrdinal("VC_NOMBRE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NOMBRE"));
                oTipoDocumento.Acronimo = rdr.IsDBNull(rdr.GetOrdinal("VC_ACRONIMO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_ACRONIMO"));
                oListaTiposDoc.Add(oTipoDocumento);
            }
            return oListaTiposDoc;
        }
    }
}
