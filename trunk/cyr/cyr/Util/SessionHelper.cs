using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BELayer;

namespace cyr.Util
{
    /// <summary>
    /// Clase utilitaria para el manejo de objetos de sesión. Ugly as it does. Don't forget the constants
    /// </summary>
    public class SessionHelper
    {
        public static void setClienteEditar(BECliente objCliente)
        {
            HttpContext.Current.Session["clienteEditarObjeto"] = objCliente;
        }

        public static BECliente getClienteEditar()
        {
            return HttpContext.Current.Session["clienteEditarObjeto"] != null ? 
                (BECliente) HttpContext.Current.Session["clienteEditarObjeto"] : null;
        }
    }
}
