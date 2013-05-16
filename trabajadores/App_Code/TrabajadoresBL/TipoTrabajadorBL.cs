using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAOTipoTrabajador;
using System.Data;

/// <summary>
/// Summary description for TipoTrabajadorBL
/// </summary>
namespace BLTipoTrabajador
{
    public class TipoTrabajadorBL
    {
        public TipoTrabajadorBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable getTipoTrabajador()
        {

            TipoTrabajadorDAO oTipo = new TipoTrabajadorDAO();
            return oTipo.getTipoTrabajador();


        }
    }
}