using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DAOCargo;

/// <summary>
/// Summary description for CargoBL
/// </summary>
namespace BLCargo
{
    public class CargoBL
    {
        CargoDAO oLog = new CargoDAO();

        public CargoBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable getCargo()
        {


            return oLog.getCargo();

        }
    }
}