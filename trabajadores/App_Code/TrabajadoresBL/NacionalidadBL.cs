using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DAONacionalidad;

/// <summary>
/// Summary description for NacionalidadBL
/// </summary>
namespace BLNacionalidad
{
    public class NacionalidadBL
    {
        NacionalidadDAO oLog = new NacionalidadDAO();

        public NacionalidadBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable GetNacionalidad()
        {


            return oLog.getNacionalidad();

        }


    }
}