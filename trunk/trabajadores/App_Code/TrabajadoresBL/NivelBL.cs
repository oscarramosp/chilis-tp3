using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DAONivel;


/// <summary>
/// Summary description for NivelBL
/// </summary>
namespace BLNivel
{
    public class NivelBL
    {
        NivelDAO oLog = new NivelDAO();
        public NivelBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable getNivel()
        {
            return oLog.getNivel();
        }
    }
}