using System;
using System.Collections.Generic;
using System.Text;
using BELayer;
using DALayer;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace BLLayer
{
    public class BLLocal
    {
        public List<BELocal> selectLocales(BELocal oLocal)
        {
            List<BELocal> oListaLocales = new List<BELocal>();

            try
            {
                DALocales oDAClientes = new DALocales();
                oListaLocales = oDAClientes.selectLocales(oLocal);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaLocales;
        }
    }
}
