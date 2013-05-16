using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DAOIdioma;

/// <summary>
/// Summary description for IdiomaBL
/// </summary>
namespace BLIdioma
{
    public class IdiomaBL
    {
        IdiomaDAO oLog = new IdiomaDAO();
        public IdiomaBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable getIdioma()
        {


            return oLog.getIdioma();

        }
    }
}