using System;
using System.Collections.Generic;
using System.Text;
using BELayer;
using DALayer;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace BLLayer
{
    public class BLTiposDocumento
    {

        public List<BETipoDocumento> selectTiposDocumento(BETipoDocumento oTipoDocumento)
        {
            List<BETipoDocumento> oListaTiposDoc = new List<BETipoDocumento>();

            try
            {
                DATiposDocumento oDATiposDocumento = new DATiposDocumento();
                oListaTiposDoc = oDATiposDocumento.selectTiposDocumento(oTipoDocumento);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaTiposDoc;
        }
    }
}
